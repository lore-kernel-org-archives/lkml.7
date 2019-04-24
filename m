Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA20C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8182F218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfDXMMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:12:41 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24082 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfDXMMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:12:41 -0400
X-IronPort-AV: E=Sophos;i="5.60,389,1549954800"; 
   d="scan'208";a="28036781"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Apr 2019 05:12:39 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.352.0; Wed, 24 Apr 2019
 05:12:39 -0700
Date:   Wed, 24 Apr 2019 14:12:38 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Paul Burton <paul.burton@mips.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Resend] arch: mips: Fix initrd_start and initrd_end when read
 from DT
Message-ID: <20190424121236.uadnsmgg3ctvljdo@soft-dev3.microsemi.net>
References: <1555409900-31278-1-git-send-email-horatiu.vultur@microchip.com>
 <20190419205456.uylahdin2jlkeyyy@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20190419205456.uylahdin2jlkeyyy@pburton-laptop>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for your detail explanation. There are few observations below.

The 04/19/2019 20:55, Paul Burton wrote:
> External E-Mail
> 
> 
> Hi Horatiu,
> 
> On Tue, Apr 16, 2019 at 12:18:20PM +0200, Horatiu Vultur wrote:
> > When the bootloader passes arguments to linux kernel through device tree,
> > it passes the address of initrd_start and initrd_stop, which are in kseg0.
> > But when linux kernel reads these addresses from device tree, it converts
> > them to virtual addresses inside the function
> > __early_init_dt_declare_initrd.
> 
> I'm not sure I follow - if the bootloader provides an address in kseg0
> then it's already a virtual address.

So I am just a novice in this, but in my case the bootloader(Uboot) passes
the address in kseg0(e.g 0x9f8a6000), but if I understand correctly
this is just cached access to location 0x1f8a6000.

> 
> It looks like __early_init_dt_declare_initrd expects the DT to provide
> physical addresses, which fits in well with the fact that DTs generally
> use physical addresses for everything else.
> 
> __early_init_dt_declare_initrd calling __va on a virtual address will
> give you something bogus, and it looks like you're just cancelling this
> out below. In practice for a typical system where PAGE_OFFSET is the
> start of kseg0 (0x80000000) the bogus address you get will happen to be
> the same as the physical address, but that's not guaranteed.
> 
> > At a later point then in the function init_initrd, it is checking for
> > initrd_start to be lower than PAGE_OFFSET, which for a 32 CPU it is not,
> > therefore it would disable the initrd by setting 0 to initrd_start and
> > initrd_stop.
> 
> The check you mention here is to make sure initrd_start looks like a
> virtual address - if it's lower than PAGE_OFFSET (typically 0x80000000)
> then it looks bad & initrd is disabled. I think your comment is
> backwards - what you have is a physical address, entirely by accident,
> and you're converting it back to a virtual address again by accident
> which keeps the check happy.

I am a little bit confused here. so the initrd_start has to have a
virtual address(in kseg0) inside the function init_initrd. Meaning that
when the bootloader passes the arguments to linux through a command line,
then initrd_start has to be already a virtual address? Because I
couldn't see a place where it converts the initrd_start. But when the
bootloader pass the arguments through DT it has to be physical address?

> 
> > The fix consists of checking if linux kernel received a device tree and not
> > having enable extended virtual address and in that case convert them back
> > to physical addresses that point in kseg0 as expected.
> 
> Can you instead just have your bootloader provide physical addresses in
> the DT?

Yes, I have done few tests and it seems to work fine, but I need to
understand it better.

> 
> Even if we were to have this code try to sanitize the value with
> something like __va(__pa(initrd_start)), it only covers systems using
> the UHI boot protocol which isn't the only way we can obtain a DT. If a
> system builds in its DTB for example it'll get different behaviour to if
> it's passed via the UHI protocol by the bootloader.
> 
> Thanks,
>     Paul
> 
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  arch/mips/kernel/setup.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> > index 8d1dc6c..774ee00 100644
> > --- a/arch/mips/kernel/setup.c
> > +++ b/arch/mips/kernel/setup.c
> > @@ -264,6 +264,17 @@ static unsigned long __init init_initrd(void)
> >  		pr_err("initrd start must be page aligned\n");
> >  		goto disable;
> >  	}
> > +
> > +	/*
> > +	 * In case the initrd_start and initrd_end are read from DT,
> > +	 * then they are converted to virtual address, therefore convert
> > +	 * them back to physical address.
> > +	 */
> > +	if (!IS_ENABLED(CONFIG_EVA) && fw_arg0 == -2) {
> > +		initrd_start = initrd_start - PAGE_OFFSET + PHYS_OFFSET;
> > +		initrd_end = initrd_end - PAGE_OFFSET + PHYS_OFFSET;
> > +	}
> > +
> >  	if (initrd_start < PAGE_OFFSET) {
> >  		pr_err("initrd start < PAGE_OFFSET\n");
> >  		goto disable;
> > -- 
> > 2.7.4
> > 
> 

-- 
/Horatiu
