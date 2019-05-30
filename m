Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27384C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20C125C30
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfE3PGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:06:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725440AbfE3PGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:06:11 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UF2srg126642
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:06:11 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stfacewxq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:06:10 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 16:06:09 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 16:06:05 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UF4nFJ36569226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:04:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C882B2071;
        Thu, 30 May 2019 15:04:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DD28B205F;
        Thu, 30 May 2019 15:04:49 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 15:04:49 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2D8C716C5D7E; Thu, 30 May 2019 08:04:51 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 1/4] srcu: Allocate per-CPU data for DEFINE_SRCU() in modules
Date:   Thu, 30 May 2019 08:04:46 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530150347.GA31311@linux.ibm.com>
References: <20190530150347.GA31311@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053015-0060-0000-0000-00000349F738
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210787; UDB=6.00636159; IPR=6.00991822;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 15:06:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053015-0061-0000-0000-0000498DFDC2
Message-Id: <20190530150449.31885-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding DEFINE_SRCU() or DEFINE_STATIC_SRCU() to a loadable module requires
that the size of the reserved region be increased, which is not something
we want to be doing all that often.  One approach would be to require
that loadable modules define an srcu_struct and invoke init_srcu_struct()
from their module_init function and cleanup_srcu_struct() from their
module_exit function.  However, this is more than a bit user unfriendly.

This commit therefore creates an ___srcu_struct_ptrs linker section,
and pointers to srcu_struct structures created by DEFINE_SRCU() and
DEFINE_STATIC_SRCU() within a module are placed into that module's
___srcu_struct_ptrs section.  The required init_srcu_struct() and
cleanup_srcu_struct() functions are then automatically invoked as needed
when that module is loaded and unloaded, thus allowing modules to continue
to use DEFINE_SRCU() and DEFINE_STATIC_SRCU() while avoiding the need
to increase the size of the reserved region.

Many of the algorithms and some of the code was cheerfully cherry-picked
from other code making use of linker sections, perhaps most notably from
tracepoints.  All bugs are nevertheless the sole property of the author.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
[ paulmck: Use __section() and use "default" in srcu_module_notify()'s
  "switch" statement as suggested by Joel Fernandes. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/asm-generic/vmlinux.lds.h |  4 ++
 include/linux/module.h            |  5 +++
 include/linux/srcutree.h          | 14 +++++--
 kernel/module.c                   |  5 +++
 kernel/rcu/srcutree.c             | 65 +++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 088987e9a3ea..ba1ad39468fc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -337,6 +337,10 @@
 		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
 		__stop___tracepoints_ptrs = .;				\
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
+		. = ALIGN(8);						\
+		__start___srcu_struct = .;				\
+		*(___srcu_struct_ptrs)					\
+		__end___srcu_struct = .;				\
 	}								\
 									\
 	.rodata1          : AT(ADDR(.rodata1) - LOAD_OFFSET) {		\
diff --git a/include/linux/module.h b/include/linux/module.h
index 188998d3dca9..1455812dd325 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -21,6 +21,7 @@
 #include <linux/rbtree_latch.h>
 #include <linux/error-injection.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/srcu.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -450,6 +451,10 @@ struct module {
 	unsigned int num_tracepoints;
 	tracepoint_ptr_t *tracepoints_ptrs;
 #endif
+#ifdef CONFIG_TREE_SRCU
+	unsigned int num_srcu_structs;
+	struct srcu_struct **srcu_struct_ptrs;
+#endif
 #ifdef CONFIG_BPF_EVENTS
 	unsigned int num_bpf_raw_events;
 	struct bpf_raw_event_map *bpf_raw_events;
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 7f7c8c050f63..8af1824c46a8 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -120,9 +120,17 @@ struct srcu_struct {
  *
  * See include/linux/percpu-defs.h for the rules on per-CPU variables.
  */
-#define __DEFINE_SRCU(name, is_static)					\
-	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);\
-	is_static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name##_srcu_data)
+#ifdef MODULE
+# define __DEFINE_SRCU(name, is_static)					\
+	is_static struct srcu_struct name;				\
+	struct srcu_struct *__srcu_struct_##name			\
+		__section("___srcu_struct_ptrs") = &name
+#else
+# define __DEFINE_SRCU(name, is_static)					\
+	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);	\
+	is_static struct srcu_struct name =				\
+		__SRCU_STRUCT_INIT(name, name##_srcu_data)
+#endif
 #define DEFINE_SRCU(name)		__DEFINE_SRCU(name, /* not static */)
 #define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, static)
 
diff --git a/kernel/module.c b/kernel/module.c
index 6e6712b3aaf5..c79a53b629b6 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3095,6 +3095,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					     sizeof(*mod->tracepoints_ptrs),
 					     &mod->num_tracepoints);
 #endif
+#ifdef CONFIG_TREE_SRCU
+	mod->srcu_struct_ptrs = section_objs(info, "___srcu_struct_ptrs",
+					     sizeof(*mod->srcu_struct_ptrs),
+					     &mod->num_srcu_structs);
+#endif
 #ifdef CONFIG_BPF_EVENTS
 	mod->bpf_raw_events = section_objs(info, "__bpf_raw_tp_map",
 					   sizeof(*mod->bpf_raw_events),
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 9b761e546de8..2ded2614a2f4 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1310,3 +1310,68 @@ void __init srcu_init(void)
 		queue_work(rcu_gp_wq, &ssp->work.work);
 	}
 }
+
+#ifdef CONFIG_MODULES
+
+/* Initialize any global-scope srcu_struct structures used by this module. */
+static int srcu_module_coming(struct module *mod)
+{
+	int i;
+	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
+	int ret;
+
+	for (i = 0; i < mod->num_srcu_structs; i++) {
+		ret = init_srcu_struct(*(sspp++));
+		if (WARN_ON_ONCE(ret))
+			return ret;
+	}
+	return 0;
+}
+
+/* Clean up any global-scope srcu_struct structures used by this module. */
+static void srcu_module_going(struct module *mod)
+{
+	int i;
+	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
+
+	for (i = 0; i < mod->num_srcu_structs; i++)
+		cleanup_srcu_struct(*(sspp++));
+}
+
+/* Handle one module, either coming or going. */
+static int srcu_module_notify(struct notifier_block *self,
+			      unsigned long val, void *data)
+{
+	struct module *mod = data;
+	int ret = 0;
+
+	switch (val) {
+	case MODULE_STATE_COMING:
+		ret = srcu_module_coming(mod);
+		break;
+	case MODULE_STATE_GOING:
+		srcu_module_going(mod);
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+static struct notifier_block srcu_module_nb = {
+	.notifier_call = srcu_module_notify,
+	.priority = 0,
+};
+
+static __init int init_srcu_module_notifier(void)
+{
+	int ret;
+
+	ret = register_module_notifier(&srcu_module_nb);
+	if (ret)
+		pr_warn("Failed to register srcu module notifier\n");
+	return ret;
+}
+late_initcall(init_srcu_module_notifier);
+
+#endif /* #ifdef CONFIG_MODULES */
-- 
2.17.1

