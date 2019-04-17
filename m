Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6FFC282E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F5F20651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuXpETwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733240AbfDQTkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:40:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33515 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732958AbfDQTkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:40:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so12509627plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 12:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UyR+E+QP9/YBgUof0HLUBtIXg8lauiwUZnv+8kGnwi0=;
        b=RuXpETwf6J+1aIICtr0LjFkcyuGTYqyudqgt8yJ0XbVu5l9h3Ww0nVugPD7GI8Rr/O
         nyHCGDf0oIDjpyXnYFM+rPSnWyp+MJJWqscIXrYy+4hNH36PEN21GXxpa4E29tB8P8O6
         JCR9uMaGPtqyYKFHdXpPUYHStJ2s53LHFn1Rfrvxvshx9dwNmkUrr9mK3EQ1NXLeUveS
         AifpuUIvSYIIj7shDDsB6cHmB9Af2Z/85i6xCMIZQwxBhib8hszXwgSfOFQEv6Jy/lMF
         53TCRBDNby1eH9QncyfSnPcZMVoiQEGeq7rxabL9YeEeMYaZhuPLnmM2pBybElmXhPAd
         uU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UyR+E+QP9/YBgUof0HLUBtIXg8lauiwUZnv+8kGnwi0=;
        b=lntGzsxVrkXwkIKOPi+IkaIwQC/5PtlIw15g3AWaWCdja+O3UYDgehtObpEd20VTvb
         sigDKcnQaomw4CVaQXgBj9d7NI9jA8yyq8oUERIeFXdtqcVfgiWl48JyFAkPFdUyTQto
         4+Y1RfnMSi7Wdrvau46JoRdd9R2ycDj/0theRUt2dfQosQHq2BtYHxJY84qOsQN+oiJi
         SytMbTppepGMU8NYwXSUUxXU30JmPgAc+f+kbNUJMMVdrvbcWhwygx4BgzuHMBA/IrrR
         Ni3/m10rAGDkmBKftvVR+aKoOVLcxhbzoQ1KTnV4R4JDv4hHuGNZBXw9Xg6chYG3ZmpE
         ucQg==
X-Gm-Message-State: APjAAAW7xkBh83tV+rUerF53dHo8pnIwQL9lyban5Yq35tC4Kis4syqK
        ++dRebxJIR3Ca2Gwftk8ikQ=
X-Google-Smtp-Source: APXvYqzML/UNV8wJQff9+LzTiwC5spXfqD2Mqzdl4tmtOaS9M0PSAFTJ3kptuFcifq4SMlxYvWkbug==
X-Received: by 2002:a17:902:988e:: with SMTP id s14mr87750846plp.167.1555530009021;
        Wed, 17 Apr 2019 12:40:09 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::3:856])
        by smtp.gmail.com with ESMTPSA id v9sm8625949pgf.73.2019.04.17.12.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 12:40:08 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v4 2/2] mm: show number of vmalloc pages in /proc/meminfo
Date:   Wed, 17 Apr 2019 12:40:02 -0700
Message-Id: <20190417194002.12369-3-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417194002.12369-1-guro@fb.com>
References: <20190417194002.12369-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vmalloc() is getting more and more used these days (kernel stacks,
bpf and percpu allocator are new top users), and the total %
of memory consumed by vmalloc() can be pretty significant
and changes dynamically.

/proc/meminfo is the best place to display this information:
its top goal is to show top consumers of the memory.

Since the VmallocUsed field in /proc/meminfo is not in use
for quite a long time (it has been defined to 0 by the
commit a5ad88ce8c7f ("mm: get rid of 'vmalloc_info' from
/proc/meminfo")), let's reuse it for showing the actual
physical memory consumption of vmalloc().

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/proc/meminfo.c       |  2 +-
 include/linux/vmalloc.h |  2 ++
 mm/vmalloc.c            | 10 ++++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 568d90e17c17..465ea0153b2a 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -120,7 +120,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "Committed_AS:   ", committed);
 	seq_printf(m, "VmallocTotal:   %8lu kB\n",
 		   (unsigned long)VMALLOC_TOTAL >> 10);
-	show_val_kb(m, "VmallocUsed:    ", 0ul);
+	show_val_kb(m, "VmallocUsed:    ", vmalloc_nr_pages());
 	show_val_kb(m, "VmallocChunk:   ", 0ul);
 	show_val_kb(m, "Percpu:         ", pcpu_nr_pages());
 
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index ad483378fdd1..316efa31c8b8 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -67,10 +67,12 @@ extern void vm_unmap_aliases(void);
 
 #ifdef CONFIG_MMU
 extern void __init vmalloc_init(void);
+extern unsigned long vmalloc_nr_pages(void);
 #else
 static inline void vmalloc_init(void)
 {
 }
+static inline unsigned long vmalloc_nr_pages(void) { return 0; }
 #endif
 
 extern void *vmalloc(unsigned long size);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 8ad8e8464e55..69a5673c4cd3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -397,6 +397,13 @@ static void purge_vmap_area_lazy(void);
 static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
 static unsigned long lazy_max_pages(void);
 
+static atomic_long_t nr_vmalloc_pages;
+
+unsigned long vmalloc_nr_pages(void)
+{
+	return atomic_long_read(&nr_vmalloc_pages);
+}
+
 static struct vmap_area *__find_vmap_area(unsigned long addr)
 {
 	struct rb_node *n = vmap_area_root.rb_node;
@@ -2141,6 +2148,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			BUG_ON(!page);
 			__free_pages(page, 0);
 		}
+		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
 
 		kvfree(area->pages);
 	}
@@ -2317,12 +2325,14 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		if (unlikely(!page)) {
 			/* Successfully allocated i pages, free them in __vunmap() */
 			area->nr_pages = i;
+			atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 			goto fail;
 		}
 		area->pages[i] = page;
 		if (gfpflags_allow_blocking(gfp_mask|highmem_mask))
 			cond_resched();
 	}
+	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 
 	if (map_vm_area(area, prot, pages))
 		goto fail;
-- 
2.20.1

