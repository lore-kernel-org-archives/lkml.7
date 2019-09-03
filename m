Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666FCC3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7A621881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfICFZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 01:25:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726555AbfICFZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 01:25:19 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x835N0WI018936
        for <linux-kernel@vger.kernel.org>; Tue, 3 Sep 2019 01:25:18 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uscgkftx5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 01:25:18 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Tue, 3 Sep 2019 06:25:16 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Sep 2019 06:25:12 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x835PB6X3670192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Sep 2019 05:25:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B66E11C04A;
        Tue,  3 Sep 2019 05:25:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1688511C04C;
        Tue,  3 Sep 2019 05:25:11 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Sep 2019 05:25:11 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id D1DCAA00EC;
        Tue,  3 Sep 2019 15:25:09 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qian Cai <cai@lca.pw>, Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] powerpc: Chunk calls to flush_dcache_range in arch_*_memory
Date:   Tue,  3 Sep 2019 15:23:58 +1000
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903052407.16638-1-alastair@au1.ibm.com>
References: <20190903052407.16638-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090305-0020-0000-0000-00000366F243
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090305-0021-0000-0000-000021BC5945
Message-Id: <20190903052407.16638-5-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909030060
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
 arch/powerpc/mm/mem.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index cd540123874d..854aaea2c6ae 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -104,11 +104,14 @@ int __weak remove_section_mapping(unsigned long start, unsigned long end)
 	return -ENODEV;
 }
 
+#define FLUSH_CHUNK_SIZE SZ_1G
+
 int __ref arch_add_memory(int nid, u64 start, u64 size,
 			struct mhp_restrictions *restrictions)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
+	u64 i;
 	int rc;
 
 	resize_hpt_for_hotplug(memblock_phys_mem_size());
@@ -120,7 +123,12 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
 			start, start + size, rc);
 		return -EFAULT;
 	}
-	flush_dcache_range(start, start + size);
+
+	for (i = 0; i < size; i += FLUSH_CHUNK_SIZE) {
+		flush_dcache_range(start + i,
+				   min(start + size, start + i + FLUSH_CHUNK_SIZE));
+		cond_resched();
+	}
 
 	return __add_pages(nid, start_pfn, nr_pages, restrictions);
 }
@@ -131,13 +139,19 @@ void __ref arch_remove_memory(int nid, u64 start, u64 size,
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	struct page *page = pfn_to_page(start_pfn) + vmem_altmap_offset(altmap);
+	u64 i;
 	int ret;
 
 	__remove_pages(page_zone(page), start_pfn, nr_pages, altmap);
 
 	/* Remove htab bolted mappings for this section of memory */
 	start = (unsigned long)__va(start);
-	flush_dcache_range(start, start + size);
+	for (i = 0; i < size; i += FLUSH_CHUNK_SIZE) {
+		flush_dcache_range(start + i,
+				   min(start + size, start + i + FLUSH_CHUNK_SIZE));
+		cond_resched();
+	}
+
 	ret = remove_section_mapping(start, start + size);
 	WARN_ON_ONCE(ret);
 
-- 
2.21.0

