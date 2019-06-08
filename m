Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7A1C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC25214AE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfFHLJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:09:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726828AbfFHLJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:09:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x58B6iGm039953
        for <linux-kernel@vger.kernel.org>; Sat, 8 Jun 2019 07:08:59 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t095kc4rd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 07:08:59 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 8 Jun 2019 12:08:58 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 8 Jun 2019 12:08:55 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x58B8sZj60686372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Jun 2019 11:08:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5723442041;
        Sat,  8 Jun 2019 11:08:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3C3E4203F;
        Sat,  8 Jun 2019 11:08:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  8 Jun 2019 11:08:53 +0000 (GMT)
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH/RFC 1/3] processor: remove spin_cpu_yield
Date:   Sat,  8 Jun 2019 13:08:51 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190608110853.35961-1-heiko.carstens@de.ibm.com>
References: <20190608110853.35961-1-heiko.carstens@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19060811-0012-0000-0000-000003267B5F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060811-0013-0000-0000-0000215F6932
Message-Id: <20190608110853.35961-2-heiko.carstens@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=659 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906080086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spin_cpu_yield is unused, therefore remove it.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/powerpc/include/asm/processor.h | 2 --
 include/linux/processor.h            | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index ef573fe9873e..a9993e7a443b 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -346,8 +346,6 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
 
 #define spin_cpu_relax()	barrier()
 
-#define spin_cpu_yield()	spin_cpu_relax()
-
 #define spin_end()	HMT_medium()
 
 #define spin_until_cond(cond)					\
diff --git a/include/linux/processor.h b/include/linux/processor.h
index dbc952eec869..dc78bdc7079a 100644
--- a/include/linux/processor.h
+++ b/include/linux/processor.h
@@ -32,15 +32,6 @@
 #define spin_cpu_relax() cpu_relax()
 #endif
 
-/*
- * spin_cpu_yield may be called to yield (undirected) to the hypervisor if
- * necessary. This should be used if the wait is expected to take longer
- * than context switch overhead, but we can't sleep or do a directed yield.
- */
-#ifndef spin_cpu_yield
-#define spin_cpu_yield() cpu_relax_yield()
-#endif
-
 #ifndef spin_end
 #define spin_end()
 #endif
-- 
2.17.1

