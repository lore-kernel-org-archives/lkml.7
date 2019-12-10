Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6814BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C672053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfLJWKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:10:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728519AbfLJWKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:10:33 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBAM8Aag048555;
        Tue, 10 Dec 2019 17:09:56 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wsu3q16b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 17:09:56 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBAM9rxj078877;
        Tue, 10 Dec 2019 17:09:56 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wsu3q16ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 17:09:56 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBAM58mK007122;
        Tue, 10 Dec 2019 22:09:55 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 2wr3q6fk0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 22:09:54 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBAM9sbL52035866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 22:09:54 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DC02C607D;
        Tue, 10 Dec 2019 22:09:54 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E69DC607B;
        Tue, 10 Dec 2019 22:09:48 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.178.57])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 10 Dec 2019 22:09:47 +0000 (GMT)
References: <1575681159-30356-1-git-send-email-linuxram@us.ibm.com> <1575681159-30356-2-git-send-email-linuxram@us.ibm.com> <1575681159-30356-3-git-send-email-linuxram@us.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Ram Pai <linuxram@us.ibm.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        benh@kernel.crashing.org, david@gibson.dropbear.id.au,
        paulus@ozlabs.org, mdroth@linux.vnet.ibm.com, hch@lst.de,
        andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, mst@redhat.com,
        ram.n.pai@gmail.com, aik@ozlabs.ru, cai@lca.pw, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, leonardo@linux.ibm.com
Subject: Re: [PATCH v5 2/2] powerpc/pseries/iommu: Use dma_iommu_ops for Secure VM.
In-reply-to: <1575681159-30356-3-git-send-email-linuxram@us.ibm.com>
Date:   Tue, 10 Dec 2019 19:09:45 -0300
Message-ID: <87mubzygra.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_07:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 mlxlogscore=671 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Ram,

Ram Pai <linuxram@us.ibm.com> writes:

> Commit edea902c1c1e ("powerpc/pseries/iommu: Don't use dma_iommu_ops on
> 		secure guests")
> disabled dma_iommu_ops path, for secure VMs. Disabling dma_iommu_ops
> path for secure VMs, helped enable dma_direct path.  This enabled
> support for bounce-buffering through SWIOTLB.  However it fails to
> operate when IOMMU is enabled, since I/O pages are not TCE mapped.
>
> Renable dma_iommu_ops path for pseries Secure VMs.  It handles all
> cases including, TCE mapping I/O pages, in the presence of a
> IOMMU.
>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/iommu.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 67b5009..4e27d66 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -36,7 +36,6 @@
>  #include <asm/udbg.h>
>  #include <asm/mmzone.h>
>  #include <asm/plpar_wrappers.h>
> -#include <asm/svm.h>
>  #include <asm/ultravisor.h>
>
>  #include "pseries.h"

You still need to keep <asm/svm.h>, otherwise there won't be a
definition of is_secure_guest() when CONFIG_PPC_SVM=n.

--
Thiago Jung Bauermann
IBM Linux Technology Center
