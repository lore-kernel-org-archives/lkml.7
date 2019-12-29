Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28C2C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B054E20CC7
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640169;
	bh=Panl6ey8aJhDX79dopph3tzoDf23sIp1mSKPr/j7FDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wFh2QhAnpxcgTl7lUzXvLhaU7UoWjtWUcU8k9QGpiGM36NxCDNczyXsFdoe1PsGGZ
	 +53zUjrI95RRoG3iS6bnZEBbKMDCTLycRUuogGlX/7DKz9GYZ1LgTZY19ogH0HmuwO
	 j59D7gXDQdDKFHi6isJQNb5EigHXf8fMRvfNFwyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfL2RWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:22:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfL2RWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:22:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C06BB207FD;
        Sun, 29 Dec 2019 17:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640163;
        bh=Panl6ey8aJhDX79dopph3tzoDf23sIp1mSKPr/j7FDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J1wG8cp47ZlzNEomJJI9aiGGXqNMChKBTTw/wEHedod1u2KoaUpspDku1v9ftxhTp
         mv6ve4huaU04tiA1NGyyVFbXtxckD7BZtbXCe9k7e2E71egXGgo03y5DDwRoPO96zz
         fHzxmz3+UNvQCEB5HhC/cXCHuIFEvFSAWZPCtPHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 009/161] qede: Fix multicast mac configuration
Date:   Sun, 29 Dec 2019 18:17:37 +0100
Message-Id: <20191229162358.554444582@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162355.500086350@linuxfoundation.org>
References: <20191229162355.500086350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1181,7 +1181,7 @@ qede_configure_mcast_filtering(struct ne
 	netif_addr_lock_bh(ndev);
 
 	mc_count = netdev_mc_count(ndev);
-	if (mc_count < 64) {
+	if (mc_count <= 64) {
 		netdev_for_each_mc_addr(ha, ndev) {
 			ether_addr_copy(temp, ha->addr);
 			temp += ETH_ALEN;


