Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9407CC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF782070D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDKR0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:26:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41288 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKR0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:26:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id d1so3734473plj.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QjhRMAZduxqRZQUhNunQHswzR+zZYZkcqsD6e+FeoCo=;
        b=Un0Vle+B1yrX1fGfEahqQY/uGjcxfP5K0OJM7+C0Utek/PBqL9wk4mRnMO2N5OTuHZ
         n35v4wvZRWw9xGhqMbTurIzVzRm73ZysF6kqjzcKgZKMPsSj38ShQgQ+zGMAinV0RD5+
         Em2RjbmofxR8RqefbaceBvnEneqTQ3MQt5LbR7DTa4d708dZFCUj1juOV0A2fTgJE2VF
         Pxj1iVaAz3Zon4YCnqJiSjPeOFypW32x8uQBINIfJx43Lp9Tl5/2EfGILxnRFjmXvVmB
         9L8pEn3/MZ5A4U1h0L/yeUiQk+3wYntg091jmXYbQYmBL7SuaP3XMPH99Ziwd5m1TiwU
         tVqQ==
X-Gm-Message-State: APjAAAXwR6XyWwHaf7Mw0DoqOrRuTvOCf6eaj4qPnCpAg0ttumDX3eVA
        DXgUELirS/TrUXijH5IHuIM=
X-Google-Smtp-Source: APXvYqwthOG62mcn+zo0o+IuWOREa+oj1maNy0Arf0ZHgRdIQi4vwDdlUwpRYuz2IfaZOvSxD8Q4Qw==
X-Received: by 2002:a17:902:d24:: with SMTP id 33mr52776107plu.246.1555003579508;
        Thu, 11 Apr 2019 10:26:19 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s15sm45109443pga.71.2019.04.11.10.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 10:26:18 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Will Deacon <will.deacon@arm.com>,
        Waiman Long <longman@redhat.com>, shenghui <shhuiw@foxmail.com>
Subject: [PATCH] locking/lockdep: Make lockdep_register_key() ignore 'debug_locks'
Date:   Thu, 11 Apr 2019 10:26:12 -0700
Message-Id: <20190411172612.39180-1-bvanassche@acm.org>
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
by making lockdep_register_key() unconditionally register lock keys.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Waiman Long <longman@redhat.com>
Cc: shenghui <shhuiw@foxmail.com>
Reported-by: shenghui <shhuiw@foxmail.com>
Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use") # v5.1-rc1.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d2d65bbfae01..a228509b62f1 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1027,15 +1027,16 @@ void lockdep_register_key(struct lock_class_key *key)
 	hash_head = keyhashentry(key);
 
 	raw_local_irq_save(flags);
-	if (!graph_lock())
-		goto restore_irqs;
+	arch_spin_lock(&lockdep_lock);
+	current->lockdep_recursion = 1;
 	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
 		if (WARN_ON_ONCE(k == key))
 			goto out_unlock;
 	}
 	hlist_add_head_rcu(&key->hash_entry, hash_head);
 out_unlock:
-	graph_unlock();
+	current->lockdep_recursion = 0;
+	arch_spin_unlock(&lockdep_lock);
 restore_irqs:
 	raw_local_irq_restore(flags);
 }
-- 
2.21.0.196.g041f5ea1cf98

