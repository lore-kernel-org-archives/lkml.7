Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90466C32771
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 02:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5C2217F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 02:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgADCtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 21:49:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbgADCtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 21:49:39 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 914983BC149815AC4723;
        Sat,  4 Jan 2020 10:49:37 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Sat, 4 Jan 2020 10:49:28 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 8/8] net: hns3: modify an unsuitable reset level for hardware error
Date:   Sat, 4 Jan 2020 10:49:31 +0800
Message-ID: <1578106171-17238-9-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578106171-17238-1-git-send-email-tanhuazhong@huawei.com>
References: <1578106171-17238-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to hardware user manual, when hardware reports error
'roc_pkt_without_key_port', the driver should assert function
reset to do the recovery.

So this patch uses HNAE3_FUNC_RESET to replace HNAE3_GLOBAL_RESET.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index dc66b4e..f8127d7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -505,7 +505,7 @@ static const struct hclge_hw_error hclge_ssu_mem_ecc_err_int[] = {
 
 static const struct hclge_hw_error hclge_ssu_port_based_err_int[] = {
 	{ .int_msk = BIT(0), .msg = "roc_pkt_without_key_port",
-	  .reset_level = HNAE3_GLOBAL_RESET },
+	  .reset_level = HNAE3_FUNC_RESET },
 	{ .int_msk = BIT(1), .msg = "tpu_pkt_without_key_port",
 	  .reset_level = HNAE3_GLOBAL_RESET },
 	{ .int_msk = BIT(2), .msg = "igu_pkt_without_key_port",
@@ -599,7 +599,7 @@ static const struct hclge_hw_error hclge_ssu_ets_tcg_int[] = {
 
 static const struct hclge_hw_error hclge_ssu_port_based_pf_int[] = {
 	{ .int_msk = BIT(0), .msg = "roc_pkt_without_key_port",
-	  .reset_level = HNAE3_GLOBAL_RESET },
+	  .reset_level = HNAE3_FUNC_RESET },
 	{ .int_msk = BIT(9), .msg = "low_water_line_err_port",
 	  .reset_level = HNAE3_NONE_RESET },
 	{ .int_msk = BIT(10), .msg = "hi_water_line_err_port",
-- 
2.7.4

