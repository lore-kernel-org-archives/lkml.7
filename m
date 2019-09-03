Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734D7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B66122CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="nv6N8hPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfICQAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:00:47 -0400
Received: from mail.efficios.com ([167.114.142.138]:48752 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbfICQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:00:46 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C31962AD040;
        Tue,  3 Sep 2019 12:00:44 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id EphBwRFn-4t9; Tue,  3 Sep 2019 12:00:43 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9AB5D2AD032;
        Tue,  3 Sep 2019 12:00:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9AB5D2AD032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567526443;
        bh=k5CKeSUxPsj6j/dB1hvkDB9UORtbJi60JtUm4Cx5s6Q=;
        h=From:To:Date:Message-Id;
        b=nv6N8hPPFWUw9zv2Y1vs0FOv/Z2vNJgjPyVnE/nwXvr6QZeHAo99OAT+IIt/CKvmy
         BVUNlUUvYrtOJ7jcNV+a4ATPIk38xWTTRKJxgypC3hOakSqtg01PgU38FnR/Qnp8HZ
         CeLEPIgeU9O7psejg7Y9RY2iC3GtBxGKD4NCK22l2td1+b+TYqpbcx68vgayEDbB1u
         OY9KtlNtR07lMT7NmJJZKH4i5CQarTJCgRcKcJiAqMKLOzOKs0/SzjJia15m//++kF
         vqfpUs6sq2Pcn3s04Di4PXxIfLgNBgNLKpsWG42Ttnyxqu1oNXQ9rt6uVkSB3g7g5R
         Fh64SaEsXKWCw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 8QqFABYLnlDB; Tue,  3 Sep 2019 12:00:43 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 63B1B2AD024;
        Tue,  3 Sep 2019 12:00:43 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 1/3] Fix: sched: task_rcu_dereference: check probe_kernel_address return value
Date:   Tue,  3 Sep 2019 12:00:34 -0400
Message-Id: <20190903160036.2400-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160036.2400-1-mathieu.desnoyers@efficios.com>
References: <20190903160036.2400-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

probe_kernel_address can return -EFAULT on error, which leads to use of
an uninitialized or partially initialized sighand variable.

There is ongoing discussion on removing task_rcu_dereference altogether,
which seems like a nice way forward. This patch is submitted as a fix
aiming to be backported to prior stable kernel releases.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Kirill Tkhai <tkhai@yandex.ru>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/exit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 5b4a5dcce8f8..b1c3e1ba501c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -249,7 +249,8 @@ struct task_struct *task_rcu_dereference(struct task_struct **ptask)
 	if (!task)
 		return NULL;
 
-	probe_kernel_address(&task->sighand, sighand);
+	if (probe_kernel_address(&task->sighand, sighand))
+		sighand = NULL;
 
 	/*
 	 * Pairs with atomic_dec_and_test() in put_task_struct(). If this task
-- 
2.17.1

