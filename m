Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ECCC5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 07:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A34A208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 07:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEn/62K+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfF3H6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 03:58:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46358 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfF3H6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 03:58:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id i8so1305770pgm.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 00:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1O194sl4mriIRHMJ+1n1JK+TuGyK9Js7DoiaFQdgQv8=;
        b=OEn/62K+J11Xx0gAIj6SvDBBuGQTLa7CSqID3ESlLB8MnLY6lpCNrF2hf2cdH56/VF
         C/MeWypHaohajj1XSCX3Ypfj1PjJgM3wxihALO1JUA4y3m+rLAFjaTxwnTKjWDvoH7Bx
         /vOaXx5/8WsrzgspGBMsW91Nt1VCbPJRydP5taAv12MLBMLHirmt5zbDE2Y2fuzt0tZc
         xf8PDH89r+DSPWgJnEJQvCcvD5hTDgGmkX3MxEa5VdkGpetQmxBHyniA9t0aFiTLSgQ4
         bBtVJKRZrqr90QxPzQnDv+xt8B0M0XkM2XxtRM1yBak0SLvLqxW6arty/2QR96RQcNGt
         9+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1O194sl4mriIRHMJ+1n1JK+TuGyK9Js7DoiaFQdgQv8=;
        b=HMpRS0gbpGkBAs6Y9xGTCWCXKIVJKc0EwWy0N67LkrEquG5wz6Gg3XRlhR+R0hIKVV
         dwAfc/FUl/vcxjBBCUkiHuEXnPFGOLHQ9MLxH3YsiPpqKDuKPUvWMB5Z3yQ6WysPCuIe
         NSePPYmTaj9iooSoJCZw3CbhcpfYva7AinW6ysZcE00fPME0LFgMjg2UuWRKF60xaJ6G
         L4m0EZBFvi+QXnNlVn/hhvzpYwuxDiEvr62XJr87FNNqA5sQPc8zJv5a7gatzs5mT9K3
         45Yv4+2bcULmJQ/9+ugWJQyPZTTbfajjuFf8UcF+Ww3ehAWA2L32yjgzn9KIBeCLOS9N
         8WCA==
X-Gm-Message-State: APjAAAW0oMiiSJN8mjKSFSUxNN/PI2kqNXimPKrZEckkPGFGxjIvqtK6
        eNBEBYInilF5hQV9TmQ3YZA=
X-Google-Smtp-Source: APXvYqxwJ/beY2Bt8wvFjmEdWCtorwLHvk8lQaWPG6WozdEGoz5Cy3qsjOPOmLtmHXolEV7ZWBCVIQ==
X-Received: by 2002:a65:6210:: with SMTP id d16mr17859467pgv.180.1561881481064;
        Sun, 30 Jun 2019 00:58:01 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:648:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id w10sm5989637pgs.32.2019.06.30.00.57.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 00:58:00 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com
Cc:     rpenyaev@suse.de, mhocko@suse.com, guro@fb.com,
        aryabinin@virtuozzo.com, rppt@linux.ibm.com, mingo@kernel.org,
        rick.p.edgecombe@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 5/5] mm/vmalloc.c: Rewrite struct vmap_area to reduce its size
Date:   Sun, 30 Jun 2019 15:56:50 +0800
Message-Id: <20190630075650.8516-6-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630075650.8516-1-lpf.vector@gmail.com>
References: <20190630075650.8516-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Members of struct vmap_area are not being used at the same time.
For example,
(1)members @flags, @purge_list, and @vm are unused when vmap area is
in the *FREE* tree;

(2)members @subtree_max_size and @purge_list are unused when vmap area is
in the *BUSY* tree and not in the purge list;

(3)members @subtree_max_size and @vm are unused when vmap area is
in the *BUSY* tree and in the purge list.

Since members @subtree_max_size, @purge_list and @vm are not used
at the same time, so they can be placed in a union to reduce the
size of struct vmap_area.

Besides, rename @flags to @_vm_valid to indicate if @vm is valid.
The reason why @_vm_valid can be placed in a union with @va_start
is that if @vm is valid, then @va_start can be known by @vm.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 include/linux/vmalloc.h | 28 ++++++++++----
 mm/vmalloc.c            | 85 +++++++++++++++++++++++++++++++----------
 2 files changed, 85 insertions(+), 28 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 51e131245379..7b99de5ccbec 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -48,18 +48,30 @@ struct vm_struct {
 };
 
 struct vmap_area {
-	unsigned long va_start;
+	union {
+		unsigned long va_start;
+		/*
+		 * Determine whether vm is valid according to
+		 * the value of _vm_valid
+		 */
+		unsigned long _vm_valid;
+	};
+
 	unsigned long va_end;
 
-	/*
-	 * Largest available free size in subtree.
-	 */
-	unsigned long subtree_max_size;
-	unsigned long flags;
+	union {
+		/* Only used when vmap area in *FREE* vmap_area tree */
+		unsigned long subtree_max_size;
+
+		/* Only used when vmap area in vmap_purge_list */
+		struct llist_node purge_list;
+
+		/* Only used when va_vm_is_valid() return true */
+		struct vm_struct *vm;
+	};
+
 	struct rb_node rb_node;         /* address sorted rbtree */
 	struct list_head list;          /* address sorted list */
-	struct llist_node purge_list;    /* "lazy purge" list */
-	struct vm_struct *vm;
 };
 
 /*
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4148d6fdfb6d..89b93ee0ec04 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -329,8 +329,28 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 #define DEBUG_AUGMENT_PROPAGATE_CHECK 0
 #define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
 
-#define VM_LAZY_FREE	0x02
-#define VM_VM_AREA	0x04
+#define VA_VM_VALID	0x01UL
+
+static __always_inline void
+__va_set_vm(struct vmap_area *va, struct vm_struct *vm)
+{
+	/* Overwrite va->va_start by va->_vm_valid */
+	va->_vm_valid = VA_VM_VALID;
+	va->vm = vm;
+}
+
+static __always_inline void
+__va_unset_vm(struct vmap_area *va)
+{
+	/* Restore va->va_start and overwrite va->_vm_valid */
+	va->va_start = (unsigned long)va->vm->addr;
+}
+
+static __always_inline bool
+va_vm_is_valid(struct vmap_area *va)
+{
+	return (va->_vm_valid == VA_VM_VALID);
+}
 
 static DEFINE_SPINLOCK(vmap_area_lock);
 /* Export for kexec only */
@@ -399,15 +419,26 @@ static void purge_vmap_area_lazy(void);
 static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
 static unsigned long lazy_max_pages(void);
 
+/*
+ * Search the *BUSY* vmap_area tree. If va_vm_is_valid() return true,
+ * then va->va_start has been overwritten by va->_vm_valid,
+ * otherwise va->va_start remains the original value.
+ */
 static struct vmap_area *__search_va_from_busy_tree(unsigned long addr)
 {
 	struct rb_node *n = vmap_area_root.rb_node;
 
 	while (n) {
 		struct vmap_area *va;
+		unsigned long start;
 
 		va = rb_entry(n, struct vmap_area, rb_node);
-		if (addr < va->va_start)
+		if (va_vm_is_valid(va))
+			start = (unsigned long)va->vm->addr;
+		else
+			start = va->va_start;
+
+		if (addr < start)
 			n = n->rb_left;
 		else if (addr >= va->va_end)
 			n = n->rb_right;
@@ -429,8 +460,13 @@ find_va_links(struct vmap_area *va,
 {
 	struct vmap_area *tmp_va;
 	struct rb_node **link;
+	unsigned long start;
+	bool is_busy_va_tree = false;
 
 	if (root) {
+		if (root == &vmap_area_root)
+			is_busy_va_tree = true;
+
 		link = &root->rb_node;
 		if (unlikely(!*link)) {
 			*parent = NULL;
@@ -447,6 +483,10 @@ find_va_links(struct vmap_area *va,
 	 */
 	do {
 		tmp_va = rb_entry(*link, struct vmap_area, rb_node);
+		if (is_busy_va_tree && va_vm_is_valid(tmp_va))
+			start = (unsigned long)tmp_va->vm->addr;
+		else
+			start = tmp_va->va_start;
 
 		/*
 		 * During the traversal we also do some sanity check.
@@ -454,9 +494,9 @@ find_va_links(struct vmap_area *va,
 		 * or full overlaps.
 		 */
 		if (va->va_start < tmp_va->va_end &&
-				va->va_end <= tmp_va->va_start)
+				va->va_end <= start)
 			link = &(*link)->rb_left;
-		else if (va->va_end > tmp_va->va_start &&
+		else if (va->va_end > start &&
 				va->va_start >= tmp_va->va_end)
 			link = &(*link)->rb_right;
 		else
@@ -1079,8 +1119,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 
 	va->va_start = addr;
 	va->va_end = addr + size;
-	va->flags = 0;
 	insert_va_to_busy_tree(va);
+	va->vm = NULL;
 
 	spin_unlock(&vmap_area_lock);
 
@@ -1872,11 +1912,11 @@ void __init vmalloc_init(void)
 		if (WARN_ON_ONCE(!va))
 			continue;
 
-		va->flags = VM_VM_AREA;
 		va->va_start = (unsigned long)tmp->addr;
 		va->va_end = va->va_start + tmp->size;
-		va->vm = tmp;
 		insert_va_to_busy_tree(va);
+
+		__va_set_vm(va, tmp);
 	}
 
 	/*
@@ -1969,8 +2009,9 @@ static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
 	vm->addr = (void *)va->va_start;
 	vm->size = va->va_end - va->va_start;
 	vm->caller = caller;
-	va->vm = vm;
-	va->flags |= VM_VM_AREA;
+
+	__va_set_vm(va, vm);
+
 	spin_unlock(&vmap_area_lock);
 }
 
@@ -2075,7 +2116,7 @@ struct vm_struct *find_vm_area(const void *addr)
 	struct vmap_area *va;
 
 	va = find_vmap_area((unsigned long)addr);
-	if (va && va->flags & VM_VM_AREA)
+	if (va && va_vm_is_valid(va))
 		return va->vm;
 
 	return NULL;
@@ -2098,13 +2139,15 @@ struct vm_struct *remove_vm_area(const void *addr)
 	might_sleep();
 
 	va = find_vmap_area((unsigned long)addr);
-	if (va && va->flags & VM_VM_AREA) {
+	if (va && va_vm_is_valid(va)) {
 		struct vm_struct *vm = va->vm;
 
 		spin_lock(&vmap_area_lock);
-		va->vm = NULL;
-		va->flags &= ~VM_VM_AREA;
-		va->flags |= VM_LAZY_FREE;
+		/*
+		 * Call __va_unset_vm() to restore the value of va->va_start
+		 * before calling free_unmap_vmap_area() to add it to purge list
+		 */
+		__va_unset_vm(va);
 		spin_unlock(&vmap_area_lock);
 
 		kasan_free_shadow(vm);
@@ -2813,7 +2856,7 @@ long vread(char *buf, char *addr, unsigned long count)
 		if (!count)
 			break;
 
-		if (!(va->flags & VM_VM_AREA))
+		if (!va_vm_is_valid(va))
 			continue;
 
 		vm = va->vm;
@@ -2893,7 +2936,7 @@ long vwrite(char *buf, char *addr, unsigned long count)
 		if (!count)
 			break;
 
-		if (!(va->flags & VM_VM_AREA))
+		if (!va_vm_is_valid(va))
 			continue;
 
 		vm = va->vm;
@@ -3407,14 +3450,16 @@ static int s_show(struct seq_file *m, void *p)
 	va = list_entry(p, struct vmap_area, list);
 
 	/*
-	 * s_show can encounter race with remove_vm_area, !VM_VM_AREA on
+	 * s_show can encounter race with remove_vm_area, !va_vm_is_valid() on
 	 * behalf of vmap area is being tear down or vm_map_ram allocation.
+	 * And if va->vm != NULL then vmap area is being tear down,
+	 * otherwise vmap area is allocated by vm_map_ram().
 	 */
-	if (!(va->flags & VM_VM_AREA)) {
+	if (!va_vm_is_valid(va)) {
 		seq_printf(m, "0x%pK-0x%pK %7ld %s\n",
 			(void *)va->va_start, (void *)va->va_end,
 			va->va_end - va->va_start,
-			va->flags & VM_LAZY_FREE ? "unpurged vm_area" : "vm_map_ram");
+			va->vm ? "unpurged vm_area" : "vm_map_ram");
 
 		return 0;
 	}
-- 
2.21.0

