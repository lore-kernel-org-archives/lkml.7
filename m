Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC6FC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0A2205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483405;
	bh=zHpT5ox9eP1tHLBjnqlnUf9eoQ/p8QToFJchykBnIfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1RhAHLO7+F3MdgpHhG+pXUUdmchvEG8lBzXEjQcvAT9GnF7JqfhpNcDaCYa7wv3Me
	 VlbMxU3tz8vJjqrZyiI0Ze+vtcJpFL+SUaF2i6yzxyOpgav+L8M1h3EdZe9Ejxpadf
	 MHlnmISiCdpMTcyskLvaBl4hLUVQqw442Xughjjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbfLDSQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:16:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730863AbfLDSMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:12:49 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC5EC20675;
        Wed,  4 Dec 2019 18:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483169;
        bh=zHpT5ox9eP1tHLBjnqlnUf9eoQ/p8QToFJchykBnIfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMjEWZbRUa1xGpogglavwu9MY4wZceUAdTVd5TTp5eraZeOs2IXo5JZcsYeQUedVw
         QVVwx4PTfXq6aXt6xUIwohLN7h2UFA2X5QuvqY3CN4cCp0Z2GCUAeiV0NwSjGKX4sy
         bIRHcLWysozXB2eDiLCbldlLFOERIHDNCPV+kNC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 078/125] atl1e: checking the status of atl1e_write_phy_reg
Date:   Wed,  4 Dec 2019 18:56:23 +0100
Message-Id: <20191204175323.775773586@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
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
index 974713b19ab64..5e1f03590aaf2 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -478,7 +478,9 @@ static void atl1e_mdio_write(struct net_device *netdev, int phy_id,
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



