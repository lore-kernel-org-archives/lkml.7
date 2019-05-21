Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39F7C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30BC21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfEUEx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:53:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727931AbfEUExw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:53:52 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L4qs8O082135
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:53:51 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sma1g1540-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:53:51 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 21 May 2019 05:53:51 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 May 2019 05:53:48 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4L4rlZH10682868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 04:53:47 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DB6FC6057;
        Tue, 21 May 2019 04:53:47 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6320C605A;
        Tue, 21 May 2019 04:53:29 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.80.203.157])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 21 May 2019 04:53:29 +0000 (GMT)
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
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH 10/12] powerpc/pseries/iommu: Don't use dma_iommu_ops on secure guests
Date:   Tue, 21 May 2019 01:49:10 -0300
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521044912.1375-1-bauerman@linux.ibm.com>
References: <20190521044912.1375-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052104-0036-0000-0000-00000AC00A2D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011134; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01206343; UDB=6.00633450; IPR=6.00987311;
 MB=3.00026980; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-21 04:53:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052104-0037-0000-0000-00004BE14B58
Message-Id: <20190521044912.1375-11-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=553 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Secure guest memory is inacessible to devices so regular DMA isn't
possible.

In that case set devices' dma_map_ops to NULL so that the generic
DMA code path will use SWIOTLB and DMA to bounce buffers.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 03bbb299320e..7d9550edb700 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -50,6 +50,7 @@
 #include <asm/udbg.h>
 #include <asm/mmzone.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/svm.h>
 
 #include "pseries.h"
 
@@ -1332,7 +1333,10 @@ void iommu_init_early_pSeries(void)
 	of_reconfig_notifier_register(&iommu_reconfig_nb);
 	register_memory_notifier(&iommu_mem_nb);
 
-	set_pci_dma_ops(&dma_iommu_ops);
+	if (is_secure_guest())
+		set_pci_dma_ops(NULL);
+	else
+		set_pci_dma_ops(&dma_iommu_ops);
 }
 
 static int __init disable_multitce(char *str)

