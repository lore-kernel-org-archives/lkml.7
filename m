Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6B4C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34A020835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394402AbfIWMfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:35:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393992AbfIWMfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:35:10 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8NCRP0b147402
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 08:35:09 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v6wmv1bwu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 08:35:08 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 23 Sep 2019 13:35:07 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Sep 2019 13:35:04 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8NCZ2GZ52625646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 12:35:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9279511C04C;
        Mon, 23 Sep 2019 12:35:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CE4A11C054;
        Mon, 23 Sep 2019 12:35:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Sep 2019 12:35:02 +0000 (GMT)
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [RFC PATCH 1/3] dma-mapping: make overriding GFP_* flags arch customizable
Date:   Mon, 23 Sep 2019 14:34:16 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923123418.22695-1-pasic@linux.ibm.com>
References: <20190923123418.22695-1-pasic@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19092312-4275-0000-0000-0000036A0B33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092312-4276-0000-0000-0000387C7F65
Message-Id: <20190923123418.22695-2-pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909230124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit 57bf5a8963f8 ("dma-mapping: clear harmful GFP_* flags in
common code") tweaking the client code supplied GFP_* flags used to be
an issue handled in the architecture specific code. The commit message
suggests, that fixing the client code would actually be a better way
of dealing with this.

On s390 common I/O devices are generally capable of using the full 64
bit address space for DMA I/O, but some chunks of the DMA memory need to
be 31 bit addressable (in physical address space) because the
instructions involved mandate it. Before switching to DMA API this used
to be a non-issue, we used to allocate those chunks from ZONE_DMA.
Currently our only option with the DMA API is to restrict the devices to
(via dma_mask and dma_mask_coherent) to 31 bit, which is sub-optimal.

Thus s390 we would benefit form having control over what flags are
dropped.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 include/linux/dma-mapping.h | 10 ++++++++++
 kernel/dma/Kconfig          |  6 ++++++
 kernel/dma/mapping.c        |  4 +---
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4a1c4fca475a..5024bc863fa7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -817,4 +817,14 @@ static inline int dma_mmap_wc(struct device *dev,
 #define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
 #endif
 
+#ifdef CONFIG_ARCH_HAS_DMA_OVERRIDE_GFP_FLAGS
+extern gfp_t dma_override_gfp_flags(struct device *dev, gfp_t flags);
+#else
+static inline gfp_t dma_override_gfp_flags(struct device *dev, gfp_t flags)
+{
+	/* let the implementation decide on the zone to allocate from: */
+	return flags & ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
+}
+#endif
+
 #endif
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 73c5c2b8e824..4756c75047e3 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -54,6 +54,12 @@ config ARCH_HAS_DMA_PREP_COHERENT
 config ARCH_HAS_DMA_COHERENT_TO_PFN
 	bool
 
+config ARCH_HAS_DMA_MMAP_PGPROT
+	bool
+
+config ARCH_HAS_DMA_OVERRIDE_GFP_FLAGS
+	bool
+
 config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	bool
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index d9334f31a5af..535b809548e2 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -303,9 +303,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
 		return cpu_addr;
 
-	/* let the implementation decide on the zone to allocate from: */
-	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
-
+	flag = dma_override_gfp_flags(dev, flag);
 	if (dma_is_direct(ops))
 		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
 	else if (ops->alloc)
-- 
2.17.1

