Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA42C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1DB25C33
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfE3PGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:06:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbfE3PGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:06:14 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UF2OUC109005
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:06:13 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgfkb697-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:06:12 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 16:06:11 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 16:06:05 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UF4nJt36372482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:04:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F579B2065;
        Thu, 30 May 2019 15:04:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AA5AB2066;
        Thu, 30 May 2019 15:04:49 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 15:04:49 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 39D0216C5D85; Thu, 30 May 2019 08:04:51 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        paulmck@linux.vnet.ibm.com, kernel-hardening@lists.openwall.com,
        kernel-team@android.com,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 3/4] module: Make srcu_struct ptr array as read-only
Date:   Thu, 30 May 2019 08:04:48 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530150347.GA31311@linux.ibm.com>
References: <20190530150347.GA31311@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053015-0060-0000-0000-00000349F73B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210787; UDB=6.00636159; IPR=6.00991822;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 15:06:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053015-0061-0000-0000-0000498DFDC1
Message-Id: <20190530150449.31885-3-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Since commit title ("srcu: Allocate per-CPU data for DEFINE_SRCU() in
modules"), modules that call DEFINE_{STATIC,}SRCU will have a new array
of srcu_struct pointers, which is used by srcu code to initialize and
clean up these structures and save valuable per-cpu reserved space.

There is no reason for this array of pointers to be writable, and can
cause security or other hidden bugs. Mark these are read-only after the
module init has completed.

Tested with the following diff to ensure array not writable:

(diff is a bit reduced to avoid patch command getting confused)
 a/kernel/module.c
 b/kernel/module.c
  -3506,6 +3506,14  static noinline int do_init_module [snip]
 	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
 #endif
 	module_enable_ro(mod, true);
+
+	if (mod->srcu_struct_ptrs) {
+		// Check if srcu_struct_ptrs access is possible
+		char x = *(char *)mod->srcu_struct_ptrs;
+		*(char *)mod->srcu_struct_ptrs = 0;
+		*(char *)mod->srcu_struct_ptrs = x;
+	}
+
 	mod_tree_remove_init(mod);
 	disable_ro_nx(&mod->init_layout);
 	module_arch_freeing_init(mod);

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: paulmck@linux.vnet.ibm.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: rcu@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: kernel-team@android.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/linux/srcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 8af1824c46a8..9cfcc8a756ae 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -123,7 +123,7 @@ struct srcu_struct {
 #ifdef MODULE
 # define __DEFINE_SRCU(name, is_static)					\
 	is_static struct srcu_struct name;				\
-	struct srcu_struct *__srcu_struct_##name			\
+	struct srcu_struct * const __srcu_struct_##name			\
 		__section("___srcu_struct_ptrs") = &name
 #else
 # define __DEFINE_SRCU(name, is_static)					\
-- 
2.17.1

