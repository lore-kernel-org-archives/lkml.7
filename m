Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E704C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC564206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfK0MBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:01:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726984AbfK0MBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:01:51 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARBrFJH135003;
        Wed, 27 Nov 2019 07:01:40 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2whcy7pbv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 07:01:40 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xARC070S002618;
        Wed, 27 Nov 2019 12:01:40 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 2wevd6we36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 12:01:39 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xARC1cbL30999034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 12:01:38 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 573F4C605D;
        Wed, 27 Nov 2019 12:01:38 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11B83C605B;
        Wed, 27 Nov 2019 12:01:38 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.209])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 27 Nov 2019 12:01:38 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 6B1732E2ED5; Wed, 27 Nov 2019 17:31:35 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 1/3] powerpc/pseries: Account for SPURR ticks on idle CPUs
Date:   Wed, 27 Nov 2019 17:31:10 +0530
Message-Id: <1574856072-30972-2-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574856072-30972-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1574856072-30972-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_02:2019-11-27,2019-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911270104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

On PSeries LPARs, to compute the utilization, tools such as lparstat
need to know the [S]PURR ticks when the CPUs were busy or idle.

In the pseries cpuidle driver, we keep track of the idle PURR ticks in
the VPA variable "wait_state_cycles". This patch extends the support
to account for the idle SPURR ticks.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/idle.c        |  2 ++
 drivers/cpuidle/cpuidle-pseries.c | 28 +++++++++++++++++-----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index a36fd05..708ec68 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -33,6 +33,8 @@
 unsigned long cpuidle_disable = IDLE_NO_OVERRIDE;
 EXPORT_SYMBOL(cpuidle_disable);
 
+DEFINE_PER_CPU(u64, idle_spurr_cycles);
+
 static int __init powersave_off(char *arg)
 {
 	ppc_md.power_save = NULL;
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 74c2479..45e2be4 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -30,11 +30,14 @@ struct cpuidle_driver pseries_idle_driver = {
 static struct cpuidle_state *cpuidle_state_table __read_mostly;
 static u64 snooze_timeout __read_mostly;
 static bool snooze_timeout_en __read_mostly;
+DECLARE_PER_CPU(u64, idle_spurr_cycles);
 
-static inline void idle_loop_prolog(unsigned long *in_purr)
+static inline void idle_loop_prolog(unsigned long *in_purr,
+				    unsigned long *in_spurr)
 {
 	ppc64_runlatch_off();
 	*in_purr = mfspr(SPRN_PURR);
+	*in_spurr = mfspr(SPRN_SPURR);
 	/*
 	 * Indicate to the HV that we are idle. Now would be
 	 * a good time to find other work to dispatch.
@@ -42,13 +45,16 @@ static inline void idle_loop_prolog(unsigned long *in_purr)
 	get_lppaca()->idle = 1;
 }
 
-static inline void idle_loop_epilog(unsigned long in_purr)
+static inline void idle_loop_epilog(unsigned long in_purr,
+				    unsigned long in_spurr)
 {
 	u64 wait_cycles;
+	u64 *idle_spurr_cycles_ptr = this_cpu_ptr(&idle_spurr_cycles);
 
 	wait_cycles = be64_to_cpu(get_lppaca()->wait_state_cycles);
 	wait_cycles += mfspr(SPRN_PURR) - in_purr;
 	get_lppaca()->wait_state_cycles = cpu_to_be64(wait_cycles);
+	*idle_spurr_cycles_ptr += mfspr(SPRN_SPURR) - in_spurr;
 	get_lppaca()->idle = 0;
 
 	ppc64_runlatch_on();
@@ -58,12 +64,12 @@ static int snooze_loop(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
 {
-	unsigned long in_purr;
+	unsigned long in_purr, in_spurr;
 	u64 snooze_exit_time;
 
 	set_thread_flag(TIF_POLLING_NRFLAG);
 
-	idle_loop_prolog(&in_purr);
+	idle_loop_prolog(&in_purr, &in_spurr);
 	local_irq_enable();
 	snooze_exit_time = get_tb() + snooze_timeout;
 
@@ -87,7 +93,7 @@ static int snooze_loop(struct cpuidle_device *dev,
 
 	local_irq_disable();
 
-	idle_loop_epilog(in_purr);
+	idle_loop_epilog(in_purr, in_spurr);
 
 	return index;
 }
@@ -113,9 +119,9 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
-	unsigned long in_purr;
+	unsigned long in_purr, in_spurr;
 
-	idle_loop_prolog(&in_purr);
+	idle_loop_prolog(&in_purr, &in_spurr);
 	get_lppaca()->donate_dedicated_cpu = 1;
 
 	HMT_medium();
@@ -124,7 +130,7 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
 	local_irq_disable();
 	get_lppaca()->donate_dedicated_cpu = 0;
 
-	idle_loop_epilog(in_purr);
+	idle_loop_epilog(in_purr, in_spurr);
 
 	return index;
 }
@@ -133,9 +139,9 @@ static int shared_cede_loop(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
 {
-	unsigned long in_purr;
+	unsigned long in_purr, in_spurr;
 
-	idle_loop_prolog(&in_purr);
+	idle_loop_prolog(&in_purr, &in_spurr);
 
 	/*
 	 * Yield the processor to the hypervisor.  We return if
@@ -147,7 +153,7 @@ static int shared_cede_loop(struct cpuidle_device *dev,
 	check_and_cede_processor();
 
 	local_irq_disable();
-	idle_loop_epilog(in_purr);
+	idle_loop_epilog(in_purr, in_spurr);
 
 	return index;
 }
-- 
1.9.4

