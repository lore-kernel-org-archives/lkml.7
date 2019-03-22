Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E10C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B992192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256097;
	bh=t4EKE5cAqwZ3xyucemYWwdZP3mIKRs8eI140+TXwXe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mV71+h4Wh0GW4UrghzIgFq7V+mwZwMgxTUV8pti2VxwdTbgwtUaVVS6xT7uzFCk8l
	 US5YledMBiuXNkoY9VckHKbkcUdY03jKGldsOBEN+kBHnLYhojtbdlvDmx0XmP/tZr
	 lpQV3QuM5uRqm2c6e3sqWcMR+/ph9gLrtb0d6B0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388232AbfCVMBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388224AbfCVMBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:01:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BBD1204FD;
        Fri, 22 Mar 2019 12:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256091;
        bh=t4EKE5cAqwZ3xyucemYWwdZP3mIKRs8eI140+TXwXe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=coLEDsmmZv4Wz/fsLiPU6ZghSXW2My/8wWdH7IAu8fZewCJyJuZnBU4vF2FOeTgkD
         RAp6A/9sz3196bNKXKZ3anzqcgXTDxk4lnvINsYpAM+ZGK3pCCAxbIp3sSnw9KMWNR
         SKoGDezhJbABBcqT9sZA842xfBJItA9JtQq4jlLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 080/280] net: dsa: bcm_sf2: Do not assume DSA master supports WoL
Date:   Fri, 22 Mar 2019 12:13:53 +0100
Message-Id: <20190322111310.866332380@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index bb26a193361e..2fa2caf7a746 100644
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



