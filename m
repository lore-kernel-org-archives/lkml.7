Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A577FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765BD206DD
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfCBAha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:37:30 -0500
Received: from smtprelay0088.hostedemail.com ([216.40.44.88]:35233 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725966AbfCBAha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 19:37:30 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6178E52BF;
        Sat,  2 Mar 2019 00:37:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wrist32_6defd356f537
X-Filterd-Recvd-Size: 1834
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 Mar 2019 00:37:27 +0000 (UTC)
Message-ID: <b9e4efeeca1ede0ec53043e78b15a6ffd03ed195.camel@perches.com>
Subject: [PATCH] fsl/fman: Use vsprintf extension %pM
From:   Joe Perches <joe@perches.com>
To:     Madalin Bucur <madalin.bucur@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Date:   Fri, 01 Mar 2019 16:37:25 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make logging of an ethernet address more consistent with
the rest of the kernel.

Miscellanea:

The %02hx use also did not quite match the u8 definition
of addr though that did not actually matter given normal
integer promotion rules.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/freescale/fman/mac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 71f4205f14e7..3c21486c6c84 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -855,9 +855,7 @@ static int mac_probe(struct platform_device *_of_dev)
 	if (err < 0)
 		dev_err(dev, "fman_set_mac_active_pause() = %d\n", err);
 
-	dev_info(dev, "FMan MAC address: %02hx:%02hx:%02hx:%02hx:%02hx:%02hx\n",
-		 mac_dev->addr[0], mac_dev->addr[1], mac_dev->addr[2],
-		 mac_dev->addr[3], mac_dev->addr[4], mac_dev->addr[5]);
+	dev_info(dev, "FMan MAC address: %pM\n", mac_dev->addr);
 
 	priv->eth_dev = dpaa_eth_add_device(fman_id, mac_dev);
 	if (IS_ERR(priv->eth_dev)) {


