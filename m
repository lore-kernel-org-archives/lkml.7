Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2338FC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0645217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738531;
	bh=aMw5OEOfuvqaK4/8eH+FqTlovkkEXzLycm8UxsZWlJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VTOkOw7KZhdjrQa4pzLaeqRj4wDl/gUZL7OrE2B4iGjLc6Uos9uwTsuhBZGDwHOIm
	 2X9vmZ22zGz7qZLW3w3HrbFHuioEV39fPklJE+Odxuka6oWvlybBpYjzWU3Xv9cfRa
	 xjSNqITssLV80avXOnD+a6Oh7bCRpAvDAZgcvWNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391668AbfHBJf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391655AbfHBJfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:35:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F9D4217D6;
        Fri,  2 Aug 2019 09:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738524;
        bh=aMw5OEOfuvqaK4/8eH+FqTlovkkEXzLycm8UxsZWlJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LAox6Nw9Kv3aI/nnsF9GYy9ZoRm3ae7HE7tuQSbxj8ElX+CmZ/zKoINOY+y1IAV5I
         YS4iGGVqlh9e+ohCXQ7kVkHZZaAJVWjPJtR2Trq+VdyHO1V0fpbSz8GPiZjJfm0YoV
         VEysy10x+M2n9CaPjqWHXjmyQyXip8+CoRmqm11w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Will Deacon <will@kernel.org>, Yuyang Du <duyuyang@gmail.com>,
        frederic@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 138/158] locking/lockdep: Hide unused class variable
Date:   Fri,  2 Aug 2019 11:29:19 +0200
Message-Id: <20190802092231.013094782@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 68037aa78208f34bda4e5cd76c357f718b838cbb ]

The usage is now hidden in an #ifdef, so we need to move
the variable itself in there as well to avoid this warning:

  kernel/locking/lockdep_proc.c:203:21: error: unused variable 'class' [-Werror,-Wunused-variable]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yuyang Du <duyuyang@gmail.com>
Cc: frederic@kernel.org
Fixes: 68d41d8c94a3 ("locking/lockdep: Fix lock used or unused stats error")
Link: https://lkml.kernel.org/r/20190715092809.736834-1-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/lockdep_proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 9778b6701019..35b34eccdd10 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -217,7 +217,6 @@ static void lockdep_stats_debug_show(struct seq_file *m)
 
 static int lockdep_stats_show(struct seq_file *m, void *v)
 {
-	struct lock_class *class;
 	unsigned long nr_unused = 0, nr_uncategorized = 0,
 		      nr_irq_safe = 0, nr_irq_unsafe = 0,
 		      nr_softirq_safe = 0, nr_softirq_unsafe = 0,
@@ -228,6 +227,8 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 		      sum_forward_deps = 0;
 
 #ifdef CONFIG_PROVE_LOCKING
+	struct lock_class *class;
+
 	list_for_each_entry(class, &all_lock_classes, lock_entry) {
 
 		if (class->usage_mask == 0)
-- 
2.20.1



