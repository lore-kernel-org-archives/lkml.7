Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3E5C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 04:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304B9208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 04:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfHOEMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 00:12:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725681AbfHOEMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 00:12:37 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7F4CBDp042078
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 00:12:36 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ucxt9jb8b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 00:12:35 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Thu, 15 Aug 2019 05:12:34 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 15 Aug 2019 05:12:30 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7F4CTtR33357896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 04:12:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E831A405C;
        Thu, 15 Aug 2019 04:12:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D619A405F;
        Thu, 15 Aug 2019 04:12:29 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 15 Aug 2019 04:12:29 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 1E58BA03BC;
        Thu, 15 Aug 2019 14:12:28 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Qian Cai <cai@lca.pw>, Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] powerpc: Chunk calls to flush_dcache_range in arch_*_memory
Date:   Thu, 15 Aug 2019 14:10:49 +1000
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815041057.13627-1-alastair@au1.ibm.com>
References: <20190815041057.13627-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19081504-0008-0000-0000-000003094922
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081504-0009-0000-0000-00004A27618B
Message-Id: <20190815041057.13627-5-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

When presented with large amounts of memory being hotplugged
(in my test case, ~890GB), the call to flush_dcache_range takes
a while (~50 seconds), triggering RCU stalls.

This patch breaks up the call into 16GB chunks, calling
cond_resched() inbetween to allow the scheduler to run.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/mm/mem.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 5400da87a804..fb0d5e9aa11b 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -104,11 +104,14 @@ int __weak remove_section_mapping(unsigned long start, unsigned long end)
 	return -ENODEV;
 }
 
+#define FLUSH_CHUNK_SIZE (16ull * 1024ull * 1024ull * 1024ull)
+
 int __ref arch_add_memory(int nid, u64 start, u64 size,
 			struct mhp_restrictions *restrictions)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
+	unsigned long i;
 	int rc;
 
 	resize_hpt_for_hotplug(memblock_phys_mem_size());
@@ -120,7 +123,11 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
 			start, start + size, rc);
 		return -EFAULT;
 	}
-	flush_dcache_range(start, start + size);
+
+	for (i = 0; i < size; i += FLUSH_CHUNK_SIZE) {
+		flush_dcache_range(start + i, min(start + size, start + i + FLUSH_CHUNK_SIZE));
+		cond_resched();
+	}
 
 	return __add_pages(nid, start_pfn, nr_pages, restrictions);
 }
@@ -131,13 +138,18 @@ void __ref arch_remove_memory(int nid, u64 start, u64 size,
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	struct page *page = pfn_to_page(start_pfn) + vmem_altmap_offset(altmap);
+	unsigned long i;
 	int ret;
 
 	__remove_pages(page_zone(page), start_pfn, nr_pages, altmap);
 
 	/* Remove htab bolted mappings for this section of memory */
 	start = (unsigned long)__va(start);
-	flush_dcache_range(start, start + size);
+	for (i = 0; i < size; i += FLUSH_CHUNK_SIZE) {
+		flush_dcache_range(start + i, min(start + size, start + i + FLUSH_CHUNK_SIZE));
+		cond_resched();
+	}
+
 	ret = remove_section_mapping(start, start + size);
 	WARN_ON_ONCE(ret);
 
-- 
2.21.0

