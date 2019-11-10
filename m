Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA5BC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97224214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354791;
	bh=TgMTOV6vcLpQIk4fl+/asFU0iDlVDGF7K2gCTffcTAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IML5I0nx3SoBWd0hQVOdef8HyJbLgQUZz6UiukagOd7i4RbP8+KT5VLC7oLvx5uCW
	 xTvfHb0E5d7fGeDPpP/UxxWccfrfxS/sY+t7rLbdgYwfHgQvJ5zYWk4gU43OnHZTf3
	 H7UCPQfmDoedUYPAlqtYbP1pPO2TWhQZ06IaO8qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfKJC7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:59:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:47276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729381AbfKJC4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:56:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2F4B2256F;
        Sun, 10 Nov 2019 02:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354121;
        bh=TgMTOV6vcLpQIk4fl+/asFU0iDlVDGF7K2gCTffcTAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nw+4F+dMzBSVp8Zh5+ch9FS+ciuVdZ3PfIjQVS9WJqyVIfPqr5158VDvmrMbXh9rp
         TbSh3oExkpe6L9ThfZpu4fsnXCoP0pTHtuKGWsu2qGapNxZmpc1jG9V/ryHteHKUDP
         2JloV4bwPKTg2CJ469NMZ8mhKxtTbdHPrEbtYbNw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 109/109] net: phy: mdio-bcm-unimac: mark PM functions as __maybe_unused
Date:   Sat,  9 Nov 2019 21:45:41 -0500
Message-Id: <20191110024541.31567-109-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024541.31567-1-sashal@kernel.org>
References: <20191110024541.31567-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 9b97123a584f60a5bca5a2663485768a1f6cd0a4 ]

The newly added runtime-pm support causes a harmless warning
when CONFIG_PM is disabled:

drivers/net/phy/mdio-bcm-unimac.c:330:12: error: 'unimac_mdio_resume' defined but not used [-Werror=unused-function]
 static int unimac_mdio_resume(struct device *d)
drivers/net/phy/mdio-bcm-unimac.c:321:12: error: 'unimac_mdio_suspend' defined but not used [-Werror=unused-function]
 static int unimac_mdio_suspend(struct device *d)

Marking the functions as __maybe_unused is the easiest workaround
and avoids adding #ifdef checks.

Fixes: b78ac6ecd1b6 ("net: phy: mdio-bcm-unimac: Allow configuring MDIO clock divider")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mdio-bcm-unimac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio-bcm-unimac.c b/drivers/net/phy/mdio-bcm-unimac.c
index f9d98a6e67bc4..52703bbd4d666 100644
--- a/drivers/net/phy/mdio-bcm-unimac.c
+++ b/drivers/net/phy/mdio-bcm-unimac.c
@@ -316,7 +316,7 @@ static int unimac_mdio_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int unimac_mdio_suspend(struct device *d)
+static int __maybe_unused unimac_mdio_suspend(struct device *d)
 {
 	struct unimac_mdio_priv *priv = dev_get_drvdata(d);
 
@@ -325,7 +325,7 @@ static int unimac_mdio_suspend(struct device *d)
 	return 0;
 }
 
-static int unimac_mdio_resume(struct device *d)
+static int __maybe_unused unimac_mdio_resume(struct device *d)
 {
 	struct unimac_mdio_priv *priv = dev_get_drvdata(d);
 	int ret;
-- 
2.20.1

