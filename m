Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C65DC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D132083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yml/HzIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfFUGLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 02:11:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53418 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFUGLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 02:11:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5L63hwT133989;
        Fri, 21 Jun 2019 06:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=XQC2vWYEYxVCAdoqaVl6sGe93jBERWNKKPMelCZgp70=;
 b=yml/HzIfevjcHdXvGkL+F1EBoLnXH+xKybo8yYqgNvrF4fPeXVBFo8srb9b4vrkrp3hA
 v+4U1TIyat3oDkzYZC2rTKtlxHsx0S/Qeu8+ovo8wNwoK0YPchErb5ElP1VE75Bg5WHa
 /ANN7n6LXJkbWbbTenZcvSGUZvIUAGpggjfA9POK7CR22phZebRloPwzX/FiYLaJ623k
 T3cNUNY/E2GRjoYgy+Ex8Ix5qLLXlKYNQDAOCyb3sRxoOQreozGXfckMjqKirjuMPQyd
 6d5WMh06ygydHWQnfddmz2cy0PExXRo+66qwlF4RTd66QE83DyspKQqfUbZcuBMzKRkh 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2t7809mkcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 06:10:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5L69pPM175378;
        Fri, 21 Jun 2019 06:10:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t77yp0x75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 06:10:53 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5L6Ands010731;
        Fri, 21 Jun 2019 06:10:49 GMT
Received: from z2.cn.oracle.com (/10.182.69.87) by default (Oracle Beehive
 Gateway v4.0) with ESMTP ; Thu, 20 Jun 2019 23:10:28 -0700
MIME-Version: 1.0
Message-ID: <1561011237-12312-1-git-send-email-zhenzhong.duan@oracle.com>
Date:   Wed, 19 Jun 2019 23:13:57 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, jgross@suse.com, ndesaulniers@google.com,
        gregkh@linuxfoundation.org, srinivas.eeda@oracle.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH] x86/speculation/mds: Flush store buffer after wake up from
 sleep
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=817
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906210052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=860 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel document says: "When a thread wakes from a sleep state, the store
buffer is repartitioned again. This causes the store buffer to transfer
store buffer entries from the thread that was already active to the one
which just woke up."

To avoid data leak from sibling thread to the woken thread, flush store
buffer right after wake up.

Move mds_idle_clear_cpu_buffers() after trace_hardirqs_on() to ensure
all store buffer entries are flushed before sleep.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 arch/x86/include/asm/irqflags.h | 2 ++
 arch/x86/include/asm/mwait.h    | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 8a0e56e..641c4d8 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -58,12 +58,14 @@ static inline __cpuidle void native_safe_halt(void)
 {
 	mds_idle_clear_cpu_buffers();
 	asm volatile("sti; hlt": : :"memory");
+	mds_idle_clear_cpu_buffers();
 }
 
 static inline __cpuidle void native_halt(void)
 {
 	mds_idle_clear_cpu_buffers();
 	asm volatile("hlt": : :"memory");
+	mds_idle_clear_cpu_buffers();
 }
 
 #endif
diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index eb0f80c..1d145d9 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -46,6 +46,7 @@ static inline void __mwait(unsigned long eax, unsigned long ecx)
 	/* "mwait %eax, %ecx;" */
 	asm volatile(".byte 0x0f, 0x01, 0xc9;"
 		     :: "a" (eax), "c" (ecx));
+	mds_idle_clear_cpu_buffers();
 }
 
 /*
@@ -86,12 +87,13 @@ static inline void __mwaitx(unsigned long eax, unsigned long ebx,
 
 static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
-	mds_idle_clear_cpu_buffers();
-
 	trace_hardirqs_on();
+
+	mds_idle_clear_cpu_buffers();
 	/* "mwait %eax, %ecx;" */
 	asm volatile("sti; .byte 0x0f, 0x01, 0xc9;"
 		     :: "a" (eax), "c" (ecx));
+	mds_idle_clear_cpu_buffers();
 }
 
 /*
-- 
1.8.3.1

