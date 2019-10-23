Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195D2CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B9021872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390293AbfJWI0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:26:39 -0400
Received: from salem.gmr.ssr.upm.es ([138.4.36.7]:56260 "EHLO
        salem.gmr.ssr.upm.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfJWI0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:26:39 -0400
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Oct 2019 04:26:38 EDT
Received: by salem.gmr.ssr.upm.es (Postfix, from userid 1000)
        id C3267AC0075; Wed, 23 Oct 2019 10:17:29 +0200 (CEST)
Date:   Wed, 23 Oct 2019 10:17:29 +0200
From:   Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: microblaze: support for reserved-memory entries in
 DT
Message-ID: <20191023081728.GA17517@salem.gmr.ssr.upm.es>
References: <20191022081929.10602-1-alvaro.gamez@hazent.com>
 <64db9f22-2e24-23f8-bf64-c4a972fa50c1@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64db9f22-2e24-23f8-bf64-c4a972fa50c1@monstr.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal

On Wed, Oct 23, 2019 at 09:59:40AM +0200, Michal Simek wrote:
> Hi,
> 
> 
> On 22. 10. 19 10:19, Alvaro Gamez Machado wrote:
> > Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
> 
> please put there reasonable description to commit message.

Ok, will use those below as template.
 
> > ---
> >  arch/microblaze/mm/init.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
> > index a015a951c8b7..928c5c2816e4 100644
> > --- a/arch/microblaze/mm/init.c
> > +++ b/arch/microblaze/mm/init.c
> > @@ -17,6 +17,8 @@
> >  #include <linux/slab.h>
> >  #include <linux/swap.h>
> >  #include <linux/export.h>
> > +#include <linux/of_fdt.h>
> > +#include <linux/of.h>
> 
> of_fdt.h should be enough.

Ok

> >  
> >  #include <asm/page.h>
> >  #include <asm/mmu_context.h>
> > @@ -188,6 +190,9 @@ void __init setup_memory(void)
> >  
> >  void __init mem_init(void)
> >  {
> > +	early_init_fdt_reserve_self();
> > +	early_init_fdt_scan_reserved_mem();
> > +
> >  	high_memory = (void *)__va(memory_start + lowmem_size - 1);
> >  
> >  	/* this will put all memory onto the freelists */
> > 
> 
> 
> Also I have looked at others arch and take a look at
> 
> 1b10cb21d888c021bedbe678f7c26aee1bf04ffa
> ARC: add support for reserved memory defined by device tree
> 
> where they also enable OF_RESERVED_MEM to call fdt_init_reserve_mem()
> 
> The same here
> 4e7c84ec045921dacc78d36295e2e61390249665
>  xtensa: support reserved-memory DT node
> 
> and here
> 9bf14b7c540ae9ca7747af3a0c0d8470ef77b6ce
> arm64: add support for reserved memory defined by device tree
> 

They did that at the time, but it seems it's not needed anymore:

34e04eedd1cf1be714abb0e5976338cc72ccc05f
  of: select OF_RESERVED_MEM automatically

This commit removed those select OF_RESERVED_MEM lines. Is it needed
specifically for microblaze? I didn't need to do that in order for
reserved-memory entries to work on my platform.

Thanks!

> Please note this in commit message.
> 
> Thanks,
> Michal
> 
> 
> -- 
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Xilinx Microblaze
> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
> 

-- 
Alvaro G. M.
