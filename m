Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEDAC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2A92342C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vM1+9Vta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfH3Qgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:36:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41425 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfH3Qgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:36:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so3797836pgg.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6foCHXYvGc/YUv+C7UREe6hicJoeLXUOk4RCFm7CD8U=;
        b=vM1+9Vtan3m+Dx2GCYwwzu54AD6Ybxe5HZPpHkb++iFYXQsxAreaQngONIGaas9fk1
         5g9UAXvBQVgfBQ7pRjr9WCno1ofr7z//vfjfwwOkZDjFAZvmj8fAqRfBQnTlsP+K8aMC
         3F/M8QRJg8K94LQ5q8rYJgSWuAclLWgkdXCFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6foCHXYvGc/YUv+C7UREe6hicJoeLXUOk4RCFm7CD8U=;
        b=UO/9z8KI9s9RpYcaAP1k7Ef1cfzF6Fh+HcRwH72kpRdW4lJ83tUDLqu31wAiY9irkB
         Z5sUIk8xveiX+5lHcRHdBPhdkZ9In1uaWPRJcTnKixFNgE/elrqLS67HkwLczzk+qcXB
         IEFRcgAwa+jO3h5FSTmk+hw/MoCWAHkoobutAIDAE3h51T7X5WKSReDwcjLN2KEDl6oi
         Bdz2B8SJuoRZ7Yg0fXusEUBBCs+iCSlm8Hsu9A7sX71c0nrstfP2jH2kJSlul3graxgq
         uyqiinNlMGZkXgXrFHvszt//aQEb+2TDN+zrGJPkcdT0JjN4wUuNJsGiwPnJpweb6Nxu
         xnDQ==
X-Gm-Message-State: APjAAAVFOzQiH7q5iGGvW7Se6SQNFOnUxpktENMPHZR0lplSGu9068Fw
        ynrgZ+r1j9/c4KWRgRQ9Ut7P1XiVBLc=
X-Google-Smtp-Source: APXvYqyfyCzAysxf821xWN8fbyp1VftaNHPBq9mcl3pQd/MSyGep+IAVXGQIOsVMqA5koDPpakOFog==
X-Received: by 2002:a63:e907:: with SMTP id i7mr13492018pgh.84.1567183008166;
        Fri, 30 Aug 2019 09:36:48 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j74sm6114080pje.14.2019.08.30.09.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 09:36:47 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        byungchul.park@lge.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 -rcu dev 3/5] rcu/tree: Add support for debug_objects debugging for kfree_rcu()
Date:   Fri, 30 Aug 2019 12:36:31 -0400
Message-Id: <20190830163633.104099-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190830163633.104099-1-joel@joelfernandes.org>
References: <20190830163633.104099-1-joel@joelfernandes.org>
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
index 2e1772469de9..de13805d1bd0 100644
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
@@ -2876,6 +2877,13 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
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

