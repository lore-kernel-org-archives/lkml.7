Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B6DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959B82173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553837724;
	bh=Hz7xR+e4LP2NZV8Nscu4LHLTew74p5atnOXRGVZqvnU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ixOjwhH64bnplZAdVBprdA7JrKv32Dc65+IkSS26p/DB8oSwlutVFfRYHu8jCS1wr
	 dZrFZVQ2OBNX8sPSN6JzDgzafFeYOerYkegAnjm7Qdfr2ghGYxoSUZYEF1MhF2Z8nM
	 denPUNcHF8/KltIlHOFhpRdkwW/OA5XkO0bYHvLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfC2FfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 01:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfC2FfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 01:35:22 -0400
Received: from localhost.localdomain (unknown [106.200.210.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C67CC2173C;
        Fri, 29 Mar 2019 05:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553837721;
        bh=Hz7xR+e4LP2NZV8Nscu4LHLTew74p5atnOXRGVZqvnU=;
        h=From:To:Cc:Subject:Date:From;
        b=GaA7KHTfQs/vYaGFoz+7xe8HndKKDLINzxzQhcjlViSLSUTB3+nFqOuPw9lT2REf5
         weORFIc8Tgb86YdsDAHvQJO1zfR4q4oRgEWhWBqprD8frzOW1GlKIRdvXEIdn+zUU6
         xbmrsPNS21PqKvBEsQWcCOkrwZnA6F3Ff07+8W8w=
From:   Vinod Koul <vkoul@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Xiaofei Shen <xiaofeis@codeaurora.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2] net: dsa: read mac address from DT for slave device
Date:   Fri, 29 Mar 2019 11:04:58 +0530
Message-Id: <20190329053458.11891-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaofei Shen <xiaofeis@codeaurora.org>

Before creating a slave netdevice, get the mac address from DTS and
apply in case it is valid.

Signed-off-by: Xiaofei Shen <xiaofeis@codeaurora.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---

v2: Rebase on net-next. The binding patch is already merged

 include/net/dsa.h | 1 +
 net/dsa/dsa2.c    | 1 +
 net/dsa/slave.c   | 5 ++++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index ae480bba11f5..0cfc2f828b87 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -140,6 +140,7 @@ struct dsa_port {
 	unsigned int		index;
 	const char		*name;
 	const struct dsa_port	*cpu_dp;
+	const char		*mac;
 	struct device_node	*dn;
 	unsigned int		ageing_time;
 	u8			stp_state;
diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index fe0a6197db9c..0e1cce460406 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -266,6 +266,7 @@ static int dsa_port_setup(struct dsa_port *dp)
 		return 0;
 
 	memset(&dp->devlink_port, 0, sizeof(dp->devlink_port));
+	dp->mac = of_get_mac_address(dp->dn);
 
 	switch (dp->type) {
 	case DSA_PORT_TYPE_CPU:
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 093eef6f2599..9e4208140142 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1378,7 +1378,10 @@ int dsa_slave_create(struct dsa_port *port)
 				NETIF_F_HW_VLAN_CTAG_FILTER;
 	slave_dev->hw_features |= NETIF_F_HW_TC;
 	slave_dev->ethtool_ops = &dsa_slave_ethtool_ops;
-	eth_hw_addr_inherit(slave_dev, master);
+	if (port->mac && is_valid_ether_addr(port->mac))
+		ether_addr_copy(slave_dev->dev_addr, port->mac);
+	else
+		eth_hw_addr_inherit(slave_dev, master);
 	slave_dev->priv_flags |= IFF_NO_QUEUE;
 	slave_dev->netdev_ops = &dsa_slave_netdev_ops;
 	slave_dev->min_mtu = 0;
-- 
2.20.1

