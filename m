Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA93C468BE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA51214AE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfFHLJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:09:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726828AbfFHLJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:09:03 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x58B6iGb002292
        for <linux-kernel@vger.kernel.org>; Sat, 8 Jun 2019 07:09:02 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t09j53qnn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 07:09:00 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 8 Jun 2019 12:08:57 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 8 Jun 2019 12:08:55 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x58B8saq60686376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Jun 2019 11:08:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B36E742041;
        Sat,  8 Jun 2019 11:08:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 662DC4203F;
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
Subject: [PATCH/RFC 2/3] s390: improve wait logic of stop_machine
Date:   Sat,  8 Jun 2019 13:08:52 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190608110853.35961-1-heiko.carstens@de.ibm.com>
References: <20190608110853.35961-1-heiko.carstens@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19060811-0020-0000-0000-000003484E26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060811-0021-0000-0000-0000219B6AD7
Message-Id: <20190608110853.35961-3-heiko.carstens@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906080086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The stop_machine loop to advance the state machine and to wait for all
affected CPUs to check-in calls cpu_relax_yield in a tight loop until
the last missing CPUs acknowledged the state transition.

On a virtual system where not all logical CPUs are backed by real CPUs
all the time it can take a while for all CPUs to check-in. With the
current definition of cpu_relax_yield a diagnose 0x44 is done which
tells the hypervisor to schedule *some* other CPU. That can be any
CPU and not necessarily one of the CPUs that need to run in order to
advance the state machine. This can lead to a pretty bad diagnose 0x44
storm until the last missing CPU finally checked-in.

Replace the undirected cpu_relax_yield based on diagnose 0x44 with a
directed yield. Each CPU in the wait loop will pick up the next CPU
in the cpumask of stop_machine. The diagnose 0x9c is used to tell the
hypervisor to run this next CPU instead of the current one. If there
is only a limited number of real CPUs backing the virtual CPUs we
end up with the real CPUs passed around in a round-robin fashion.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/include/asm/processor.h |  3 ++-
 arch/s390/kernel/processor.c      | 19 ++++++++++++++-----
 arch/s390/kernel/smp.c            |  2 +-
 include/linux/sched.h             |  2 +-
 kernel/stop_machine.c             | 14 +++++++++-----
 5 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index b0fcbc37b637..445ce9ee4404 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -36,6 +36,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/cpumask.h>
 #include <linux/linkage.h>
 #include <linux/irqflags.h>
 #include <asm/cpu.h>
@@ -225,7 +226,7 @@ static __no_kasan_or_inline unsigned short stap(void)
  * Give up the time slice of the virtual PU.
  */
 #define cpu_relax_yield cpu_relax_yield
-void cpu_relax_yield(void);
+void cpu_relax_yield(const struct cpumask *cpumask);
 
 #define cpu_relax() barrier()
 
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 5de13307b703..2c781e2b0078 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -31,6 +31,7 @@ struct cpu_info {
 };
 
 static DEFINE_PER_CPU(struct cpu_info, cpu_info);
+static DEFINE_PER_CPU(int, cpu_relax_retry);
 
 static bool machine_has_cpu_mhz;
 
@@ -58,13 +59,21 @@ void s390_update_cpu_mhz(void)
 		on_each_cpu(update_cpu_mhz, NULL, 0);
 }
 
-void notrace cpu_relax_yield(void)
+void notrace cpu_relax_yield(const struct cpumask *cpumask)
 {
-	if (!smp_cpu_mtid && MACHINE_HAS_DIAG44) {
-		diag_stat_inc(DIAG_STAT_X044);
-		asm volatile("diag 0,0,0x44");
+	int cpu;
+
+	if (__this_cpu_inc_return(cpu_relax_retry) >= spin_retry) {
+		__this_cpu_write(cpu_relax_retry, 0);
+		cpu = cpumask_next(smp_processor_id(), cpumask);
+		if (cpu >= nr_cpu_ids) {
+			cpu = cpumask_first(cpumask);
+			if (cpu == smp_processor_id())
+				return;
+		}
+		if (arch_vcpu_is_preempted(cpu))
+			smp_yield_cpu(cpu);
 	}
-	barrier();
 }
 EXPORT_SYMBOL(cpu_relax_yield);
 
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 35fafa2b91a8..a8eef7b7770a 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -418,7 +418,7 @@ void smp_yield_cpu(int cpu)
 		diag_stat_inc_norecursion(DIAG_STAT_X09C);
 		asm volatile("diag %0,0,0x9c"
 			     : : "d" (pcpu_devices[cpu].address));
-	} else if (MACHINE_HAS_DIAG44) {
+	} else if (MACHINE_HAS_DIAG44 && !smp_cpu_mtid) {
 		diag_stat_inc_norecursion(DIAG_STAT_X044);
 		asm volatile("diag 0,0,0x44");
 	}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 11837410690f..1f9f3160da7e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1519,7 +1519,7 @@ static inline int set_cpus_allowed_ptr(struct task_struct *p, const struct cpuma
 #endif
 
 #ifndef cpu_relax_yield
-#define cpu_relax_yield() cpu_relax()
+#define cpu_relax_yield(cpumask) cpu_relax()
 #endif
 
 extern int yield_to(struct task_struct *p, bool preempt);
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 2b5a6754646f..b8b0c5ff8da9 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -183,6 +183,7 @@ static int multi_cpu_stop(void *data)
 	struct multi_stop_data *msdata = data;
 	enum multi_stop_state curstate = MULTI_STOP_NONE;
 	int cpu = smp_processor_id(), err = 0;
+	const struct cpumask *cpumask;
 	unsigned long flags;
 	bool is_active;
 
@@ -192,15 +193,18 @@ static int multi_cpu_stop(void *data)
 	 */
 	local_save_flags(flags);
 
-	if (!msdata->active_cpus)
-		is_active = cpu == cpumask_first(cpu_online_mask);
-	else
-		is_active = cpumask_test_cpu(cpu, msdata->active_cpus);
+	if (!msdata->active_cpus) {
+		cpumask = cpu_online_mask;
+		is_active = cpu == cpumask_first(cpumask);
+	} else {
+		cpumask = msdata->active_cpus;
+		is_active = cpumask_test_cpu(cpu, cpumask);
+	}
 
 	/* Simple state machine */
 	do {
 		/* Chill out and ensure we re-read multi_stop_state. */
-		cpu_relax_yield();
+		cpu_relax_yield(cpumask);
 		if (msdata->state != curstate) {
 			curstate = msdata->state;
 			switch (curstate) {
-- 
2.17.1

