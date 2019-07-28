Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D7AC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E012070D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfG1Rf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 13:35:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35156 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1Rf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 13:35:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so59355834wrm.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 10:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b2zuiNV9z+FTezAi/VZPRSNLA8E7gVpLhLnn8tmOsl8=;
        b=kgKwcNeG16HoeyiIZqJvgFAVoqNZk/t7LGsGuKFNiLjfCOvkOuVjlwyFRg1TFg1f4H
         ERmb6bt5kg2fzs7QyJqRjmo6HZ9D3qM0umu67Pnhz8ND2Yr4WJtgk4QLrgcOVMo9WfSb
         QYUaCUMVMsMxf0RFACkhAGj9L55HTC2Q8qLYRYRVIooR+nZMC6FN+g6r9e9aecyxBQw9
         /4/I7OWZ3vim2vT0YqEwP90Qn+eQfxCNsbsMPtzeGI/+mdDhS0yYwvKu6WpwLre9uGuH
         Wt8X72/oe8YQwn5GLXXt9WOxS6d42N+vJpu4ts8RKDJk1WHLSz0Mfi4W/KIlty6xXVST
         Xx2g==
X-Gm-Message-State: APjAAAVqkZ2ez/hvGA4RtPorUP92bkzyZf+Z/PRVPlhMwJiigLSK83wd
        +Dyq2GxuNoW7+LEntEfnMMfwwA==
X-Google-Smtp-Source: APXvYqzmHrUH5DR1DuabwII6AeoWJ1witAV6rclFFLf5pp1RWkQsEUhAKHdon+uwsXhFoDu6Hpk5ww==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr41178123wrw.138.1564335355423;
        Sun, 28 Jul 2019 10:35:55 -0700 (PDT)
Received: from mcroce-redhat.redhat.com (host221-208-dynamic.27-79-r.retail.telecomitalia.it. [79.27.208.221])
        by smtp.gmail.com with ESMTPSA id x20sm134505614wrg.10.2019.07.28.10.35.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 10:35:54 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Subject: [PATCH net v2] mvpp2: refactor the HW checksum setup
Date:   Sun, 28 Jul 2019 19:35:49 +0200
Message-Id: <20190728173549.32034-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware can only offload checksum calculation on first port due to
the Tx FIFO size limitation, and has a maximum L3 offset of 128 bytes.
Document this in a comment and move duplicated code in a function.

Fixes: 576193f2d579 ("net: mvpp2: jumbo frames support")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 35 ++++++++++++-------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 937e4b928b94..a99405135046 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -811,6 +811,26 @@ static int mvpp2_swf_bm_pool_init(struct mvpp2_port *port)
 	return 0;
 }
 
+static void mvpp2_set_hw_csum(struct mvpp2_port *port,
+			      enum mvpp2_bm_pool_log_num new_long_pool)
+{
+	const netdev_features_t csums = NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
+
+	/* Update L4 checksum when jumbo enable/disable on port.
+	 * Only port 0 supports hardware checksum offload due to
+	 * the Tx FIFO size limitation.
+	 * Also, don't set NETIF_F_HW_CSUM because L3_offset in TX descriptor
+	 * has 7 bits, so the maximum L3 offset is 128.
+	 */
+	if (new_long_pool == MVPP2_BM_JUMBO && port->id != 0) {
+		port->dev->features &= ~csums;
+		port->dev->hw_features &= ~csums;
+	} else {
+		port->dev->features |= csums;
+		port->dev->hw_features |= csums;
+	}
+}
+
 static int mvpp2_bm_update_mtu(struct net_device *dev, int mtu)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
@@ -843,15 +863,7 @@ static int mvpp2_bm_update_mtu(struct net_device *dev, int mtu)
 		/* Add port to new short & long pool */
 		mvpp2_swf_bm_pool_init(port);
 
-		/* Update L4 checksum when jumbo enable/disable on port */
-		if (new_long_pool == MVPP2_BM_JUMBO && port->id != 0) {
-			dev->features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
-			dev->hw_features &= ~(NETIF_F_IP_CSUM |
-					      NETIF_F_IPV6_CSUM);
-		} else {
-			dev->features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
-			dev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
-		}
+		mvpp2_set_hw_csum(port, new_long_pool);
 	}
 
 	dev->mtu = mtu;
@@ -5209,10 +5221,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 		dev->features |= NETIF_F_NTUPLE;
 	}
 
-	if (port->pool_long->id == MVPP2_BM_JUMBO && port->id != 0) {
-		dev->features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
-		dev->hw_features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
-	}
+	mvpp2_set_hw_csum(port, port->pool_long->id);
 
 	dev->vlan_features |= features;
 	dev->gso_max_segs = MVPP2_MAX_TSO_SEGS;
-- 
2.21.0

