Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C740CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EB021743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565240839;
	bh=H5FYkCkRBz87c4Ku6tWWxD1X+CNR/CYk6nK3ExV0F1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=jcGzwcVllS9kLs+DxGfQEL7hBeuPCqQbzt5SrC3x8w28aj2IFoB208g2QmI+ynHTu
	 1CTXFgdeI4ubWh9AjgQs4F2STia8DYueFmeOhq/sG6fIKfNNx6YHiFaBeB+2XRj9yk
	 wPIf37G4EXJNYY2DApszgHTl4KwP31EMdVTEWuUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfHHFHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 01:07:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:28742 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfHHFHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 01:07:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 22:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="scan'208";a="174736649"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga008.fm.intel.com with ESMTP; 07 Aug 2019 22:07:15 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        Ran Wang <ran.wang_1@nxp.com>
Subject: Re: [PATCH v1] usb: dwc3: remove the call trace of USBx_GFLADJ
In-Reply-To: <20190729064607.8131-1-yinbo.zhu@nxp.com>
References: <20190729064607.8131-1-yinbo.zhu@nxp.com>
Date:   Thu, 08 Aug 2019 08:07:14 +0300
Message-ID: <875zn8nt31.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Yinbo Zhu <yinbo.zhu@nxp.com> writes:

> layerscape board sometimes reported some usb call trace, that is due to
> kernel sent LPM tokerns automatically when it has no pending transfers
> and think that the link is idle enough to enter L1, which procedure will
> ask usb register has a recovery,then kernel will compare USBx_GFLADJ and
> set GFLADJ_30MHZ, GFLADJ_30MHZ_REG until GFLADJ_30MHZ is equal 0x20, if
> the conditions were met then issue occur, but whatever the conditions
> whether were met that usb is all need keep GFLADJ_30MHZ of value is 0x20
> (xhci spec ask use GFLADJ_30MHZ to adjust any offset from clock source
> that generates the clock that drives the SOF counter, 0x20 is default
> value of it)That is normal logic, so need remove the call trace.
>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  drivers/usb/dwc3/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 98bce85c29d0..a133d8490322 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -300,8 +300,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
>  
>  	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
>  	dft = reg & DWC3_GFLADJ_30MHZ_MASK;
> -	if (!dev_WARN_ONCE(dwc->dev, dft == dwc->fladj,
> -	    "request value same as default, ignoring\n")) {
> +	if (dft != dwc->fladj) {

if the value isn't different, why do you want to change it?

-- 
balbi
