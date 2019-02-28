Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0718AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEBF218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551373993;
	bh=xJBvYIz9y7bwnllKsJ0V8fVOwpxwwkwe0aKG5eTNPCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cndlLdQ19emx1w3poRVduzXaqVvnqNegQOc5pGyh7+qLBoq7f2HuM6Ulu4/T1Kw9h
	 IKyZdkGidDYPbZqCSymDzwJif0VOW7Cu/MUdOAGe1NJINA1NPjjNaUrf4Uv/kRcSMH
	 xc64w762xJSeKMM70upvVgNptJ04ZETEx8yOBotA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbfB1RNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:13:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387557AbfB1RNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:13:09 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FD93218AE;
        Thu, 28 Feb 2019 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551373988;
        bh=xJBvYIz9y7bwnllKsJ0V8fVOwpxwwkwe0aKG5eTNPCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piwpizMmLTMAGxhvNnBLbE69VUqdevNlOl6ikcmTc/CMKVinuxlIkqUkIwz8MYPY5
         v/AmhHFoevMy0HQfYR6UQZZPAfutVhxccBqocTqqe4+wiUsEDbaEQf1pk1jgWHF8pA
         ZaAgCX0XhNR3Lj/RI+9mKYU7AgNHd5StK5lk8Bjo=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 05/37] locking/lockdep: Introduce lock usage mask iterator
Date:   Thu, 28 Feb 2019 18:12:10 +0100
Message-Id: <20190228171242.32144-6-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a mask iterator that can be used to get the bit numbers from a
lock usage mask.

We don't want the overhead of the bitmap library for a fixed small 64
bit mask. So we just want a simple loop relying on an ffs() like
function. Yet we want to be careful not to shift further 64 bits at once
as it has unpredictable behaviour, depending on architecture backend.

Therefore the shift on each iteration is cut in two parts:

1) Shift by the first set bit number (can't exceed 63)
2) Shift again by 1 because __ffs64() counts from zero

Inspired-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/lockdep.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 004278969afc..1a335176cb61 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -463,6 +463,23 @@ const char * __get_key_name(struct lockdep_subclass_key *key, char *str)
 	return kallsyms_lookup((unsigned long)key, NULL, NULL, NULL, str);
 }
 
+static u64 mask_iter(u64 *mask, int *bit)
+{
+	u64 old_mask = *mask;
+
+	if (old_mask) {
+		long fs = __ffs64(old_mask);
+		*bit += fs;
+		*mask >>= fs;
+		*mask >>= 1;
+	}
+
+	return old_mask;
+}
+
+#define for_each_bit_nr(mask, bit)	\
+	for (bit = 0; mask_iter(&mask, &bit); bit++)
+
 static inline u64 lock_flag(enum lock_usage_bit bit)
 {
 	return BIT_ULL(bit);
-- 
2.21.0

