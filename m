Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D54C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30C62075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712227;
	bh=XX8Hn9a9Oah4IHGno6eDUs0zRW/pen3d/J+I3YWdfkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tyY61TGjg1YEcdnpr1p1c+J1+uRKk4ykAtziBdnhYayEc/9GTElz+EPbyEbd2uJ1i
	 r0yJPfLSUbvqxgkdVT9JIKi4ry6umcIqd49klmOUBBdHOl2cOVuKsd10WC+KgD6Ouu
	 G8o3mxee6WokH+6kY1luS3WeKR+zL9MOktBYp7LI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392034AbfC0Snr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391180AbfC0SVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:21:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E28932063F;
        Wed, 27 Mar 2019 18:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710889;
        bh=XX8Hn9a9Oah4IHGno6eDUs0zRW/pen3d/J+I3YWdfkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWXU/t7fUzIIVEOmQqN5Bojquw+03wRnkXmSe1hCwTU5LeDs4eRJaadfhv9NGWr7a
         bG8vhTjbl/XKByIn8CX8e6dBYsyvwN6WcFsC9gSGsveJH3YYuZHGGviO6VNDTew9O+
         2ipBsUfm46fZh1C945Cs7IKdIPplswQiRz5eMCpE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 29/87] ARM: 8840/1: use a raw_spinlock_t in unwind
Date:   Wed, 27 Mar 2019 14:19:42 -0400
Message-Id: <20190327182040.17444-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182040.17444-1-sashal@kernel.org>
References: <20190327182040.17444-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 74ffe79ae538283bbf7c155e62339f1e5c87b55a ]

Mostly unwind is done with irqs enabled however SLUB may call it with
irqs disabled while creating a new SLUB cache.

I had system freeze while loading a module which called
kmem_cache_create() on init. That means SLUB's __slab_alloc() disabled
interrupts and then

->new_slab_objects()
 ->new_slab()
  ->setup_object()
   ->setup_object_debug()
    ->init_tracking()
     ->set_track()
      ->save_stack_trace()
       ->save_stack_trace_tsk()
        ->walk_stackframe()
         ->unwind_frame()
          ->unwind_find_idx()
           =>spin_lock_irqsave(&unwind_lock);

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/unwind.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 0bee233fef9a..314cfb232a63 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -93,7 +93,7 @@ extern const struct unwind_idx __start_unwind_idx[];
 static const struct unwind_idx *__origin_unwind_idx;
 extern const struct unwind_idx __stop_unwind_idx[];
 
-static DEFINE_SPINLOCK(unwind_lock);
+static DEFINE_RAW_SPINLOCK(unwind_lock);
 static LIST_HEAD(unwind_tables);
 
 /* Convert a prel31 symbol to an absolute address */
@@ -201,7 +201,7 @@ static const struct unwind_idx *unwind_find_idx(unsigned long addr)
 		/* module unwind tables */
 		struct unwind_table *table;
 
-		spin_lock_irqsave(&unwind_lock, flags);
+		raw_spin_lock_irqsave(&unwind_lock, flags);
 		list_for_each_entry(table, &unwind_tables, list) {
 			if (addr >= table->begin_addr &&
 			    addr < table->end_addr) {
@@ -213,7 +213,7 @@ static const struct unwind_idx *unwind_find_idx(unsigned long addr)
 				break;
 			}
 		}
-		spin_unlock_irqrestore(&unwind_lock, flags);
+		raw_spin_unlock_irqrestore(&unwind_lock, flags);
 	}
 
 	pr_debug("%s: idx = %p\n", __func__, idx);
@@ -529,9 +529,9 @@ struct unwind_table *unwind_table_add(unsigned long start, unsigned long size,
 	tab->begin_addr = text_addr;
 	tab->end_addr = text_addr + text_size;
 
-	spin_lock_irqsave(&unwind_lock, flags);
+	raw_spin_lock_irqsave(&unwind_lock, flags);
 	list_add_tail(&tab->list, &unwind_tables);
-	spin_unlock_irqrestore(&unwind_lock, flags);
+	raw_spin_unlock_irqrestore(&unwind_lock, flags);
 
 	return tab;
 }
@@ -543,9 +543,9 @@ void unwind_table_del(struct unwind_table *tab)
 	if (!tab)
 		return;
 
-	spin_lock_irqsave(&unwind_lock, flags);
+	raw_spin_lock_irqsave(&unwind_lock, flags);
 	list_del(&tab->list);
-	spin_unlock_irqrestore(&unwind_lock, flags);
+	raw_spin_unlock_irqrestore(&unwind_lock, flags);
 
 	kfree(tab);
 }
-- 
2.19.1

