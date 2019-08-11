Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927BCC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 22:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660DC2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 22:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RNMJIQZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfHKWLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 18:11:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41762 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfHKWLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 18:11:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so38158864pgg.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 15:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jg1q7sKCNt8sI7DQNayH9inWmrGqOZwwN13K5ONIY4Q=;
        b=RNMJIQZoGD+AKdhoRPPti5I51AMHvV5mYDXKAJvWLLTIXhov2hAB/mlubzCGJZZvqN
         jdFGMPAG0ui/vmgBiTmzrK1TSmtU4Ff8BsjO/AOMv/ogYfOTU7XEwv4oYwpoynaUuXlz
         FB+/0/PFQfK8A6SidEG+2RrPrN0tWz6fx7rwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jg1q7sKCNt8sI7DQNayH9inWmrGqOZwwN13K5ONIY4Q=;
        b=SBOpQCZdBRjISY5OI4aNrm5QO4bOpwb9eTveq957LfpiTSRPgrjS1Jzk3UwtRgzbnn
         bkLuTFnH4DiHlOSRGnKzL8d04zB+Ab6PWbRtLVRrwIsxBFrUDt4tQltFr9FEqHdcsod3
         LmHUorZrScq1AglZ7+ub1Hr8MvZgxlR+oGyDCqQy4PjQbiSQ9ampjLF6ShNofLS+cfX/
         gIUMQQNPCVaYBK+koKPE5pzhojQZmH6qz49cFxJYl9P/vyH8A8Hd8VQjXWNODTyI3Bm9
         c06EP6dJcAMMhb6Eabg9nsq2vfNzXmCmLmBM6p9SLox2vAdumv1+bK1/fxd0symLjXRl
         czhw==
X-Gm-Message-State: APjAAAUk7wjgjSpjvhGBx6zipxZKolV33tVRMDiYVyTUYUejBH+S+eCX
        TEZ8BIHq4w1Dx5cjV73bi0uBKq7t9E0=
X-Google-Smtp-Source: APXvYqwV0Q84Ts/sU/Wiyc5e58Q2BXvfPrlpDhgpdlrMav0oBqexshnN2vV/yXZRyBgkrd69z686NQ==
X-Received: by 2002:a62:e901:: with SMTP id j1mr33444864pfh.189.1565561489050;
        Sun, 11 Aug 2019 15:11:29 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n10sm31376428pgv.67.2019.08.11.15.11.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 15:11:27 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/3] workqueue: Convert for_each_wq to use built-in list check (v2)
Date:   Sun, 11 Aug 2019 18:11:09 -0400
Message-Id: <20190811221111.99401-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

list_for_each_entry_rcu now has support to check for RCU reader sections
as well as lock. Just use the support in it, instead of explicitly
checking in the caller.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/workqueue.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 601d61150b65..e882477ebf6e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -364,11 +364,6 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 			 !lockdep_is_held(&wq_pool_mutex),		\
 			 "RCU or wq_pool_mutex should be held")
 
-#define assert_rcu_or_wq_mutex(wq)					\
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
-			 !lockdep_is_held(&wq->mutex),			\
-			 "RCU or wq->mutex should be held")
-
 #define assert_rcu_or_wq_mutex_or_pool_mutex(wq)			\
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
 			 !lockdep_is_held(&wq->mutex) &&		\
@@ -425,9 +420,8 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
  * ignored.
  */
 #define for_each_pwq(pwq, wq)						\
-	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node)		\
-		if (({ assert_rcu_or_wq_mutex(wq); false; })) { }	\
-		else
+	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,		\
+				 lock_is_held(&(wq->mutex).dep_map))
 
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

