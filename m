Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6B2C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7353920B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="I/G32rLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbfHFLVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:21:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54477 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfHFLVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:21:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x76BKv4U2142329
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 6 Aug 2019 04:20:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x76BKv4U2142329
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565090457;
        bh=5DHQQMlrThLSLa0IhoZQIL07mGa5rz1rbnFabqRBjzI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=I/G32rLqqZXy4W/Ta7Rf08hvGnLActTBwcv5IPNYsr/pLPE/4GZHlnBOhs2S/zFqs
         5TZAzf0Se6Zjav6pwgLazeGSznSZs6bZeYu+WA74MKn2IbSdZzXi8L1XwSXqsXtrgv
         B5xbev7kbDFE3kjPYAcAaDrh2V6wrQVNItDICKMefbw9DLzITXVOyw20MJnGScUFfQ
         d1vKachGnkUTnFnQwZ7Nlj/ybQHzaNWKBBdGhQJqQjeIMns2XYGZtk/QgYeXrKciCN
         TvLpcCfLiu8q2zKP8d1189XHeK50yVIC8//jWw95Xr4Df9h+3zZ/wS8wIPEqclCv56
         E84mcGutQpUZw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x76BKu7n2142326;
        Tue, 6 Aug 2019 04:20:56 -0700
Date:   Tue, 6 Aug 2019 04:20:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Suren Baghdasaryan <tipbot@zytor.com>
Message-ID: <tip-04e048cf09d7b5fc995817cdc5ae1acd4482429c@git.kernel.org>
Cc:     hpa@zytor.com, nnk@google.com, surenb@google.com,
        peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, surenb@google.com, nnk@google.com,
          hpa@zytor.com
In-Reply-To: <20190730013310.162367-1-surenb@google.com>
References: <20190730013310.162367-1-surenb@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/psi: Do not require setsched permission
 from the trigger creator
Git-Commit-ID: 04e048cf09d7b5fc995817cdc5ae1acd4482429c
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

Commit-ID:  04e048cf09d7b5fc995817cdc5ae1acd4482429c
Gitweb:     https://git.kernel.org/tip/04e048cf09d7b5fc995817cdc5ae1acd4482429c
Author:     Suren Baghdasaryan <surenb@google.com>
AuthorDate: Mon, 29 Jul 2019 18:33:10 -0700
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 6 Aug 2019 12:49:18 +0200

sched/psi: Do not require setsched permission from the trigger creator

When a process creates a new trigger by writing into /proc/pressure/*
files, permissions to write such a file should be used to determine whether
the process is allowed to do so or not. Current implementation would also
require such a process to have setsched capability. Setting of psi trigger
thread's scheduling policy is an implementation detail and should not be
exposed to the user level. Remove the permission check by using _nocheck
version of the function.

Suggested-by: Nick Kralevich <nnk@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: lizefan@huawei.com
Cc: mingo@redhat.com
Cc: akpm@linux-foundation.org
Cc: kernel-team@android.com
Cc: dennisszhou@gmail.com
Cc: dennis@kernel.org
Cc: hannes@cmpxchg.org
Cc: axboe@kernel.dk
Link: https://lkml.kernel.org/r/20190730013310.162367-1-surenb@google.com
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7fe2c5fd26b5..23fbbcc414d5 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1061,7 +1061,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 			mutex_unlock(&group->trigger_lock);
 			return ERR_CAST(kworker);
 		}
-		sched_setscheduler(kworker->task, SCHED_FIFO, &param);
+		sched_setscheduler_nocheck(kworker->task, SCHED_FIFO, &param);
 		kthread_init_delayed_work(&group->poll_work,
 				psi_poll_work);
 		rcu_assign_pointer(group->poll_kworker, kworker);
