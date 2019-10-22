Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03948CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56B2214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ0tkEZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbfJVP6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 11:58:13 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45952 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731642AbfJVP6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:58:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id v8so12952935lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Egq0KjbDto0SJVyFWX4U54efLY3lAH4Yzy9pg7bXtE=;
        b=KJ0tkEZ4FUSc+DV3oAIJ+9hT57WjsNH2uUzm3ZKF56NFMlkt8Jr+7LO1Ep88TL7yPb
         URglKxvmPttT8mn8YwHYbWXFzcivNXpo7/lcJUY3gAhjdqqE4x8bbh/hCR71A6kH1vAi
         hHoCfeIof5U8kNek3qJs69TCQ5ZjQ/OC+Of7ZjusMjOOghXGBFZ7UwAEH0vqMN2pGi1U
         z6xarHhaF6DQptj86StDFPtWKs8KP9SCyI+fn25LLWZLmDWlvPJdmARsfocYjeqfu1bC
         +uIm1+C5FoUeKZcfNEj89o6mcsSyOPlQrhITVTl+MXcof6X1vPudiCihJayfcVv6Q08a
         /02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Egq0KjbDto0SJVyFWX4U54efLY3lAH4Yzy9pg7bXtE=;
        b=dYudgKyfgFYQMnNI/niiNRuVahtlR9vJUk1UzaoHo6RVed5Tah5A93ICAOInj734le
         06NYoirBHzboj+l5Md5f1JLHM4VhZg9C0LOor3b876w3e5RyAJ5HA0T2ItxB/pomWJ6M
         2WBzARDsOiMWWtkYBo7YvLq4ibhBPVBebZPa1/lDbVTkL3SI8hWpXvqy2LIZpcSCbnmS
         EJ9v3tEmcooeOIKch0cS8JMNn5tQU5+4lcIj0Zy8rVz4zkqeLsQruhLkY6TH5ZNq3hIw
         grATL1VQ4nKOiYCL6tdd04X/L5gRoSXNHPcHEIdzI+TV/aDkIvA2Re3m7h7Cwj3VkVr2
         NN3A==
X-Gm-Message-State: APjAAAWxIVNP/ZT0ed/sJWA0dqEY71cpKmpAOqXU8s3t7fM5fTx6mzLL
        tbnPTn94yjl0R496E+FJYM+olxMq20s=
X-Google-Smtp-Source: APXvYqyYSbGGyIPKCejPKLgCReIGnnlt73NG52MUPbET30mOrt+KfKd80G5zbSJYA3o10zN7OhJupA==
X-Received: by 2002:a19:6813:: with SMTP id d19mr16840328lfc.144.1571759890273;
        Tue, 22 Oct 2019 08:58:10 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id v203sm10019637lfa.25.2019.10.22.08.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 08:58:09 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/1] mm/vmalloc: rework vmap_area_lock
Date:   Tue, 22 Oct 2019 17:58:00 +0200
Message-Id: <20191022155800.20468-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the new allocation approach introduced in the 5.2 kernel, it
becomes possible to get rid of one global spinlock. By doing that
we can further improve the KVA from the performance point of view.

Basically we can have two independent locks, one for allocation
part and another one for deallocation, because of two different
entities: "free data structures" and "busy data structures".

As a result, allocation/deallocation operations can still interfere
between each other in case of running simultaneously on different
CPUs, it means there is still dependency, but with two locks it
becomes lower.

Summarizing:
  - it reduces the high lock contention
  - it allows to perform operations on "free" and "busy"
    trees in parallel on different CPUs. Please note it
    does not solve scalability issue.

Test results:
In order to evaluate this patch, we can run "vmalloc test driver"
to see how many CPU cycles it takes to complete all test cases
running sequentially. All online CPUs run it so it will cause
a high lock contention.

HiKey 960, ARM64, 8xCPUs, big.LITTLE:

<snip>
    sudo ./test_vmalloc.sh sequential_test_order=1
<snip>

<default>
[  390.950557] All test took CPU0=457126382 cycles
[  391.046690] All test took CPU1=454763452 cycles
[  391.128586] All test took CPU2=454539334 cycles
[  391.222669] All test took CPU3=455649517 cycles
[  391.313946] All test took CPU4=388272196 cycles
[  391.410425] All test took CPU5=384036264 cycles
[  391.492219] All test took CPU6=387432964 cycles
[  391.578433] All test took CPU7=387201996 cycles
<default>

<patched>
[  304.721224] All test took CPU0=391521310 cycles
[  304.821219] All test took CPU1=393533002 cycles
[  304.917120] All test took CPU2=392243032 cycles
[  305.008986] All test took CPU3=392353853 cycles
[  305.108944] All test took CPU4=297630721 cycles
[  305.196406] All test took CPU5=297548736 cycles
[  305.288602] All test took CPU6=297092392 cycles
[  305.381088] All test took CPU7=297293597 cycles
<patched>

~14%-23% patched variant is better.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 80 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 30 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 2005acd612af..f48f64c8d200 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -331,6 +331,7 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 
 
 static DEFINE_SPINLOCK(vmap_area_lock);
+static DEFINE_SPINLOCK(free_vmap_area_lock);
 /* Export for kexec only */
 LIST_HEAD(vmap_area_list);
 static LLIST_HEAD(vmap_purge_list);
@@ -1114,7 +1115,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		 */
 		pva = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
 
-	spin_lock(&vmap_area_lock);
+	spin_lock(&free_vmap_area_lock);
 
 	if (pva && __this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva))
 		kmem_cache_free(vmap_area_cachep, pva);
@@ -1124,14 +1125,17 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	 * returned. Therefore trigger the overflow path.
 	 */
 	addr = __alloc_vmap_area(size, align, vstart, vend);
+	spin_unlock(&free_vmap_area_lock);
+
 	if (unlikely(addr == vend))
 		goto overflow;
 
 	va->va_start = addr;
 	va->va_end = addr + size;
 	va->vm = NULL;
-	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
 
+	spin_lock(&vmap_area_lock);
+	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
 	spin_unlock(&vmap_area_lock);
 
 	BUG_ON(!IS_ALIGNED(va->va_start, align));
@@ -1141,7 +1145,6 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	return va;
 
 overflow:
-	spin_unlock(&vmap_area_lock);
 	if (!purged) {
 		purge_vmap_area_lazy();
 		purged = 1;
@@ -1177,28 +1180,25 @@ int unregister_vmap_purge_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_vmap_purge_notifier);
 
-static void __free_vmap_area(struct vmap_area *va)
+/*
+ * Free a region of KVA allocated by alloc_vmap_area
+ */
+static void free_vmap_area(struct vmap_area *va)
 {
 	/*
 	 * Remove from the busy tree/list.
 	 */
+	spin_lock(&vmap_area_lock);
 	unlink_va(va, &vmap_area_root);
+	spin_unlock(&vmap_area_lock);
 
 	/*
-	 * Merge VA with its neighbors, otherwise just add it.
+	 * Insert/Merge it back to the free tree/list.
 	 */
+	spin_lock(&free_vmap_area_lock);
 	merge_or_add_vmap_area(va,
 		&free_vmap_area_root, &free_vmap_area_list);
-}
-
-/*
- * Free a region of KVA allocated by alloc_vmap_area
- */
-static void free_vmap_area(struct vmap_area *va)
-{
-	spin_lock(&vmap_area_lock);
-	__free_vmap_area(va);
-	spin_unlock(&vmap_area_lock);
+	spin_unlock(&free_vmap_area_lock);
 }
 
 /*
@@ -1291,7 +1291,7 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 	flush_tlb_kernel_range(start, end);
 	resched_threshold = lazy_max_pages() << 1;
 
-	spin_lock(&vmap_area_lock);
+	spin_lock(&free_vmap_area_lock);
 	llist_for_each_entry_safe(va, n_va, valist, purge_list) {
 		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
 
@@ -1306,9 +1306,9 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 		atomic_long_sub(nr, &vmap_lazy_nr);
 
 		if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
-			cond_resched_lock(&vmap_area_lock);
+			cond_resched_lock(&free_vmap_area_lock);
 	}
-	spin_unlock(&vmap_area_lock);
+	spin_unlock(&free_vmap_area_lock);
 	return true;
 }
 
@@ -2030,15 +2030,21 @@ int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page **pages)
 }
 EXPORT_SYMBOL_GPL(map_vm_area);
 
-static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
-			      unsigned long flags, const void *caller)
+static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
+	struct vmap_area *va, unsigned long flags, const void *caller)
 {
-	spin_lock(&vmap_area_lock);
 	vm->flags = flags;
 	vm->addr = (void *)va->va_start;
 	vm->size = va->va_end - va->va_start;
 	vm->caller = caller;
 	va->vm = vm;
+}
+
+static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
+			      unsigned long flags, const void *caller)
+{
+	spin_lock(&vmap_area_lock);
+	setup_vmalloc_vm_locked(vm, va, flags, caller);
 	spin_unlock(&vmap_area_lock);
 }
 
@@ -3278,7 +3284,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 			goto err_free;
 	}
 retry:
-	spin_lock(&vmap_area_lock);
+	spin_lock(&free_vmap_area_lock);
 
 	/* start scanning - we scan from the top, begin with the last area */
 	area = term_area = last_area;
@@ -3360,29 +3366,38 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 		va = vas[area];
 		va->va_start = start;
 		va->va_end = start + size;
-
-		insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
 	}
 
-	spin_unlock(&vmap_area_lock);
+	spin_unlock(&free_vmap_area_lock);
 
 	/* insert all vm's */
-	for (area = 0; area < nr_vms; area++)
-		setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
+	spin_lock(&vmap_area_lock);
+	for (area = 0; area < nr_vms; area++) {
+		insert_vmap_area(vas[area], &vmap_area_root, &vmap_area_list);
+
+		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
 				 pcpu_get_vm_areas);
+	}
+	spin_unlock(&vmap_area_lock);
 
 	kfree(vas);
 	return vms;
 
 recovery:
-	/* Remove previously inserted areas. */
+	/*
+	 * Remove previously allocated areas. There is no
+	 * need in removing these areas from the busy tree,
+	 * because they are inserted only on the final step
+	 * and when pcpu_get_vm_areas() is success.
+	 */
 	while (area--) {
-		__free_vmap_area(vas[area]);
+		merge_or_add_vmap_area(vas[area],
+			&free_vmap_area_root, &free_vmap_area_list);
 		vas[area] = NULL;
 	}
 
 overflow:
-	spin_unlock(&vmap_area_lock);
+	spin_unlock(&free_vmap_area_lock);
 	if (!purged) {
 		purge_vmap_area_lazy();
 		purged = true;
@@ -3433,9 +3448,12 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 
 #ifdef CONFIG_PROC_FS
 static void *s_start(struct seq_file *m, loff_t *pos)
+	__acquires(&vmap_purge_lock)
 	__acquires(&vmap_area_lock)
 {
+	mutex_lock(&vmap_purge_lock);
 	spin_lock(&vmap_area_lock);
+
 	return seq_list_start(&vmap_area_list, *pos);
 }
 
@@ -3445,8 +3463,10 @@ static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 }
 
 static void s_stop(struct seq_file *m, void *p)
+	__releases(&vmap_purge_lock)
 	__releases(&vmap_area_lock)
 {
+	mutex_unlock(&vmap_purge_lock);
 	spin_unlock(&vmap_area_lock);
 }
 
-- 
2.20.1

