Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6CAC2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 01:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F33206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 01:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hr2ixI8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfLaBda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 20:33:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50642 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727827AbfLaBd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 20:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577756008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+BU8EnvAFQ15SiyK+InKxVY2/QKfob4UUICg/0rQxlk=;
        b=Hr2ixI8Bd4mHwiXbkgzJ9xXVLJEBx9EeaWZptvye0PFJdc2NCK7NzC+e9kTza4f730hL3M
        lCovfgrynEdY0VnFZwKMl/9ruseT4a7AIMi3aQQf3CGpwMI1nL7vKMrzmjus/XX92Ebnow
        /+Ak7WKTZy2Zo3BC2N+PaVbIJq6bGuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-9I-U1Z06Nn6CXQqW1s8xdQ-1; Mon, 30 Dec 2019 20:33:24 -0500
X-MC-Unique: 9I-U1Z06Nn6CXQqW1s8xdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A885E18031C3;
        Tue, 31 Dec 2019 01:33:22 +0000 (UTC)
Received: from localhost (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C314410001BD;
        Tue, 31 Dec 2019 01:33:21 +0000 (UTC)
Date:   Tue, 31 Dec 2019 09:33:18 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        "Jin, Zhi" <zhi.jin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm/page_alloc: Skip non present sections on zone
 initialization
Message-ID: <20191231013318.GB26758@MiWiFi-R3L-srv>
References: <20191230093828.24613-1-kirill.shutemov@linux.intel.com>
 <20191231012345.GA26758@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231012345.GA26758@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/19 at 09:23am, Baoquan He wrote:
> On 12/30/19 at 12:38pm, Kirill A. Shutemov wrote:
> > memmap_init_zone() can be called on the ranges with holes during the
> > boot. It will skip any non-valid PFNs one-by-one. It works fine as long
> > as holes are not too big.
> > 
> > But huge holes in the memory map causes a problem. It takes over 20
> > seconds to walk 32TiB hole. x86-64 with 5-level paging allows for much
> > larger holes in the memory map which would practically hang the system.
> > 
> > Deferred struct page init doesn't help here. It only works on the
> > present ranges.
> > 
> > Skipping non-present sections would fix the issue.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> > 
> > The situation can be emulated using the following QEMU patch:
> > 
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index ac08e6360437..f5f2258092e1 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1159,13 +1159,14 @@ void pc_memory_init(PCMachineState *pcms,
> >      memory_region_add_subregion(system_memory, 0, ram_below_4g);
> >      e820_add_entry(0, x86ms->below_4g_mem_size, E820_RAM);
> >      if (x86ms->above_4g_mem_size > 0) {
> > +        int shift = 45;
> >          ram_above_4g = g_malloc(sizeof(*ram_above_4g));
> >          memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram,
> >                                   x86ms->below_4g_mem_size,
> >                                   x86ms->above_4g_mem_size);
> > -        memory_region_add_subregion(system_memory, 0x100000000ULL,
> > +        memory_region_add_subregion(system_memory, 1ULL << shift,
> >                                      ram_above_4g);
> > -        e820_add_entry(0x100000000ULL, x86ms->above_4g_mem_size, E820_RAM);
> > +        e820_add_entry(1ULL << shift, x86ms->above_4g_mem_size, E820_RAM);
> >      }
> >  
> >      if (!pcmc->has_reserved_memory &&
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index cde2a16b941a..694c26947bf6 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -1928,7 +1928,7 @@ uint64_t cpu_get_tsc(CPUX86State *env);
> >  /* XXX: This value should match the one returned by CPUID
> >   * and in exec.c */
> >  # if defined(TARGET_X86_64)
> > -# define TCG_PHYS_ADDR_BITS 40
> > +# define TCG_PHYS_ADDR_BITS 52
> >  # else
> >  # define TCG_PHYS_ADDR_BITS 36
> >  # endif
> > 
> > ---
> >  mm/page_alloc.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index df62a49cd09e..442dc0244bb4 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5873,6 +5873,30 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
> >  	return false;
> >  }
> >  
> > +#ifdef CONFIG_SPARSEMEM
> > +/* Skip PFNs that belong to non-present sections */
> > +static inline __meminit unsigned long next_pfn(unsigned long pfn)
> > +{
> > +	unsigned long section_nr;
> > +
> > +	section_nr = pfn_to_section_nr(++pfn);
> > +	if (present_section_nr(section_nr))
> > +		return pfn;
> > +
> > +	while (++section_nr <= __highest_present_section_nr) {
> > +		if (present_section_nr(section_nr))
> > +			return section_nr_to_pfn(section_nr);
> > +	}
> > +
> > +	return -1;
> > +}
> > +#else
> > +static inline __meminit unsigned long next_pfn(unsigned long pfn)
> > +{
> > +	return pfn++;
> > +}
> > +#endif
> > +
> >  /*
> >   * Initially all pages are reserved - free ones are freed
> >   * up by memblock_free_all() once the early boot process is
> > @@ -5912,8 +5936,10 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> >  		 * function.  They do not exist on hotplugged memory.
> >  		 */
> >  		if (context == MEMMAP_EARLY) {
> > -			if (!early_pfn_valid(pfn))
> > +			if (!early_pfn_valid(pfn)) {
> > +				pfn = next_pfn(pfn) - 1;
> 
> Just pass by, I think this is a necessary optimization. Wondering why
> next_pfn(pfn) is not put in for loop:
> -	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> +	for (pfn = start_pfn; pfn < end_pfn; pfn=next_pfn(pfn)) {
> 
> 
> >  				continue;
> > +			}
> >  			if (!early_pfn_in_nid(pfn, nid))
> >  				continue;
> 
> Why the other two 'continue' don't need be worried on the huge hole
> case?

OK, I see. early_pfn_valid() may have encountered the huge hole case,
the check in patch sounds reasonable.

FWIW, looks good to me.

Reviewed-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

