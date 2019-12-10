Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BA6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89EB2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575951622;
	bh=nQF9quNxVBcU3S+fZmNYk/8oN/cX4almQAM+hd3939M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=crGaLGJEXwO4S0zaHFhZcoqqIFm6g1xbjmWHOrqaR5l9YwW2qVq9olr0NYbJBBi4q
	 8/AEoviYgoVW6x8298IUrtRY6ch7zEueDY55aQX+1N6W0W+0CJj0uss5M+LAE+CgvU
	 NdQTT9Bd4ZNg9qijFGNGaQsh5bx/D+pVptJMLmxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLJEUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:20:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfLJEUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:20:10 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3E1D24655;
        Tue, 10 Dec 2019 04:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951610;
        bh=nQF9quNxVBcU3S+fZmNYk/8oN/cX4almQAM+hd3939M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2KoB5DATs4TWXLbAF7Be8U337q/mpUUW117KerEC+fnKHdtnj3lgE9p3IomftW5Zs
         1vMYCpwiDDrQsvdwEi63LZrjyLIP6bwM1CiQSlAr2WXzGO6cmPI1W52bnBS95CCutE
         QbqOufofId9PUW2/bJKxtHJ07ojefpo+n/mSpoiQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 9/9] rculist.h: Add list_tail_rcu()
Date:   Mon,  9 Dec 2019 20:20:02 -0800
Message-Id: <20191210042002.3490-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210041938.GA3367@paulmck-ThinkPad-P72>
References: <20191210041938.GA3367@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch adds the macro list_tail_rcu() and documents it.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
[ paulmck: Reword a bit. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 4b7ae1b..9f313e4 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -40,6 +40,16 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
  */
 #define list_next_rcu(list)	(*((struct list_head __rcu **)(&(list)->next)))
 
+/**
+ * list_tail_rcu - returns the prev pointer of the head of the list
+ * @head: the head of the list
+ *
+ * Note: This should only be used with the list header, and even then
+ * only if list_del() and similar primitives are not also used on the
+ * list header.
+ */
+#define list_tail_rcu(head)	(*((struct list_head __rcu **)(&(head)->prev)))
+
 /*
  * Check during list traversal that we are within an RCU reader
  */
-- 
2.9.5

