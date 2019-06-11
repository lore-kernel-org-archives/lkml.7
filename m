Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F9EC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C57206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391910AbfFKTYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:24:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387563AbfFKTYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:24:17 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BJLn3T127775
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 15:24:15 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2h882xv0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 15:24:15 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 11 Jun 2019 20:24:14 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 20:24:11 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5BJOAhN30802374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 19:24:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CAABB2096;
        Tue, 11 Jun 2019 19:24:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40495B2097;
        Tue, 11 Jun 2019 19:24:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.136.117])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 19:24:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2E51016C5DA1; Tue, 11 Jun 2019 12:24:10 -0700 (PDT)
Date:   Tue, 11 Jun 2019 12:24:10 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux@arm.linux.org.uk, mark.rutland@arm.com,
        dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH arm] Use common outgoing-CPU-notification code
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19061119-0052-0000-0000-000003CE9AB4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011247; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216561; UDB=6.00639663; IPR=6.00997660;
 MB=3.00027267; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-11 19:24:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061119-0053-0000-0000-0000614938FF
Message-Id: <20190611192410.GA27930@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes the open-coded CPU-offline notification with new
common code.  In particular, this change avoids calling scheduler code
using RCU from an offline CPU that RCU is ignoring.  This is a minimal
change.  A more intrusive change might invoke the cpu_check_up_prepare()
and cpu_set_state_online() functions at CPU-online time, which would
allow onlining throw an error if the CPU did not go offline properly.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index ebc53804d57b..8687d619260f 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -267,15 +267,13 @@ int __cpu_disable(void)
 	return 0;
 }
 
-static DECLARE_COMPLETION(cpu_died);
-
 /*
  * called on the thread which is asking for a CPU to be shutdown -
  * waits until shutdown has completed, or it is timed out.
  */
 void __cpu_die(unsigned int cpu)
 {
-	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
+	if (!cpu_wait_death(cpu, 5)) {
 		pr_err("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
@@ -322,7 +320,7 @@ void arch_cpu_idle_dead(void)
 	 * this returns, power and/or clocks can be removed at any point
 	 * from this CPU and its cache by platform_cpu_kill().
 	 */
-	complete(&cpu_died);
+	(void)cpu_report_death();
 
 	/*
 	 * Ensure that the cache lines associated with that completion are

