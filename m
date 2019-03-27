Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E763C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BDC2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5jnzZkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfC0WFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:05:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39163 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC0WFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:05:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id p20so14987949eds.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ND2aP4CvAW94uzpYxHJXlDaBzbOabRXBg6QbMg2nYWs=;
        b=K5jnzZkdNMzVze237gA2hKZiJ+KZLOoh4KTCX3vS0ZXjmU2MOEiWUazPOVuoopfpJt
         L6/rs+uCK1VEY8M6ZAJRpEA9Nw6yYjEX3Gj3cZTqdUvz+LVJQGHwz2Ai61Yxo5whzmS8
         FXn/krPL34udheN1j+3h0v/ArL5UNFP6mefpqgitqXvcPLFrzCfemyfESP3gsfgJHXV4
         5spGm1QPB1TXWzSWyz2Re+QGqLPliPyWUAYy59dofTBS/KqU7deS/Cta9fkf5ATSbSV5
         zn9AH6iXPfsmL7P2aSP+Ap+Y1CAoZJx+6MqxvoIQkl5EvVu60+u8vw7/SZ37PdxKB10G
         MbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ND2aP4CvAW94uzpYxHJXlDaBzbOabRXBg6QbMg2nYWs=;
        b=unlNistjqpY6hp+u3V7e3cwvSxtpdllsQOsEBynK9VAmpWhxMwh6pnPNFeIltQfoln
         LRZoAExmO9+yS727vFl/IYhG9582k3I8P2/ubboHFXsekF4/VYAnnJrMdwur7rQ7+jG5
         dlmdThb5VJ+9RyKHoVGnlyUPx+RgO/bPMOQNEMnb+5UK6iPEVweqw/9KVjqqWLiuNa3d
         s478YaLqoKzUCm4XIWTwbH0NY5fptw86jzaYvQTALzDw97YR9oji+vacGOeKlClyvXhn
         IKH/7dfuBvNlQQP89Clyy9ZNGv0R/XSQjoRQhadsch4ZEoihn+Cpp3lLhaPtXog+uDdC
         Cqpg==
X-Gm-Message-State: APjAAAUAdc/kzeYhVMgkq99Eqzd8FOBXQ6oyihupCBvLH4qUWIdq63CS
        50b6NSewuXj0Qo2ENX6atlE=
X-Google-Smtp-Source: APXvYqxD3ldVnDUaKLhM+JmVDCb60GrjBcRlZNV0dnNEHILmHv/dVqDnmD2FmRPGmWqiF0oFkYzCdQ==
X-Received: by 2002:a17:906:4d85:: with SMTP id s5mr17398970eju.18.1553724314326;
        Wed, 27 Mar 2019 15:05:14 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id lw14sm1171011ejb.24.2019.03.27.15.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 15:05:13 -0700 (PDT)
Date:   Wed, 27 Mar 2019 22:05:13 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or
Subject: Re: [PATCH 4/6] x86, mm: make split_mem_range() more easy to read
Message-ID: <20190327220513.p4qrgxhvmvgooxjv@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190212021215.13247-1-richardw.yang@linux.intel.com>
 <20190212021215.13247-5-richardw.yang@linux.intel.com>
 <alpine.DEB.2.21.1903232345500.1798@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903232345500.1798@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 03:29:04PM +0100, Thomas Gleixner wrote:
>Wei,
>
>On Tue, 12 Feb 2019, Wei Yang wrote:
>> 
>> This patch changes the implementation from the first perception to the
>> second to reduce one different handling on end_pfn. After doing so, the
>> code is easier to read.
>
>It's maybe slightly easier to read, but it's still completely unreadable
>garbage.
>
>  Not your fault, it was garbage before.
>
>But refining garbage still results in garbage. Just the smell is slightly
>different.
>
>Why?
>
> 1) Doing all the calculations PFN based is just a pointless
>    indirection. Just look at all the rounding magic and back and forth
>    conversions.
>    
>    All of that can be done purely address/size based which makes the code
>    truly readable.
>
> 2) The 5(3) sections are more or less copied code with a few changes of
>    constants, except for the first section (A) which has an extra quirk
>    for 32bit. Plus all the 64bit vs. 32bit #ifdeffery which is not making
>    it any better.
>
>    This copied mess can be avoided by using helper functions and proper
>    loops.
>
> 3) During the bootmem phase the code tries to preserve large mappings
>    _AFTER_ splitting them up and then it tries to merge the resulting
>    overlaps.
>
>    This is completely backwards because the expansion of the range can be
>    tried right away when then mapping of a large page is attempted. Surely
>    not with the current mess, but with a proper loop based approach it can
>    be done nicely.
>
>    Btw, there is a bug in that expansion code which could result in
>    undoing the enforced 4K mapping of the lower 2M/4M range on 32bit. It's
>    probably not an issue in practice because the low range is usually not
>    contiguous. But it works by chance not by design.
>
> 4) The debug print string retrieval function is just silly.
>
>The logic for rewriting this is pretty obvious:
>
>    while (addr < end) {
>    	  setup_mr(mr, addr, end);
>    	  for_each_map_size(1G, 2M, 4K) {
>	  	if (try_map(mr, size))
>			break;
>	  }
>	  addr = mr->end;
>    }
>
>    setup_mr() takes care of the 32bit 0-2/4M range by limiting the
>    range and setting the allowed size mask in mr to 4k only.
>
>    try_map() does:
>    
>       1) Try to expand the range to preserve large pages during bootmem
>       
>       2) If the range start is not aligned, limit the end to the large
>          size boundary, so the next lower map size will only cover the
>	  unaligned portion.
>
>       3) If the range end is not aligned, fit as much large
>          size as possible.
>
>   No magic A-E required, because it just falls into place naturally and
>   the expansion is done at the right place and not after the fact.
>
>Find a mostly untested patch which implements this below. I just booted it
>in a 64bit guest and it did not explode.
>
>It removes 55 lines of code instead of adding 35 and reduces the binary
>size by 408 bytes on 64bit and 128 bytes on 32bit.
>
>Note, it's a combo of changes (including your patch 1/6) and needs to be
>split up. It would be nice if you have time to split it up into separate
>patches, add proper changelogs and test the heck out of it on both 32 and
>64 bit. If you don't have time, please let me know.
>

Thanks for your suggestions :-)

Just get my head up, will try to understand the code and test on both
arch.

BTW, do you have some suggestions in the test? Currently I just use
bootup test. Basicly I think this is fine to cover the cases. Maybe you
would have some better idea.

>Thanks,
>
>	tglx
>
>8<---------------
> arch/x86/mm/init.c |  259 ++++++++++++++++++++---------------------------------
> 1 file changed, 102 insertions(+), 157 deletions(-)
>
>--- a/arch/x86/mm/init.c
>+++ b/arch/x86/mm/init.c
>@@ -157,17 +157,28 @@ void  __init early_alloc_pgt_buf(void)
> 	pgt_buf_top = pgt_buf_start + (tables >> PAGE_SHIFT);
> }
> 
>-int after_bootmem;
>+int after_bootmem __ro_after_init;
> 
> early_param_on_off("gbpages", "nogbpages", direct_gbpages, CONFIG_X86_DIRECT_GBPAGES);
> 
> struct map_range {
>-	unsigned long start;
>-	unsigned long end;
>-	unsigned page_size_mask;
>+	unsigned long	start;
>+	unsigned long	end;
>+	unsigned int	page_size_mask;
> };
> 
>-static int page_size_mask;
>+#ifdef CONFIG_X86_32
>+#define NR_RANGE_MR 3
>+#else
>+#define NR_RANGE_MR 5
>+#endif
>+
>+struct mapinfo {
>+	unsigned int	mask;
>+	unsigned int	size;
>+};
>+
>+static unsigned int page_size_mask __ro_after_init;
> 
> static void __init probe_page_size_mask(void)
> {
>@@ -177,7 +188,7 @@ static void __init probe_page_size_mask(
> 	 * large pages into small in interrupt context, etc.
> 	 */
> 	if (boot_cpu_has(X86_FEATURE_PSE) && !debug_pagealloc_enabled())
>-		page_size_mask |= 1 << PG_LEVEL_2M;
>+		page_size_mask |= 1U << PG_LEVEL_2M;
> 	else
> 		direct_gbpages = 0;
> 
>@@ -201,7 +212,7 @@ static void __init probe_page_size_mask(
> 	/* Enable 1 GB linear kernel mappings if available: */
> 	if (direct_gbpages && boot_cpu_has(X86_FEATURE_GBPAGES)) {
> 		printk(KERN_INFO "Using GB pages for direct mapping\n");
>-		page_size_mask |= 1 << PG_LEVEL_1G;
>+		page_size_mask |= 1U << PG_LEVEL_1G;
> 	} else {
> 		direct_gbpages = 0;
> 	}
>@@ -249,185 +260,119 @@ static void setup_pcid(void)
> 	}
> }
> 
>-#ifdef CONFIG_X86_32
>-#define NR_RANGE_MR 3
>-#else /* CONFIG_X86_64 */
>-#define NR_RANGE_MR 5
>+static void __meminit mr_print(struct map_range *mr, unsigned int maxidx)
>+{
>+#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
>+	static const char *sz[2] = { "4k", "4M" };
>+#else
>+	static const char *sz[4] = { "4k", "2M", "1G", "" };
> #endif
>+	unsigned int idx, s;
> 
>-static int __meminit save_mr(struct map_range *mr, int nr_range,
>-			     unsigned long start_pfn, unsigned long end_pfn,
>-			     unsigned long page_size_mask)
>-{
>-	if (start_pfn < end_pfn) {
>-		if (nr_range >= NR_RANGE_MR)
>-			panic("run out of range for init_memory_mapping\n");
>-		mr[nr_range].start = start_pfn<<PAGE_SHIFT;
>-		mr[nr_range].end   = end_pfn<<PAGE_SHIFT;
>-		mr[nr_range].page_size_mask = page_size_mask;
>-		nr_range++;
>+	for (idx = 0; idx < maxidx; idx++, mr++) {
>+		s = (mr->page_size_mask >> PG_LEVEL_2M) & (ARRAY_SIZE(sz) -1);
>+		pr_debug(" [mem %#010lx-%#010lx] page size %s\n",
>+			 mr->start, mr->end - 1, sz[s]);
> 	}
>-
>-	return nr_range;
> }
> 
> /*
>- * adjust the page_size_mask for small range to go with
>- *	big page size instead small one if nearby are ram too.
>+ * Try to preserve large mappings during bootmem by expanding the current
>+ * range to large page mapping of @size and verifying that the result is
>+ * within a memory region.
>  */
>-static void __ref adjust_range_page_size_mask(struct map_range *mr,
>-							 int nr_range)
>+static void __meminit mr_expand(struct map_range *mr, unsigned int size)
> {
>-	int i;
>-
>-	for (i = 0; i < nr_range; i++) {
>-		if ((page_size_mask & (1<<PG_LEVEL_2M)) &&
>-		    !(mr[i].page_size_mask & (1<<PG_LEVEL_2M))) {
>-			unsigned long start = round_down(mr[i].start, PMD_SIZE);
>-			unsigned long end = round_up(mr[i].end, PMD_SIZE);
>+	unsigned long start = round_down(mr->start, size);
>+	unsigned long end = round_up(mr->end, size);
> 
>-#ifdef CONFIG_X86_32
>-			if ((end >> PAGE_SHIFT) > max_low_pfn)
>-				continue;
>-#endif
>+	if (IS_ENABLED(CONFIG_X86_32) && (end >> PAGE_SHIFT) > max_low_pfn)
>+		return;
> 
>-			if (memblock_is_region_memory(start, end - start))
>-				mr[i].page_size_mask |= 1<<PG_LEVEL_2M;
>-		}
>-		if ((page_size_mask & (1<<PG_LEVEL_1G)) &&
>-		    !(mr[i].page_size_mask & (1<<PG_LEVEL_1G))) {
>-			unsigned long start = round_down(mr[i].start, PUD_SIZE);
>-			unsigned long end = round_up(mr[i].end, PUD_SIZE);
>-
>-			if (memblock_is_region_memory(start, end - start))
>-				mr[i].page_size_mask |= 1<<PG_LEVEL_1G;
>-		}
>+	if (memblock_is_region_memory(start, end - start)) {
>+		mr->start = start;
>+		mr->end = end;
> 	}
> }
> 
>-static const char *page_size_string(struct map_range *mr)
>+static bool __meminit mr_try_map(struct map_range *mr, const struct mapinfo *mi)
> {
>-	static const char str_1g[] = "1G";
>-	static const char str_2m[] = "2M";
>-	static const char str_4m[] = "4M";
>-	static const char str_4k[] = "4k";
>+	unsigned long len;
> 
>-	if (mr->page_size_mask & (1<<PG_LEVEL_1G))
>-		return str_1g;
>-	/*
>-	 * 32-bit without PAE has a 4M large page size.
>-	 * PG_LEVEL_2M is misnamed, but we can at least
>-	 * print out the right size in the string.
>-	 */
>-	if (IS_ENABLED(CONFIG_X86_32) &&
>-	    !IS_ENABLED(CONFIG_X86_PAE) &&
>-	    mr->page_size_mask & (1<<PG_LEVEL_2M))
>-		return str_4m;
>+	/* Check whether the map size is supported. PAGE_SIZE always is. */
>+	if (mi->mask && !(mr->page_size_mask & mi->mask))
>+		return false;
> 
>-	if (mr->page_size_mask & (1<<PG_LEVEL_2M))
>-		return str_2m;
>+	if (!after_bootmem)
>+		mr_expand(mr, mi->size);
> 
>-	return str_4k;
>-}
>+	if (!IS_ALIGNED(mr->start, mi->size)) {
>+		/* Limit the range to the next boundary of this size. */
>+		mr->end = min_t(unsigned long, mr->end,
>+				round_up(mr->start, mi->size));
>+		return false;
>+	}
> 
>-static int __meminit split_mem_range(struct map_range *mr, int nr_range,
>-				     unsigned long start,
>-				     unsigned long end)
>-{
>-	unsigned long start_pfn, end_pfn, limit_pfn;
>-	unsigned long pfn;
>-	int i;
>+	if (!IS_ALIGNED(mr->end, mi->size)) {
>+		/* Try to fit as much as possible */
>+		len = round_down(mr->end - mr->start, mi->size);
>+		if (!len)
>+			return false;
>+		mr->end = mr->start + len;
>+	}
> 
>-	limit_pfn = PFN_DOWN(end);
>+	/* Store the effective page size mask */
>+	mr->page_size_mask = mi->mask;
>+	return true;
>+}
> 
>-	/* head if not big page alignment ? */
>-	pfn = start_pfn = PFN_DOWN(start);
>-#ifdef CONFIG_X86_32
>+static void __meminit mr_setup(struct map_range *mr, unsigned long start,
>+			       unsigned long end)
>+{
> 	/*
>-	 * Don't use a large page for the first 2/4MB of memory
>-	 * because there are often fixed size MTRRs in there
>-	 * and overlapping MTRRs into large pages can cause
>-	 * slowdowns.
>+	 * On 32bit the first 2/4MB are often covered by fixed size MTRRs.
>+	 * Overlapping MTRRs on large pages can cause slowdowns. Force 4k
>+	 * mappings.
> 	 */
>-	if (pfn == 0)
>-		end_pfn = PFN_DOWN(PMD_SIZE);
>-	else
>-		end_pfn = round_up(pfn, PFN_DOWN(PMD_SIZE));
>-#else /* CONFIG_X86_64 */
>-	end_pfn = round_up(pfn, PFN_DOWN(PMD_SIZE));
>-#endif
>-	if (end_pfn > limit_pfn)
>-		end_pfn = limit_pfn;
>-	if (start_pfn < end_pfn) {
>-		nr_range = save_mr(mr, nr_range, start_pfn, end_pfn, 0);
>-		pfn = end_pfn;
>-	}
>-
>-	/* big page (2M) range */
>-	start_pfn = round_up(pfn, PFN_DOWN(PMD_SIZE));
>-#ifdef CONFIG_X86_32
>-	end_pfn = round_down(limit_pfn, PFN_DOWN(PMD_SIZE));
>-#else /* CONFIG_X86_64 */
>-	end_pfn = round_up(pfn, PFN_DOWN(PUD_SIZE));
>-	if (end_pfn > round_down(limit_pfn, PFN_DOWN(PMD_SIZE)))
>-		end_pfn = round_down(limit_pfn, PFN_DOWN(PMD_SIZE));
>-#endif
>-
>-	if (start_pfn < end_pfn) {
>-		nr_range = save_mr(mr, nr_range, start_pfn, end_pfn,
>-				page_size_mask & (1<<PG_LEVEL_2M));
>-		pfn = end_pfn;
>+	if (IS_ENABLED(CONFIG_X86_32) && start < PMD_SIZE) {
>+		mr->page_size_mask = 0;
>+		mr->end = min_t(unsigned long, end, PMD_SIZE);
>+	} else {
>+		/* Set the possible mapping sizes and allow full range. */
>+		mr->page_size_mask = page_size_mask;
>+		mr->end = end;
> 	}
>+	mr->start = start;
>+}
> 
>+static int __meminit split_mem_range(struct map_range *mr, unsigned long start,
>+				     unsigned long end)
>+{
>+	static const struct mapinfo mapinfos[] = {
> #ifdef CONFIG_X86_64
>-	/* big page (1G) range */
>-	start_pfn = round_up(pfn, PFN_DOWN(PUD_SIZE));
>-	end_pfn = round_down(limit_pfn, PFN_DOWN(PUD_SIZE));
>-	if (start_pfn < end_pfn) {
>-		nr_range = save_mr(mr, nr_range, start_pfn, end_pfn,
>-				page_size_mask &
>-				 ((1<<PG_LEVEL_2M)|(1<<PG_LEVEL_1G)));
>-		pfn = end_pfn;
>-	}
>-
>-	/* tail is not big page (1G) alignment */
>-	start_pfn = round_up(pfn, PFN_DOWN(PMD_SIZE));
>-	end_pfn = round_down(limit_pfn, PFN_DOWN(PMD_SIZE));
>-	if (start_pfn < end_pfn) {
>-		nr_range = save_mr(mr, nr_range, start_pfn, end_pfn,
>-				page_size_mask & (1<<PG_LEVEL_2M));
>-		pfn = end_pfn;
>-	}
>+		{ .mask = 1U << PG_LEVEL_1G, .size = PUD_SIZE },
> #endif
>+		{ .mask = 1U << PG_LEVEL_2M, .size = PMD_SIZE },
>+		{ .mask = 0, .size = PAGE_SIZE },
>+	};
>+	const struct mapinfo *mi;
>+	struct map_range *curmr;
>+	unsigned long addr;
>+	int idx;
>+
>+	for (idx = 0, addr = start, curmr = mr; addr < end; idx++, curmr++) {
>+		BUG_ON(idx == NR_RANGE_MR);
> 
>-	/* tail is not big page (2M) alignment */
>-	start_pfn = pfn;
>-	end_pfn = limit_pfn;
>-	nr_range = save_mr(mr, nr_range, start_pfn, end_pfn, 0);
>+		mr_setup(curmr, addr, end);
> 
>-	if (!after_bootmem)
>-		adjust_range_page_size_mask(mr, nr_range);
>+		/* Try map sizes top down. PAGE_SIZE will always succeed. */
>+		for (mi = mapinfos; !mr_try_map(curmr, mi); mi++);
> 
>-	/* try to merge same page size and continuous */
>-	for (i = 0; nr_range > 1 && i < nr_range - 1; i++) {
>-		unsigned long old_start;
>-		if (mr[i].end != mr[i+1].start ||
>-		    mr[i].page_size_mask != mr[i+1].page_size_mask)
>-			continue;
>-		/* move it */
>-		old_start = mr[i].start;
>-		memmove(&mr[i], &mr[i+1],
>-			(nr_range - 1 - i) * sizeof(struct map_range));
>-		mr[i--].start = old_start;
>-		nr_range--;
>+		/* Get the start address for the next range */
>+		addr = curmr->end;
> 	}
>-
>-	for (i = 0; i < nr_range; i++)
>-		pr_debug(" [mem %#010lx-%#010lx] page %s\n",
>-				mr[i].start, mr[i].end - 1,
>-				page_size_string(&mr[i]));
>-
>-	return nr_range;
>+	mr_print(mr, idx);
>+	return idx;
> }
> 
> struct range pfn_mapped[E820_MAX_ENTRIES];
>@@ -474,7 +419,7 @@ unsigned long __ref init_memory_mapping(
> 	       start, end - 1);
> 
> 	memset(mr, 0, sizeof(mr));
>-	nr_range = split_mem_range(mr, 0, start, end);
>+	nr_range = split_mem_range(mr, start, end);
> 
> 	for (i = 0; i < nr_range; i++)
> 		ret = kernel_physical_mapping_init(mr[i].start, mr[i].end,

-- 
Wei Yang
Help you, Help me
