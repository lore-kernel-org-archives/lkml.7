Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5C2C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47710205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012624;
	bh=RYreaePGYqn6h48jEO9OXHRhf140s7bUrNjGzY8Q2NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w7IP9EXX8h6E/G2XT0ObuzxeyUpJmc7RU7M5T819QqAu8DrdOHzt9udqjYxXWL3LJ
	 Tx2d8K5f5m2AnvncpUcke2Eho60XxFhgWNRGHSGxu+Whs9Ou2cwH6WjgwrZa9lGzgo
	 2A4L5JUC0nlMPdCPm5NCl1Pcs6oV+Jbs49k3xl2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfLJVRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:17:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbfLJVNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:13:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3829520828;
        Tue, 10 Dec 2019 21:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012385;
        bh=RYreaePGYqn6h48jEO9OXHRhf140s7bUrNjGzY8Q2NA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZwiNrQV8BzJKYWLqujm9EZxQJXH7sb2oHLk51ggCp3OYbKpGSF9ZTBmSG2/ZHpR+
         bH0LYuRsk1jGke4g6y7fym0i6yyty3O89ixK2uZ7gNdeX3h5e2k1locdaTHfHKGHG0
         kAcH1maz5MX4minhPETE00bnR1qPAKTSI6YtNceI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 308/350] bnxt_en: Return proper error code for non-existent NVM variable
Date:   Tue, 10 Dec 2019 16:06:53 -0500
Message-Id: <20191210210735.9077-269-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

[ Upstream commit 05069dd4c577f9b143dfd243d55834333c4470c5 ]

For NVM params that are not supported in the current NVM
configuration, return the error as -EOPNOTSUPP.

Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 7151244f8c7d2..7d2cfea05737a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -311,10 +311,17 @@ static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
 	} else {
 		rc = hwrm_send_message_silent(bp, msg, msg_len,
 					      HWRM_CMD_TIMEOUT);
-		if (!rc)
+		if (!rc) {
 			bnxt_copy_from_nvm_data(val, data,
 						nvm_param.nvm_num_bits,
 						nvm_param.dl_num_bytes);
+		} else {
+			struct hwrm_err_output *resp = bp->hwrm_cmd_resp_addr;
+
+			if (resp->cmd_err ==
+				NVM_GET_VARIABLE_CMD_ERR_CODE_VAR_NOT_EXIST)
+				rc = -EOPNOTSUPP;
+		}
 	}
 	dma_free_coherent(&bp->pdev->dev, sizeof(*data), data, data_dma_addr);
 	if (rc == -EACCES)
-- 
2.20.1

