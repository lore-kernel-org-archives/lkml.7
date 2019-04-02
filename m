Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FF0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0FE2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbfDBSPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:15:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730481AbfDBSPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 14:15:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x32I9ZNH142203
        for <linux-kernel@vger.kernel.org>; Tue, 2 Apr 2019 14:15:18 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rmbn4kw7q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:15:18 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <cclaudio@linux.ibm.com>;
        Tue, 2 Apr 2019 19:15:17 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Apr 2019 19:15:12 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x32IFB3I21233804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 18:15:11 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F47E112076;
        Tue,  2 Apr 2019 18:15:11 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40C28112072;
        Tue,  2 Apr 2019 18:15:09 +0000 (GMT)
Received: from rino.br.ibm.com (unknown [9.18.235.111])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Apr 2019 18:15:09 +0000 (GMT)
From:   Claudio Carvalho <cclaudio@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH 1/4] powerpc/include: Override unneeded early ioremap functions
Date:   Tue,  2 Apr 2019 15:15:02 -0300
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402181505.25037-1-cclaudio@linux.ibm.com>
References: <20190402181505.25037-1-cclaudio@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040218-0064-0000-0000-000003C5817E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010862; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183359; UDB=6.00619523; IPR=6.00964108;
 MB=3.00026264; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 18:15:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040218-0065-0000-0000-00003CECEC80
Message-Id: <20190402181505.25037-2-cclaudio@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=856 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_EFI is enabled, the EFI driver includes the generic
early_ioremap header, which assumes that architectures may want to
provide their own early ioremap functions.

This patch overrides the ioremap functions in powerpc because they are
not required for secure boot on powerpc systems.

Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
---
 arch/powerpc/include/asm/early_ioremap.h | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 arch/powerpc/include/asm/early_ioremap.h

diff --git a/arch/powerpc/include/asm/early_ioremap.h b/arch/powerpc/include/asm/early_ioremap.h
new file mode 100644
index 000000000000..a86a06e9f3b9
--- /dev/null
+++ b/arch/powerpc/include/asm/early_ioremap.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Early ioremap definitions
+ *
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Claudio Carvalho <cclaudio@linux.ibm.com>
+ *
+ */
+#ifndef _ASM_POWERPC_EARLY_IOREMAP_H
+#define _ASM_POWERPC_EARLY_IOREMAP_H
+
+static inline void __iomem *early_ioremap(resource_size_t phys_addr,
+					  unsigned long size)
+{
+	return NULL;
+}
+
+static inline void *early_memremap(resource_size_t phys_addr,
+				   unsigned long size)
+{
+	return NULL;
+}
+
+static inline void *early_memremap_ro(resource_size_t phys_addr,
+				      unsigned long size)
+{
+	return NULL;
+}
+
+static inline void *early_memremap_prot(resource_size_t phys_addr,
+					unsigned long size,
+					unsigned long prot_val)
+{
+	return NULL;
+}
+
+static inline void early_iounmap(void __iomem *addr, unsigned long size) { }
+static inline void early_memunmap(void *addr, unsigned long size) { }
+static inline void early_ioremap_shutdown(void) { }
+
+#endif
-- 
2.20.1

