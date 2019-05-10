Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B0AC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E92217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfEJHVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:21:48 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44513 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfEJHVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:21:33 -0400
Received: by mail-qk1-f195.google.com with SMTP id w25so3047870qkj.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 00:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vOejBc1QN8TJ6K5lhz+Yvn4+87eApSQ46e32YrdputU=;
        b=stPIaAE8WyGUcWExUKY5n+2KdfzMooZZxhMx8Gug7jNnArJ8wM1rdLBwlpf+Zomb5e
         oiwelU+5cXoz+SZRfxRNm7TGY77vj6X+ebaMTXKy1WFHUEDjqEECGZzGZ1NZOMATbUnu
         B99AcwBRn1KCWUuKWN6jpu59dovZzAC/grAjxpxPT/QfRUdinXsyMSiBBXKBAexZhVtH
         ixYlVfXUTOgh9wW3prp5h42iucGZ1N+3Qp9SS2D9/YcbXX844Q1kC9KX3V7/yzq8EUSD
         8z1XqpWbdWjk7lf0DGRWB8Sd3lTuxaQI5p4/YjgWKPCa/mnCcnxivC4YDs76z5XoFmu/
         6YIA==
X-Gm-Message-State: APjAAAVJ7u2657XF9+alQysVG4MkTeF6WaHUM3k9lzI0LnmYtcMEqDJD
        bZgM305j6cDNNedy2ygBXn0XJsaK1co2rQ==
X-Google-Smtp-Source: APXvYqzPe26b8EbsZNX43wXIk/ZJMwyIsrlo41vyylWWI/zUIYOTf4fWR2vuKOPN9vH/HO0FjC5SPg==
X-Received: by 2002:a37:5444:: with SMTP id i65mr7490671qkb.263.1557472892023;
        Fri, 10 May 2019 00:21:32 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y18sm2145077qty.78.2019.05.10.00.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 00:21:31 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
Subject: [PATCH RFC 2/4] mm/ksm: introduce VM_UNMERGEABLE
Date:   Fri, 10 May 2019 09:21:23 +0200
Message-Id: <20190510072125.18059-3-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190510072125.18059-1-oleksandr@redhat.com>
References: <20190510072125.18059-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add separate vmaflag to allow applications to opt out of automatic VMAs
merging due to (possible) security concerns.

Since vmaflags are tight on free bits, this flag is available on 64-bit
architectures only. Thus, subsequently, KSM "always" mode will be
available for 64-bit architectures only as well.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 fs/proc/task_mmu.c             |  3 +++
 include/linux/mm.h             |  6 ++++++
 include/trace/events/mmflags.h |  7 +++++++
 mm/ksm.c                       | 13 +++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 95ca1fe7283c..19cc246000e8 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -648,6 +648,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_MIXEDMAP)]	= "mm",
 		[ilog2(VM_HUGEPAGE)]	= "hg",
 		[ilog2(VM_NOHUGEPAGE)]	= "nh",
+#ifdef VM_UNMERGEABLE
+		[ilog2(VM_UNMERGEABLE)]	= "ug",
+#endif
 		[ilog2(VM_MERGEABLE)]	= "mg",
 		[ilog2(VM_UFFD_MISSING)]= "um",
 		[ilog2(VM_UFFD_WP)]	= "uw",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6b10c21630f5..114cdb882cdd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -252,11 +252,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -272,6 +274,10 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
+#ifdef VM_HIGH_ARCH_5
+#define VM_UNMERGEABLE	VM_HIGH_ARCH_5	/* Opt-out for KSM "always" mode */
+#endif /* VM_HIGH_ARCH_5 */
+
 #if defined(CONFIG_X86)
 # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
 #elif defined(CONFIG_PPC)
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index a1675d43777e..717e0fd9d2ef 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -130,6 +130,12 @@ IF_HAVE_PG_IDLE(PG_idle,		"idle"		)
 #define IF_HAVE_VM_SOFTDIRTY(flag,name)
 #endif
 
+#ifdef VM_UNMERGEABLE
+#define IF_HAVE_VM_UNMERGEABLE(flag,name) {flag, name },
+#else
+#define IF_HAVE_VM_UNMERGEABLE(flag,name)
+#endif
+
 #define __def_vmaflag_names						\
 	{VM_READ,			"read"		},		\
 	{VM_WRITE,			"write"		},		\
@@ -161,6 +167,7 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_MIXEDMAP,			"mixedmap"	},		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
+IF_HAVE_VM_UNMERGEABLE(VM_UNMERGEABLE,	"unmergeable"	)		\
 	{VM_MERGEABLE,			"mergeable"	}		\
 
 #define show_vma_flags(flags)						\
diff --git a/mm/ksm.c b/mm/ksm.c
index a6b0788a3a22..0fb5f850087a 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2450,12 +2450,18 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 
 	switch (advice) {
 	case MADV_MERGEABLE:
+#ifdef VM_UNMERGEABLE
+		*vm_flags &= ~VM_UNMERGEABLE;
+#endif
 		err = ksm_enter(mm, vma, vm_flags);
 		if (err)
 			return err;
 		break;
 
 	case MADV_UNMERGEABLE:
+#ifdef VM_UNMERGEABLE
+		*vm_flags |= VM_UNMERGEABLE;
+#endif
 		if (!(*vm_flags & VM_MERGEABLE))
 			return 0;		/* just ignore the advice */
 
@@ -2496,6 +2502,10 @@ int ksm_enter(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (*vm_flags & VM_SPARC_ADI)
 		return 0;
 #endif
+#ifdef VM_UNMERGEABLE
+	if (*vm_flags & VM_UNMERGEABLE)
+		return 0;
+#endif
 
 	if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
 		err = __ksm_enter(mm);
@@ -3173,6 +3183,9 @@ static ssize_t full_scans_show(struct kobject *kobj,
 KSM_ATTR_RO(full_scans);
 
 static struct attribute *ksm_attrs[] = {
+#ifdef VM_UNMERGEABLE
+	&mode_attr.attr,
+#endif
 	&sleep_millisecs_attr.attr,
 	&pages_to_scan_attr.attr,
 	&run_attr.attr,
-- 
2.21.0

