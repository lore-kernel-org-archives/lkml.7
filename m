Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B414C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371A4205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054462;
	bh=qaolnFThAXRJh7xb80Fx8IN+cYUOpdIQLpeqRO5twEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wh9odTgHsF6E/S3Zo8R2o1ubjpUC4I8GYQFfSrXWuXrS+Nsof5To/tmuJX2h+u32r
	 GxWOx1R5hpdUb+Q108/MetsAqixjWB9IVd6wVYRQA0xixd93BAZB804pCYSpT16zsn
	 +KFqMWDad3PUbjVGPBMp2sdmbrwj9/X7uINRq/94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfFTSOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729426AbfFTSOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:14:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91857205F4;
        Thu, 20 Jun 2019 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054458;
        bh=qaolnFThAXRJh7xb80Fx8IN+cYUOpdIQLpeqRO5twEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mipC7RZ7lqNgX6Zm6YC7Xh9fG0Fh3Xa7w5h2it3OClf2G1I4eegqNXS2cqLU8fyQM
         gBxK9CD+fsZs4UAfuBQCgEMqMIVrzvaJKRKun0zG63qv2O6VkOd5cejvPZbPq0r2+O
         jnTtN/LoxD3z20aLWlmqsnScjOFpMSasuHxLvw/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 35/98] staging: wilc1000: Fix some double unlock bugs in wilc_wlan_cleanup()
Date:   Thu, 20 Jun 2019 19:57:02 +0200
Message-Id: <20190620174350.685315646@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fea69916360468e364a4988db25a5afa835f3406 ]

If ->hif_read_reg() or ->hif_write_reg() fail then the code unlocks
and keeps executing.  It should just return.

Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/wilc1000/wilc_wlan.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_wlan.c b/drivers/staging/wilc1000/wilc_wlan.c
index c2389695fe20..70b1ab21f8a3 100644
--- a/drivers/staging/wilc1000/wilc_wlan.c
+++ b/drivers/staging/wilc1000/wilc_wlan.c
@@ -1076,13 +1076,17 @@ void wilc_wlan_cleanup(struct net_device *dev)
 	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 
 	ret = wilc->hif_func->hif_read_reg(wilc, WILC_GP_REG_0, &reg);
-	if (!ret)
+	if (!ret) {
 		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+		return;
+	}
 
 	ret = wilc->hif_func->hif_write_reg(wilc, WILC_GP_REG_0,
 					(reg | ABORT_INT));
-	if (!ret)
+	if (!ret) {
 		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+		return;
+	}
 
 	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
 	wilc->hif_func->hif_deinit(NULL);
-- 
2.20.1



