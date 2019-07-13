Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4B7C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 06:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D2B204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 06:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfGMGDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 02:03:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727580AbfGMGDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 02:03:41 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6D5w7nM100673;
        Sat, 13 Jul 2019 02:01:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tq9m9r2um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Jul 2019 02:01:23 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6D5wtYx101629;
        Sat, 13 Jul 2019 02:01:23 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tq9m9r2u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Jul 2019 02:01:23 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6D608rm007644;
        Sat, 13 Jul 2019 06:01:22 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 2tq6x60t7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Jul 2019 06:01:22 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6D61KWK52494680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Jul 2019 06:01:20 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C983EC6059;
        Sat, 13 Jul 2019 06:01:20 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5C94C6055;
        Sat, 13 Jul 2019 06:01:17 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.135.203])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 13 Jul 2019 06:01:17 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v2 12/13] powerpc/pseries/svm: Force SWIOTLB for secure guests
Date:   Sat, 13 Jul 2019 03:00:22 -0300
Message-Id: <20190713060023.8479-13-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190713060023.8479-1-bauerman@linux.ibm.com>
References: <20190713060023.8479-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-13_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907130070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

SWIOTLB checks range of incoming CPU addresses to be bounced and sees if
the device can access it through its DMA window without requiring bouncing.
In such cases it just chooses to skip bouncing. But for cases like secure
guests on powerpc platform all addresses need to be bounced into the shared
pool of memory because the host cannot access it otherwise. Hence the need
to do the bouncing is not related to device's DMA window and use of bounce
buffers is forced by setting swiotlb_force.

Also, connect the shared memory conversion functions into the
ARCH_HAS_MEM_ENCRYPT hooks and call swiotlb_update_mem_attributes() to
convert SWIOTLB's memory pool to shared memory.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
[ bauerman: Use ARCH_HAS_MEM_ENCRYPT hooks to share swiotlb memory pool. ]
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/mem_encrypt.h | 26 +++++++++++++++
 arch/powerpc/platforms/pseries/Kconfig |  3 ++
 arch/powerpc/platforms/pseries/svm.c   | 45 ++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/arch/powerpc/include/asm/mem_encrypt.h b/arch/powerpc/include/asm/mem_encrypt.h
new file mode 100644
index 000000000000..d8d5a7fcf298
--- /dev/null
+++ b/arch/powerpc/include/asm/mem_encrypt.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SVM helper functions
+ *
+ * Copyright 2019 IBM Corporation
+ */
+
+#ifndef _ASM_POWERPC_MEM_ENCRYPT_H
+#define _ASM_POWERPC_MEM_ENCRYPT_H
+
+#include <asm/svm.h>
+
+static inline bool mem_encrypt_active(void)
+{
+	return is_secure_guest();
+}
+
+static inline bool force_dma_unencrypted(struct device *dev)
+{
+	return is_secure_guest();
+}
+
+int set_memory_encrypted(unsigned long addr, int numpages);
+int set_memory_decrypted(unsigned long addr, int numpages);
+
+#endif /* _ASM_POWERPC_MEM_ENCRYPT_H */
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index d09deb05bb66..9e35cddddf73 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -149,6 +149,9 @@ config PAPR_SCM
 config PPC_SVM
 	bool "Secure virtual machine (SVM) support for POWER"
 	depends on PPC_PSERIES
+	select SWIOTLB
+	select ARCH_HAS_MEM_ENCRYPT
+	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	help
 	 There are certain POWER platforms which support secure guests using
 	 the Protected Execution Facility, with the help of an Ultravisor
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index c508196f7c83..618622d636d5 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -7,8 +7,53 @@
  */
 
 #include <linux/mm.h>
+#include <asm/machdep.h>
+#include <asm/svm.h>
+#include <asm/swiotlb.h>
 #include <asm/ultravisor.h>
 
+static int __init init_svm(void)
+{
+	if (!is_secure_guest())
+		return 0;
+
+	/* Don't release the SWIOTLB buffer. */
+	ppc_swiotlb_enable = 1;
+
+	/*
+	 * Since the guest memory is inaccessible to the host, devices always
+	 * need to use the SWIOTLB buffer for DMA even if dma_capable() says
+	 * otherwise.
+	 */
+	swiotlb_force = SWIOTLB_FORCE;
+
+	/* Share the SWIOTLB buffer with the host. */
+	swiotlb_update_mem_attributes();
+
+	return 0;
+}
+machine_early_initcall(pseries, init_svm);
+
+int set_memory_encrypted(unsigned long addr, int numpages)
+{
+	if (!PAGE_ALIGNED(addr))
+		return -EINVAL;
+
+	uv_unshare_page(PHYS_PFN(__pa(addr)), numpages);
+
+	return 0;
+}
+
+int set_memory_decrypted(unsigned long addr, int numpages)
+{
+	if (!PAGE_ALIGNED(addr))
+		return -EINVAL;
+
+	uv_share_page(PHYS_PFN(__pa(addr)), numpages);
+
+	return 0;
+}
+
 /* There's one dispatch log per CPU. */
 #define NR_DTL_PAGE (DISPATCH_LOG_BYTES * CONFIG_NR_CPUS / PAGE_SIZE)
 
