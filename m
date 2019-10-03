Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A58C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA82222CA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570067261;
	bh=R+zo9I1mubtG3diDjh8Lku6UQCrP3wdMPlHyM/++ND0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EoZYZvl+pYuV1BhSCE+sRx9VHeXRZaJ5tluMT3lliJ1P2vLZIjNCG2vVfWfuajd3Z
	 0n6aRyDtnsZ9yya1R/kFglzxZvQvHTtNNLF9wp62/gDdOv1+xovz0uJRjGW5lBmKii
	 sk5MTlxGomW31LbiavE8Frjuesi0WU2aCxweEbpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfJCBrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbfJCBrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:47:33 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECCCE222C6;
        Thu,  3 Oct 2019 01:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570067253;
        bh=R+zo9I1mubtG3diDjh8Lku6UQCrP3wdMPlHyM/++ND0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u4gjXP0tg/2bMt2euad4lPndRXnwb0jLGi8R+qpSOADQyFnwlT1UHa1O4Z9s0Zz3W
         8qXCJXcevL6oNzDqgPluZGzqscDWWC/hHsrmOjgkyAtnEA2GGMvtr3LhprdE5Y2Atv
         g6RS1Nr7epfOReccYfWINwA+O0mzrfmqf//qFJJQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Wolfgang M. Reimer" <linuxball@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 8/9] locking: locktorture: Do not include rwlock.h directly
Date:   Wed,  2 Oct 2019 18:47:27 -0700
Message-Id: <20191003014728.13496-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003014710.GA13323@paulmck-ThinkPad-P72>
References: <20191003014710.GA13323@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Wolfgang M. Reimer" <linuxball@gmail.com>

Including rwlock.h directly will cause kernel builds to fail
if CONFIG_PREEMPT_RT is defined. The correct header file
(rwlock_rt.h OR rwlock.h) will be included by spinlock.h which
is included by locktorture.c anyway.

Remove the include of linux/rwlock.h.

Signed-off-by: Wolfgang M. Reimer <linuxball@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 8dd9002..99475a6 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -16,7 +16,6 @@
 #include <linux/kthread.h>
 #include <linux/sched/rt.h>
 #include <linux/spinlock.h>
-#include <linux/rwlock.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/smp.h>
-- 
2.9.5

