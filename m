Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0003FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5A82070B
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211224;
	bh=rh7W5OPq+XnPn7mFp/vhye5vyY2W7CQUPc9AMpzsR38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jQy0l41Ywm8usmhZafXjRNyUQitL9WXV7FaJpGC4CAAhkhlauO5ezmPX3lvjaEZgQ
	 6HLrRT9D3J+tzRFWojaYVJEeBT4/lz+2xCxXH7dvlMrm+NpPThq/Fyqd3SxIwNW2Pp
	 hzF981jmd4bqbSnZ53bybT+Fiq5CwWQQAT/DzDoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbfJ0VUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731656AbfJ0VUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:20:20 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C816205C9;
        Sun, 27 Oct 2019 21:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211220;
        bh=rh7W5OPq+XnPn7mFp/vhye5vyY2W7CQUPc9AMpzsR38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pSuEGDfvrsK9ZGZaCta3DOmDKTOeSrOrKZuhlfnPag+c0w0LpegQaNIdOBghaSwCQ
         66sppe6g2kiwOJC4E7sT+xTnUJxK0JoP4xVlGyAL3ylAZ/GWFoA/9UQKrbrxOSCJim
         hq1NItoEeRJbi2f8wOfUpD7UV85vmGUzKHgmfCas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 073/197] net: bcmgenet: Set phydev->dev_flags only for internal PHYs
Date:   Sun, 27 Oct 2019 21:59:51 +0100
Message-Id: <20191027203355.585233888@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 92696286f3bb37ba50e4bd8d1beb24afb759a799 ]

phydev->dev_flags is entirely dependent on the PHY device driver which
is going to be used, setting the internal GENET PHY revision in those
bits only makes sense when drivers/net/phy/bcm7xxx.c is the PHY driver
being used.

Fixes: 487320c54143 ("net: bcmgenet: communicate integrated PHY revision to PHY driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -277,11 +277,12 @@ int bcmgenet_mii_probe(struct net_device
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct device_node *dn = priv->pdev->dev.of_node;
 	struct phy_device *phydev;
-	u32 phy_flags;
+	u32 phy_flags = 0;
 	int ret;
 
 	/* Communicate the integrated PHY revision */
-	phy_flags = priv->gphy_rev;
+	if (priv->internal_phy)
+		phy_flags = priv->gphy_rev;
 
 	/* Initialize link state variables that bcmgenet_mii_setup() uses */
 	priv->old_link = -1;


