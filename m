Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C121C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0982075D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633871AbfIYEGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 00:06:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633859AbfIYEGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 00:06:51 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8P41t3A102255
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 00:06:50 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v809f14yu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 00:06:49 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 25 Sep 2019 05:06:47 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Sep 2019 05:06:44 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8P46hrU50462800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 04:06:43 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F950A4051;
        Wed, 25 Sep 2019 04:06:43 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7844A4053;
        Wed, 25 Sep 2019 04:06:41 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.31.69])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Sep 2019 04:06:41 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org, christophe.leroy@c-s.fr
Cc:     npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v4 5/5] Powerpc/Watchpoint: Support for 8xx in ptrace-hwbreak.c selftest
Date:   Wed, 25 Sep 2019 09:36:30 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925040630.6948-1-ravi.bangoria@linux.ibm.com>
References: <20190925040630.6948-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19092504-0008-0000-0000-0000031A9ABB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092504-0009-0000-0000-00004A3930A3
Message-Id: <20190925040630.6948-6-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-25_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909250039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the 8xx, signals are generated after executing the instruction.
So no need to manually single-step on 8xx.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 .../selftests/powerpc/ptrace/ptrace-hwbreak.c | 26 ++++++++++++++-----
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
index 654131591fca..58505277346d 100644
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
@@ -489,5 +496,10 @@ static int ptrace_hwbreak(void)
 
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

