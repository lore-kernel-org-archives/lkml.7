Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F07C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0AD214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cPbPmc0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfLLRFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:05:52 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33216 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbfLLRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4X5EU0pfF6Z3fhCjCKm1r7MRDtxFUKoUAl8Auif1vpI=; b=cPbPmc0rPHNht2FyrAGsaL4sZ
        6UXaRrzmPZh0viTAYeczfFgxsMwVY1SpImOKLyMrRC6lT6GZ7zjWt6KLglfTVuqTAC/mlfRCooU+F
        QvWlKLsWtfZPg2HtBxWGj9gySogBEKbimrt9u2mT8q2NBhtsXwna2XOz4vPTn07i3amCDQsnmD2Ze
        3KhwunOnHYHY+gkzl7QGXDym8pFeawWZIHfGGG+YV55tsQw77jlhckNXA27+K8tpZGxTZg7IPTOJN
        zWDEIDu6mp7o8G9ZuvpXFYxL5jTUMyFfhQPYwQ4xGSjYxSj8m4TXSUnoMNyTipXBhlHj3GIMqGAGY
        jKTIzVZ4A==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:47912)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ifRuF-00080S-OB; Thu, 12 Dec 2019 17:05:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ifRuD-0006y7-98; Thu, 12 Dec 2019 17:05:37 +0000
Date:   Thu, 12 Dec 2019 17:05:37 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        x86 <x86@kernel.org>
Subject: Re: [PATCH v1] clk: Convert managed get functions to devm_add_action
 API
Message-ID: <20191212170537.GL25745@shell.armlinux.org.uk>
References: <3d8a58bf-0814-1ec1-038a-10a20b9646ad@free.fr>
 <20191128185630.GK82109@yoga>
 <20191202014237.GR248138@dtor-ws>
 <f177ef95-ef7e-cab0-1322-6de28f18ecdb@free.fr>
 <c0ccca86-b7b1-b587-60c1-4794376fa789@arm.com>
 <ba630966-5479-c831-d0e2-bc2eb12bc317@free.fr>
 <20191211222829.GV50317@dtor-ws>
 <70528f77-ca10-01cd-153b-23486ce87d45@free.fr>
 <cf5b3dee-061e-a476-7219-aa08c2977488@arm.com>
 <6a647c20-c2fa-f14c-256d-6516d0ad03b0@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a647c20-c2fa-f14c-256d-6516d0ad03b0@free.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 05:59:04PM +0100, Marc Gonzalez wrote:
> On 12/12/2019 15:47, Robin Murphy wrote:
> 
> > On 12/12/2019 1:53 pm, Marc Gonzalez wrote:
> >
> >> On 11/12/2019 23:28, Dmitry Torokhov wrote:
> >>
> >>> On Wed, Dec 11, 2019 at 05:17:28PM +0100, Marc Gonzalez wrote:
> >>>
> >>>> What is the rationale for the devm_add_action API?
> >>>
> >>> For one-off and maybe complex unwind actions in drivers that wish to use
> >>> devm API (as mixing devm and manual release is verboten). Also is often
> >>> used when some core subsystem does not provide enough devm APIs.
> >>
> >> Thanks for the insight, Dmitry. Thanks to Robin too.
> >>
> >> This is what I understand so far:
> >>
> >> devm_add_action() is nice because it hides/factorizes the complexity
> >> of the devres API, but it incurs a small storage overhead of one
> >> pointer per call, which makes it unfit for frequently used actions,
> >> such as clk_get.
> >>
> >> Is that correct?
> >>
> >> My question is: why not design the API without the small overhead?
> > 
> > Probably because on most architectures, ARCH_KMALLOC_MINALIGN is at 
> > least as big as two pointers anyway, so this "overhead" should mostly be 
> > free in practice. Plus the devres API is almost entirely about being 
> > able to write simple robust code, rather than absolute efficiency - I 
> > mean, struct devres itself is already 5 pointers large at the absolute 
> > minimum ;)
> 
> (3 pointers: 1 list_head + 1 function pointer)
> 
> I'm confused. The first patch was criticized for potentially adding
> an extra pointer for every devm_clk_get (e.g. 800 bytes on a 64-bit
> platform with 100 clocks).
> 
> Let's see. On arm64, ARCH_KMALLOC_MINALIGN is 128.
> 
> So basically, a struct devres looks like this on arm64:
> 
> 	list_head.next
> 	list_head.prev
> 	dr_release_t
> 		.
> 		.
> 		.
> 	104 bytes of padding
> 		.
> 		.
> 		.
> 	data (flexible array)
> 		.
> 		.
> 		.
> 	padding up to 256 bytes
> 
> 
> Basically, on arm64, every struct devres occupies 256 bytes, most of it
> (typically 104 + 112 = 216) wasted as padding.
> 
> Hmmm, given how many devm stuff goes on in a modern platform, there
> might be large savings to be had...
> 
> Assuming 10,000 calls to devres_alloc_node(), we would be wasting ~2 MB
> of RAM. Not sure it's worth trying to save that?
> 
> $ git grep '#define ARCH_DMA_MINALIGN'
> arch/arc/include/asm/cache.h:#define ARCH_DMA_MINALIGN  SMP_CACHE_BYTES
> arch/arm/include/asm/cache.h:#define ARCH_DMA_MINALIGN  L1_CACHE_BYTES
> arch/arm64/include/asm/cache.h:#define ARCH_DMA_MINALIGN        (128)
> arch/c6x/include/asm/cache.h:#define ARCH_DMA_MINALIGN  L1_CACHE_BYTES
> arch/csky/include/asm/cache.h:#define ARCH_DMA_MINALIGN L1_CACHE_BYTES
> arch/hexagon/include/asm/cache.h:#define ARCH_DMA_MINALIGN      L1_CACHE_BYTES
> arch/m68k/include/asm/cache.h:#define ARCH_DMA_MINALIGN L1_CACHE_BYTES
> arch/microblaze/include/asm/page.h:#define ARCH_DMA_MINALIGN    L1_CACHE_BYTES
> arch/mips/include/asm/mach-generic/kmalloc.h:#define ARCH_DMA_MINALIGN  128
> arch/mips/include/asm/mach-ip32/kmalloc.h:#define ARCH_DMA_MINALIGN     32
> arch/mips/include/asm/mach-ip32/kmalloc.h:#define ARCH_DMA_MINALIGN     128
> arch/mips/include/asm/mach-tx49xx/kmalloc.h:#define ARCH_DMA_MINALIGN L1_CACHE_BYTES
> arch/nds32/include/asm/cache.h:#define ARCH_DMA_MINALIGN   L1_CACHE_BYTES
> arch/nios2/include/asm/cache.h:#define ARCH_DMA_MINALIGN        L1_CACHE_BYTES
> arch/parisc/include/asm/cache.h:#define ARCH_DMA_MINALIGN       L1_CACHE_BYTES
> arch/powerpc/include/asm/page_32.h:#define ARCH_DMA_MINALIGN    L1_CACHE_BYTES
> arch/sh/include/asm/page.h:#define ARCH_DMA_MINALIGN    L1_CACHE_BYTES
> arch/unicore32/include/asm/cache.h:#define ARCH_DMA_MINALIGN    L1_CACHE_BYTES
> arch/xtensa/include/asm/cache.h:#define ARCH_DMA_MINALIGN       L1_CACHE_BYTES
> 
> Hmmm, how does arch/x86 do it?

As I understand it, x86 tends to be fully coherent, so has no there
is not much requirement for DMA to be aligned to cachelines.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
