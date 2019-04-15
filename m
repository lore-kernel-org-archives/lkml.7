Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCE1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EA02075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfDORFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:05:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36033 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfDORFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:05:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so8915501pfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 10:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqPF6cVkRaWxPUG61WHSdVmGRxrRtg3EbV3y1hjxGxY=;
        b=L6odk70cd+d/crDQqWpCdMIwXMYynjsRXxSjvuPHxR+uUSYS8l6iTzI4bkTyzKwoZs
         oo+0BuCnDqCjyZSvnC/Tpx/46v9KOTPNO2lqy5qcoOgiXJA+Oc2J92IaozLKCctqodqO
         wHHXTRbBrwddkhcCgt4zzN+micrhBkwrsZ6DHq5wtHpcQBKzKVl0kGQGUtlecHfaowZh
         j+uwvBBhiZa3+pxrSJL6V5cskZU3PbbKHk8XDkNBkFZOL4Ib+CF2d7qpcXBsuctiebcn
         ydGdKeWn88lwkd2j3VxAIPAVaD9LNIOwvuKu6tEkJdWqwmNzzjYZmyzdOLV4U2FbA/DK
         0CHQ==
X-Gm-Message-State: APjAAAUuhGc9gbhLMrdo+YRMIo+7dXbgafeNFJ1uzJgTyG3U23xnsPmT
        7DMVMlzX1ishv977HA1XtqwgB5A616U=
X-Google-Smtp-Source: APXvYqyiMPe7Joju60HTakSRAr8rfO81BjzaMzBkFcsoMFDxTo4SW02kpskOLDLn4N28rsa04QOr/A==
X-Received: by 2002:a63:360c:: with SMTP id d12mr67685333pga.404.1555347948914;
        Mon, 15 Apr 2019 10:05:48 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id j19sm61312568pfh.41.2019.04.15.10.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 10:05:47 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Will Deacon <will.deacon@arm.com>,
        Waiman Long <longman@redhat.com>, shenghui <shhuiw@foxmail.com>
Subject: [PATCH] locking/lockdep: Make lockdep_unregister_key() honor 'debug_locks' again
Date:   Mon, 15 Apr 2019 10:05:38 -0700
Message-Id: <20190415170538.23491-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If lockdep_register_key() and lockdep_unregister_key() are called with
debug_locks == false then the following warning is reported:

WARNING: CPU: 2 PID: 15145 at kernel/locking/lockdep.c:4920 lockdep_unregister_key+0x1ad/0x240

That warning is reported because lockdep_unregister_key() ignores the
value of 'debug_locks' and because the behavior of lockdep_register_key()
depends on whether or not 'debug_locks' is set. Fix this inconsistency
by making lockdep_unregister_key() take 'debug_locks' again into
account.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Waiman Long <longman@redhat.com>
Cc: shenghui <shhuiw@foxmail.com>
Fixes: 90c1cba2b3b3 ("locking/lockdep: Zap lock classes even with lock debugging disabled")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e16766ff184b..e221be724fe8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4907,8 +4907,9 @@ void lockdep_unregister_key(struct lock_class_key *key)
 		return;
 
 	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion = 1;
+	if (!graph_lock())
+		goto out_irq;
+
 	pf = get_pending_free();
 	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
 		if (k == key) {
@@ -4920,8 +4921,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	WARN_ON_ONCE(!found);
 	__lockdep_free_key_range(pf, key, 1);
 	call_rcu_zapped(pf);
-	current->lockdep_recursion = 0;
-	arch_spin_unlock(&lockdep_lock);
+	graph_unlock();
+out_irq:
 	raw_local_irq_restore(flags);
 
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
-- 
2.21.0.196.g041f5ea1cf98

