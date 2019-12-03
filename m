Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A5BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF2C2073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413044;
	bh=N+b0vuYWSBg71gFu4yFtCo20tGHuQRE5QfD4HUrU0KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SUl/YTq7PHlFprrVJ+RM9NMX0E+RPBPlUsBOTk4222jyOvgMVHT0iLUi37e7VenM7
	 ZsSNyVch7WSJTYD8suUKW+un+KHq87ok0mRpDdqM+L9WyeLI0PZrXPJvZGznnIlVNf
	 B/ZY8tWYcsipeGm5XUln06YdmUqZ41pLDu4RKKfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfLCWoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:44:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728897AbfLCWoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:44:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3159F206EC;
        Tue,  3 Dec 2019 22:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413040;
        bh=N+b0vuYWSBg71gFu4yFtCo20tGHuQRE5QfD4HUrU0KA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MTF2Zgz6cAWj4NsojAHuMQQzIOPHVpROnLTk+NM1lUfgwM0C9i1hy8Whd7lvtTKqC
         N4bXyJ235uhbxxH2p8JbCc5t//VVNotbfaTD0VmPQdLlMMK4kCNgTI27NgKC04v5pa
         aaaE9Biuef3l0dnZkTbWNWeGv9HJQABoOnh9j7rQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 112/135] net: dsa: sja1105: fix sja1105_parse_rgmii_delays()
Date:   Tue,  3 Dec 2019 23:35:52 +0100
Message-Id: <20191203213042.231167118@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 9bca3a0a923fc3f0fb9e41391be1d0f291e86858 ]

This function was using configuration of port 0 in devicetree for all ports.
In case CPU port was not 0, the delay settings was ignored. This resulted not
working communication between CPU and the switch.

Fixes: f5b8631c293b ("net: dsa: sja1105: Error out if RGMII delays are requested in DT")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -591,15 +591,15 @@ static int sja1105_parse_rgmii_delays(st
 	int i;
 
 	for (i = 0; i < SJA1105_NUM_PORTS; i++) {
-		if (ports->role == XMII_MAC)
+		if (ports[i].role == XMII_MAC)
 			continue;
 
-		if (ports->phy_mode == PHY_INTERFACE_MODE_RGMII_RXID ||
-		    ports->phy_mode == PHY_INTERFACE_MODE_RGMII_ID)
+		if (ports[i].phy_mode == PHY_INTERFACE_MODE_RGMII_RXID ||
+		    ports[i].phy_mode == PHY_INTERFACE_MODE_RGMII_ID)
 			priv->rgmii_rx_delay[i] = true;
 
-		if (ports->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID ||
-		    ports->phy_mode == PHY_INTERFACE_MODE_RGMII_ID)
+		if (ports[i].phy_mode == PHY_INTERFACE_MODE_RGMII_TXID ||
+		    ports[i].phy_mode == PHY_INTERFACE_MODE_RGMII_ID)
 			priv->rgmii_tx_delay[i] = true;
 
 		if ((priv->rgmii_rx_delay[i] || priv->rgmii_tx_delay[i]) &&


