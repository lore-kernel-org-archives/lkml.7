Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB9DC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38E22075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505316;
	bh=GfLxg7WygPntAiFzKdAupVW6hQ4v5bSVgeqmSQsn3ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cpyx5/xVvP0Ogdbl585cz1oBst/fRnj6Fqstoh04Q6KluhBtIndt4u59oCGewtX4Q
	 S3iPCy07IY791jxlkwiZeswQ0j75WQ2mMc7LfrgZNLPcDXOUQb6UXQPGXbfVidKDon
	 gTPHzZ5TjRD0dcR/b8qB5fImhQmoFMGQx7z5ARXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfCMT2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:28:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbfCMTNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:13:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC98217F5;
        Wed, 13 Mar 2019 19:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504413;
        bh=GfLxg7WygPntAiFzKdAupVW6hQ4v5bSVgeqmSQsn3ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uvYXmafl8zt22KeJDcNChPIj42qLsLblf7BEFrayCBW/6LrY9CpJ6lBiYXdhJkdS5
         cwJ41DSc9JcqBpO/w8vPCZ/jHcZrBKd/M13zM4UQLuKy0GJzPCxLFpO9JFvJySBUOE
         9rWju2Xp2vlo22kIB37lTA79SkuX7Tp+yKO2B0+c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 14/48] net: dsa: bcm_sf2: Do not assume DSA master supports WoL
Date:   Wed, 13 Mar 2019 15:12:16 -0400
Message-Id: <20190313191250.158955-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191250.158955-1-sashal@kernel.org>
References: <20190313191250.158955-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit c3152ec4c0691e351f35a2f63347a464b5f35151 ]

We assume in the bcm_sf2 driver that the DSA master network device
supports ethtool_ops::{get,set}_wol operations, which is not a given.
Avoid de-referencing potentially non-existent function pointers and
check them as we should.

Fixes: 96e65d7f3f88 ("net: dsa: bcm_sf2: add support for Wake-on-LAN")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/bcm_sf2.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index fc8b48adf38b..a5e2d8df013b 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -724,10 +724,11 @@ static void bcm_sf2_sw_get_wol(struct dsa_switch *ds, int port,
 {
 	struct net_device *p = ds->ports[port].cpu_dp->master;
 	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
-	struct ethtool_wolinfo pwol;
+	struct ethtool_wolinfo pwol = { };
 
 	/* Get the parent device WoL settings */
-	p->ethtool_ops->get_wol(p, &pwol);
+	if (p->ethtool_ops->get_wol)
+		p->ethtool_ops->get_wol(p, &pwol);
 
 	/* Advertise the parent device supported settings */
 	wol->supported = pwol.supported;
@@ -748,9 +749,10 @@ static int bcm_sf2_sw_set_wol(struct dsa_switch *ds, int port,
 	struct net_device *p = ds->ports[port].cpu_dp->master;
 	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
 	s8 cpu_port = ds->ports[port].cpu_dp->index;
-	struct ethtool_wolinfo pwol;
+	struct ethtool_wolinfo pwol =  { };
 
-	p->ethtool_ops->get_wol(p, &pwol);
+	if (p->ethtool_ops->get_wol)
+		p->ethtool_ops->get_wol(p, &pwol);
 	if (wol->wolopts & ~pwol.supported)
 		return -EINVAL;
 
-- 
2.19.1

