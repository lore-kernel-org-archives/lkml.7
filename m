Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD20FC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE1620643
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgAHOJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:09:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9136 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbgAHOJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:09:50 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C4BAABD800286D2C95C4;
        Wed,  8 Jan 2020 22:09:47 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 8 Jan 2020
 22:09:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <doshir@vmware.com>, <pv-drivers@vmware.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        yuehaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] vmxnet3: Remove always false conditional statement
Date:   Wed, 8 Jan 2020 22:08:22 +0800
Message-ID: <20200108140822.47016-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuehaibing <yuehaibing@huawei.com>

param->rx_mini_pending is __u32 variable, it will never
be less than zero.

Signed-off-by: yuehaibing <yuehaibing@huawei.com>
---
 drivers/net/vmxnet3/vmxnet3_ethtool.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethtool.c b/drivers/net/vmxnet3/vmxnet3_ethtool.c
index 0a38c76..1e4b9ba 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethtool.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethtool.c
@@ -555,10 +555,8 @@ vmxnet3_set_ringparam(struct net_device *netdev,
 	}
 
 	if (VMXNET3_VERSION_GE_3(adapter)) {
-		if (param->rx_mini_pending < 0 ||
-		    param->rx_mini_pending > VMXNET3_RXDATA_DESC_MAX_SIZE) {
+		if (param->rx_mini_pending > VMXNET3_RXDATA_DESC_MAX_SIZE)
 			return -EINVAL;
-		}
 	} else if (param->rx_mini_pending != 0) {
 		return -EINVAL;
 	}
-- 
2.7.4


