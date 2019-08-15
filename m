Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98245C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 04:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D7B208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 04:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfHOEMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 00:12:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbfHOEMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 00:12:45 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7F4CLPZ057625
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 00:12:44 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ucy4fhrx1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 00:12:44 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Thu, 15 Aug 2019 05:12:41 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 15 Aug 2019 05:12:36 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7F4CZWI51839198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 04:12:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A89ADA405F;
        Thu, 15 Aug 2019 04:12:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57FAEA4054;
        Thu, 15 Aug 2019 04:12:35 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 15 Aug 2019 04:12:35 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 38195A03BC;
        Thu, 15 Aug 2019 14:12:34 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>, Qian Cai <cai@lca.pw>,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] powerpc: Remove 'extern' from func prototypes in cache headers
Date:   Thu, 15 Aug 2019 14:10:50 +1000
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815041057.13627-1-alastair@au1.ibm.com>
References: <20190815041057.13627-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19081504-0012-0000-0000-0000033EEEBC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081504-0013-0000-0000-000021790431
Message-Id: <20190815041057.13627-6-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=906 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

The 'extern' keyword does not value-add for function prototypes.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/include/asm/cache.h      | 8 ++++----
 arch/powerpc/include/asm/cacheflush.h | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index 728f154204db..c5c096e968e0 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -102,10 +102,10 @@ static inline u32 l1_icache_bytes(void)
 #define __read_mostly __attribute__((__section__(".data..read_mostly")))
 
 #ifdef CONFIG_PPC_BOOK3S_32
-extern long _get_L2CR(void);
-extern long _get_L3CR(void);
-extern void _set_L2CR(unsigned long);
-extern void _set_L3CR(unsigned long);
+long _get_L2CR(void);
+long _get_L3CR(void);
+void _set_L2CR(unsigned long val);
+void _set_L3CR(unsigned long val);
 #else
 #define _get_L2CR()	0L
 #define _get_L3CR()	0L
diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 4c3377aff8ed..1826bf2cc137 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -38,15 +38,15 @@ static inline void flush_cache_vmap(unsigned long start, unsigned long end) { }
 #endif
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
-extern void flush_dcache_page(struct page *page);
+void flush_dcache_page(struct page *page);
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
 void flush_icache_range(unsigned long start, unsigned long stop);
-extern void flush_icache_user_range(struct vm_area_struct *vma,
+void flush_icache_user_range(struct vm_area_struct *vma,
 				    struct page *page, unsigned long addr,
 				    int len);
-extern void flush_dcache_icache_page(struct page *page);
+void flush_dcache_icache_page(struct page *page);
 
 /**
  * flush_dcache_range(): Write any modified data cache blocks out to memory and invalidate them.
-- 
2.21.0

