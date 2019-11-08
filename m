Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBEEC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A7C2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239814;
	bh=yUzASy/JA7yMigBVCczCyoIZcMNDuo1175O8fzfNnzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WPZ9N2CRxA62edA90Gz+4HdotI7vp7cQ5DOSCHt6CXlfhAoOFDcKUqfLKDO1gtJwW
	 F+LNH3ipdFi0fEX4vauEcokyNNwTZ0U1pKDQsF9a/wvZ035atzQ/dyk+lLhNYXIvcP
	 S+oUNPzHt0nNlWN2xyr0L5pLV60UQhRTWwaY8sek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390792AbfKHTDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:03:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387843AbfKHTDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:03:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E4E92087E;
        Fri,  8 Nov 2019 19:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239804;
        bh=yUzASy/JA7yMigBVCczCyoIZcMNDuo1175O8fzfNnzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HB01RT9f9XUOZn/75g1zYITcXT5l2D4mXpk2HS79sxm98ODiKzvkdfoC4NFmeHM/0
         4MPf+bMU/Uq47KPAWi+1gDzwilG/DPaLAlrg4fArDkykJDWfSzRURkE48d0wu0UzDt
         cN66Cz6SbVcVqieOLR7z2mD6+0sssSSAIcnh7Btc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 66/79] net: phy: bcm7xxx: define soft_reset for 40nm EPHY
Date:   Fri,  8 Nov 2019 19:50:46 +0100
Message-Id: <20191108174822.513246011@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174745.495640141@linuxfoundation.org>
References: <20191108174745.495640141@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit fe586b823372a9f43f90e2c6aa0573992ce7ccb7 ]

The internal 40nm EPHYs use a "Workaround for putting the PHY in
IDDQ mode." These PHYs require a soft reset to restore functionality
after they are powered back up.

This commit defines the soft_reset function to use genphy_soft_reset
during phy_init_hw to accommodate this.

Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/bcm7xxx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -643,6 +643,7 @@ static int bcm7xxx_28nm_probe(struct phy
 	.name           = _name,					\
 	.features       = PHY_BASIC_FEATURES,				\
 	.flags          = PHY_IS_INTERNAL,				\
+	.soft_reset	= genphy_soft_reset,				\
 	.config_init    = bcm7xxx_config_init,				\
 	.suspend        = bcm7xxx_suspend,				\
 	.resume         = bcm7xxx_config_init,				\


