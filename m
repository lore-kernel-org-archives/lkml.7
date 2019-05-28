Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BAEC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D831720B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559038791;
	bh=/Z71lIdbA1iPMW4yhci+/fst7eiRfIGrEAKen5cASvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=yxMmxRRaDgqIY17qfe9YO2V8sMp6ApT1i1lcOj/prVa/xC9PRt476ZnxHnsc7b7S3
	 2JBEd+vgg91YjQFtYahidKdkxk3x/vf9qU1n4iV/lu9wEFmpE+gTUVFj5hbzZ+eEcC
	 CYEtwF0uTltsMLa4Avidql71gvUmJD5qmogGmleQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfE1KTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:19:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:9291 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfE1KTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:19:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 03:19:49 -0700
X-ExtLoop1: 1
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga001.fm.intel.com with ESMTP; 28 May 2019 03:19:48 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list\:DESIGNWARE USB3 DRD IP DRIVER" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: Enable the USB snooping
In-Reply-To: <AM5PR0402MB28654EBE2D431CC2F8061CF8F11E0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20171115060459.45375-1-ran.wang_1@nxp.com> <87ineb9b5v.fsf@linux.intel.com> <VI1PR04MB1504776EF3D4D8C374F0C069F1290@VI1PR04MB1504.eurprd04.prod.outlook.com> <87shdfet90.fsf@linux.intel.com> <AM5PR0402MB28654EBE2D431CC2F8061CF8F11E0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
Date:   Tue, 28 May 2019 13:19:47 +0300
Message-ID: <87k1eaanjw.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Ran Wang <ran.wang_1@nxp.com> writes:

> Hi Felipe,
>
>     Sorry for the late reply:
>
> On Wednesday, November 15, 2017 18:23, Felipe Balbi wrote:

that's 1.5 year ago. I really don't remember the details of this conversation

>> Ran Wang <ran.wang_1@nxp.com> writes:
>> >> Ran Wang <ran.wang_1@nxp.com> writes:
>> >> > Add support for USB3 snooping by asserting bits in register
>> >> > DWC3_GSBUSCFG0 for data and descriptor.
>> >>
>> >> we know *how* to enable a feature :-) It's always the same, you
>> >> fiddle with some registers and it works. What you failed to tell us is:
>> >>
>> >> a) WHY do you need this?
>> >> b) WHY do we need another DT property for this?
>> >> c) WHAT does this mean for PCI devices?
>> >
>> > So far I cannot have the answer for you, will get you back after some
>> > discussion with my colleagues.
>> 
>> IOW, you have no idea why you need this, right? We're not patching things for
>> the sake of patching things. We need to understand what these changes mean
>> to the HW before we send out a patch publicly.
>> 
>> Remember that the moment a patch like this is accepted, it has the potential of
>> changing behavior for *ALL* users.
>> 
>> >> > +	}
>> >> > +
>> >> > +	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
>> >>
>> >> this will *always* read and write GSBUSCFG0 even for those platforms
>> >> which don't need to change anything on this register. You should just
>> >> bail out early if !dwc->dma_coherent
>> >>
>> >> Also, I think dma_coherent is likely not the best name for this property.
>> >>
>> >> Another question is: Why wasn't this setup properly during
>> >> coreConsultant instantiation of the RTL? Do you have devices on the
>> >> market already that need this or is this some early FPGA model or test-only
>> ASIC?
>> >
>> > Yes, you are right. Actually I thought that all dwc3 IP  will have
>> > this register, and it can be controlled by DTS property.
>> 
>> they all *have* the register, however, it's sort of expected that RTL engineer will
>> setup good defaults when instantiating the RTL using SNPS'
>> coreConsultant tool.
>> 
>> Does your platform work without this patch?
>
> On Layerscape SoC (such as LS1088A, LS1046A, LS1043A) When I add 'dma-coherent'
> to USB nodes without this patch, dwc3 will fail on device enumeration as below:
> [    3.610620] xhci-hcd xhci-hcd.2.auto: WARNING: Host System Error
> [    3.630609] usb usb2-port1: couldn't allocate usb_device

Right, and same as before: are these devices in the market or are you
dealing with pre-silicon prototypes?

>> >> >  /* Global Debug Queue/FIFO Space Available Register */
>> >> >  #define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
>> >> >  #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
>> >> > @@ -859,6 +867,7 @@ struct dwc3_scratchpad_array {
>> >> >   * 	3	- Reserved
>> >> >   * @imod_interval: set the interrupt moderation interval in 250ns
>> >> >   *                 increments or 0 to disable.
>> >> > + * @dma_coherent: set if enable dma-coherent.
>> >>
>> >> you're not enabling dma coherency, you're enabling cache snooping.
>> >> And this property should describe that. Also, keep in mind that
>> >> different devices may want different cache types for each of those
>> >> fields, so your property would have to be a lot more complex. Something like:
>> >>
>> >> 	snps,cache-type = <foobar "cacheable">, <baz "cacheable">, ...
>> >>
>> >> Then driver would have to parse this properly to setup GSBUSCFG0.
>
> According to the DesignWare Cores SuperSpeed USB 3.0 Controller Databook (v2.60a),
> it has described Type Bit Assignments for all supported master bus type:
> AHB, AXI3, AXI4 and Native. I found the bit definition are different among them.
> So, for the example you gave above, feel a little bit confused. 
> Did you mean:
>     snps,cache-type = <DATA_RD  "write allocate">, <DESC_RD "cacheable">, <DATA_WR  "bufferable">, <DESC_WR  "read allocate">

yeah, something like that.

>> > Got it, learn a lot, need more time to digest and test, thanks for
>> > your patiently explanation.
>> 
>> no problem, please figure out the answers to my previous questions, without
>> which I can't accept your patch.

^^^

I still don't have all the answers

-- 
balbi
