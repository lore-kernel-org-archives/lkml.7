Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F12C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC0B25E9B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559192098;
	bh=WDK5eOGnzlU+rY7LHnbKwB3mxhm5pC32ymVzPXusi+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ALe7afURyJ4Q8dKR2+yj+vd/dGg+5ygHYoosRrG3nAzpAW4gTvgPGL5JOegh6DX8M
	 AusscMQf/Z9pQYdkXiqPgS/BVaOiu0UPBi5AYYmK8c6r6+5GlDIqx1NC4wuHNDKqol
	 KrC8tVMh4xEAXrexJevOh2Tz/wwpXjfVk14xQOsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389141AbfE3Ey5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbfE3DKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:10:19 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D6E244BF;
        Thu, 30 May 2019 03:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185818;
        bh=WDK5eOGnzlU+rY7LHnbKwB3mxhm5pC32ymVzPXusi+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eN4xqeZeJpofABdgjmKUA+nHvY9WJAxXkotEelUNL/zVuvETZ5qEd1XBFT/+YKJ7g
         BixykcjFCV3bD2BQGSHPXIP0fUPqLP9kzrCBTM1+YumUWQMP+PDmUnqX5NELvtLfFE
         pEhrA4Zl0e3S+HtP1vjM2zH1mB/rQGllE22VjEXQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 113/405] net: hns3: use atomic_t replace u32 for arqs count
Date:   Wed, 29 May 2019 20:01:51 -0700
Message-Id: <20190530030546.721646057@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 30780a8b1677e7409b32ae52a9a84f7d41ae6b43 ]

Since irq handler and mailbox task will both update arq's count,
so arq's count should use atomic_t instead of u32, otherwise
its value may go wrong finally.

Fixes: 07a0556a3a73 ("net: hns3: Changes to support ARQ(Asynchronous Receive Queue)")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h          | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c | 7 ++++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
index 299b277bc7ae9..589b7ee32bff8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
@@ -107,7 +107,7 @@ struct hclgevf_mbx_arq_ring {
 	struct hclgevf_dev *hdev;
 	u32 head;
 	u32 tail;
-	u32 count;
+	atomic_t count;
 	u16 msg_q[HCLGE_MBX_MAX_ARQ_MSG_NUM][HCLGE_MBX_MAX_ARQ_MSG_SIZE];
 };
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
index 9441b453d38df..9a0a501908aec 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
@@ -327,7 +327,7 @@ int hclgevf_cmd_init(struct hclgevf_dev *hdev)
 	hdev->arq.hdev = hdev;
 	hdev->arq.head = 0;
 	hdev->arq.tail = 0;
-	hdev->arq.count = 0;
+	atomic_set(&hdev->arq.count, 0);
 	hdev->hw.cmq.csq.next_to_clean = 0;
 	hdev->hw.cmq.csq.next_to_use = 0;
 	hdev->hw.cmq.crq.next_to_clean = 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index 7dc3c9f79169f..4f2c77283cb43 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -208,7 +208,8 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 			/* we will drop the async msg if we find ARQ as full
 			 * and continue with next message
 			 */
-			if (hdev->arq.count >= HCLGE_MBX_MAX_ARQ_MSG_NUM) {
+			if (atomic_read(&hdev->arq.count) >=
+			    HCLGE_MBX_MAX_ARQ_MSG_NUM) {
 				dev_warn(&hdev->pdev->dev,
 					 "Async Q full, dropping msg(%d)\n",
 					 req->msg[1]);
@@ -220,7 +221,7 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 			memcpy(&msg_q[0], req->msg,
 			       HCLGE_MBX_MAX_ARQ_MSG_SIZE * sizeof(u16));
 			hclge_mbx_tail_ptr_move_arq(hdev->arq);
-			hdev->arq.count++;
+			atomic_inc(&hdev->arq.count);
 
 			hclgevf_mbx_task_schedule(hdev);
 
@@ -308,7 +309,7 @@ void hclgevf_mbx_async_handler(struct hclgevf_dev *hdev)
 		}
 
 		hclge_mbx_head_ptr_move_arq(hdev->arq);
-		hdev->arq.count--;
+		atomic_dec(&hdev->arq.count);
 		msg_q = hdev->arq.msg_q[hdev->arq.head];
 	}
 }
-- 
2.20.1



