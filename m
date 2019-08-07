Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3854C31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DC3205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfHGBiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:38:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729380AbfHGBiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:38:02 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x771aqBb082922;
        Tue, 6 Aug 2019 21:37:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u7h71y7up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 21:37:41 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x771beMp085009;
        Tue, 6 Aug 2019 21:37:40 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u7h71y7u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 21:37:40 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x771Z6dc000311;
        Wed, 7 Aug 2019 01:37:39 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03wdc.us.ibm.com with ESMTP id 2u51w636ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 01:37:39 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x771bcFS54854100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Aug 2019 01:37:38 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2E28AC059;
        Wed,  7 Aug 2019 01:37:38 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BDC6AC05E;
        Wed,  7 Aug 2019 01:37:36 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.167.225])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed,  7 Aug 2019 01:37:36 +0000 (GMT)
References: <20190806052237.12525-1-bauerman@linux.ibm.com> <20190806052237.12525-14-bauerman@linux.ibm.com> <20190806054841.GA14197@lst.de>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>
Subject: Re: [PATCH v3 13/16] powerpc/pseries/iommu: Don't use dma_iommu_ops on secure guests
In-reply-to: <20190806054841.GA14197@lst.de>
Date:   Tue, 06 Aug 2019 22:37:34 -0300
Message-ID: <87k1bpzrfl.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=945 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Christoph,

Thanks for your review.

Christoph Hellwig <hch@lst.de> writes:

> On Tue, Aug 06, 2019 at 02:22:34AM -0300, Thiago Jung Bauermann wrote:
>> @@ -1318,7 +1319,10 @@ void iommu_init_early_pSeries(void)
>>  	of_reconfig_notifier_register(&iommu_reconfig_nb);
>>  	register_memory_notifier(&iommu_mem_nb);
>>  
>> -	set_pci_dma_ops(&dma_iommu_ops);
>> +	if (is_secure_guest())
>> +		set_pci_dma_ops(NULL);
>> +	else
>> +		set_pci_dma_ops(&dma_iommu_ops);
>
> Shoudn't:
>
> 	if (!is_secure_guest())
> 		set_pci_dma_ops(&dma_iommu_ops);
>
> be enough here, given that NULL is the default?

Indeed, it is enough.

> Also either way I think this conditional needs a comment explaining
> why it is there.

Good point. I added the commit message as a comment in the code.
New version of this patch below.


From 5dc3914efa4765eef2869d554d4ea1c676bb1e75 Mon Sep 17 00:00:00 2001
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Thu, 24 Jan 2019 22:40:16 -0200
Subject: [PATCH] powerpc/pseries/iommu: Don't use dma_iommu_ops on secure
 guests

Secure guest memory is inacessible to devices so regular DMA isn't
possible.

In that case set devices' dma_map_ops to NULL so that the generic
DMA code path will use SWIOTLB to bounce buffers for DMA.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 889dc2e44b89..8d9c2b17ad54 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -36,6 +36,7 @@
 #include <asm/udbg.h>
 #include <asm/mmzone.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/svm.h>
 
 #include "pseries.h"
 
@@ -1318,7 +1319,15 @@ void iommu_init_early_pSeries(void)
 	of_reconfig_notifier_register(&iommu_reconfig_nb);
 	register_memory_notifier(&iommu_mem_nb);
 
-	set_pci_dma_ops(&dma_iommu_ops);
+	/*
+	 * Secure guest memory is inacessible to devices so regular DMA isn't
+	 * possible.
+	 *
+	 * In that case keep devices' dma_map_ops as NULL so that the generic
+	 * DMA code path will use SWIOTLB to bounce buffers for DMA.
+	 */
+	if (!is_secure_guest())
+		set_pci_dma_ops(&dma_iommu_ops);
 }
 
 static int __init disable_multitce(char *str)
