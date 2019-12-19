Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569C4C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FD4206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="S+1TVgtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfLSQWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:22:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44997 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSQWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:22:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id 195so2670914pfw.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 08:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XjhTktDNNIa4enH2Adg8E64+TNvvSeb3MU4xDD4N6y4=;
        b=S+1TVgtFUfcAkeVMZX15JSnrsSR+b4mHrDAJZPEW0YIuzlFcPMY/jQ6QIbrny4bqxR
         KV+6ieZWWcuNCefV0X0KZl5TJ85CuQsLOjJUe1RvKwLmj0JOXxDpE5V1wk7VsqFaJxAg
         EBaG9nxlhkZKlC6W9cAgW+V8qNBEd+61ZHu4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XjhTktDNNIa4enH2Adg8E64+TNvvSeb3MU4xDD4N6y4=;
        b=ZczIKWlj9hvKwuWmefCyBDaxYtaGzAwp6sLzHPPuoGbPt/6kBAl3PEbt7Wq+5XsOtG
         bHJMMAzMMsNCw+cNhk+ZSEP5zt4Bqe4MBdIJn1+hIYvRa5uOYBq8RYNvqsZWvsC733IK
         c2rPDv4hXN4IsfBKZpnOoWv/rQKa7d/GPxPfjTNGaAJ1NIBC7AUk6sWnufc+41PArT/N
         OF2FgrsbSc0HJ9LlrpQurz9n6Ojiepp4P0sl4mK9BsFCMuuZdnxJDmpBKn3xjMj3ppzb
         q8yG/F0GwsOJELIkRShPN1Lgx5I6ovKXnENQMR8npC9V2Xwn5PlIiAg4dELHhN9Ssq6Q
         fo3w==
X-Gm-Message-State: APjAAAVleGde/lZ9Du2M49vCWWp5HdqPn4IuVGCtpPKCDsda7k0A6cb0
        57VmQkjCMkP7Cn5npZ63JqRiJBRPLAw=
X-Google-Smtp-Source: APXvYqxHXwpOEGvBlevCbs/eVfPnI8BV0/eirURjLaUDm0uj6xZohikXALfWZdJ0pnLprPjRBCREvA==
X-Received: by 2002:aa7:90c9:: with SMTP id k9mr10699178pfk.53.1576772567094;
        Thu, 19 Dec 2019 08:22:47 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k21sm8033830pgt.22.2019.12.19.08.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 08:22:46 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        bristot@redhat.com, frextrite@gmail.com,
        madhuparnabhowmik04@gmail.com, urezki@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 rcu-dev] rcuperf: Measure memory footprint during kfree_rcu() test
Date:   Thu, 19 Dec 2019 11:22:42 -0500
Message-Id: <20191219162242.128282-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During changes to kfree_rcu() code, we often check how much is free
memory. Instead of doing so manually, add a measurement in the test
itself. We measure 4 times during the test for available memory and
compare with the beginning.

A sample run shows something like:

Total time taken by all kfree'ers: 6369738407 ns, loops: 10000, batches: 764, memory footprint: 216MB

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>


---
v1->v2 : Minor corrections

Cc: bristot@redhat.com
Cc: frextrite@gmail.com
Cc: madhuparnabhowmik04@gmail.com
Cc: urezki@gmail.com

 kernel/rcu/rcuperf.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index da94b89cd531..91f0650914cc 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/err.h>
@@ -611,6 +612,7 @@ kfree_perf_thread(void *arg)
 	long me = (long)arg;
 	struct kfree_obj *alloc_ptr;
 	u64 start_time, end_time;
+	long mem_begin, mem_during = 0;
 
 	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
@@ -626,6 +628,12 @@ kfree_perf_thread(void *arg)
 	}
 
 	do {
+		if (!mem_during) {
+			mem_during = mem_begin = si_mem_available();
+		} else if (loop % (kfree_loops / 4) == 0) {
+			mem_during = (mem_during + si_mem_available()) / 2;
+		}
+
 		for (i = 0; i < kfree_alloc_num; i++) {
 			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
 			if (!alloc_ptr)
@@ -645,9 +653,11 @@ kfree_perf_thread(void *arg)
 		else
 			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
 
-		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld\n",
+		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %ldMB\n",
 		       (unsigned long long)(end_time - start_time), kfree_loops,
-		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started));
+		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
+		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
+
 		if (shutdown) {
 			smp_mb(); /* Assign before wake. */
 			wake_up(&shutdown_wq);
-- 
2.24.1.735.g03f4e72817-goog
