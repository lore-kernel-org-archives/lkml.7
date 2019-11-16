Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97114C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EEA214DE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921183;
	bh=T93k57TIsenFOGGX58LNq3dynzwqIM/Y3j3qkoXDZw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zln7u+uLgnkbPpiK2z3a9NW4TlD929hiaIbTcVr2LD7ylqZixb90nsw0TVDFmgqva
	 GOIljR1Vwr7qU0E6z7eE6epBsCXsyBvQN/8CO26e6TOSWbzqzOYHfwkm10y/rINT2s
	 HtMuhCPS9gLLSQVc7WbH13iayuUR6XhrYH+1EpSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfKPQTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:19:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729267AbfKPPp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:45:59 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B4762077B;
        Sat, 16 Nov 2019 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919158;
        bh=T93k57TIsenFOGGX58LNq3dynzwqIM/Y3j3qkoXDZw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDacVGEKW2bE1GynioaYrgaxcUiMcjHWOM3bLxFXnOuaq84u5cxtp9/3YmgD1fy72
         uGVZwKC3tqv2qej+RKEnaRYeqYIv37+0DP3Bz6knyu0ayrFTMnSEk/dBoK+P2JI4jO
         0SOgraUPRm2rhGNG38fVnq354oJTWfkbe07jBhaQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huazhong Tan <tanhuazhong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 169/237] net: hns3: bugfix for reporting unknown vector0 interrupt repeatly problem
Date:   Sat, 16 Nov 2019 10:40:04 -0500
Message-Id: <20191116154113.7417-169-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit 0d4411408a7fb9aad0645f23911d9bfdd2ce3177 ]

The current driver supports handling two vector0 interrupts, reset and
mailbox. When the hardware reports an interrupt of another type of
interrupt source, if the driver does not process the interrupt, but
enables the interrupt, the hardware will repeatedly report the unknown
interrupt.

Therefore, the driver enables the vector0 interrupt after clearing the
known type of interrupt source. Other conditions are not enabled.

Fixes: cd8c5c269b1d ("net: hns3: Fix for hclge_reset running repeatly problem")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 89ca69fa2b97b..0b622d20cd305 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2574,7 +2574,7 @@ static irqreturn_t hclge_misc_irq_handle(int irq, void *data)
 	}
 
 	/* clear the source of interrupt if it is not cause by reset */
-	if (event_cause != HCLGE_VECTOR0_EVENT_RST) {
+	if (event_cause == HCLGE_VECTOR0_EVENT_MBX) {
 		hclge_clear_event_cause(hdev, event_cause, clearval);
 		hclge_enable_vector(&hdev->misc_vector, true);
 	}
-- 
2.20.1

