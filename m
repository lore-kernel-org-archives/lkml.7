Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D06C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550D42087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfEFVZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:25:36 -0400
Received: from smtp-out.xnet.cz ([178.217.244.18]:38274 "EHLO smtp-out.xnet.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfEFVZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:25:35 -0400
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id 96A1D50A4;
        Mon,  6 May 2019 23:25:33 +0200 (CEST)
Received: by meh.true.cz (OpenSMTPD) with ESMTP id d3e8320a;
        Mon, 6 May 2019 23:25:32 +0200 (CEST)
From:   =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
Subject: [PATCH net-next v2 2/4] net: dsa: support of_get_mac_address new ERR_PTR error
Date:   Mon,  6 May 2019 23:24:45 +0200
Message-Id: <1557177887-30446-3-git-send-email-ynezz@true.cz>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557177887-30446-1-git-send-email-ynezz@true.cz>
References: <1557177887-30446-1-git-send-email-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was NVMEM support added to of_get_mac_address, so it could now
return ERR_PTR encoded error values, so we need to adjust all current
users of of_get_mac_address to this new fact.

While at it, remove superfluous is_valid_ether_addr as the MAC address
returned from of_get_mac_address is always valid and checked by
is_valid_ether_addr anyway.

Fixes: d01f449c008a ("of_net: add NVMEM support to of_get_mac_address")
Signed-off-by: Petr Štetiar <ynezz@true.cz>
---
 net/dsa/slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 316bce9..fe7b6a6 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1418,7 +1418,7 @@ int dsa_slave_create(struct dsa_port *port)
 				NETIF_F_HW_VLAN_CTAG_FILTER;
 	slave_dev->hw_features |= NETIF_F_HW_TC;
 	slave_dev->ethtool_ops = &dsa_slave_ethtool_ops;
-	if (port->mac && is_valid_ether_addr(port->mac))
+	if (!IS_ERR_OR_NULL(port->mac))
 		ether_addr_copy(slave_dev->dev_addr, port->mac);
 	else
 		eth_hw_addr_inherit(slave_dev, master);
-- 
1.9.1

