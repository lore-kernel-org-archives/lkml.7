Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DF2C468BC
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D47F214AF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfFHLJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:09:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726859AbfFHLJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:09:02 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x58B6iuq027809
        for <linux-kernel@vger.kernel.org>; Sat, 8 Jun 2019 07:09:01 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t09h53m6u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 07:09:00 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 8 Jun 2019 12:08:58 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 8 Jun 2019 12:08:56 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x58B8tT145482078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Jun 2019 11:08:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BEB242045;
        Sat,  8 Jun 2019 11:08:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C269642042;
        Sat,  8 Jun 2019 11:08:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  8 Jun 2019 11:08:54 +0000 (GMT)
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH/RFC 3/3] processor: get rid of cpu_relax_yield
Date:   Sat,  8 Jun 2019 13:08:53 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190608110853.35961-1-heiko.carstens@de.ibm.com>
References: <20190608110853.35961-1-heiko.carstens@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19060811-0020-0000-0000-000003484E27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060811-0021-0000-0000-0000219B6AD8
Message-Id: <20190608110853.35961-4-heiko.carstens@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=843 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906080086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stop_machine is the only user left of cpu_relax_yield. Given that it
now has special semantics which are tied to stop_machine introduce a
weak stop_machine_yield function which architectures can override, and
get rid of the generic cpu_relax_yield implementation.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/include/asm/processor.h | 6 ------
 arch/s390/kernel/processor.c      | 4 ++--
 include/linux/sched.h             | 4 ----
 include/linux/stop_machine.h      | 1 +
 kernel/stop_machine.c             | 7 ++++++-
 5 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 445ce9ee4404..14883b1562e0 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -222,12 +222,6 @@ static __no_kasan_or_inline unsigned short stap(void)
 	return cpu_address;
 }
 
-/*
- * Give up the time slice of the virtual PU.
- */
-#define cpu_relax_yield cpu_relax_yield
-void cpu_relax_yield(const struct cpumask *cpumask);
-
 #define cpu_relax() barrier()
 
 #define ECAG_CACHE_ATTRIBUTE	0
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 2c781e2b0078..f84eaf53c397 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -7,6 +7,7 @@
 #define KMSG_COMPONENT "cpu"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
+#include <linux/stop_machine.h>
 #include <linux/cpufeature.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
@@ -59,7 +60,7 @@ void s390_update_cpu_mhz(void)
 		on_each_cpu(update_cpu_mhz, NULL, 0);
 }
 
-void notrace cpu_relax_yield(const struct cpumask *cpumask)
+void notrace stop_machine_yield(const struct cpumask *cpumask)
 {
 	int cpu;
 
@@ -75,7 +76,6 @@ void notrace cpu_relax_yield(const struct cpumask *cpumask)
 			smp_yield_cpu(cpu);
 	}
 }
-EXPORT_SYMBOL(cpu_relax_yield);
 
 /*
  * cpu_init - initializes state that is per-CPU.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1f9f3160da7e..911675416b05 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1518,10 +1518,6 @@ static inline int set_cpus_allowed_ptr(struct task_struct *p, const struct cpuma
 }
 #endif
 
-#ifndef cpu_relax_yield
-#define cpu_relax_yield(cpumask) cpu_relax()
-#endif
-
 extern int yield_to(struct task_struct *p, bool preempt);
 extern void set_user_nice(struct task_struct *p, long nice);
 extern int task_prio(const struct task_struct *p);
diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 6d3635c86dbe..f9a0c6189852 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -36,6 +36,7 @@ int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg);
 int try_stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg);
 void stop_machine_park(int cpu);
 void stop_machine_unpark(int cpu);
+void stop_machine_yield(const struct cpumask *cpumask);
 
 #else	/* CONFIG_SMP */
 
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index b8b0c5ff8da9..b4f83f7bdf86 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -177,6 +177,11 @@ static void ack_state(struct multi_stop_data *msdata)
 		set_state(msdata, msdata->state + 1);
 }
 
+void __weak stop_machine_yield(const struct cpumask *cpumask)
+{
+	cpu_relax();
+}
+
 /* This is the cpu_stop function which stops the CPU. */
 static int multi_cpu_stop(void *data)
 {
@@ -204,7 +209,7 @@ static int multi_cpu_stop(void *data)
 	/* Simple state machine */
 	do {
 		/* Chill out and ensure we re-read multi_stop_state. */
-		cpu_relax_yield(cpumask);
+		stop_machine_yield(cpumask);
 		if (msdata->state != curstate) {
 			curstate = msdata->state;
 			switch (curstate) {
-- 
2.17.1

