Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBD7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7AC2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505592;
	bh=ognpR68lZ0ABQFK+IlI98eA9rIlTa1PHRDdPUtu5sAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zhJnbvYNaBJvyeHm11FJS+HNlMoMasGC3FjyLpEQlNVd56mvlu3pTlLqUPunhCY0E
	 KSjl4Qpq4HlCTUxjVBkSi5q0GKROxy8t++2Fxt9DMlgM9tHqN+K8SJJ3MtPAGwGyCO
	 VPz/lMJMG2wXdF1t/oRCSuH11eKPbO41NK9UIPg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfCMTdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbfCMTK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:10:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAFB62184C;
        Wed, 13 Mar 2019 19:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504257;
        bh=ognpR68lZ0ABQFK+IlI98eA9rIlTa1PHRDdPUtu5sAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=us+n4Crz1YjQdEUSlhUu1v6RgFLR++vw6Mue7n7GXgPVhYRAmXinceGrjjiD1UxH+
         kvmrJWYsLA/I68X2dhLXCjtUExU5IprKvLAM8UA6RzTplveZx3BzAjdM+1AmxQaEbM
         umXkcayHuUwHaDluiurX5gsE5ryAiaUwAmgmg2o0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 16/60] net: dsa: bcm_sf2: Do not assume DSA master supports WoL
Date:   Wed, 13 Mar 2019 15:09:37 -0400
Message-Id: <20190313191021.158171-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
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
index 2eb68769562c..5c00dfb6684a 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -723,10 +723,11 @@ static void bcm_sf2_sw_get_wol(struct dsa_switch *ds, int port,
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
@@ -747,9 +748,10 @@ static int bcm_sf2_sw_set_wol(struct dsa_switch *ds, int port,
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

