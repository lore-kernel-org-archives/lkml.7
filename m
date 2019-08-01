Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A759C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8052084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389960AbfHAWnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:43:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732753AbfHAWni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:43:38 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MfdNw109318;
        Thu, 1 Aug 2019 18:43:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u486f1qx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:43:00 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71MftMs110195;
        Thu, 1 Aug 2019 18:43:00 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u486f1qwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:42:59 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MeuVm030283;
        Thu, 1 Aug 2019 22:42:59 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 2u0e85w6sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:42:59 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MgwoG11797102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:42:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8EDFB2079;
        Thu,  1 Aug 2019 22:42:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A33B2B2070;
        Thu,  1 Aug 2019 22:42:58 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:42:58 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0878716C9A36; Thu,  1 Aug 2019 15:43:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 1/8] treewide: Rename rcu_dereference_raw_notrace() to _check()
Date:   Thu,  1 Aug 2019 15:42:51 -0700
Message-Id: <20190801224258.16679-1-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801224240.GA16092@linux.ibm.com>
References: <20190801224240.GA16092@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The rcu_dereference_raw_notrace() API name is confusing.  It is equivalent
to rcu_dereference_raw() except that it also does sparse pointer checking.

There are only a few users of rcu_dereference_raw_notrace(). This patches
renames all of them to be rcu_dereference_raw_check() with the "_check()"
indicating sparse checking.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Fix checkpatch warnings about parentheses. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/RCU/Design/Requirements/Requirements.html | 2 +-
 arch/powerpc/include/asm/kvm_book3s_64.h                | 2 +-
 include/linux/rculist.h                                 | 6 +++---
 include/linux/rcupdate.h                                | 2 +-
 kernel/trace/ftrace_internal.h                          | 8 ++++----
 kernel/trace/trace.c                                    | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index 5a9238a2883c..bdbc84f1b949 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -2512,7 +2512,7 @@ disabled across the entire RCU read-side critical section.
 <p>
 It is possible to use tracing on RCU code, but tracing itself
 uses RCU.
-For this reason, <tt>rcu_dereference_raw_notrace()</tt>
+For this reason, <tt>rcu_dereference_raw_check()</tt>
 is provided for use by tracing, which avoids the destructive
 recursion that could otherwise ensue.
 This API is also used by virtualization in some architectures,
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index bb7c8cc77f1a..04b2b927bb5a 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -535,7 +535,7 @@ static inline void note_hpte_modification(struct kvm *kvm,
  */
 static inline struct kvm_memslots *kvm_memslots_raw(struct kvm *kvm)
 {
-	return rcu_dereference_raw_notrace(kvm->memslots[0]);
+	return rcu_dereference_raw_check(kvm->memslots[0]);
 }
 
 extern void kvmppc_mmu_debugfs_init(struct kvm *kvm);
diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index e91ec9ddcd30..932296144131 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -622,7 +622,7 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
  * as long as the traversal is guarded by rcu_read_lock().
  */
 #define hlist_for_each_entry_rcu(pos, head, member)			\
-	for (pos = hlist_entry_safe (rcu_dereference_raw(hlist_first_rcu(head)),\
+	for (pos = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(head)),\
 			typeof(*(pos)), member);			\
 		pos;							\
 		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
@@ -642,10 +642,10 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
  * not do any RCU debugging or tracing.
  */
 #define hlist_for_each_entry_rcu_notrace(pos, head, member)			\
-	for (pos = hlist_entry_safe (rcu_dereference_raw_notrace(hlist_first_rcu(head)),\
+	for (pos = hlist_entry_safe(rcu_dereference_raw_check(hlist_first_rcu(head)),\
 			typeof(*(pos)), member);			\
 		pos;							\
-		pos = hlist_entry_safe(rcu_dereference_raw_notrace(hlist_next_rcu(\
+		pos = hlist_entry_safe(rcu_dereference_raw_check(hlist_next_rcu(\
 			&(pos)->member)), typeof(*(pos)), member))
 
 /**
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 8f7167478c1d..bfcafbc1e301 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -476,7 +476,7 @@ do {									      \
  * The no-tracing version of rcu_dereference_raw() must not call
  * rcu_read_lock_held().
  */
-#define rcu_dereference_raw_notrace(p) __rcu_dereference_check((p), 1, __rcu)
+#define rcu_dereference_raw_check(p) __rcu_dereference_check((p), 1, __rcu)
 
 /**
  * rcu_dereference_protected() - fetch RCU pointer when updates prevented
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index 0515a2096f90..0456e0a3dab1 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -6,22 +6,22 @@
 
 /*
  * Traverse the ftrace_global_list, invoking all entries.  The reason that we
- * can use rcu_dereference_raw_notrace() is that elements removed from this list
+ * can use rcu_dereference_raw_check() is that elements removed from this list
  * are simply leaked, so there is no need to interact with a grace-period
- * mechanism.  The rcu_dereference_raw_notrace() calls are needed to handle
+ * mechanism.  The rcu_dereference_raw_check() calls are needed to handle
  * concurrent insertions into the ftrace_global_list.
  *
  * Silly Alpha and silly pointer-speculation compiler optimizations!
  */
 #define do_for_each_ftrace_op(op, list)			\
-	op = rcu_dereference_raw_notrace(list);			\
+	op = rcu_dereference_raw_check(list);			\
 	do
 
 /*
  * Optimized for just a single item in the list (as that is the normal case).
  */
 #define while_for_each_ftrace_op(op)				\
-	while (likely(op = rcu_dereference_raw_notrace((op)->next)) &&	\
+	while (likely(op = rcu_dereference_raw_check((op)->next)) &&	\
 	       unlikely((op) != &ftrace_list_end))
 
 extern struct ftrace_ops __rcu *ftrace_ops_list;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 525a97fbbc60..642474b26ba7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2642,10 +2642,10 @@ static void ftrace_exports(struct ring_buffer_event *event)
 
 	preempt_disable_notrace();
 
-	export = rcu_dereference_raw_notrace(ftrace_exports_list);
+	export = rcu_dereference_raw_check(ftrace_exports_list);
 	while (export) {
 		trace_process_export(export, event);
-		export = rcu_dereference_raw_notrace(export->next);
+		export = rcu_dereference_raw_check(export->next);
 	}
 
 	preempt_enable_notrace();
-- 
2.17.1

