Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD884C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA5220685
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257486;
	bh=jWsm3zmM5L6Feb+pa2boPJBjm/Ociv13cvC+A6JpqKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kBfer6+o+e/hCcFIVG/Ny6Y5sJaz3dNvpTejDRIXszfmXp9a4cqlxgTV+buE3OCfZ
	 K0nY9RvzSd/oU0rVpp6TP3XG5WkxVHJSlWCTcuXmJD1DWhhEu92Fxn/6JDjDIIrMcJ
	 dl8M05fexz7BUfBfCaaRuerCYwWMKpNPohhd24+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403816AbfCVMYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390928AbfCVMYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:24:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF00C2054F;
        Fri, 22 Mar 2019 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257475;
        bh=jWsm3zmM5L6Feb+pa2boPJBjm/Ociv13cvC+A6JpqKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=df5UHjGlls+8F9rNca+/xQjr1YnuPoCKzReDqY10ifUWq36NbPBEeCer1Mmo5WT9m
         GUZyKjtPMtsA7GoVSAzJ/D78fWkbZ7oAjk+0LzkCA9l6Nqts+pTUgJRvXgt9UhQ9/N
         Q6RQi/RlL6zCoVt+gXuB0hL2qPjdlijqkObUlMsw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Johan Hovold <johan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 234/238] net: dsa: lantiq_gswip: fix OF child-node lookups
Date:   Fri, 22 Mar 2019 12:17:33 +0100
Message-Id: <20190322111312.201064148@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit c8cbcb0d8bd72d44fad1a5ddc348ac10e0fb1b37 upstream.

Use the new of_get_compatible_child() helper to look up child nodes to
avoid ever matching non-child nodes elsewhere in the tree.

Also fix up the related struct device_node leaks.

Fixes: 14fceff4771e ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
Cc: stable <stable@vger.kernel.org>	# 4.20
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/dsa/lantiq_gswip.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1069,10 +1069,10 @@ static int gswip_probe(struct platform_d
 	version = gswip_switch_r(priv, GSWIP_VERSION);
 
 	/* bring up the mdio bus */
-	gphy_fw_np = of_find_compatible_node(pdev->dev.of_node, NULL,
-					     "lantiq,gphy-fw");
+	gphy_fw_np = of_get_compatible_child(dev->of_node, "lantiq,gphy-fw");
 	if (gphy_fw_np) {
 		err = gswip_gphy_fw_list(priv, gphy_fw_np, version);
+		of_node_put(gphy_fw_np);
 		if (err) {
 			dev_err(dev, "gphy fw probe failed\n");
 			return err;
@@ -1080,13 +1080,12 @@ static int gswip_probe(struct platform_d
 	}
 
 	/* bring up the mdio bus */
-	mdio_np = of_find_compatible_node(pdev->dev.of_node, NULL,
-					  "lantiq,xrx200-mdio");
+	mdio_np = of_get_compatible_child(dev->of_node, "lantiq,xrx200-mdio");
 	if (mdio_np) {
 		err = gswip_mdio(priv, mdio_np);
 		if (err) {
 			dev_err(dev, "mdio probe failed\n");
-			goto gphy_fw;
+			goto put_mdio_node;
 		}
 	}
 
@@ -1115,7 +1114,8 @@ disable_switch:
 mdio_bus:
 	if (mdio_np)
 		mdiobus_unregister(priv->ds->slave_mii_bus);
-gphy_fw:
+put_mdio_node:
+	of_node_put(mdio_np);
 	for (i = 0; i < priv->num_gphy_fw; i++)
 		gswip_gphy_fw_remove(priv, &priv->gphy_fw[i]);
 	return err;
@@ -1134,8 +1134,10 @@ static int gswip_remove(struct platform_
 
 	dsa_unregister_switch(priv->ds);
 
-	if (priv->ds->slave_mii_bus)
+	if (priv->ds->slave_mii_bus) {
 		mdiobus_unregister(priv->ds->slave_mii_bus);
+		of_node_put(priv->ds->slave_mii_bus->dev.of_node);
+	}
 
 	for (i = 0; i < priv->num_gphy_fw; i++)
 		gswip_gphy_fw_remove(priv, &priv->gphy_fw[i]);


