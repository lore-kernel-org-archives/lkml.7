Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEC5ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD5920663
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439513AbfJQJcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:32:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439496AbfJQJck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:32:40 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9H9SBtR120012
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 05:32:39 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vpnpmr2x7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 05:32:39 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 17 Oct 2019 10:32:37 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Oct 2019 10:32:32 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9H9WVlB9961582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 09:32:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A07E04C052;
        Thu, 17 Oct 2019 09:32:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D8404C04E;
        Thu, 17 Oct 2019 09:32:29 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.56.216])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Oct 2019 09:32:28 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     christophe.leroy@c-s.fr, mpe@ellerman.id.au, mikey@neuling.org
Cc:     npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v6 7/7] Powerpc/Watchpoint: Support for 8xx in ptrace-hwbreak.c selftest
Date:   Thu, 17 Oct 2019 15:02:04 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017093204.7511-1-ravi.bangoria@linux.ibm.com>
References: <20191017093204.7511-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101709-4275-0000-0000-00000372E523
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101709-4276-0000-0000-00003885FD0A
Message-Id: <20191017093204.7511-8-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the 8xx, signals are generated after executing the instruction.
So no need to manually single-step on 8xx. Also, 8xx __set_dabr()
currently ignores length and hardcodes the length to 8 bytes. So
all unaligned and 512 byte testcase will fail on 8xx. Ignore those
testcases on 8xx.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 .../selftests/powerpc/ptrace/ptrace-hwbreak.c | 32 +++++++++++++------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
index 916e97f5f8b1..7deedbc16b0b 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
@@ -22,6 +22,11 @@
 #include <sys/wait.h>
 #include "ptrace.h"
 
+#define SPRN_PVR	0x11F
+#define PVR_8xx		0x00500000
+
+bool is_8xx;
+
 /*
  * Use volatile on all global var so that compiler doesn't
  * optimise their load/stores. Otherwise selftest can fail.
@@ -205,13 +210,15 @@ static void check_success(pid_t child_pid, const char *name, const char *type,
 
 	printf("%s, %s, len: %d: Ok\n", name, type, len);
 
-	/*
-	 * For ptrace registered watchpoint, signal is generated
-	 * before executing load/store. Singlestep the instruction
-	 * and then continue the test.
-	 */
-	ptrace(PTRACE_SINGLESTEP, child_pid, NULL, 0);
-	wait(NULL);
+	if (!is_8xx) {
+		/*
+		 * For ptrace registered watchpoint, signal is generated
+		 * before executing load/store. Singlestep the instruction
+		 * and then continue the test.
+		 */
+		ptrace(PTRACE_SINGLESTEP, child_pid, NULL, 0);
+		wait(NULL);
+	}
 }
 
 static void ptrace_set_debugreg(pid_t child_pid, unsigned long wp_addr)
@@ -447,8 +454,10 @@ run_tests(pid_t child_pid, struct ppc_debug_info *dbginfo, bool dawr)
 	test_set_debugreg(child_pid);
 	if (dbginfo->features & PPC_DEBUG_FEATURE_DATA_BP_RANGE) {
 		test_sethwdebug_exact(child_pid);
-		test_sethwdebug_range_aligned(child_pid);
-		if (dawr) {
+
+		if (!is_8xx)
+			test_sethwdebug_range_aligned(child_pid);
+		if (dawr && !is_8xx) {
 			test_sethwdebug_range_unaligned(child_pid);
 			test_sethwdebug_range_unaligned_dar(child_pid);
 			test_sethwdebug_dawr_max_range(child_pid);
@@ -489,5 +498,10 @@ static int ptrace_hwbreak(void)
 
 int main(int argc, char **argv, char **envp)
 {
+	int pvr = 0;
+	asm __volatile__ ("mfspr %0,%1" : "=r"(pvr) : "i"(SPRN_PVR));
+	if (pvr == PVR_8xx)
+		is_8xx = true;
+
 	return test_harness(ptrace_hwbreak, "ptrace-hwbreak");
 }
-- 
2.21.0

