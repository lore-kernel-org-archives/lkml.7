Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A866BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15F7206DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YYw7JjL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404420AbfIFDNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 23:13:17 -0400
Received: from mail.efficios.com ([167.114.142.138]:40154 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391312AbfIFDNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 23:13:09 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 19AE432CD80;
        Thu,  5 Sep 2019 23:13:08 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Arz52DbPDMz9; Thu,  5 Sep 2019 23:13:07 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2230832CD6D;
        Thu,  5 Sep 2019 23:13:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2230832CD6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567739587;
        bh=FAbnlBYHkpKoL/bnDfXB8638h4RpnPFzbHOMT8XjsZY=;
        h=From:To:Date:Message-Id;
        b=YYw7JjL1JNVq88xDdDvjpimUT3M82hs6cIMQ4Pk1UXfW/tPA5YZjKSF5fNKH0Nca8
         O70R5YlxE/pOlH3MgwQBbCrlt1Cm/oIQns0oQZSgSPvpC0pb1FjCNTIskmh0l6dIjS
         dD8AzeuVcEiAT+vnuzFWjNoglRabzPbKYw91pkWQw0lLPDiugNIN5PtYL5MeCWTeZn
         of2uliOPs+cqbu/7/uiz5wzJX/pg/NDbtle9RgVJvNZyRK+O8fwSavuaqbV5b/4r46
         K8Ktua6kYcDb7iIA/kN7PLplWW8B2JhNvDxC+Vw5+Ypiz0GTaVOEBM6OsdtljvTSFf
         4dXS3VlGO6uIA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id XWhHZ1nQ4C5t; Thu,  5 Sep 2019 23:13:07 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id D548132CD60;
        Thu,  5 Sep 2019 23:13:06 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 1/4] Fix: sched/membarrier: private expedited registration check
Date:   Thu,  5 Sep 2019 23:12:57 -0400
Message-Id: <20190906031300.1647-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190906031300.1647-1-mathieu.desnoyers@efficios.com>
References: <20190906031300.1647-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a logic flaw in the way membarrier_register_private_expedited()
handles ready state checks for private expedited sync core and private
expedited registrations.

If a private expedited membarrier registration is first performed, and
then a private expedited sync_core registration is performed, the ready
state check will skip the second registration when it really should not.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
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
 kernel/sched/membarrier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index aa8d75804108..5110d91b1b0e 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -226,7 +226,7 @@ static int membarrier_register_private_expedited(int flags)
 	 * groups, which use the same mm. (CLONE_VM but not
 	 * CLONE_THREAD).
 	 */
-	if (atomic_read(&mm->membarrier_state) & state)
+	if ((atomic_read(&mm->membarrier_state) & state) == state)
 		return 0;
 	atomic_or(MEMBARRIER_STATE_PRIVATE_EXPEDITED, &mm->membarrier_state);
 	if (flags & MEMBARRIER_FLAG_SYNC_CORE)
-- 
2.17.1

