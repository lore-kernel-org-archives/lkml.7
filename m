Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B85C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8272082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbfDBRrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:47:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731820AbfDBRrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:47:04 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x32Hjn3r099291
        for <linux-kernel@vger.kernel.org>; Tue, 2 Apr 2019 13:47:03 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rmbmtjkxw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 13:47:03 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <walling@linux.ibm.com>;
        Tue, 2 Apr 2019 18:47:02 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Apr 2019 18:46:58 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x32HkumF18677798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 17:46:56 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E66C112067;
        Tue,  2 Apr 2019 17:46:56 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64D2F112065;
        Tue,  2 Apr 2019 17:46:56 +0000 (GMT)
Received: from T470p.pok.ibm.com (unknown [9.56.58.47])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Apr 2019 17:46:56 +0000 (GMT)
From:   Collin Walling <walling@linux.ibm.com>
To:     pbonzini@redhat.com, david@redhat.com, cohuck@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com
Subject: [PATCH v3 1/2] s390/setup: diag318: remove bit check and refactor struct
Date:   Tue,  2 Apr 2019 13:46:35 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402174636.15175-1-walling@linux.ibm.com>
References: <20190402174636.15175-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040217-0068-0000-0000-000003AF869C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010862; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183350; UDB=6.00619517; IPR=6.00964098;
 MB=3.00026263; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 17:47:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040217-0069-0000-0000-00004804F412
Message-Id: <20190402174636.15175-2-walling@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Execution of DIAGNOSE 0x318 is fenced by checking an SCLP bit
for the availability of hardware support for the instruction.

In order to support this instruction for a KVM/QEMU guest, we
would need to provide modifications to the SCLP Read SCP Info
data, which will in turn reduce the maximum number of CPUs that
may be provided to the guest. This issue introduces compatability
and legacy concerns.

Let's circumvent this issue by removing the bit check and blindly
executing the instruction. An exception table rule is in place to
catch the case where hardware does not support this instruction.

While we're at it, let's condense the version code fields in the
diag318_info struct until we can determine how it will be used.

This modifies commit 4ad78b8651aacf26b3ab6d1e784952eb70469c43

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 arch/s390/include/asm/diag.h |  6 ++----
 arch/s390/kernel/setup.c     | 12 ++++++------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index 19562be22b7e..215516284175 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -298,10 +298,8 @@ struct diag26c_mac_resp {
 union diag318_info {
 	unsigned long val;
 	struct {
-		unsigned int cpnc : 8;
-		unsigned int cpvc_linux : 24;
-		unsigned char cpvc_distro[3];
-		unsigned char zero;
+		unsigned long cpnc : 8;
+		unsigned long cpvc : 56;
 	};
 };
 
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 2c642af526ce..fe70201f8b5d 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -1011,15 +1011,15 @@ static void __init setup_control_program_code(void)
 {
 	union diag318_info diag318_info = {
 		.cpnc = CPNC_LINUX,
-		.cpvc_linux = 0,
-		.cpvc_distro = {0},
+		.cpvc = 0,
 	};
 
-	if (!sclp.has_diag318)
-		return;
-
 	diag_stat_inc(DIAG_STAT_X318);
-	asm volatile("diag %0,0,0x318\n" : : "d" (diag318_info.val));
+	asm volatile(
+		"	diag	%0,0,0x318\n"
+		"0:	nopr	%%r7\n"
+		EX_TABLE(0b,0b)
+		: : "d" (diag318_info.val));
 }
 
 /*
-- 
2.20.1

