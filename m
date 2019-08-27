Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C2BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1792D21881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Ci9p+TaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbfH0TCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:02:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40612 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730989AbfH0TCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:02:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so13183472pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 12:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=message-id:from:to:cc:subject:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kV5KXYVJdyv65Hnx+nvfjLRXv6tCDCLMRGD0rrK31I=;
        b=Ci9p+TaNeqJRpdKmgjycDdZ1qGXv1XZJh049m7fUK6vIeeZsUv9/O/uy0CCsXAu7Sd
         P5jbOxozxX45q2CJYfbeMhDBp6qxOp9Y1bkpQvUUbYaPjeQGViihVHZ6CHfeUmp9ZXdj
         s76MwmIqSPfhAtIglSJK8Oq92XskicAPyN+1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kV5KXYVJdyv65Hnx+nvfjLRXv6tCDCLMRGD0rrK31I=;
        b=QqipbZ8wjwU3BJyhN9GBdjUrJp2K67x9fwyMMPdb8DmfJyE/Oknwl5BbJP2E9jBRDK
         QgGc5CtglNBs+orjHCg3BRriuIDU/m7Aim631o/rsFAnco8t6tnwOi9oKKFYvvMuONuq
         8gGjkSnNAP/C44yc5GuULnssPC5jkxHNiVsC6S77VpB5ZoBPz2GGAJZKFHLaiZdS7LyB
         6SKDi+644lYMdJuEwVXdU0L4USW7OFQCoavsnXBKTH5Ezus3bxgL8VXboV05nsIUBSJa
         MMVTw+JKWP6/7mdfDn+R02avCbWSX6TXZzUDF/sAoyV/Gmhcmc87aet9LyUfqMM2C9Oy
         r1pA==
X-Gm-Message-State: APjAAAXm2nu9UoZvYQmPpLvNpuW3MiP3DoXqgUbGyWZxtGHOFn254e6t
        Gxh4abniYj+EQSVZli+q1phaMghCqsM=
X-Google-Smtp-Source: APXvYqwEDpu+LRH81GOKlAAgs8mPTOzvlBj1YFIBm2lbfeOMjXcJ7fuw83pZGhoFWp6qscf1k3vrxw==
X-Received: by 2002:a17:90a:ff04:: with SMTP id ce4mr183366pjb.77.1566932535866;
        Tue, 27 Aug 2019 12:02:15 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k14sm33196pfi.98.2019.08.27.12.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 12:02:15 -0700 (PDT)
Message-ID: <5d657e37.1c69fb81.54250.01df@mx.google.com>
X-Google-Original-Message-ID: 1566932472104184@cam.corp.google.com
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        byungchul.park@lge.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, kernel-team@android.com
Subject: [PATCH 3/5] rcu/tree: Add support for debug_objects debugging for kfree_rcu()
Date:   Tue, 27 Aug 2019 15:01:57 -0400
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: 156693247224727@cam.corp.google.com
References: 156693247224727@cam.corp.google.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of RCU's debug_objects debugging support
(CONFIG_DEBUG_OBJECTS_RCU_HEAD) similar to call_rcu() and other flavors.
We queue the object during the kfree_rcu() call and dequeue it during
reclaim.

Tested that enabling CONFIG_DEBUG_OBJECTS_RCU_HEAD successfully detects
double kfree_rcu() calls.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9b9ae4db1c2d..64568f12641d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2757,6 +2757,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	for (; head; head = next) {
 		next = head->next;
 		/* Could be possible to optimize with kfree_bulk in future */
+		debug_rcu_head_unqueue(head);
 		__rcu_reclaim(rcu_state.name, head);
 		cond_resched_tasks_rcu_qs();
 	}
@@ -2868,6 +2869,13 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
 		return kfree_call_rcu_nobatch(head, func);
 
+	if (debug_rcu_head_queue(head)) {
+		/* Probable double kfree_rcu() */
+		WARN_ONCE(1, "kfree_call_rcu(): Double-freed call. rcu_head %p\n",
+			  head);
+		return;
+	}
+
 	head->func = func;
 
 	local_irq_save(flags);	/* For safely calling this_cpu_ptr(). */
-- 
2.23.0.187.g17f5b7556c-goog

