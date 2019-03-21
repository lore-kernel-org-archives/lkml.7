Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DB4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC0021929
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfCUWAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:00:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:53200 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbfCUWA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:00:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="216357237"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2019 15:00:23 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 30F9330214C; Thu, 21 Mar 2019 15:00:23 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 06/17] locking/core: Mark spinlocks noinline when inline spinlocks are disabled
Date:   Thu, 21 Mar 2019 14:59:58 -0700
Message-Id: <20190321220009.29334-7-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321220009.29334-1-andi@firstfloor.org>
References: <20190321220009.29334-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Otherwise LTO will inline them anyways and cause a large
kernel text increase.

Since the explicit intention here is to not inline them marking
them noinline is good documentation even for the non LTO case.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 kernel/locking/spinlock.c | 56 +++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 936f3d14dd6b..51031785e821 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -123,7 +123,7 @@ BUILD_LOCK_OPS(write, rwlock);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_TRYLOCK
-int __lockfunc _raw_spin_trylock(raw_spinlock_t *lock)
+noinline int __lockfunc _raw_spin_trylock(raw_spinlock_t *lock)
 {
 	return __raw_spin_trylock(lock);
 }
@@ -131,7 +131,7 @@ EXPORT_SYMBOL(_raw_spin_trylock);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_TRYLOCK_BH
-int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock)
+noinline int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock)
 {
 	return __raw_spin_trylock_bh(lock);
 }
@@ -139,7 +139,7 @@ EXPORT_SYMBOL(_raw_spin_trylock_bh);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_LOCK
-void __lockfunc _raw_spin_lock(raw_spinlock_t *lock)
+noinline void __lockfunc _raw_spin_lock(raw_spinlock_t *lock)
 {
 	__raw_spin_lock(lock);
 }
@@ -147,7 +147,7 @@ EXPORT_SYMBOL(_raw_spin_lock);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_LOCK_IRQSAVE
-unsigned long __lockfunc _raw_spin_lock_irqsave(raw_spinlock_t *lock)
+noinline unsigned long __lockfunc _raw_spin_lock_irqsave(raw_spinlock_t *lock)
 {
 	return __raw_spin_lock_irqsave(lock);
 }
@@ -155,7 +155,7 @@ EXPORT_SYMBOL(_raw_spin_lock_irqsave);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_LOCK_IRQ
-void __lockfunc _raw_spin_lock_irq(raw_spinlock_t *lock)
+noinline void __lockfunc _raw_spin_lock_irq(raw_spinlock_t *lock)
 {
 	__raw_spin_lock_irq(lock);
 }
@@ -163,7 +163,7 @@ EXPORT_SYMBOL(_raw_spin_lock_irq);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_LOCK_BH
-void __lockfunc _raw_spin_lock_bh(raw_spinlock_t *lock)
+noinline void __lockfunc _raw_spin_lock_bh(raw_spinlock_t *lock)
 {
 	__raw_spin_lock_bh(lock);
 }
@@ -171,7 +171,7 @@ EXPORT_SYMBOL(_raw_spin_lock_bh);
 #endif
 
 #ifdef CONFIG_UNINLINE_SPIN_UNLOCK
-void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)
+noinline void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)
 {
 	__raw_spin_unlock(lock);
 }
@@ -179,7 +179,7 @@ EXPORT_SYMBOL(_raw_spin_unlock);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE
-void __lockfunc _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
+noinline void __lockfunc _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
 {
 	__raw_spin_unlock_irqrestore(lock, flags);
 }
@@ -187,7 +187,7 @@ EXPORT_SYMBOL(_raw_spin_unlock_irqrestore);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_UNLOCK_IRQ
-void __lockfunc _raw_spin_unlock_irq(raw_spinlock_t *lock)
+noinline void __lockfunc _raw_spin_unlock_irq(raw_spinlock_t *lock)
 {
 	__raw_spin_unlock_irq(lock);
 }
@@ -195,7 +195,7 @@ EXPORT_SYMBOL(_raw_spin_unlock_irq);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_UNLOCK_BH
-void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)
+noinline void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)
 {
 	__raw_spin_unlock_bh(lock);
 }
@@ -203,7 +203,7 @@ EXPORT_SYMBOL(_raw_spin_unlock_bh);
 #endif
 
 #ifndef CONFIG_INLINE_READ_TRYLOCK
-int __lockfunc _raw_read_trylock(rwlock_t *lock)
+noinline int __lockfunc _raw_read_trylock(rwlock_t *lock)
 {
 	return __raw_read_trylock(lock);
 }
@@ -211,7 +211,7 @@ EXPORT_SYMBOL(_raw_read_trylock);
 #endif
 
 #ifndef CONFIG_INLINE_READ_LOCK
-void __lockfunc _raw_read_lock(rwlock_t *lock)
+noinline void __lockfunc _raw_read_lock(rwlock_t *lock)
 {
 	__raw_read_lock(lock);
 }
@@ -219,7 +219,7 @@ EXPORT_SYMBOL(_raw_read_lock);
 #endif
 
 #ifndef CONFIG_INLINE_READ_LOCK_IRQSAVE
-unsigned long __lockfunc _raw_read_lock_irqsave(rwlock_t *lock)
+noinline unsigned long __lockfunc _raw_read_lock_irqsave(rwlock_t *lock)
 {
 	return __raw_read_lock_irqsave(lock);
 }
@@ -227,7 +227,7 @@ EXPORT_SYMBOL(_raw_read_lock_irqsave);
 #endif
 
 #ifndef CONFIG_INLINE_READ_LOCK_IRQ
-void __lockfunc _raw_read_lock_irq(rwlock_t *lock)
+noinline void __lockfunc _raw_read_lock_irq(rwlock_t *lock)
 {
 	__raw_read_lock_irq(lock);
 }
@@ -235,7 +235,7 @@ EXPORT_SYMBOL(_raw_read_lock_irq);
 #endif
 
 #ifndef CONFIG_INLINE_READ_LOCK_BH
-void __lockfunc _raw_read_lock_bh(rwlock_t *lock)
+noinline void __lockfunc _raw_read_lock_bh(rwlock_t *lock)
 {
 	__raw_read_lock_bh(lock);
 }
@@ -243,7 +243,7 @@ EXPORT_SYMBOL(_raw_read_lock_bh);
 #endif
 
 #ifndef CONFIG_INLINE_READ_UNLOCK
-void __lockfunc _raw_read_unlock(rwlock_t *lock)
+noinline void __lockfunc _raw_read_unlock(rwlock_t *lock)
 {
 	__raw_read_unlock(lock);
 }
@@ -251,7 +251,7 @@ EXPORT_SYMBOL(_raw_read_unlock);
 #endif
 
 #ifndef CONFIG_INLINE_READ_UNLOCK_IRQRESTORE
-void __lockfunc _raw_read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
+noinline void __lockfunc _raw_read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 {
 	__raw_read_unlock_irqrestore(lock, flags);
 }
@@ -259,7 +259,7 @@ EXPORT_SYMBOL(_raw_read_unlock_irqrestore);
 #endif
 
 #ifndef CONFIG_INLINE_READ_UNLOCK_IRQ
-void __lockfunc _raw_read_unlock_irq(rwlock_t *lock)
+noinline void __lockfunc _raw_read_unlock_irq(rwlock_t *lock)
 {
 	__raw_read_unlock_irq(lock);
 }
@@ -267,7 +267,7 @@ EXPORT_SYMBOL(_raw_read_unlock_irq);
 #endif
 
 #ifndef CONFIG_INLINE_READ_UNLOCK_BH
-void __lockfunc _raw_read_unlock_bh(rwlock_t *lock)
+noinline void __lockfunc _raw_read_unlock_bh(rwlock_t *lock)
 {
 	__raw_read_unlock_bh(lock);
 }
@@ -275,7 +275,7 @@ EXPORT_SYMBOL(_raw_read_unlock_bh);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_TRYLOCK
-int __lockfunc _raw_write_trylock(rwlock_t *lock)
+noinline int __lockfunc _raw_write_trylock(rwlock_t *lock)
 {
 	return __raw_write_trylock(lock);
 }
@@ -283,7 +283,7 @@ EXPORT_SYMBOL(_raw_write_trylock);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_LOCK
-void __lockfunc _raw_write_lock(rwlock_t *lock)
+noinline void __lockfunc _raw_write_lock(rwlock_t *lock)
 {
 	__raw_write_lock(lock);
 }
@@ -291,7 +291,7 @@ EXPORT_SYMBOL(_raw_write_lock);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_LOCK_IRQSAVE
-unsigned long __lockfunc _raw_write_lock_irqsave(rwlock_t *lock)
+noinline unsigned long __lockfunc _raw_write_lock_irqsave(rwlock_t *lock)
 {
 	return __raw_write_lock_irqsave(lock);
 }
@@ -299,7 +299,7 @@ EXPORT_SYMBOL(_raw_write_lock_irqsave);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_LOCK_IRQ
-void __lockfunc _raw_write_lock_irq(rwlock_t *lock)
+noinline void __lockfunc _raw_write_lock_irq(rwlock_t *lock)
 {
 	__raw_write_lock_irq(lock);
 }
@@ -307,7 +307,7 @@ EXPORT_SYMBOL(_raw_write_lock_irq);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_LOCK_BH
-void __lockfunc _raw_write_lock_bh(rwlock_t *lock)
+noinline void __lockfunc _raw_write_lock_bh(rwlock_t *lock)
 {
 	__raw_write_lock_bh(lock);
 }
@@ -315,7 +315,7 @@ EXPORT_SYMBOL(_raw_write_lock_bh);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_UNLOCK
-void __lockfunc _raw_write_unlock(rwlock_t *lock)
+noinline void __lockfunc _raw_write_unlock(rwlock_t *lock)
 {
 	__raw_write_unlock(lock);
 }
@@ -323,7 +323,7 @@ EXPORT_SYMBOL(_raw_write_unlock);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE
-void __lockfunc _raw_write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
+noinline void __lockfunc _raw_write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 {
 	__raw_write_unlock_irqrestore(lock, flags);
 }
@@ -331,7 +331,7 @@ EXPORT_SYMBOL(_raw_write_unlock_irqrestore);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_UNLOCK_IRQ
-void __lockfunc _raw_write_unlock_irq(rwlock_t *lock)
+noinline void __lockfunc _raw_write_unlock_irq(rwlock_t *lock)
 {
 	__raw_write_unlock_irq(lock);
 }
@@ -339,7 +339,7 @@ EXPORT_SYMBOL(_raw_write_unlock_irq);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_UNLOCK_BH
-void __lockfunc _raw_write_unlock_bh(rwlock_t *lock)
+noinline void __lockfunc _raw_write_unlock_bh(rwlock_t *lock)
 {
 	__raw_write_unlock_bh(lock);
 }
-- 
2.20.1

