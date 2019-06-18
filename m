Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C06EC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00B92084D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfFRE1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 00:27:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725826AbfFRE1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 00:27:50 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5I4REcO053398
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:27:48 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t6rncrfnb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:27:48 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 18 Jun 2019 05:27:46 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Jun 2019 05:27:42 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5I4Rf1r35389744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 04:27:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B306011C04A;
        Tue, 18 Jun 2019 04:27:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFEE411C04C;
        Tue, 18 Jun 2019 04:27:38 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.63.86])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jun 2019 04:27:38 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, christophe.leroy@c-s.fr,
        naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 1/5] Powerpc/hw-breakpoint: Replace stale do_dabr() with do_break()
Date:   Tue, 18 Jun 2019 09:57:28 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618042732.5582-1-ravi.bangoria@linux.ibm.com>
References: <20190618042732.5582-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061804-0016-0000-0000-00000289F9BF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061804-0017-0000-0000-000032E747DA
Message-Id: <20190618042732.5582-2-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=389 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906180035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_dabr() was renamed with do_break() long ago. But I still see
some comments mentioning do_dabr(). Replace it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/kernel/hw_breakpoint.c | 2 +-
 arch/powerpc/kernel/ptrace.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index a293a53b4365..1908e4fcc132 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -232,7 +232,7 @@ int hw_breakpoint_handler(struct die_args *args)
 	 * Return early after invoking user-callback function without restoring
 	 * DABR if the breakpoint is from ptrace which always operates in
 	 * one-shot mode. The ptrace-ed process will receive the SIGTRAP signal
-	 * generated in do_dabr().
+	 * generated in do_break().
 	 */
 	if (bp->overflow_handler == ptrace_triggered) {
 		perf_bp_event(bp, regs);
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 684b0b315c32..44b823e5e8c8 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -2373,7 +2373,7 @@ void ptrace_triggered(struct perf_event *bp,
 	/*
 	 * Disable the breakpoint request here since ptrace has defined a
 	 * one-shot behaviour for breakpoint exceptions in PPC64.
-	 * The SIGTRAP signal is generated automatically for us in do_dabr().
+	 * The SIGTRAP signal is generated automatically for us in do_break().
 	 * We don't have to do anything about that here
 	 */
 	attr = bp->attr;
-- 
2.20.1

