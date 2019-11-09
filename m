Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A5BC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 18:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E171421848
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 18:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfKISCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 13:02:32 -0500
Received: from orthanc.universe-factory.net ([104.238.176.138]:54932 "EHLO
        orthanc.universe-factory.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbfKISCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 13:02:32 -0500
Received: from localhost.localdomain (unknown [185.216.33.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by orthanc.universe-factory.net (Postfix) with ESMTPSA id 3EDB81F56D;
        Sat,  9 Nov 2019 18:54:38 +0100 (CET)
From:   Matthias Schiffer <mschiffer@universe-factory.net>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        Matthias Schiffer <mschiffer@universe-factory.net>
Subject: [PATCH net-next 1/2] vxlan: implement get_link_ksettings ethtool method
Date:   Sat,  9 Nov 2019 18:54:13 +0100
Message-Id: <c69ddec1c46f436946c45c3a3a4ff2763992c9f6.1573321597.git.mschiffer@universe-factory.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1573321597.git.mschiffer@universe-factory.net>
References: <cover.1573321597.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to VLAN and similar drivers, we can forward get_link_ksettings to
the lower dev if we have one to get meaningful speed/duplex data.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 drivers/net/vxlan.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 11f5776affb1..bf04bc2e68c2 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -3175,9 +3175,29 @@ static void vxlan_get_drvinfo(struct net_device *netdev,
 	strlcpy(drvinfo->driver, "vxlan", sizeof(drvinfo->driver));
 }
 
+static int vxlan_get_link_ksettings(struct net_device *dev,
+				    struct ethtool_link_ksettings *cmd)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_rdst *dst = &vxlan->default_dst;
+	struct net_device *lowerdev = __dev_get_by_index(vxlan->net,
+							 dst->remote_ifindex);
+
+	if (!lowerdev) {
+		cmd->base.duplex = DUPLEX_UNKNOWN;
+		cmd->base.port = PORT_OTHER;
+		cmd->base.speed = SPEED_UNKNOWN;
+
+		return 0;
+	}
+
+	return __ethtool_get_link_ksettings(lowerdev, cmd);
+}
+
 static const struct ethtool_ops vxlan_ethtool_ops = {
-	.get_drvinfo	= vxlan_get_drvinfo,
-	.get_link	= ethtool_op_get_link,
+	.get_drvinfo		= vxlan_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_link_ksettings	= vxlan_get_link_ksettings,
 };
 
 static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
-- 
2.24.0

