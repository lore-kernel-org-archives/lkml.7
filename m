Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7236EC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D8F20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208967;
	bh=dFbAUPTxZV6FtJ6O1Xc6VM+HTS3OQjDCaQseBTiXcos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H1NQJNIEWdwFWFk9/6h4WVtGSTj5KyHEJNGF6nCBqhMWzNKnouI3W15/EUnqZScx9
	 zgLYR7tVd1ebkYjMEMVpxJ46ahs0T++5gflc6ja03jC3G1erRktg2MnXBqooIg4E2X
	 Pqku2ATlvd6tWIZuu51wJY5yQv/cf/ltmmxXIjv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfEGFf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbfEGFfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:35:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AE20214AE;
        Tue,  7 May 2019 05:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207317;
        bh=dFbAUPTxZV6FtJ6O1Xc6VM+HTS3OQjDCaQseBTiXcos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z5f9xEJEuJXsvfVIkeqbq2jF3HpH0rh/v64RkHW5infXgyNbsyjKNDH3Zwg0sGTv/
         KTyhUpRBv/14+sdhozHAhXG+usiQQrcBgqgzUuccSUEMq14qPO7ZIvmqu6s2hAfFw8
         ZZFqjJWOA9U1vkY6814FHuMytXU3QmDilqZBB0GA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Gomez <dagmcr@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 82/99] spi: Micrel eth switch: declare missing of table
Date:   Tue,  7 May 2019 01:32:16 -0400
Message-Id: <20190507053235.29900-82-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Gomez <dagmcr@gmail.com>

[ Upstream commit 2f23a2a768bee7ad2ff1e9527c3f7e279e794a46 ]

Add missing <of_device_id> table for SPI driver relying on SPI
device match since compatible is in a DT binding or in a DTS.

Before this patch:
modinfo drivers/net/phy/spi_ks8995.ko | grep alias
alias:          spi:ksz8795
alias:          spi:ksz8864
alias:          spi:ks8995

After this patch:
modinfo drivers/net/phy/spi_ks8995.ko | grep alias
alias:          spi:ksz8795
alias:          spi:ksz8864
alias:          spi:ks8995
alias:          of:N*T*Cmicrel,ksz8795C*
alias:          of:N*T*Cmicrel,ksz8795
alias:          of:N*T*Cmicrel,ksz8864C*
alias:          of:N*T*Cmicrel,ksz8864
alias:          of:N*T*Cmicrel,ks8995C*
alias:          of:N*T*Cmicrel,ks8995

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/spi_ks8995.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/spi_ks8995.c b/drivers/net/phy/spi_ks8995.c
index f17b3441779b..d8ea4147dfe7 100644
--- a/drivers/net/phy/spi_ks8995.c
+++ b/drivers/net/phy/spi_ks8995.c
@@ -162,6 +162,14 @@ static const struct spi_device_id ks8995_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ks8995_id);
 
+static const struct of_device_id ks8895_spi_of_match[] = {
+        { .compatible = "micrel,ks8995" },
+        { .compatible = "micrel,ksz8864" },
+        { .compatible = "micrel,ksz8795" },
+        { },
+ };
+MODULE_DEVICE_TABLE(of, ks8895_spi_of_match);
+
 static inline u8 get_chip_id(u8 val)
 {
 	return (val >> ID1_CHIPID_S) & ID1_CHIPID_M;
@@ -529,6 +537,7 @@ static int ks8995_remove(struct spi_device *spi)
 static struct spi_driver ks8995_driver = {
 	.driver = {
 		.name	    = "spi-ks8995",
+		.of_match_table = of_match_ptr(ks8895_spi_of_match),
 	},
 	.probe	  = ks8995_probe,
 	.remove	  = ks8995_remove,
-- 
2.20.1

