Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8D4C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E128D208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfE1JMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:12:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726560AbfE1JML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:12:11 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4S95BWO006166
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 05:12:10 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ss08h515b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 05:12:10 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Tue, 28 May 2019 10:12:09 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 May 2019 10:12:07 +0100
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4S9C6F146530724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 09:12:06 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70CF96A047;
        Tue, 28 May 2019 09:12:06 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45AB06A04D;
        Tue, 28 May 2019 09:12:04 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.31.115])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 28 May 2019 09:12:03 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, jack@suse.cz, mpe@ellerman.id.au
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v2] mm: Move MAP_SYNC to asm-generic/mman-common.h
Date:   Tue, 28 May 2019 14:41:20 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052809-0036-0000-0000-00000AC3B684
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011174; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01209716; UDB=6.00635512; IPR=6.00990746;
 MB=3.00027082; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-28 09:12:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052809-0037-0000-0000-00004BF98C6A
Message-Id: <20190528091120.13322-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=728 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905280061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables support for synchronous DAX fault on powerpc

The generic changes are added as part of
commit b6fb293f2497 ("mm: Define MAP_SYNC and VM_SYNC flags")

Without this, mmap returns EOPNOTSUPP for MAP_SYNC with MAP_SHARED_VALIDATE

Instead of adding MAP_SYNC with same value to
arch/powerpc/include/uapi/asm/mman.h, I am moving the #define to
asm-generic/mman-common.h. Two architectures using mman-common.h directly are
sparc and powerpc. We should be able to consloidate more #defines to
mman-common.h. That can be done as a separate patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
Changes from V1:
* Move #define to mman-common.h instead of powerpc specific mman.h change


 include/uapi/asm-generic/mman-common.h | 3 ++-
 include/uapi/asm-generic/mman.h        | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index abd238d0f7a4..bea0278f65ab 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -25,7 +25,8 @@
 # define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
 #endif
 
-/* 0x0100 - 0x80000 flags are defined in asm-generic/mman.h */
+/* 0x0100 - 0x40000 flags are defined in asm-generic/mman.h */
+#define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
 
 /*
diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
index 653687d9771b..2dffcbf705b3 100644
--- a/include/uapi/asm-generic/mman.h
+++ b/include/uapi/asm-generic/mman.h
@@ -13,7 +13,6 @@
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-#define MAP_SYNC	0x80000		/* perform synchronous page faults for the mapping */
 
 /* Bits [26:31] are reserved, see mman-common.h for MAP_HUGETLB usage */
 
-- 
2.21.0

