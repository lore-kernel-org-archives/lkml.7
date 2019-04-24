Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2879BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF6321900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129243;
	bh=AjD7eLZcC5Up6dXvFNhdH8P0K15EdbUkAjbaJmx9ZNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DbJF7qe1y25kA8MzLb7Tel8hetIcqLpo5zCjT4a+vLY1OaEwBbEANB7yF6E6Wdzj6
	 spJR6UNCXvOrXR6wYqBa9msxIosZekMiJxkIMtAShVMvx3yrCIzFVd474InivhdRhl
	 k9thPG9D1mMmaUsYwcBuhyBoHvbCs3/qZj5bEEuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbfDXRRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387772AbfDXRQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:16:57 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDDAC2190C;
        Wed, 24 Apr 2019 17:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126216;
        bh=AjD7eLZcC5Up6dXvFNhdH8P0K15EdbUkAjbaJmx9ZNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mLYF3l3dwD8lHgrZVO7CllB0AcD6EiqfYN97miMgCDzBF3fso3PG12AVdj6Fm5dE2
         COZtjyCfaQebcAE28t/325YbE1VKELVlJ+fDaT9z+jXTSSv5ZYVIOntLLlsDFSO4CK
         LGySEcj7f/RQdv8PFsS9eFu6v3kpBaJsGsIjPNmY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 031/168] ARM: 8840/1: use a raw_spinlock_t in unwind
Date:   Wed, 24 Apr 2019 19:07:55 +0200
Message-Id: <20190424170925.542966405@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



