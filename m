Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B2DC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C9220843
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099929;
	bh=TwtJluF6BbhJE+6h1UprJysITJvpGK9xHDONFOSyIJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rkyZNM/GlxTDsXpko/16GUP7Jg5iker36/KIDEODZvFkaL3bWnyY9YdX3zd64lplJ
	 M3P3SrMgOEKk+IHm2Oajzbb666XfC+vmkGwwnuzW5oAnJKyMjDqYw5NbcFA1kKnVHE
	 Emw0QGEMZlbamR9whJfvIDtcNrE0HuWrI9BqtB5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbfFIRF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388807AbfFIRFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:05:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D18E42084A;
        Sun,  9 Jun 2019 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099924;
        bh=TwtJluF6BbhJE+6h1UprJysITJvpGK9xHDONFOSyIJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UnGHNiZa8arrovFfCc0xD+TbC8olDaK8pyCQKMSp+Uj2ozcZHgVL1wh+RtA78nytQ
         YD23gUHCweRnEgipUDZH5K83+f5z2NmmKCCeL1nNjNJmXFwexjNLZEe4JAxO5WaLav
         SSlOvhNwvm+VqKvQ/C/NToDC8CYHORm4P8YLYAP8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 214/241] binder: Replace "%p" with "%pK" for stable
Date:   Sun,  9 Jun 2019 18:42:36 +0200
Message-Id: <20190609164154.849565479@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

This was done as part of upstream commits fdfb4a99b6ab "8inder:
separate binder allocator structure from binder proc", 19c987241ca1
"binder: separate out binder_alloc functions", and 7a4408c6bd3e
"binder: make sure accesses to proc/thread are safe".  However, those
commits made lots of other changes that are not suitable for stable.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/android/binder.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -477,7 +477,7 @@ static void binder_insert_free_buffer(st
 	new_buffer_size = binder_buffer_size(proc, new_buffer);
 
 	binder_debug(BINDER_DEBUG_BUFFER_ALLOC,
-		     "%d: add free buffer, size %zd, at %p\n",
+		     "%d: add free buffer, size %zd, at %pK\n",
 		      proc->pid, new_buffer_size, new_buffer);
 
 	while (*p) {
@@ -555,7 +555,7 @@ static int binder_update_page_range(stru
 	struct mm_struct *mm;
 
 	binder_debug(BINDER_DEBUG_BUFFER_ALLOC,
-		     "%d: %s pages %p-%p\n", proc->pid,
+		     "%d: %s pages %pK-%pK\n", proc->pid,
 		     allocate ? "allocate" : "free", start, end);
 
 	if (end <= start)
@@ -595,7 +595,7 @@ static int binder_update_page_range(stru
 		BUG_ON(*page);
 		*page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
 		if (*page == NULL) {
-			pr_err("%d: binder_alloc_buf failed for page at %p\n",
+			pr_err("%d: binder_alloc_buf failed for page at %pK\n",
 				proc->pid, page_addr);
 			goto err_alloc_page_failed;
 		}
@@ -604,7 +604,7 @@ static int binder_update_page_range(stru
 		flush_cache_vmap((unsigned long)page_addr,
 				(unsigned long)page_addr + PAGE_SIZE);
 		if (ret != 1) {
-			pr_err("%d: binder_alloc_buf failed to map page at %p in kernel\n",
+			pr_err("%d: binder_alloc_buf failed to map page at %pK in kernel\n",
 			       proc->pid, page_addr);
 			goto err_map_kernel_failed;
 		}
@@ -708,7 +708,7 @@ static struct binder_buffer *binder_allo
 	}
 
 	binder_debug(BINDER_DEBUG_BUFFER_ALLOC,
-		     "%d: binder_alloc_buf size %zd got buffer %p size %zd\n",
+		     "%d: binder_alloc_buf size %zd got buffer %pK size %zd\n",
 		      proc->pid, size, buffer, buffer_size);
 
 	has_page_addr =
@@ -738,7 +738,7 @@ static struct binder_buffer *binder_allo
 		binder_insert_free_buffer(proc, new_buffer);
 	}
 	binder_debug(BINDER_DEBUG_BUFFER_ALLOC,
-		     "%d: binder_alloc_buf size %zd got %p\n",
+		     "%d: binder_alloc_buf size %zd got %pK\n",
 		      proc->pid, size, buffer);
 	buffer->data_size = data_size;
 	buffer->offsets_size = offsets_size;
@@ -778,7 +778,7 @@ static void binder_delete_free_buffer(st
 		if (buffer_end_page(prev) == buffer_end_page(buffer))
 			free_page_end = 0;
 		binder_debug(BINDER_DEBUG_BUFFER_ALLOC,
-			     "%d: merge free, buffer %p share page with %p\n",
+			     "%d: merge free, buffer %pK share page with %pK\n",
 			      proc->pid, buffer, prev);
 	}
 
@@ -791,14 +791,14 @@ static void binder_delete_free_buffer(st
 			    buffer_start_page(buffer))
 				free_page_start = 0;
 			binder_debug(BINDER_DEBUG_BUFFER_ALLOC,
-				     "%d: merge free, buffer %p share page with %p\n",
+				     "%d: merge free, buffer %pK share page with %pK\n",
 				      proc->pid, buffer, prev);
 		}
 	}
 	list_del(&buffer->entry);
 	if (free_page_start || free_page_end) {
 		binder_debug(BINDER_DEBUG_BUFFER_ALLOC,
-			     "%d: merge free, buffer %p do not share page%s%s with %p or %p\n",
+			     "%d: merge free, buffer %pK do not share page%s%s with %pK or %pK\n",
 			     proc->pid, buffer, free_page_start ? "" : " end",
 			     free_page_end ? "" : " start", prev, next);
 		binder_update_page_range(proc, 0, free_page_start ?
@@ -819,7 +819,7 @@ static void binder_free_buf(struct binde
 		ALIGN(buffer->offsets_size, sizeof(void *));
 
 	binder_debug(BINDER_DEBUG_BUFFER_ALLOC,
-		     "%d: binder_free_buf %p size %zd buffer_size %zd\n",
+		     "%d: binder_free_buf %pK size %zd buffer_size %zd\n",
 		      proc->pid, buffer, size, buffer_size);
 
 	BUG_ON(buffer->free);
@@ -2912,7 +2912,7 @@ static int binder_mmap(struct file *filp
 #ifdef CONFIG_CPU_CACHE_VIPT
 	if (cache_is_vipt_aliasing()) {
 		while (CACHE_COLOUR((vma->vm_start ^ (uint32_t)proc->buffer))) {
-			pr_info("binder_mmap: %d %lx-%lx maps %p bad alignment\n", proc->pid, vma->vm_start, vma->vm_end, proc->buffer);
+			pr_info("binder_mmap: %d %lx-%lx maps %pK bad alignment\n", proc->pid, vma->vm_start, vma->vm_end, proc->buffer);
 			vma->vm_start += PAGE_SIZE;
 		}
 	}
@@ -3170,7 +3170,7 @@ static void binder_deferred_release(stru
 
 			page_addr = proc->buffer + i * PAGE_SIZE;
 			binder_debug(BINDER_DEBUG_BUFFER_ALLOC,
-				     "%s: %d: page %d at %p not freed\n",
+				     "%s: %d: page %d at %pK not freed\n",
 				     __func__, proc->pid, i, page_addr);
 			unmap_kernel_range((unsigned long)page_addr, PAGE_SIZE);
 			__free_page(proc->pages[i]);
@@ -3271,7 +3271,7 @@ static void print_binder_transaction(str
 static void print_binder_buffer(struct seq_file *m, const char *prefix,
 				struct binder_buffer *buffer)
 {
-	seq_printf(m, "%s %d: %p size %zd:%zd %s\n",
+	seq_printf(m, "%s %d: %pK size %zd:%zd %s\n",
 		   prefix, buffer->debug_id, buffer->data,
 		   buffer->data_size, buffer->offsets_size,
 		   buffer->transaction ? "active" : "delivered");
@@ -3374,7 +3374,7 @@ static void print_binder_node(struct seq
 
 static void print_binder_ref(struct seq_file *m, struct binder_ref *ref)
 {
-	seq_printf(m, "  ref %d: desc %d %snode %d s %d w %d d %p\n",
+	seq_printf(m, "  ref %d: desc %d %snode %d s %d w %d d %pK\n",
 		   ref->debug_id, ref->desc, ref->node->proc ? "" : "dead ",
 		   ref->node->debug_id, ref->strong, ref->weak, ref->death);
 }


