Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CEDC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEAD2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565848774;
	bh=AWvtkVoMveX+367jfIigRFuEKXKgex3lO3WvrMEOtwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=Wgb32trweZNttt0Hv480fuVMVVIdquAJoI4iTgRlCt3RXEB0ZuU719sUVvdZj3f+O
	 llXu5Xzah+XPOsQAPEBr2PDzNXmBhYeXAN5Q0s459Di2xUOBa4YPN+tf9uOa5okQQD
	 kIckmsgx6lQzYwNI3bXnYGpwZyFtJZWQgeBf9tdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfHOF7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 01:59:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:39733 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfHOF7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 01:59:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 22:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,388,1559545200"; 
   d="scan'208";a="194702947"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2019 22:59:29 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Xiaobo Xie <xiaobo.xie@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: RE: [EXT] Re: [PATCH v1] usb: dwc3: remove the call trace of USBx_GFLADJ
In-Reply-To: <VI1PR04MB4158B49129BE9E3C00997555E9AC0@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190729064607.8131-1-yinbo.zhu@nxp.com> <875zn8nt31.fsf@gmail.com> <VI1PR04MB41580DBF1A0C2DC143EE9CE3E9D30@VI1PR04MB4158.eurprd04.prod.outlook.com> <87h86nvtqo.fsf@gmail.com> <VI1PR04MB4158B49129BE9E3C00997555E9AC0@VI1PR04MB4158.eurprd04.prod.outlook.com>
Date:   Thu, 15 Aug 2019 08:59:28 +0300
Message-ID: <87v9uzt1dr.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Yinbo Zhu <yinbo.zhu@nxp.com> writes:
>> Yinbo Zhu <yinbo.zhu@nxp.com> writes:
>> >> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> >> > index
>> >> > 98bce85c29d0..a133d8490322 100644
>> >> > --- a/drivers/usb/dwc3/core.c
>> >> > +++ b/drivers/usb/dwc3/core.c
>> >> > @@ -300,8 +300,7 @@ static void dwc3_frame_length_adjustment(struct
>> >> > dwc3 *dwc)
>> >> >
>> >> >       reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
>> >> >       dft = reg & DWC3_GFLADJ_30MHZ_MASK;
>> >> > -     if (!dev_WARN_ONCE(dwc->dev, dft == dwc->fladj,
>> >> > -         "request value same as default, ignoring\n")) {
>> >> > +     if (dft != dwc->fladj) {
>> >>
>> >> if the value isn't different, why do you want to change it?
>> >>
>> >> --
>> >> Balbi
>> > Hi Balbi,
>> >
>> > I don't change any value. I was remove that call trace.
>> 
>> Sure you do. The splat only shows when you request a FLADJ value that's the
>> same as the one already in the register. The reason you see the splat is because
>> your requested value is what's already in the HW.
>> 
>> So, again, why are you adding this device tree property if the value is already the
>> correct one?
>> 
>> > In addition that GFLADJ_30MHZ value intial value is 0, and it's value
>> > must be 0x20, if not, usb will not work.
>> 
>> it's not zero, otherwise the splat wouldn't trigger. You're requesting the value
>> that's already in your register by default.
>> 
>> --
>> Balbi
>
> Hi Balbi,
>    
> According that rm doc that GFLADJ_30MHZ has a default value is 0x20,
> when GFLADJ_30MHZ_REG_SEL is 0, this 0x20 is a hard-coded value.
>
> But in fact, that default value is 0, please you note!    
>
> Then according that xhci spec 5.2.4, that register the sixth bit if is
> 0, then that can support Frame Lenth Timing value.
>
> So set GFLADJ_30MHZ_REG_SEL to 1 for use FLADJ, then I find that it
> must use 0x20 usb will work well, even thoug xhci can permit
> GFLADJ_30MHZ use other value

You only get the splat because you try to sent GFLADJ to 0x20 and it's
ALREADY 0x20. This means that you don't need the property in DTS.

> In addition about what you said is about dts patch, and that patch had
> merged by upstream, patch owner isn't me,

Well, then remove the setting from DTS, since clearly it's not needed.

> My patch is only for remove the call-trace, about why remove it commit
> information has detail introduce please check!

-- 
balbi
