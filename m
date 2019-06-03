Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70462C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44627259B4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Fy9pcCyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfFCNRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:17:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35585 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfFCNRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:17:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DHK5v606187
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:17:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DHK5v606187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567841;
        bh=ZJgHSBpX0kT7fL9wXKGuCVJbtoQ4uP+I8TijZxt9U0w=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Fy9pcCyNPhpRl8DT3wsvKPNQ3EqS1RdbbPrLvH+liy9bjDopZdKoQ3nJTKg9VgTSH
         iuGhTEesjYMxQLu1A+h6lVx8yxY1YWxaMvZklhD6wUe8eqRQgHTllremYDBmkNvNER
         uvVSff5gwa4zJS65TlWlyU4bRKqNpBMDDqkkrKcDjHu9NjxCFCQ6dUhY0uO3SLeNmR
         dJw9Jg9yganM6FC4y5YfhHMeLrtKzcZvuP413jO/N8CHfhAOzux2JInKPFB/mPztSO
         lJrMevs5YipgBLjM5oc+Wud1T2XFIMgMeKnRNINhxQQUEv+PEBq8QNqNP/1lreoL+4
         AvakixOcPs6dw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DHKSp606184;
        Mon, 3 Jun 2019 06:17:20 -0700
Date:   Mon, 3 Jun 2019 06:17:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-1ac4ba5ed0114bcc146d5743d97df414af25c524@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, duyuyang@gmail.com
Reply-To: peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          hpa@zytor.com, torvalds@linux-foundation.org, duyuyang@gmail.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190506081939.74287-17-duyuyang@gmail.com>
References: <20190506081939.74287-17-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Add explanation to lock usage
 rules in lockdep design doc
Git-Commit-ID: 1ac4ba5ed0114bcc146d5743d97df414af25c524
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

Commit-ID:  1ac4ba5ed0114bcc146d5743d97df414af25c524
Gitweb:     https://git.kernel.org/tip/1ac4ba5ed0114bcc146d5743d97df414af25c524
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:32 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:48 +0200

locking/lockdep: Add explanation to lock usage rules in lockdep design doc

The irq usage and lock dependency rules that if violated a deacklock may
happen are explained in more detail.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-17-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/locking/lockdep-design.txt | 33 ++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index ae65758383ea..f189d130e543 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -108,14 +108,24 @@ Unused locks (e.g., mutexes) cannot be part of the cause of an error.
 Single-lock state rules:
 ------------------------
 
+A lock is irq-safe means it was ever used in an irq context, while a lock
+is irq-unsafe means it was ever acquired with irq enabled.
+
 A softirq-unsafe lock-class is automatically hardirq-unsafe as well. The
-following states are exclusive, and only one of them is allowed to be
-set for any lock-class:
+following states must be exclusive: only one of them is allowed to be set
+for any lock-class based on its usage:
+
+ <hardirq-safe> or <hardirq-unsafe>
+ <softirq-safe> or <softirq-unsafe>
 
- <hardirq-safe> and <hardirq-unsafe>
- <softirq-safe> and <softirq-unsafe>
+This is because if a lock can be used in irq context (irq-safe) then it
+cannot be ever acquired with irq enabled (irq-unsafe). Otherwise, a
+deadlock may happen. For example, in the scenario that after this lock
+was acquired but before released, if the context is interrupted this
+lock will be attempted to acquire twice, which creates a deadlock,
+referred to as lock recursion deadlock.
 
-The validator detects and reports lock usage that violate these
+The validator detects and reports lock usage that violates these
 single-lock state rules.
 
 Multi-lock dependency rules:
@@ -124,15 +134,18 @@ Multi-lock dependency rules:
 The same lock-class must not be acquired twice, because this could lead
 to lock recursion deadlocks.
 
-Furthermore, two locks may not be taken in different order:
+Furthermore, two locks can not be taken in inverse order:
 
  <L1> -> <L2>
  <L2> -> <L1>
 
-because this could lead to lock inversion deadlocks. (The validator
-finds such dependencies in arbitrary complexity, i.e. there can be any
-other locking sequence between the acquire-lock operations, the
-validator will still track all dependencies between locks.)
+because this could lead to a deadlock - referred to as lock inversion
+deadlock - as attempts to acquire the two locks form a circle which
+could lead to the two contexts waiting for each other permanently. The
+validator will find such dependency circle in arbitrary complexity,
+i.e., there can be any other locking sequence between the acquire-lock
+operations; the validator will still find whether these locks can be
+acquired in a circular fashion.
 
 Furthermore, the following usage based lock dependencies are not allowed
 between any two lock-classes:
