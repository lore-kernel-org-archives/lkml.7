Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A37C46483
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8391218BC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4pTzOKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfGDNbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 09:31:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46700 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfGDNbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:31:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id i8so2909153pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPUePBpwAZp2cAxUnqaMmjnaAF2A22YwwKy9LFV95Jg=;
        b=d4pTzOKMxcI7GJ0gZ0bcaYKFu8XwSkD0G4UMw0zcHozLflTvaIzr/rg0fqWPWk554y
         adigQ1E21BcxonG+yPmoPhq1nO2n2CSETSICWw6Coia2Z2GLhPeUf+ux3Ea967oxc1aE
         cXhvKHjebC1Set0bEvbxpfkxF7FQYGScd0052nCDDPLfZAvTUxAVLAwOS5xsRqWY9vO9
         E0MsWSQ9pZJE/JxatV2LSl7jlwoP2idjCb8E79Pgbv5G3FDlAyuArktddlR8s8095Ni3
         ZZtJs8Jyi1h3IOHM3tnvxWc9GKAJ9c4nDRKTcUS/eSHtMbuRp1o/jQTTK8eCwPXYn55X
         BA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPUePBpwAZp2cAxUnqaMmjnaAF2A22YwwKy9LFV95Jg=;
        b=iNTEWRf0IiTlS1UrBoJP0HvUYsiAsamSPtsHrR52DH3lTHMfMSYoB2jbHNU/HxghCl
         /nijTq7wQEYKExwBB3shKA6ImXTZXd9X5D/pkF4pxBFc5HKBZ5AaTeIksGSuFMUaRemq
         T4dSRFv9wKaAMq/xUqkytMOwpAfTW+xYDYTS1k9w3eDptO/a4o/xkmSjCEvx2WT0rKQ+
         5RWVa5mM8HLxRN6CwHc/ioe9dxMuWqZvMYhDNmUDI4OylI8WbtvK+1vjP76rF7MvaI6S
         A25b6BSb9rBHhqGeNNf5ll760rCeVBMIJzFA966hOT6obyL3i6KJhoHdAR04edGuJcSO
         M7sw==
X-Gm-Message-State: APjAAAXGuWZfUBXNxdVHtstonTjwynM6irbM95HoHMfYFKQXVc1lJ5px
        drS8g1pHV2Kjth3HJjKn25s=
X-Google-Smtp-Source: APXvYqzs724Q0a+qAL27vJcD3e0B9fxIm2y1EPOSpY/Cw1QM2Y857mW5LJ+lb6UYnPa5TOxnWMRMCQ==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr19859656pjz.117.1562247067769;
        Thu, 04 Jul 2019 06:31:07 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:648:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id h26sm12517367pfq.64.2019.07.04.06.30.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 06:31:07 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com
Cc:     rpenyaev@suse.de, mhocko@suse.com, guro@fb.com,
        aryabinin@virtuozzo.com, rppt@linux.ibm.com, mingo@kernel.org,
        rick.p.edgecombe@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v3 1/1] Modify struct vmap_area to reduce its size
Date:   Thu,  4 Jul 2019 21:30:40 +0800
Message-Id: <20190704133040.5623-2-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190704133040.5623-1-lpf.vector@gmail.com>
References: <20190704133040.5623-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objective
---------
The current implementation of struct vmap_area wasted space.

After applying this commit, sizeof(struct vmap_area) has been
reduced from 11 words to 8 words.

Description
-----------
1) Pack "subtree_max_size", "vm" and "purge_list".
It is correct because these three variables are used in different
states.
    A) "subtree_max_size" is only used when vmap_area is in
       "free" tree
    B) "vm" is only used when vmap_area is in "busy" tree
    C) "purge_list" is only used when vmap_area is in
       vmap_purge_list

2) Eliminate "flags".
Since now only one flag VM_VM_AREA is being used, and the same
thing can be done by judging whether "vm" is NULL, then the
"flags" can be eliminated.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
Suggested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/vmalloc.h | 20 +++++++++++++-------
 mm/vmalloc.c            | 24 ++++++++++--------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 51e131245379..2bc04b717600 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -51,15 +51,21 @@ struct vmap_area {
 	unsigned long va_start;
 	unsigned long va_end;
 
-	/*
-	 * Largest available free size in subtree.
-	 */
-	unsigned long subtree_max_size;
-	unsigned long flags;
 	struct rb_node rb_node;         /* address sorted rbtree */
 	struct list_head list;          /* address sorted list */
-	struct llist_node purge_list;    /* "lazy purge" list */
-	struct vm_struct *vm;
+
+	/*
+	 * The following three variables can be packed, because
+	 * a vmap_area object is always one of the three states:
+	 *    1) in "free" tree (root is vmap_area_root)
+	 *    2) in "busy" tree (root is free_vmap_area_root)
+	 *    3) in purge list  (head is vmap_purge_list)
+	 */
+	union {
+		unsigned long subtree_max_size; /* in "free" tree */
+		struct vm_struct *vm;           /* in "buys" tree */
+		struct llist_node purge_list;   /* in purge list */
+	};
 };
 
 /*
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 948f4e35341b..07c1823d7ea5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -329,7 +329,6 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 #define DEBUG_AUGMENT_PROPAGATE_CHECK 0
 #define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
 
-#define VM_VM_AREA	0x04
 
 static DEFINE_SPINLOCK(vmap_area_lock);
 /* Export for kexec only */
@@ -1108,7 +1107,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 
 	va->va_start = addr;
 	va->va_end = addr + size;
-	va->flags = 0;
+	va->vm = NULL;
 	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
 
 	spin_unlock(&vmap_area_lock);
@@ -1912,7 +1911,6 @@ void __init vmalloc_init(void)
 		if (WARN_ON_ONCE(!va))
 			continue;
 
-		va->flags = VM_VM_AREA;
 		va->va_start = (unsigned long)tmp->addr;
 		va->va_end = va->va_start + tmp->size;
 		va->vm = tmp;
@@ -2010,7 +2008,6 @@ static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
 	vm->size = va->va_end - va->va_start;
 	vm->caller = caller;
 	va->vm = vm;
-	va->flags |= VM_VM_AREA;
 	spin_unlock(&vmap_area_lock);
 }
 
@@ -2115,10 +2112,10 @@ struct vm_struct *find_vm_area(const void *addr)
 	struct vmap_area *va;
 
 	va = find_vmap_area((unsigned long)addr);
-	if (va && va->flags & VM_VM_AREA)
-		return va->vm;
+	if (!va)
+		return NULL;
 
-	return NULL;
+	return va->vm;
 }
 
 /**
@@ -2139,11 +2136,10 @@ struct vm_struct *remove_vm_area(const void *addr)
 
 	spin_lock(&vmap_area_lock);
 	va = __find_vmap_area((unsigned long)addr);
-	if (va && va->flags & VM_VM_AREA) {
+	if (va && va->vm) {
 		struct vm_struct *vm = va->vm;
 
 		va->vm = NULL;
-		va->flags &= ~VM_VM_AREA;
 		spin_unlock(&vmap_area_lock);
 
 		kasan_free_shadow(vm);
@@ -2854,7 +2850,7 @@ long vread(char *buf, char *addr, unsigned long count)
 		if (!count)
 			break;
 
-		if (!(va->flags & VM_VM_AREA))
+		if (!va->vm)
 			continue;
 
 		vm = va->vm;
@@ -2934,7 +2930,7 @@ long vwrite(char *buf, char *addr, unsigned long count)
 		if (!count)
 			break;
 
-		if (!(va->flags & VM_VM_AREA))
+		if (!va->vm)
 			continue;
 
 		vm = va->vm;
@@ -3464,10 +3460,10 @@ static int s_show(struct seq_file *m, void *p)
 	va = list_entry(p, struct vmap_area, list);
 
 	/*
-	 * s_show can encounter race with remove_vm_area, !VM_VM_AREA on
-	 * behalf of vmap area is being tear down or vm_map_ram allocation.
+	 * If !va->vm then this vmap_area object is allocated
+	 * by vm_map_ram.
 	 */
-	if (!(va->flags & VM_VM_AREA)) {
+	if (!va->vm) {
 		seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
 			(void *)va->va_start, (void *)va->va_end,
 			va->va_end - va->va_start);
-- 
2.21.0

