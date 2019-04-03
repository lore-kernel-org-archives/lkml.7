Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3F5C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2620320657
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfDCRYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:24:34 -0400
Received: from foss.arm.com ([217.140.101.70]:45550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfDCRYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:24:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0BBF80D;
        Wed,  3 Apr 2019 10:24:33 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A6F23F68F;
        Wed,  3 Apr 2019 10:24:32 -0700 (PDT)
Date:   Wed, 3 Apr 2019 18:24:29 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     pierre kuo <vichy.kuo@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        ard.biesheuvel@linaro.org
Subject: Re: [PATCH v2 1/1] initrd: move initrd_start calculate within linear
 mapping range check
Message-ID: <20190403172429.GE17500@fuggles.cambridge.arm.com>
References: <20190314032047.15790-1-vichy.kuo@gmail.com>
 <20190319153114.GI59586@arrakis.emea.arm.com>
 <CAOVJa8HSB34ggku=96KAb6qju3G5-uGYFxCE6O2eQRMwU4bd1A@mail.gmail.com>
 <CAOVJa8Eefs7cEneNwV0VCrr8GLVb0AweJEb0Qo4TucgXTNuNWg@mail.gmail.com>
 <20190401153810.GC6884@fuggles.cambridge.arm.com>
 <CAOVJa8EcjQO2GuojwBxfFG25+T-z6BR6ytZBdcV2W2XusyW08g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOVJa8EcjQO2GuojwBxfFG25+T-z6BR6ytZBdcV2W2XusyW08g@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 12:44:25AM +0800, pierre kuo wrote:
> > On Mon, Apr 01, 2019 at 10:59:53PM +0800, pierre kuo wrote:
> > > > > With CONFIG_RANDOMIZE_BASE we can get a further change to memstart_addr
> > > > > after the place where you moved the initrd_{start,end} setting, which
> > > > > would result in a different value for __phys_to_virt(phys_initrd_start).
> > > >
> > > > I found what you mean, since __phys_to_virt will use PHYS_OFFSET
> > > > (memstart_addr) for calculating.
> > > > How about moving CONFIG_RANDOMIZE_BASE part of code ahead of
> > > > CONFIG_BLK_DEV_INITRD checking?
> > > >
> > > > That means below (d) moving ahead of (c)
> > > > prvious:
> > > > if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {} ---(a)
> > > > if (memory_limit != PHYS_ADDR_MAX) {}            ---(b)
> > > > if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {} ---(c)
> > > > if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {} ---(d)
> > > >
> > > > now:
> > > > if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) { ---(a)
> > > > if (memory_limit != PHYS_ADDR_MAX) {}              ----------------(b)
> > > > if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {}  --------------(d)
> > > > if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {}  ---(c)
> > > >
> > >
> > > After tracing the kernel code,
> > > is it even possible to move CONFIG_RANDOMIZE_BASE part of code ahead
> > > of memory_limit?
> > >
> > > that mean the flow may look like below:
> > > now2:
> > > if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {} ---(a)
> > > if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {} ---(d)
> > > if (memory_limit != PHYS_ADDR_MAX) {}            ---(b)
> > > if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {} ---(c)
> > >
> > > in (b), the result of __pa_symbol(_text), memory_limit,
> > > memblock_mem_limit_remove_map and  memblock_add
> > > are not depended on memsart_addr.
> > > So the now2 flow can grouping modification of memstart_address, put
> > > (a) and (d) together.
> >
> > I'm afraid that you've lost me with this.
> welcome for ur kind suggestion ^^
> 
> >Why isn't it just as simple as
> > the diff below?
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index c29b17b520cd..ec3487c94b10 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -377,7 +377,7 @@ void __init arm64_memblock_init(void)
> >                          base + size > memblock_start_of_DRAM() +
> >                                        linear_region_size,
> >                         "initrd not fully accessible via the linear mapping -- please check your bootloader ...\n")) {
> > -                       initrd_start = 0;
> > +                       phys_initrd_size = 0;
> >                 } else {
> >                         memblock_remove(base, size); /* clear MEMBLOCK_ flags */
> >                         memblock_add(base, size);
> 
> This patch will also fix the issue, but it still needs 2 "if
> comparisions" for getting initrd_start/initrd_end.
> By possible grouping modification of memstart_address, and put
> initrd_start/initrd_end to be calculated only when linear mapping check
> pass. Maybe (just if) can let the code be more concise.

Maybe, but I don't think we've seen a patch which accomplishes that. I think
I'll go ahead and commit the basic one-liner, then we can always improve it
afterwards if somebody sends a patch. It's not like this is a fastpath.

Will
