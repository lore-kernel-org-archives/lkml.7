Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C4EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D17B2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="JQJBKIRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLSQM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:12:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41733 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSQMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:12:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so3352444pgk.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 08:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bx8Jb0WaQCTtu/dzL5GBmb8jnnDesSBUSvEFPOM12Yc=;
        b=JQJBKIRVGtI4VwCCP3hyatO9EmbXSVs/aw6TLzZIdjHxwAHAFsxHTmhBoSd0+E4JuL
         j4avCkTjYoOlG87Cns9LFhyu+xGoaYInHiXcCbWrbnsXqvQcUnMDQ2YeZAmlWlAUb84k
         sOVhQJlbtXk5vQtRC6N3Bd2Gdi39AvyiTzS9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bx8Jb0WaQCTtu/dzL5GBmb8jnnDesSBUSvEFPOM12Yc=;
        b=Z1+GIksnhyZIJSetqEltrKhBNgY+xo8pgjgeNlMiD9R2udD2azIhkSC6M8nWHIisrG
         /kxpmbyxSbsoevD1ncexstzrOmrKmUljDT9XC4JZLONbofVPWMvHdTqsK+CVz61t/Nqv
         cpyO66lwq5lN4PLJwRHrqNPjU8ff0Wz0OBUT4iSKaPOVKZo8uzHFpJmkSpBi3/hHwgAM
         BeuWGAPney3QML7j2MbvsmtNkpKRZV560Cuo9nPXil9QAnldbvKrOhkFQjDHSli+txZI
         dDKkyDlz95YtQ4nWFpIpMEtS1zuK5Ggj0NvH+u8nh/caBll/IWd8CZnXF0oRvtIOoJ4C
         muGg==
X-Gm-Message-State: APjAAAXSvAERnjIrOabW5PjoWjye6SpZROl4qC1qTV9qg3S+2KY+0bH7
        vX58XqusRph7AJVykgWqJGOhnydZMqk=
X-Google-Smtp-Source: APXvYqw66nmbW+O3AVs6mvJmDJp+F1dljrELDidgKaMGsS8zDDjKSglw8t0bZYNqEUzI65h7lWpNwA==
X-Received: by 2002:a63:6507:: with SMTP id z7mr10081594pgb.322.1576771974899;
        Thu, 19 Dec 2019 08:12:54 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a13sm8813570pfc.40.2019.12.19.08.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 08:12:54 -0800 (PST)
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
Subject: [PATCH rcu-dev] rcuperf: Measure memory footprint during kfree_rcu() test
Date:   Thu, 19 Dec 2019 11:12:48 -0500
Message-Id: <20191219161248.109734-1-joel@joelfernandes.org>
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

Total time taken by all kfree'ers: 6369738407 ns, loops: 10000, batches: 764 memory footprint:216MB

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>


---
Cc: bristot@redhat.com
Cc: frextrite@gmail.com
Cc: madhuparnabhowmik04@gmail.com
Cc: urezki@gmail.com

 kernel/rcu/rcuperf.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index da94b89cd531..bf8e9d9b532c 100644
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
@@ -611,12 +612,14 @@ kfree_perf_thread(void *arg)
 	long me = (long)arg;
 	struct kfree_obj *alloc_ptr;
 	u64 start_time, end_time;
+	long mem_begin, mem_during = 0;
 
 	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
 
 	start_time = ktime_get_mono_fast_ns();
+	mem_begin = si_mem_available();
 
 	if (atomic_inc_return(&n_kfree_perf_thread_started) >= kfree_nrealthreads) {
 		if (gp_exp)
@@ -626,7 +629,14 @@ kfree_perf_thread(void *arg)
 	}
 
 	do {
+		if (!mem_during) {
+			mem_during = mem_begin = si_mem_available();
+		} else if (loop % (kfree_loops / 4) == 0) {
+			mem_during = (mem_during + si_mem_available()) / 2;
+		}
+
 		for (i = 0; i < kfree_alloc_num; i++) {
+
 			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
 			if (!alloc_ptr)
 				return -ENOMEM;
@@ -645,9 +655,11 @@ kfree_perf_thread(void *arg)
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
