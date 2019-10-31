Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7879CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45342087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfJaL5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:57:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55395 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfJaLzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92p-00035m-Vi; Thu, 31 Oct 2019 12:55:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 880D51C04F4;
        Thu, 31 Oct 2019 12:55:07 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:07 -0000
From:   "tip-bot2 for Wolfgang M. Reimer" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] locking: locktorture: Do not include rwlock.h directly
Cc:     "Wolfgang M. Reimer" <linuxball@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dbueso@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290720.29376.16264381220235980397.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     67d64918a163fd62cf3b668d69133b723c48ed96
Gitweb:        https://git.kernel.org/tip/67d64918a163fd62cf3b668d69133b723c48ed96
Author:        Wolfgang M. Reimer <linuxball@gmail.com>
AuthorDate:    Mon, 16 Sep 2019 16:54:04 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 11:50:24 -07:00

locking: locktorture: Do not include rwlock.h directly

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
