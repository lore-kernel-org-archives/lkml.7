Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075BBCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51C52083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfJaLXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:23:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726552AbfJaLXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:23:00 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ED3026EA62EC6D320A4D;
        Thu, 31 Oct 2019 19:22:56 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 31 Oct 2019 19:22:49 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        Guojia Liao <liaoguojia@huawei.com>,
        "Huazhong Tan" <tanhuazhong@huawei.com>
Subject: [PATCH net-next 5/9] net: hns3: cleanup a format-truncation warning
Date:   Thu, 31 Oct 2019 19:23:20 +0800
Message-ID: <1572521004-36126-6-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572521004-36126-1-git-send-email-tanhuazhong@huawei.com>
References: <1572521004-36126-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guojia Liao <liaoguojia@huawei.com>

In hns3_nic_init_irq(), when '*_int_idx' has more than 9 digits
and the length of netdev's name is IFNAMSIZ, the total length
of final name will be bigger the HNAE3_INT_NAME_LEN - 1, even
though '*_int_idx' will never have such large value, but the
compiler gives a format-truncation warning for this case.

So this patch just enlarges the length to avoid this warning.

Signed-off-by: Guojia Liao <liaoguojia@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 23478ee..45f5916 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -575,7 +575,8 @@ struct hnae3_ae_algo {
 	const struct pci_device_id *pdev_id_table;
 };
 
-#define HNAE3_INT_NAME_LEN        (IFNAMSIZ + 16)
+#define HNAE3_INT_NAME_EXT_LEN    32	 /* Max extra information length */
+#define HNAE3_INT_NAME_LEN        (IFNAMSIZ + HNAE3_INT_NAME_EXT_LEN)
 #define HNAE3_ITR_COUNTDOWN_START 100
 
 struct hnae3_tc_info {
-- 
2.7.4

