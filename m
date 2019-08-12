Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38433C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 05:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094492085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 05:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565587637;
	bh=S5XBc/9t8DA/2fd5dfsHRNt+0Dr0cByHsAw3f9N3BpM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=Zc6PvXwwAC5jITP+ctfrV2er4HD/2YZ/54vdpq26pOhYoqz6CafKzR7eY52D/4GX/
	 nPvVBmHoaB1BbS+r7GFFwQlnt7UAxVVzy1q8xD0SKVEBJWKfmGPOwvRMhj+67wKaPF
	 6m+xD/jJVBoXQ5oIfDyfTHzMHboOEHGSAxxRoE88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfHLF1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 01:27:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:37449 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfHLF1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 01:27:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Aug 2019 22:27:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,376,1559545200"; 
   d="scan'208";a="259676344"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga001.jf.intel.com with ESMTP; 11 Aug 2019 22:27:12 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Xiaobo Xie <xiaobo.xie@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: RE: [EXT] Re: [PATCH v1] usb: dwc3: remove the call trace of USBx_GFLADJ
In-Reply-To: <VI1PR04MB41580DBF1A0C2DC143EE9CE3E9D30@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190729064607.8131-1-yinbo.zhu@nxp.com> <875zn8nt31.fsf@gmail.com> <VI1PR04MB41580DBF1A0C2DC143EE9CE3E9D30@VI1PR04MB4158.eurprd04.prod.outlook.com>
Date:   Mon, 12 Aug 2019 08:27:11 +0300
Message-ID: <87h86nvtqo.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Yinbo Zhu <yinbo.zhu@nxp.com> writes:
>> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index
>> > 98bce85c29d0..a133d8490322 100644
>> > --- a/drivers/usb/dwc3/core.c
>> > +++ b/drivers/usb/dwc3/core.c
>> > @@ -300,8 +300,7 @@ static void dwc3_frame_length_adjustment(struct
>> > dwc3 *dwc)
>> >
>> >       reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
>> >       dft = reg & DWC3_GFLADJ_30MHZ_MASK;
>> > -     if (!dev_WARN_ONCE(dwc->dev, dft == dwc->fladj,
>> > -         "request value same as default, ignoring\n")) {
>> > +     if (dft != dwc->fladj) {
>> 
>> if the value isn't different, why do you want to change it?
>> 
>> --
>> Balbi
> Hi Balbi,
>
> I don't change any value. I was remove that call trace.

Sure you do. The splat only shows when you request a FLADJ value that's
the same as the one already in the register. The reason you see the
splat is because your requested value is what's already in the HW.

So, again, why are you adding this device tree property if the value is
already the correct one?

> In addition that GFLADJ_30MHZ value intial value is 0, and it's value
> must be 0x20, if not, usb will not work.

it's not zero, otherwise the splat wouldn't trigger. You're requesting
the value that's already in your register by default.

-- 
balbi
