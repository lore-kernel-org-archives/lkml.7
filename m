Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7B7C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD28B222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573609977;
	bh=HpJfRrDSSyuLg2DrJFpzk2sKf7uuJaSUC8TTp4L+rU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cVrNcZCdooQrRjAmDm2BRFXdThfsnyyVtQzHXslYG/gPhZlYN6eGipUb8MXZnAsVo
	 YugKhdBkRkFo56vZTuf45C/+Ziu8RZTiHqM1k26JROle6vH3aJFvoouZRryddE/27+
	 QKKEwUGBgsmEbbV32sI/L1Ga3aqLu6QgdOe53NaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfKMBw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:52:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbfKMBwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:52:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C393C222CA;
        Wed, 13 Nov 2019 01:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609963;
        bh=HpJfRrDSSyuLg2DrJFpzk2sKf7uuJaSUC8TTp4L+rU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1wYsRJj5LB+Co2fsa5VjjTuLYtkO/N2VDdarEwXBI7fB6msYjx/MbXTFmhtUVA++e
         DNphrX/+fXdY6fWCYf94yU+HBV7OjcpP4BBwffK0DlBWbP/R1gxm8Qj7mPSngpsL3r
         X1ti46jrbU1UvgTLRyZeu8NsOdqeyj/ADs4SgiMQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 094/209] bnxt_en: return proper error when FW returns HWRM_ERR_CODE_RESOURCE_ACCESS_DENIED
Date:   Tue, 12 Nov 2019 20:48:30 -0500
Message-Id: <20191113015025.9685-94-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

[ Upstream commit 3a1d52a54a6a4030b294e5f5732f0bfbae0e3815 ]

Return proper error code when Firmware returns
HWRM_ERR_CODE_RESOURCE_ACCESS_DENIED for HWRM_NVM_GET/SET_VARIABLE
commands.

Cc: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 790c684f08abc..b178c2e9dc231 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -78,8 +78,12 @@ static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
 		memcpy(buf, data_addr, bytesize);
 
 	dma_free_coherent(&bp->pdev->dev, bytesize, data_addr, data_dma_addr);
-	if (rc)
+	if (rc == HWRM_ERR_CODE_RESOURCE_ACCESS_DENIED) {
+		netdev_err(bp->dev, "PF does not have admin privileges to modify NVM config\n");
+		return -EACCES;
+	} else if (rc) {
 		return -EIO;
+	}
 	return 0;
 }
 
-- 
2.20.1

