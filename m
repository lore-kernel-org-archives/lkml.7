Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12635C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3A92196E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kGvu0mhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404073AbfISRif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:38:35 -0400
Received: from mail.efficios.com ([167.114.142.138]:33688 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390958AbfISRic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:38:32 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id EEFE2331894;
        Thu, 19 Sep 2019 13:38:31 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id qt4asNQH3WMj; Thu, 19 Sep 2019 13:38:31 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 99047331878;
        Thu, 19 Sep 2019 13:38:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 99047331878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568914711;
        bh=2A9/n7ArrLAzW9IAuwPyXacDtSg9pVuTezAJwqTSuNo=;
        h=From:To:Date:Message-Id;
        b=kGvu0mhB9bJ5chhInqeNSiDEy75GJcsYEvFZpuny32AY7Nyu+UCtnD0100GYwq95U
         quddf5r/bys7spWer4zncQKnr0Zloi1E/iwjgyhYRaNhGiotE9khLpTDjX62Rishm6
         N03T+LcilSltNpYFEoCN0sby6/mNsCOsxwChZMZY1miQ1krbc335DlMfFtwID9Lg+3
         3K+p11uYOYH3knbtN9SgB9+jO3C5dqcorfggsFk8148mGZZmMKQUboSa8e3kg/TMba
         y4984qN/1XY2VB0m2ymOsdDu443AhmoDQkf63aMnNn1hOt5kNhExfe6KgZKUSR0Xd9
         TmLLuIS9d3tfw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id q01PWsEaycNw; Thu, 19 Sep 2019 13:38:31 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 03EF2331860;
        Thu, 19 Sep 2019 13:38:31 -0400 (EDT)
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
Subject: [RFC PATCH for 5.4 3/7] Cleanup: sched/membarrier: Only sync_core before usermode for same mm
Date:   Thu, 19 Sep 2019 13:37:01 -0400
Message-Id: <20190919173705.2181-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919173705.2181-1-mathieu.desnoyers@efficios.com>
References: <20190919173705.2181-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the prev and next task's mm change, switch_mm() provides the core
serializing guarantees before returning to usermode. The only case
where an explicit core serialization is needed is when the scheduler
keeps the same mm for prev and next.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
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
 include/linux/sched/mm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 4a7944078cc3..8557ec664213 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -362,6 +362,8 @@ enum {
 
 static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
 {
+	if (current->mm != mm)
+		return;
 	if (likely(!(atomic_read(&mm->membarrier_state) &
 		     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE)))
 		return;
-- 
2.17.1

