Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1383C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DE524682
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfLSVqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:46:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbfLSVqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:46:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD16B24683;
        Thu, 19 Dec 2019 21:45:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1ii3cM-000Um2-QF; Thu, 19 Dec 2019 16:45:58 -0500
Message-Id: <20191219214558.682913590@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Dec 2019 16:44:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <tkhai@yandex.ru>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC][PATCH 2/4] sched: Have sched_class_highest define by vmlinux.lds.h
References: <20191219214451.340746474@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Now that the sched_class descriptors are defined by the linker script, and
this needs to be aware of the existance of stop_sched_class when SMP is
enabled or not, as it is used as the "highest" priority when defined. Move
the declaration of sched_class_highest to the same location in the linker
script that inserts stop_sched_class, and this will also make it easier to
see what should be defined as the highest class, as this linker script
location defines the priorities as well.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/asm-generic/vmlinux.lds.h | 11 ++++++++++-
 kernel/sched/sched.h              |  9 +++------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 772d961c69a5..1c14c4ddf785 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -109,9 +109,16 @@
 #endif
 
 #ifdef CONFIG_SMP
-#define STOP_SCHED_CLASS	*(__stop_sched_class)
+#define STOP_SCHED_CLASS		\
+	STRUCT_ALIGN();			\
+	sched_class_highest = .;	\
+	*(__stop_sched_class)
+#define BEFORE_DL_SCHED_CLASS
 #else
 #define STOP_SCHED_CLASS
+#define BEFORE_DL_SCHED_CLASS		\
+	STRUCT_ALIGN();			\
+	sched_class_highest = .;
 #endif
 
 /*
@@ -120,9 +127,11 @@
  * relation to each other.
  */
 #define SCHED_DATA				\
+	STRUCT_ALIGN();				\
 	*(__idle_sched_class)			\
 	*(__fair_sched_class)			\
 	*(__rt_sched_class)			\
+	BEFORE_DL_SCHED_CLASS			\
 	*(__dl_sched_class)			\
 	STOP_SCHED_CLASS
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280a3c735935..0554c588ad85 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1771,17 +1771,14 @@ static inline void set_next_task(struct rq *rq, struct task_struct *next)
 	next->sched_class->set_next_task(rq, next, false);
 }
 
-#ifdef CONFIG_SMP
-#define sched_class_highest (&stop_sched_class)
-#else
-#define sched_class_highest (&dl_sched_class)
-#endif
+/* Defined in include/asm-generic/vmlinux.lds.h */
+extern struct sched_class sched_class_highest;
 
 #define for_class_range(class, _from, _to) \
 	for (class = (_from); class != (_to); class = class->next)
 
 #define for_each_class(class) \
-	for_class_range(class, sched_class_highest, NULL)
+	for_class_range(class, &sched_class_highest, NULL)
 
 extern const struct sched_class stop_sched_class;
 extern const struct sched_class dl_sched_class;
-- 
2.24.0


