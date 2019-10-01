Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7580C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84426205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948180;
	bh=+/GPWSjFANCOmijUlq3Ycvx8UhI7FFqWIqqYSVoJUU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AUcm/KzXZW0SqulrB64p2MPAlBN30D744GTrAtfRZovQX45KmZ8jEbScP2qh4NlP6
	 JDKEJZCeP9I2mvBjgjDdyMs8tBES6zj7ZBRWbCPlVr0yl66SdcFaTI4LSyu/JS5piN
	 FKtenptKwtnudOE7Ia//UIwFxwmHwMeuUTtxuHcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732335AbfJAQm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732218AbfJAQmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:42:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5538221A4C;
        Tue,  1 Oct 2019 16:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948172;
        bh=+/GPWSjFANCOmijUlq3Ycvx8UhI7FFqWIqqYSVoJUU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ylzttj7+OsxWgFlDISFDAzahNtRpiE3kU/bKRsIAPw7nFGaKW9bd8QaVZSRVERWNe
         ns9Pa2X/QBpttQ0doxDVil0DRdbj2Syh2DYKrNayXAAybAru1D/ruDibbSjtYXD0aH
         C1c2EevuFNy5sHdwmNckZTWk2LxIx9UD5LVZNFW8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans Andersson <hans.andersson@cellavision.se>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 54/63] net: phy: micrel: add Asym Pause workaround for KSZ9021
Date:   Tue,  1 Oct 2019 12:41:16 -0400
Message-Id: <20191001164125.15398-54-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164125.15398-1-sashal@kernel.org>
References: <20191001164125.15398-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Andersson <hans.andersson@cellavision.se>

[ Upstream commit 407d8098cb1ab338199f4753162799a488d87d23 ]

The Micrel KSZ9031 PHY may fail to establish a link when the Asymmetric
Pause capability is set. This issue is described in a Silicon Errata
(DS80000691D or DS80000692D), which advises to always disable the
capability.

Micrel KSZ9021 has no errata, but has the same issue with Asymmetric Pause.
This patch apply the same workaround as the one for KSZ9031.

Fixes: 3aed3e2a143c ("net: phy: micrel: add Asym Pause workaround")
Signed-off-by: Hans Andersson <hans.andersson@cellavision.se>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/micrel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 3c8186f269f9e..2fea5541c35a8 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -763,6 +763,8 @@ static int ksz9031_get_features(struct phy_device *phydev)
 	 * Whenever the device's Asymmetric Pause capability is set to 1,
 	 * link-up may fail after a link-up to link-down transition.
 	 *
+	 * The Errata Sheet is for ksz9031, but ksz9021 has the same issue
+	 *
 	 * Workaround:
 	 * Do not enable the Asymmetric Pause capability bit.
 	 */
@@ -1076,6 +1078,7 @@ static struct phy_driver ksphy_driver[] = {
 	/* PHY_GBIT_FEATURES */
 	.driver_data	= &ksz9021_type,
 	.probe		= kszphy_probe,
+	.get_features	= ksz9031_get_features,
 	.config_init	= ksz9021_config_init,
 	.ack_interrupt	= kszphy_ack_interrupt,
 	.config_intr	= kszphy_config_intr,
-- 
2.20.1

