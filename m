Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45DDC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98003222F0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="IMAA9N+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKRSp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:45:29 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44977 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfKRSp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 13:45:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id c19so15421673otr.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 10:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojwNV7qRLqZeN1a5CxXJeGJOgRABSewsVVNOXcM0vKc=;
        b=IMAA9N+YudO3YAIdgOGoya/FONOIdEabjT+1yINPKxJqlTkaRSEtwyybwPL7CeykZf
         SipgE/qBPZ553Q10eYkgfQBQExBr6KcY5eOswAqLT26FcLUbrI6G/dPj1ogC/uhqsLxn
         Q1Xq9alggNKMLnXEou3J39PdiJGASGQ3QPQ5yIw6pShio70mjbFq2/IbqdDWyUvVUG7J
         neNspFdNch1m3wZrS//eTGj2J2LprzfOmXAOgVkd5JHfyI70GsldRcDK9kNMgHprBRvT
         GZUC1oCVESbWPwJD0B4+Q4ZGd+EXr4fPZfe8QzXuP4m5cU94Qdm2rmrWXMHYfKCBi9oE
         Kc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojwNV7qRLqZeN1a5CxXJeGJOgRABSewsVVNOXcM0vKc=;
        b=Z0JrnKomnVeUWBBHdrfN6zp8ZTvPQGNqX6w8NZuNNGSBQh0XUklxTBkpnNx2gnAPoX
         dn8MkE9wGdEXaIX47u5oLHLcPPF2UFHZF9YlPtq30ecjj4sv6RojgxyAwYrFjDKf97Tt
         pBtbGno7JfAJXFjx73UQqUc/tQyeXVBnWWWmbxIfDgEPG8VPszMTy+l3ukDuUBhFeN5l
         FIkUCkg3BcH06uInKZkWAcXS0ltAaOi360YTIgd/hNsUtjCdrd62aSU93spZGOBpEeFI
         tXOvcesy03njflCE/igye57IrfvNCL7mJS1pv9Q1n0izN8qH8hl45WXzlbQ0CiCh/AyR
         O2Gg==
X-Gm-Message-State: APjAAAV9UQhVs4DIPwGgTejBiCR+szZrJlbJ0pdRF6WKNJcmpESTSvgU
        hSff3Z1kvq1z7Kz/e0ZFAVcJvlwsMYkslf4dOna5IQ==
X-Google-Smtp-Source: APXvYqy+/lHyvxwtb1J4RO8yzQj0Uzm8eoZw1lPppdBpE3VKjpr0g0rD+bnc+NAtQu64j02ImaNDD6VJc6GhU8m0Ob8=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr552124otb.126.1574102728187;
 Mon, 18 Nov 2019 10:45:28 -0800 (PST)
MIME-Version: 1.0
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157401276776.43284.12396353118982684546.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157401276776.43284.12396353118982684546.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Nov 2019 10:45:17 -0800
Message-ID: <CAPcyv4g91QYmmkQKVQ+hrROHnd7vDhTMgfSZ_Z0d-9kF_ZaNMg@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] x86/numa: Provide a range-to-target_node lookup facility
To:     linux-nvdimm <linux-nvdimm@lists.01.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        kbuild test robot <lkp@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 10:00 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> The DEV_DAX_KMEM facility is a generic mechanism to allow device-dax
> instances, fronting performance-differentiated-memory like pmem, to be
> added to the System RAM pool. The numa node for that hot-added memory is
> derived from the device-dax instance's 'target_node' attribute.
>
> Recall that the 'target_node' is the ACPI-PXM-to-node translation for
> memory when it comes online whereas the 'numa_node' attribute of the
> device represents the closest online cpu node.
>
> Presently useful target_node information from the ACPI SRAT is discarded
> with the expectation that "Reserved" memory will never be onlined. Now,
> DEV_DAX_KMEM violates that assumption, there is a need to retain the
> translation. Move, rather than discard, numa_memblk data to a secondary
> array that memory_add_physaddr_to_target_node() may consider at a later
> point in time.
>
> Note that memory_add_physaddr_to_nid() is currently only available on
> CONFIG_MEMORY_HOTPLUG=y platforms whereas the target node information
> may be useful on CONFIG_MEMORY_HOTPLUG=n builds, hence why it is calling
> phys_to_target_node() and optionally defined by asm/io.h rather than a
> memory_add_physaddr_to_target_nid() helper that lives in
> include/linux/memory_hotplug.h.
>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/mm/numa.c   |   76 +++++++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/numa.h |    8 +++++
>  mm/mempolicy.c       |    5 +++
>  3 files changed, 83 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 4123100e0eaf..f4f02ac0c465 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -31,6 +31,24 @@ __initdata
>  #endif
>  ;
>
> +/*
> + * Presently, DEV_DAX_KMEM is the only kernel facility that might
> + * convert Reserved or Soft Reserved memory to System RAM.
> + */
> +#if IS_ENABLED(CONFIG_DEV_DAX_KMEM)
> +static struct numa_meminfo __numa_reserved_meminfo;
> +
> +static struct numa_meminfo *numa_reserved_meminfo(void)
> +{
> +       return &__numa_reserved_meminfo;
> +}
> +#else
> +static struct numa_meminfo *numa_reserved_meminfo(void)
> +{
> +       return NULL;
> +}
> +#endif
> +
>  static int numa_distance_cnt;
>  static u8 *numa_distance;
>
> @@ -168,6 +186,26 @@ void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi)
>                 (mi->nr_blks - idx) * sizeof(mi->blk[0]));
>  }
>
> +/**
> + * numa_move_memblk - Move one numa_memblk from one numa_meminfo to another
> + * @dst: numa_meminfo to move block to
> + * @idx: Index of memblk to remove
> + * @src: numa_meminfo to remove memblk from
> + *
> + * If @dst is non-NULL add it at the @dst->nr_blks index and increment
> + * @dst->nr_blks, then remove it from @src.
> + */
> +static void __init numa_move_memblk(struct numa_meminfo *dst, int idx,
> +               struct numa_meminfo *src)
> +{
> +       if (dst) {
> +               memcpy(&dst->blk[dst->nr_blks], &src->blk[idx],
> +                               sizeof(struct numa_memblk));
> +               dst->nr_blks++;
> +       }
> +       numa_remove_memblk_from(idx, src);
> +}
> +
>  /**
>   * numa_add_memblk - Add one numa_memblk to numa_meminfo
>   * @nid: NUMA node ID of the new memblk
> @@ -245,7 +283,7 @@ int __init numa_cleanup_meminfo(struct numa_meminfo *mi)
>                 if (bi->start >= bi->end ||
>                     !memblock_overlaps_region(&memblock.memory,
>                         bi->start, bi->end - bi->start))
> -                       numa_remove_memblk_from(i--, mi);
> +                       numa_move_memblk(numa_reserved_meminfo(), i--, mi);
>         }
>
>         /* merge neighboring / overlapping entries */
> @@ -881,16 +919,44 @@ EXPORT_SYMBOL(cpumask_of_node);
>
>  #endif /* !CONFIG_DEBUG_PER_CPU_MAPS */
>
> +static int meminfo_to_nid(struct numa_meminfo *mi, u64 start, int *nid)
> +{
> +       int i;
> +
> +       for (i = 0; mi && i < mi->nr_blks; i++)
> +               if (mi->blk[i].start <= start && mi->blk[i].end > start) {
> +                       *nid = mi->blk[i].nid;
> +                       break;
> +               }
> +       return i;
> +}
> +
> +int phys_to_target_node(phys_addr_t start)
> +{
> +       struct numa_meminfo *mi = &numa_meminfo;
> +       int nid = mi->blk[0].nid;
> +       int i = meminfo_to_nid(mi, start, &nid);
> +
> +       /*
> +        * Prefer online nodes, but if reserved memory might be
> +        * hot-added continue the search with reserved ranges.
> +        */
> +       if (i < mi->nr_blks)
> +               return nid;
> +
> +       mi = numa_reserved_meminfo();
> +       meminfo_to_nid(mi, start, &nid);
> +       return nid;
> +}

The kbuild-robot points out that this function causes a section
mismatch warning in the CONFIG_MEMORY_HOTPLUG=n case. It touches
numa_meminfo which gets marked __init in that configuration. Given the
numa information is useful independent of memory hotplug I am going to
add a patch to add a CONFIG_KEEP_NUMA configuration symbol that is
selected by CONFIG_MEMORY_HOTPLUG, or any driver that wants to use
phys_to_target_node(). Then use CONFIG_KEEP_NUMA to gate whether
numa_meminfo is marked __init, or not.
