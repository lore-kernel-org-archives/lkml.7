Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AACFC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6ECE20740
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468911;
	bh=qJJlTlHRi51WTrLwYlXoW7LIzvQeZU6Zad7hGcPoHiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1cVgT5r9jfhJXjmOeFKX5DubfQWPihKsMCPDIDIh3MnHYkPMzczr/NjCb+OXlR5F5
	 7bzi2FBCqq59T3YMU9xCUCu87JqwMM6+nPrOEmVEdsOZ1ko8iSQkwseiMjlFmZ9POo
	 oCPTS54qXPGQXEaACCgGDyev+CsFgQpXTDdS0ISc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfL0Rsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:48:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728532AbfL0Ron (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:44:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 024EF20740;
        Fri, 27 Dec 2019 17:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468682;
        bh=qJJlTlHRi51WTrLwYlXoW7LIzvQeZU6Zad7hGcPoHiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Za7HgRmvF4VoIYpbfJ/NjpML5xUcd7ZSLzGg9wUHbIjoI9IBA9+SinAAWhXHSrllQ
         5BR53JYWCOXDBgN+2a418ckeAZ9GvpRiIA3oXUkkppuIRZWIUR/mEh1JnrbpIxjd3E
         uTGVXOtc1uebFDizSttirjY2vG7lU2SWOJuDxfBg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 41/84] qede: Fix multicast mac configuration
Date:   Fri, 27 Dec 2019 12:43:09 -0500
Message-Id: <20191227174352.6264-41-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Chopra <manishc@marvell.com>

[ Upstream commit 0af67e49b018e7280a4227bfe7b6005bc9d3e442 ]

Driver doesn't accommodate the configuration for max number
of multicast mac addresses, in such particular case it leaves
the device with improper/invalid multicast configuration state,
causing connectivity issues (in lacp bonding like scenarios).

Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index b16ce7d93caf..c3d5d40afec0 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1230,7 +1230,7 @@ qede_configure_mcast_filtering(struct net_device *ndev,
 	netif_addr_lock_bh(ndev);
 
 	mc_count = netdev_mc_count(ndev);
-	if (mc_count < 64) {
+	if (mc_count <= 64) {
 		netdev_for_each_mc_addr(ha, ndev) {
 			ether_addr_copy(temp, ha->addr);
 			temp += ETH_ALEN;
-- 
2.20.1

