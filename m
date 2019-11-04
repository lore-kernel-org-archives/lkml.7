Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941C1CA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 02:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B24D217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 02:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfKDCep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 21:34:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3518 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728227AbfKDCeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 21:34:44 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA42WQDg012869
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 21:34:43 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w14m2ru09-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 21:34:43 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Mon, 4 Nov 2019 02:34:40 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Nov 2019 02:34:37 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA42Y1uZ39256520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Nov 2019 02:34:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E53011C04C;
        Mon,  4 Nov 2019 02:34:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AC5511C04A;
        Mon,  4 Nov 2019 02:34:36 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Nov 2019 02:34:36 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6E9DDA01D6;
        Mon,  4 Nov 2019 13:34:34 +1100 (AEDT)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Qian Cai <cai@lca.pw>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/6] powerpc: Chunk calls to flush_dcache_range in arch_*_memory
Date:   Mon,  4 Nov 2019 13:32:57 +1100
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191104023305.9581-1-alastair@au1.ibm.com>
References: <20191104023305.9581-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19110402-0028-0000-0000-000003B25911
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110402-0029-0000-0000-00002474AAB4
Message-Id: <20191104023305.9581-6-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911040026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

When presented with large amounts of memory being hotplugged
(in my test case, ~890GB), the call to flush_dcache_range takes
a while (~50 seconds), triggering RCU stalls.

This patch breaks up the call into 1GB chunks, calling
cond_resched() inbetween to allow the scheduler to run.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/mm/mem.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 54d61ba15e93..a7b662fc02c8 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -104,6 +104,27 @@ int __weak remove_section_mapping(unsigned long start, unsigned long end)
 	return -ENODEV;
 }
 
+#define FLUSH_CHUNK_SIZE SZ_1G
+/**
+ * flush_dcache_range_chunked(): Write any modified data cache blocks out to
+ * memory and invalidate them, in chunks of up to FLUSH_CHUNK_SIZE
+ * Does not invalidate the corresponding instruction cache blocks.
+ *
+ * @start: the start address
+ * @stop: the stop address (exclusive)
+ * @chunk: the max size of the chunks
+ */
+static void flush_dcache_range_chunked(unsigned long start, unsigned long stop,
+				       unsigned long chunk)
+{
+	unsigned long i;
+
+	for (i = start; i < stop; i += chunk) {
+		flush_dcache_range(i, min(stop, start + chunk));
+		cond_resched();
+	}
+}
+
 int __ref arch_add_memory(int nid, u64 start, u64 size,
 			struct mhp_restrictions *restrictions)
 {
@@ -120,7 +141,8 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
 			start, start + size, rc);
 		return -EFAULT;
 	}
-	flush_dcache_range(start, start + size);
+
+	flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
 
 	return __add_pages(nid, start_pfn, nr_pages, restrictions);
 }
@@ -137,7 +159,8 @@ void __ref arch_remove_memory(int nid, u64 start, u64 size,
 
 	/* Remove htab bolted mappings for this section of memory */
 	start = (unsigned long)__va(start);
-	flush_dcache_range(start, start + size);
+	flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
+
 	ret = remove_section_mapping(start, start + size);
 	WARN_ON_ONCE(ret);
 
-- 
2.21.0

