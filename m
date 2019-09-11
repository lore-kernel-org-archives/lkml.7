Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94779C5AE5C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 00:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B11521D79
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 00:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JleHZLOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfIKA14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 20:27:56 -0400
Received: from mail.efficios.com ([167.114.142.138]:60000 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfIKA1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 20:27:54 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 88A1CBD669;
        Tue, 10 Sep 2019 20:27:53 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Bb5JDBfMkZDU; Tue, 10 Sep 2019 20:27:53 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 22552BD657;
        Tue, 10 Sep 2019 20:27:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 22552BD657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568161673;
        bh=0AOj4Cqa3vF0hisHUzfMACALABVREE/Ti6Xyn871J5Y=;
        h=From:To:Date:Message-Id;
        b=JleHZLOLjmjgCbv9ZMeWei0sLrRREKFLXnBv1oDJZ86C9UKaqzsEGWflkhDt5C+eW
         Rul0CS46AUHMIULF3FQBsa2pAQAf5gxuUggvSAHYEt4gvnC1BcNCvRzgx6JdbGUW+m
         yZKntrk3BjmTbfXZrKJizY0MigEY15AODL+c3bOYssPm8fOmm1GO7x1AF3JNFAhnMG
         LyyalBnKggyHuEilh+v5HEdsMip2HzKWWVczt55kb/e8F8rjQ9B1Pri8khD6jLnJcX
         wUr5gfXcvsr6xkMYur1r1WUXdL9F02okTnEYybDcdrLO+v4xi2GblUsnE+OMhT0xYs
         MumTSKMp0ZClQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id imSYtPCCEs3O; Tue, 10 Sep 2019 20:27:53 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 56310BD642;
        Tue, 10 Sep 2019 20:27:52 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [RFC PATCH 4/4] rseq/selftests: Use RSEQ_FLAG_UNREG_CLONE_FLAGS
Date:   Tue, 10 Sep 2019 20:27:44 -0400
Message-Id: <20190911002744.8690-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190911002744.8690-1-mathieu.desnoyers@efficios.com>
References: <20190911002744.8690-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new RSEQ_FLAG_UNREG_CLONE_FLAGS rseq flag in the rseq selftests.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Paul Turner <pjt@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 tools/testing/selftests/rseq/rseq.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 7159eb777fd3..d5268570014c 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -68,9 +68,10 @@ static void signal_restore(sigset_t oldset)
 }
 
 static int sys_rseq(volatile struct rseq *rseq_abi, uint32_t rseq_len,
-		    int flags, uint32_t sig)
+		    int flags, uint32_t sig, int unreg_clone_flags)
 {
-	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
+	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig,
+		       unreg_clone_flags);
 }
 
 int rseq_register_current_thread(void)
@@ -87,7 +88,9 @@ int rseq_register_current_thread(void)
 	}
 	if (__rseq_refcount++)
 		goto end;
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq), 0, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq),
+		      RSEQ_FLAG_UNREG_CLONE_FLAGS, RSEQ_SIG,
+		      CLONE_SETTLS);
 	if (!rc) {
 		assert(rseq_current_cpu_raw() >= 0);
 		goto end;
@@ -116,7 +119,7 @@ int rseq_unregister_current_thread(void)
 	if (--__rseq_refcount)
 		goto end;
 	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq),
-		      RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
+		      RSEQ_FLAG_UNREGISTER, RSEQ_SIG, 0);
 	if (!rc)
 		goto end;
 	__rseq_refcount = 1;
-- 
2.17.1

