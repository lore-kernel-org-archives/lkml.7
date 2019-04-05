Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CFDC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01058206B7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JQtrxFaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbfDEBLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:11:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43606 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbfDEBLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 21:11:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3518bEq117607;
        Fri, 5 Apr 2019 01:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=CSaQ+vwd/SY4oxO6tdbB1QfPer03uXAwyhMCG3dJPCw=;
 b=JQtrxFaNWoPIOXDc82RKdN1HXxgqrfA70ZU075uKBOiroU7o+oVx4W9g8Y7mY1B0RzrF
 2/UACY1cAlk/0jtrRMW2shTNrqtlmY8w/+tfmtxrTLaG4yAZE51I9OngwUIU3IJJ/iho
 7jis/vVzj4n+8Nj7mtWRzInqDSczpgKFFpaIWlbM8NoutWVvNSO6OCHMDLOluYgpY8Xx
 09hKWipP18WRK2Q4GID/WQmXIukLFX0B1oF091hla6dkW/Vn9Q42hKImTjyPxWLZHzsZ
 +ISMU1/CcAhSQeXAqCuydJMO+XOp2rdsDT9ciFxKa/yDT7qyjrY4e/dmptHIujk77cqm HQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2rhyvtj98j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 01:11:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3519fwl088211;
        Fri, 5 Apr 2019 01:11:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2rm8f6yxph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 01:11:31 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x351BTYW002785;
        Fri, 5 Apr 2019 01:11:29 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Apr 2019 18:11:28 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, konrad.wilk@oracle.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com, joe.jin@oracle.com,
        srinivas.eeda@oracle.com, dongli.zhang@oracle.com
Subject: [PATCH 1/1] swiotlb: dump used and total slots when swiotlb buffer is full
Date:   Fri,  5 Apr 2019 09:15:25 +0800
Message-Id: <1554426925-2431-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=777
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904050007
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=815 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904050007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far the kernel only prints the requested size if swiotlb buffer if full.
It is not possible to know whether it is simply an out of buffer, or it is
because swiotlb cannot allocate buffer with the requested size due to
fragmentation.

As 'io_tlb_used' is available since commit 71602fe6d4e9 ("swiotlb: add
debugfs to track swiotlb buffer usage"), both 'io_tlb_used' and
'io_tlb_nslabs' are printed when swiotlb buffer is full.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 kernel/dma/swiotlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 53012db..3f43b37 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -540,7 +540,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 not_found:
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
-		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
+		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu, used %lu\n",
+			 size, io_tlb_nslabs, io_tlb_used);
 	return DMA_MAPPING_ERROR;
 found:
 	io_tlb_used += nslots;
-- 
2.7.4

