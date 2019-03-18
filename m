Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52081C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAD320857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quzza9Np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfCRI6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:58:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35300 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfCRI6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:58:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so261686pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8o6gy3jUrTIKg4DHxyQ/Y6z8fUbsl5WG4SDEUCkkek4=;
        b=quzza9Np9FTKQ8nXkeunTVXm7hA9pVQ/zXUnjaecnR/YjBlkoxJgir8oRrtVk5zjt7
         FuTDrPeCng9AInAiNbaGM5UDTT34gqXgPWNlI/Tv9NswaAksCclf7wUwB594iBPprbxc
         kMNJ0M+V5IlIK4uTbMVD3s4SdoqYujh3cT0OVTYCgzKAry+FX8AMOP/RIKkyTX6iIfvl
         Z7qjTJJs4JL75UI/8I0kxcS5/h7SW7tCATDLSx2Q62G0C2z8nK2EZDitnq1yk9sLaGGx
         nq11Ksq62QBjRTjvmZ3lqfjcKVboKpnY1TEHNmKhcX5TM4Y4lN0HelatxMe3hMqSNatQ
         s2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8o6gy3jUrTIKg4DHxyQ/Y6z8fUbsl5WG4SDEUCkkek4=;
        b=awSSNukImGytdXJTyzbFW7o2hWWfEkUeLq3J/zqVbB7jhaNScU7Knktqy/2pszTluS
         qwrJlIGazuvvWX+/fBzdTUaf9swuZWDM0gPy4Qbk9oV2B2o9OXsgzcHg+Rc70ulN22Yp
         3xzrJnfj1BksRAh8FKg0zyTMWVxJIqSaP4Dp0miGYyKjw56tqQOyYTcrx7KBiYWJjU6t
         QqmTcJiM0GJ+eq9jjIeoj6eCcX9lhG3RqZate+7mAetivL7ZVpBDMyO/0IpIj0g3xNVA
         yts42OIEnUJLHywseQlaNWao+BSal6427FdtzTSXHKmL45Cp6NCX8obzOf2KPU3/R8KV
         CF0Q==
X-Gm-Message-State: APjAAAX6MBbhPODdL23H8wfnp9dUPDqXT8dMhlIbhRxCoZiis9Awgsha
        dVuoXdAE5+WaTDzxCf/FOXHlpSpIVMQFaw==
X-Google-Smtp-Source: APXvYqxMl+hu95A+n+LCU5a3RQk4/sUKg4Mg9bZZAYKxYKIKBrowhwE/daHCwegPCxK1GxlfCbKjhA==
X-Received: by 2002:a17:902:2aca:: with SMTP id j68mr18170911plb.233.1552899513631;
        Mon, 18 Mar 2019 01:58:33 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:58:33 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 18/19] locking/lockdep: Update comments on dependency search
Date:   Mon, 18 Mar 2019 16:57:32 +0800
Message-Id: <20190318085733.3143-19-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The breadth-first search is implemented as flat-out non-recursive now, but
the comments are still describing it as recursive, update the comments in
that regard.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 90d58cc..1d38bf6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1384,6 +1384,10 @@ static inline struct list_head *get_backward_dep(struct lock_list * lock)
 	return &lock->class->locks_before;
 }
 
+/*
+ * Forward- or backward-dependency search, used for both circular dependency
+ * checking and hardirq-unsafe/softirq-unsafe checking.
+ */
 static int __bfs(struct lock_list *source_entry,
 		 void *data,
 		 int (*match)(struct lock_list *entry, void *data),
@@ -1461,12 +1465,6 @@ static inline int __bfs_backwards(struct lock_list *src_entry, void *data,
 }
 
 /*
- * Recursive, forwards-direction lock-dependency checking, used for
- * both noncyclic checking and for hardirq-unsafe/softirq-unsafe
- * checking.
- */
-
-/*
  * Print a dependency chain entry (this is only done when a deadlock
  * has been detected):
  */
@@ -2166,7 +2164,7 @@ static void print_deadlock_scenario(struct held_lock *nxt,
 
 /*
  * There was a chain-cache miss, and we are about to add a new dependency
- * to a previous lock. We recursively validate the following rules:
+ * to a previous lock. We validate the following rules:
  *
  *  - would the adding of the <prev> -> <next> dependency create a
  *    circular dependency in the graph? [== circular deadlock]
@@ -2216,11 +2214,12 @@ static void print_deadlock_scenario(struct held_lock *nxt,
 	/*
 	 * Prove that the new <prev> -> <next> dependency would not
 	 * create a circular dependency in the graph. (We do this by
-	 * forward-recursing into the graph starting at <next>, and
-	 * checking whether we can reach <prev>.)
+	 * a breadth-first search into the graph starting at <next>,
+	 * which checks whether we can reach <prev>.)
 	 *
-	 * We are using global variables to control the recursion, to
-	 * keep the stackframe size of the recursive functions low:
+	 * The search is limited by the size of the circular queue (i.e.,
+	 * MAX_CIRCULAR_QUEUE_SIZE) which keeps track of a breadth of nodes
+	 * in the graph whose neighbours are to be checked.
 	 */
 	this.class = hlock_class(next);
 	this.parent = NULL;
-- 
1.8.3.1

