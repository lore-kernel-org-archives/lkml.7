Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A053DC2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AEC20748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Ygv8JhuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfL3Jig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 04:38:36 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35634 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfL3Jig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 04:38:36 -0500
Received: by mail-lf1-f67.google.com with SMTP id 15so24798875lfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 01:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z0vdDOcQ8v/e5BOs7LEyb3P17yQ8hnJKwJziys7L6rQ=;
        b=Ygv8JhuINbWLBhzkd3IlrKctEf1mAMdzzYF3we4UVT1cSJi50jRZ4MfyCoCfdKhgee
         fEM5wKIN18hFiBSGoP3wNRwOsDfAyaOAGCfXPBCdr1u7aYGb6xroGI43ceDtO6bWdq9r
         Og4U87PV4DBhC+OxqlCpRHDtJBdLfcyy+NJv1vZKw4HmOh4vj1x9AgQZJPEV9zRpmY+L
         OAGkZdLmUhtdGh02PJKK1TWGgKEKU9gllNxDgjMDMEhsxA5ft8OD69GdhjBLFRxaefnL
         xOR3w8Ggv5HNgBB6AkBi0jPbFeiIbf2FB4UH1kHJw37THervQ6/LjP6X2vJcKHfuCA+4
         5pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z0vdDOcQ8v/e5BOs7LEyb3P17yQ8hnJKwJziys7L6rQ=;
        b=d4cRIQ9WL3N3dfl7PAZvZBkgFZOIRPrtMjJjokXsI94yLHEzBZOY+XKVm6oyspVxlP
         hz54UgUWvXFt6GazKkxv+mNr6WEuP19VXsTCo1pgiGZVsTON9fYB43yPrD+7AeJZ5s6j
         wXaqw+GglPHMTFlhLRK51AuxgvEdhlfdWV664bVDdEdMP5yMcjf3oT9IgbECK56XzhW0
         vA9/1JvKR9uSWF1hYibDZHxXT2E6cJy51RlhPCaKIqqZQSJ1+R3+SzK5/rIcxLTDZbh2
         DoThquGwb77SoRV7v2188n2UQcxpOyFTRpsGEqEbMc0REQRYv1U7vzcitPM++aDTfg+J
         Lrow==
X-Gm-Message-State: APjAAAW24WpdF1XquvgZr4Hn4DAeZAbJZvDBmr9g/L3GaTB8OAAaNOKs
        IWijiOs1ZG/uM6jbBgpUmgEFuw==
X-Google-Smtp-Source: APXvYqwvy+jwnOiLX19xtMYVXRbH7ItJEWyLKetcakwpxsGTkfxA+b08EXSS6xLAhjnIwSUmyUvZ/Q==
X-Received: by 2002:a19:f716:: with SMTP id z22mr39561834lfe.14.1577698713777;
        Mon, 30 Dec 2019 01:38:33 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e8sm20764094ljb.45.2019.12.30.01.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 01:38:33 -0800 (PST)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id BD47610152C; Mon, 30 Dec 2019 12:38:34 +0300 (+03)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        "Jin, Zhi" <zhi.jin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] mm/page_alloc: Skip non present sections on zone initialization
Date:   Mon, 30 Dec 2019 12:38:28 +0300
Message-Id: <20191230093828.24613-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memmap_init_zone() can be called on the ranges with holes during the
boot. It will skip any non-valid PFNs one-by-one. It works fine as long
as holes are not too big.

But huge holes in the memory map causes a problem. It takes over 20
seconds to walk 32TiB hole. x86-64 with 5-level paging allows for much
larger holes in the memory map which would practically hang the system.

Deferred struct page init doesn't help here. It only works on the
present ranges.

Skipping non-present sections would fix the issue.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---

The situation can be emulated using the following QEMU patch:

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ac08e6360437..f5f2258092e1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1159,13 +1159,14 @@ void pc_memory_init(PCMachineState *pcms,
     memory_region_add_subregion(system_memory, 0, ram_below_4g);
     e820_add_entry(0, x86ms->below_4g_mem_size, E820_RAM);
     if (x86ms->above_4g_mem_size > 0) {
+        int shift = 45;
         ram_above_4g = g_malloc(sizeof(*ram_above_4g));
         memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram,
                                  x86ms->below_4g_mem_size,
                                  x86ms->above_4g_mem_size);
-        memory_region_add_subregion(system_memory, 0x100000000ULL,
+        memory_region_add_subregion(system_memory, 1ULL << shift,
                                     ram_above_4g);
-        e820_add_entry(0x100000000ULL, x86ms->above_4g_mem_size, E820_RAM);
+        e820_add_entry(1ULL << shift, x86ms->above_4g_mem_size, E820_RAM);
     }
 
     if (!pcmc->has_reserved_memory &&
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cde2a16b941a..694c26947bf6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1928,7 +1928,7 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 /* XXX: This value should match the one returned by CPUID
  * and in exec.c */
 # if defined(TARGET_X86_64)
-# define TCG_PHYS_ADDR_BITS 40
+# define TCG_PHYS_ADDR_BITS 52
 # else
 # define TCG_PHYS_ADDR_BITS 36
 # endif

---
 mm/page_alloc.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index df62a49cd09e..442dc0244bb4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5873,6 +5873,30 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
 	return false;
 }
 
+#ifdef CONFIG_SPARSEMEM
+/* Skip PFNs that belong to non-present sections */
+static inline __meminit unsigned long next_pfn(unsigned long pfn)
+{
+	unsigned long section_nr;
+
+	section_nr = pfn_to_section_nr(++pfn);
+	if (present_section_nr(section_nr))
+		return pfn;
+
+	while (++section_nr <= __highest_present_section_nr) {
+		if (present_section_nr(section_nr))
+			return section_nr_to_pfn(section_nr);
+	}
+
+	return -1;
+}
+#else
+static inline __meminit unsigned long next_pfn(unsigned long pfn)
+{
+	return pfn++;
+}
+#endif
+
 /*
  * Initially all pages are reserved - free ones are freed
  * up by memblock_free_all() once the early boot process is
@@ -5912,8 +5936,10 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		 * function.  They do not exist on hotplugged memory.
 		 */
 		if (context == MEMMAP_EARLY) {
-			if (!early_pfn_valid(pfn))
+			if (!early_pfn_valid(pfn)) {
+				pfn = next_pfn(pfn) - 1;
 				continue;
+			}
 			if (!early_pfn_in_nid(pfn, nid))
 				continue;
 			if (overlap_memmap_init(zone, &pfn))
-- 
2.24.1

