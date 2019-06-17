Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E4BC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275752084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aoMimue4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfFQOSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:18:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57619 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQOSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:18:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEI0mV3452655
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:18:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEI0mV3452655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560781081;
        bh=QvsIwv5WIf+fcrELoHYf3/XxiI/T/+7WhknAQJefcpA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=aoMimue4QS255/49S8jKwNJ6HkiHmK8XmmopUCnbCmM+RvIgclS7dSMgFtzjAr2FM
         2RSPuDhoDnmyTJpr3AiqHc4rjnyMDQE0PX1iFtkwMcBa1UvxO2JGTfeMWjKO1k1+Vr
         qHSxqL8Y+sPQ6Eic8f+h5dj8H5risLAmba14gkl/XqN6rcXpycgkpItwqAeIIiPzq0
         EU4EEfb7kecAKrqPEH5VF13UUfpuph14DD/txFIkWdO47edHQiOb9URoMDn4c0BOQi
         tvZKPoDRSejXD472LZ5tMaweqiacuOijyzeNBsutNX65fSqJznYomzxSoRdo0R6GG8
         nQNZ5uff7VXxQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEI08Z3452652;
        Mon, 17 Jun 2019 07:18:00 -0700
Date:   Mon, 17 Jun 2019 07:18:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kobe Wu <tipbot@zytor.com>
Message-ID: <tip-dd471efe345bf6f9e1206f6c629ca3e80eb43523@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com, hpa@zytor.com,
        tglx@linutronix.de, kobe-cp.wu@mediatek.com,
        eason-yh.lin@mediatek.com, mingo@kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Reply-To: peterz@infradead.org, linux-mediatek@lists.infradead.org,
          will.deacon@arm.com, linux-kernel@vger.kernel.org,
          eason-yh.lin@mediatek.com, kobe-cp.wu@mediatek.com,
          wsd_upstream@mediatek.com, tglx@linutronix.de, hpa@zytor.com,
          torvalds@linux-foundation.org, mingo@kernel.org
In-Reply-To: <1559217575-30298-1-git-send-email-kobe-cp.wu@mediatek.com>
References: <1559217575-30298-1-git-send-email-kobe-cp.wu@mediatek.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Remove unnecessary
 DEBUG_LOCKS_WARN_ON()
Git-Commit-ID: dd471efe345bf6f9e1206f6c629ca3e80eb43523
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

Commit-ID:  dd471efe345bf6f9e1206f6c629ca3e80eb43523
Gitweb:     https://git.kernel.org/tip/dd471efe345bf6f9e1206f6c629ca3e80eb43523
Author:     Kobe Wu <kobe-cp.wu@mediatek.com>
AuthorDate: Thu, 30 May 2019 19:59:35 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:09:37 +0200

locking/lockdep: Remove unnecessary DEBUG_LOCKS_WARN_ON()

DEBUG_LOCKS_WARN_ON() will turn off debug_locks and
makes print_unlock_imbalance_bug() return directly.

Remove a redundant whitespace.

Signed-off-by: Kobe Wu <kobe-cp.wu@mediatek.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <linux-mediatek@lists.infradead.org>
Cc: <wsd_upstream@mediatek.com>
Cc: Eason Lin <eason-yh.lin@mediatek.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/1559217575-30298-1-git-send-email-kobe-cp.wu@mediatek.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 48a840adb281..5e368f485330 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4160,7 +4160,7 @@ __lock_release(struct lockdep_map *lock, unsigned long ip)
 	 * So we're all set to release this lock.. wait what lock? We don't
 	 * own any locks, you've been drinking again?
 	 */
-	if (DEBUG_LOCKS_WARN_ON(depth <= 0)) {
+	if (depth <= 0) {
 		print_unlock_imbalance_bug(curr, lock, ip);
 		return 0;
 	}
