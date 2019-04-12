Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B49C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972F82171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3Om5tuL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfDLLhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:37:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52204 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfDLLhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:37:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3CBXaUq064783;
        Fri, 12 Apr 2019 11:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=lvEATiOX/reCATWgKO5W5Jr5NeYIp6H11K9cRiCr+oc=;
 b=3Om5tuL+sXrbgrKgaPqX5oCSInll/0qfQCtJBKp9/VudEH16zU6toERWfGWlILXyN/ne
 7ZcfiHo6Ye/QP6IrzAImgBnXGwZd4rvStdStGiqUoGwA6tiu4ZYIt0WmUDPg9MMc1Akz
 tq4aU6bUYD1J4SFTKCQxDPixnxsHc0uMSlK3qA/PTbM9SWOvcn0EZgWRd2zcIEEdVAUJ
 9wz9+qVJSQ2Mc1TldhDdo6ij/sTnoVuN6/pLlTX3dDqaNIcweEDhf2R2ql4VKxqlex2m
 p10FZ4eJlHiEgFoUt+R1cRLfnD3JXxl4ShJzfjcs820cdyvO9Xkjt1upuXUgfEqDPEdA kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2rphmex51t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 11:36:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3CBY2Ac142174;
        Fri, 12 Apr 2019 11:34:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2rtd84g8yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 11:34:47 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3CBYhJD011836;
        Fri, 12 Apr 2019 11:34:44 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Apr 2019 04:34:43 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     iommu@lists.linux-foundation.org, konrad.wilk@oracle.com
Cc:     linux-kernel@vger.kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joe.jin@oracle.com, haakon.bugge@oracle.com,
        dongli.zhang@oracle.com
Subject: [PATCH 1/1] swiotlb: save io_tlb_used to local variable before leaving critical section
Date:   Fri, 12 Apr 2019 19:38:26 +0800
Message-Id: <1555069106-2964-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904120076
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904120076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When swiotlb is full, the kernel would print io_tlb_used. However, the
result might be inaccurate at that time because we have left the critical
section protected by spinlock.

Therefore, we backup the io_tlb_used into local variable before leaving
critical section.

Fixes: 83ca25948940 ("swiotlb: dump used and total slots when swiotlb buffer is full")
Suggested-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 kernel/dma/swiotlb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 857e823..6f7619c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -452,6 +452,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	unsigned long mask;
 	unsigned long offset_slots;
 	unsigned long max_slots;
+	unsigned long tmp_io_tlb_used;
 
 	if (no_iotlb_memory)
 		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
@@ -538,10 +539,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	} while (index != wrap);
 
 not_found:
+	tmp_io_tlb_used = io_tlb_used;
+
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
-		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu, used %lu\n",
-			 size, io_tlb_nslabs, io_tlb_used);
+		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
+			 size, io_tlb_nslabs, tmp_io_tlb_used);
 	return DMA_MAPPING_ERROR;
 found:
 	io_tlb_used += nslots;
-- 
2.7.4

