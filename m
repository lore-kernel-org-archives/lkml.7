Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0484C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7965217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfCMDmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 23:42:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbfCMDme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 23:42:34 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2D3dKXL136923
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 23:42:33 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r6p5th9ff-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 23:42:33 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Wed, 13 Mar 2019 03:42:30 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Mar 2019 03:42:28 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2D3gRFL55967864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Mar 2019 03:42:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECE05AE051;
        Wed, 13 Mar 2019 03:42:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55642AE04D;
        Wed, 13 Mar 2019 03:42:26 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Mar 2019 03:42:26 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 3AB1AA00D1;
        Wed, 13 Mar 2019 14:42:25 +1100 (AEDT)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     "Alastair D'Silva" <alastair@d-silva.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arch/powerpc: Rework local_paca to avoid LTO warnings
Date:   Wed, 13 Mar 2019 14:42:06 +1100
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031303-0028-0000-0000-000003535281
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031303-0029-0000-0000-00002411D8A6
Message-Id: <20190313034208.13134-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130024
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

When building an LTO kernel, the existing code generates warnings:
    ./arch/powerpc/include/asm/paca.h:37:30: warning: register of
        ‘local_paca’ used for multiple global register variables
     register struct paca_struct *local_paca asm("r13");
                              ^
    ./arch/powerpc/include/asm/paca.h:37:30: note: conflicts with
        ‘local_paca’

This patch reworks local_paca into an inline getter & setter function,
which addresses the warning.

Generated ASM from this patch is broadly similar (addresses have
changed and the compiler uses different GPRs in some places).

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/include/asm/paca.h | 44 +++++++++++++++++++++++----------
 arch/powerpc/kernel/paca.c      |  2 +-
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index e843bc5d1a0f..9c9e2dea0f9b 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -34,19 +34,6 @@
 #include <asm/cpuidle.h>
 #include <asm/atomic.h>
 
-register struct paca_struct *local_paca asm("r13");
-
-#if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
-extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
-/*
- * Add standard checks that preemption cannot occur when using get_paca():
- * otherwise the paca_struct it points to may be the wrong one just after.
- */
-#define get_paca()	((void) debug_smp_processor_id(), local_paca)
-#else
-#define get_paca()	local_paca
-#endif
-
 #ifdef CONFIG_PPC_PSERIES
 #define get_lppaca()	(get_paca()->lppaca_ptr)
 #endif
@@ -266,6 +253,37 @@ struct paca_struct {
 #endif
 } ____cacheline_aligned;
 
+#if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
+extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
+#endif
+
+static inline struct paca_struct *get_paca_no_preempt_check(void)
+{
+	register struct paca_struct *paca asm("r13");
+	return paca;
+}
+
+static inline struct paca_struct *get_paca(void)
+{
+#if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
+	/*
+	 * Add standard checks that preemption cannot occur when using get_paca():
+	 * otherwise the paca_struct it points to may be the wrong one just after.
+	 */
+	debug_smp_processor_id();
+#endif
+	return get_paca_no_preempt_check();
+}
+
+#define local_paca	get_paca_no_preempt_check()
+
+static inline void set_paca(struct paca_struct *new)
+{
+	register struct paca_struct *paca asm("r13");
+	paca = new;
+}
+
+
 extern void copy_mm_to_paca(struct mm_struct *mm);
 extern struct paca_struct **paca_ptrs;
 extern void initialise_paca(struct paca_struct *new_paca, int cpu);
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 913bfca09c4f..ae5c243f9d5a 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -172,7 +172,7 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 void setup_paca(struct paca_struct *new_paca)
 {
 	/* Setup r13 */
-	local_paca = new_paca;
+	set_paca(new_paca);
 
 #ifdef CONFIG_PPC_BOOK3E
 	/* On Book3E, initialize the TLB miss exception frames */
-- 
2.20.1

