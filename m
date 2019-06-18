Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51881C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332F220823
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfFRHck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:32:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725870AbfFRHck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:32:40 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5I7SVn7104593
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 03:32:38 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t6ta4b7mt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 03:32:38 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 18 Jun 2019 08:32:37 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Jun 2019 08:32:33 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5I7WWdI32702618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 07:32:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94A9C4C046;
        Tue, 18 Jun 2019 07:32:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFB6B4C063;
        Tue, 18 Jun 2019 07:32:30 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.53])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Jun 2019 07:32:30 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Tue, 18 Jun 2019 10:32:30 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] arm64/mm: don't initialize pgd_cache twice
Date:   Tue, 18 Jun 2019 10:32:29 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19061807-0016-0000-0000-0000028A04C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061807-0017-0000-0000-000032E7538F
Message-Id: <1560843149-13845-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=857 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906180062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When PGD_SIZE != PAGE_SIZE, arm64 uses kmem_cache for allocation of PGD
memory. That cache was initialized twice: first through
pgtable_cache_init() alias and then as an override for weak
pgd_cache_init().

Remove the alias from pgtable_cache_init() and keep the only pgd_cache
initialization in pgd_cache_init().

Fixes: caa841360134 ("x86/mm: Initialize PGD cache during mm initialization")
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/include/asm/pgtable.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 2c41b04..851c68d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -812,8 +812,7 @@ extern int kern_addr_valid(unsigned long addr);
 
 #include <asm-generic/pgtable.h>
 
-void pgd_cache_init(void);
-#define pgtable_cache_init	pgd_cache_init
+static inline void pgtable_cache_init(void) { }
 
 /*
  * On AArch64, the cache coherency is handled via the set_pte_at() function.
-- 
2.7.4

