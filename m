Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD89C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D20127FFF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kPqR3vnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfFCNIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:08:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46747 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfFCNIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:08:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53D7oQX604683
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:07:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53D7oQX604683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567271;
        bh=GRLkO+ZDYhVg+i2YTXLTWgXWujGKHdWWN1O3IXC/BiQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=kPqR3vnGHzlQhOnXLJp+WM1Ie6kl4wThTSy+zSMFPcDf/Hdk1pInz9H78XFQwsW8V
         uZ1hY7NlGNRAzzYjlH0eTjoDDbnmKW9Lp/uI77HnxBxSYyU5UeJcBQQcQn6RAXBMUt
         6wIRpzO2CeqX9tMmyba27rmUpySH9OsT3tqq2ESm3vRsX1niQoWqn+KpLYWFunjLDZ
         sFKsxR39SiIh9jWSxYHpkxcJPAPRspH/dLfTvz1hc0DaBNIx5gxQvBMa2Osw/nMUu1
         7ueAHhEaacYk3a9UzpZCqWpUh/DP76tdf8n88Gg+MflVIkfwjcEX7/nqzBZNcJKGUc
         0vhxosb0F13mA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53D7on4604680;
        Mon, 3 Jun 2019 06:07:50 -0700
Date:   Mon, 3 Jun 2019 06:07:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-c52478f4f38ace598475413a08dba9b9fd827eaf@git.kernel.org>
Cc:     hpa@zytor.com, duyuyang@gmail.com, mingo@kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, duyuyang@gmail.com, mingo@kernel.org,
          torvalds@linux-foundation.org, peterz@infradead.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190506081939.74287-4-duyuyang@gmail.com>
References: <20190506081939.74287-4-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Adjust lock usage bit character
 checks
Git-Commit-ID: c52478f4f38ace598475413a08dba9b9fd827eaf
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c52478f4f38ace598475413a08dba9b9fd827eaf
Gitweb:     https://git.kernel.org/tip/c52478f4f38ace598475413a08dba9b9fd827eaf
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:19 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:35 +0200

locking/lockdep: Adjust lock usage bit character checks

The lock usage bit characters are defined and determined with tricks.
Add some explanation to make it a bit clearer, then adjust the logic to
check the usage, which optimizes the code a bit.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-4-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 109b56267c8f..a033df00fd1d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -500,15 +500,26 @@ static inline unsigned long lock_flag(enum lock_usage_bit bit)
 
 static char get_usage_char(struct lock_class *class, enum lock_usage_bit bit)
 {
+	/*
+	 * The usage character defaults to '.' (i.e., irqs disabled and not in
+	 * irq context), which is the safest usage category.
+	 */
 	char c = '.';
 
-	if (class->usage_mask & lock_flag(bit + LOCK_USAGE_DIR_MASK))
+	/*
+	 * The order of the following usage checks matters, which will
+	 * result in the outcome character as follows:
+	 *
+	 * - '+': irq is enabled and not in irq context
+	 * - '-': in irq context and irq is disabled
+	 * - '?': in irq context and irq is enabled
+	 */
+	if (class->usage_mask & lock_flag(bit + LOCK_USAGE_DIR_MASK)) {
 		c = '+';
-	if (class->usage_mask & lock_flag(bit)) {
-		c = '-';
-		if (class->usage_mask & lock_flag(bit + LOCK_USAGE_DIR_MASK))
+		if (class->usage_mask & lock_flag(bit))
 			c = '?';
-	}
+	} else if (class->usage_mask & lock_flag(bit))
+		c = '-';
 
 	return c;
 }
