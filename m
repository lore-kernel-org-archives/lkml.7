Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396CFC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCD820862
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482751;
	bh=I+9HfdYWanbujl1taV32XPKQTdpZAE/Rjg/alK72ODc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HWArZVYwxrytfxR/fXLEbv0MEXyvHKno2zMxK6G3Zc6glwxL6uXHN4Gndv9aapDyv
	 eZNzui/TgvYwvNj1YPqQdtsZQV0ZcyNde3lsYkh2rI0Q5L8QyESFtbGmYOtsluXXCL
	 ckTckv3TRgcF9SroMtIS2OW2R2a5L8Z53QpvgQI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfLDSFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:05:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:52694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730425AbfLDSFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:05:41 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3743C20659;
        Wed,  4 Dec 2019 18:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482740;
        bh=I+9HfdYWanbujl1taV32XPKQTdpZAE/Rjg/alK72ODc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJ1rkX6eyCkMZJM6jmqzkqVB4nzjHB1AUEziSqsBWE986wkZK0wP7zj76mMwWgb+z
         9Kk0+ISZom4rao7f6JyltpOIazIRJF3S+5zTLOcPnGuSzEmFY6zUhCp4avobHP11NY
         vRC92T7yDZkhEgCamFkuhbXi8V3ITVRCSHvCMBbU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 116/209] atl1e: checking the status of atl1e_write_phy_reg
Date:   Wed,  4 Dec 2019 18:55:28 +0100
Message-Id: <20191204175331.108807474@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit ff07d48d7bc0974d4f96a85a4df14564fb09f1ef ]

atl1e_write_phy_reg() could fail. The fix issues an error message when
it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index 4f7e195af0bc6..0d08039981b54 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -472,7 +472,9 @@ static void atl1e_mdio_write(struct net_device *netdev, int phy_id,
 {
 	struct atl1e_adapter *adapter = netdev_priv(netdev);
 
-	atl1e_write_phy_reg(&adapter->hw, reg_num & MDIO_REG_ADDR_MASK, val);
+	if (atl1e_write_phy_reg(&adapter->hw,
+				reg_num & MDIO_REG_ADDR_MASK, val))
+		netdev_err(netdev, "write phy register failed\n");
 }
 
 static int atl1e_mii_ioctl(struct net_device *netdev,
-- 
2.20.1



