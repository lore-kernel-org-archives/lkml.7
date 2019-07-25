Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1CCC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7887920823
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfGYXTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:19:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37090 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfGYXTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:19:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so27338636wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 16:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K3wHkemLb3xaCpDEOIj/woHJAbVwLsLkHjzsKdx3mpc=;
        b=iE5fP78vQJNNEpUlj/w8P2zd5lVYcK/GEEYtKmli/8t6+RClly+os1sCsFVr101z+C
         lIzlpGPn/Gl9nXDANPZkWRXrzCGBOp3T70eTP22I1HqfCIA4w4eNsdYzqj03gwUsrWEM
         J9abwSF0pjCC68oM4q4Cp6BjWdHnLTVwTNnz7ktmQjdoDVyEWr+VAwgOA0Xt1hHpKxEj
         oz7OoKZNi2qKsd00cC3PYQ9zJzCWIuv1p8jOFZSKqwtF5AXfanTFXY4bV5kYCba0E5IK
         6kI4iejG2G/5AYMnRFwjzeqIe1QHqFejq/jyA6EzVsjOLBQcSwvHmXOIctE77p0ypJm6
         PNZw==
X-Gm-Message-State: APjAAAV9CL/duv4rOgSIWP2LdkdtgtZ+QlxkQlPVJ26Ksqy4QIxu2hAg
        Cp1PFGB4WacGy6kHDmsJToD8MA==
X-Google-Smtp-Source: APXvYqzjWT4ow6D0N4ysM5JtU6bPrYkvp6eH3dlpaBKFdVmxlLFewHnONQ5vX0oLS8HYmV85Lf7nuA==
X-Received: by 2002:a05:6000:1203:: with SMTP id e3mr20306951wrx.300.1564096779690;
        Thu, 25 Jul 2019 16:19:39 -0700 (PDT)
Received: from mcroce-redhat.homenet.telecomitalia.it (host21-50-dynamic.21-87-r.retail.telecomitalia.it. [87.21.50.21])
        by smtp.gmail.com with ESMTPSA id y1sm38206717wma.32.2019.07.25.16.19.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 16:19:38 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH net] mvpp2: refactor MTU change code
Date:   Fri, 26 Jul 2019 01:19:31 +0200
Message-Id: <20190725231931.24073-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MTU change code can call napi_disable() with the device already down,
leading to a deadlock. Also, lot of code is duplicated unnecessarily.

Rework mvpp2_change_mtu() to avoid the deadlock and remove duplicated code.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 41 ++++++-------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 2f7286bd203b..60eb98f99571 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3612,6 +3612,7 @@ static int mvpp2_set_mac_address(struct net_device *dev, void *p)
 static int mvpp2_change_mtu(struct net_device *dev, int mtu)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
+	bool running = netif_running(dev);
 	int err;
 
 	if (!IS_ALIGNED(MVPP2_RX_PKT_SIZE(mtu), 8)) {
@@ -3620,40 +3621,24 @@ static int mvpp2_change_mtu(struct net_device *dev, int mtu)
 		mtu = ALIGN(MVPP2_RX_PKT_SIZE(mtu), 8);
 	}
 
-	if (!netif_running(dev)) {
-		err = mvpp2_bm_update_mtu(dev, mtu);
-		if (!err) {
-			port->pkt_size =  MVPP2_RX_PKT_SIZE(mtu);
-			return 0;
-		}
-
-		/* Reconfigure BM to the original MTU */
-		err = mvpp2_bm_update_mtu(dev, dev->mtu);
-		if (err)
-			goto log_error;
-	}
-
-	mvpp2_stop_dev(port);
+	if (running)
+		mvpp2_stop_dev(port);
 
 	err = mvpp2_bm_update_mtu(dev, mtu);
-	if (!err) {
+	if (err) {
+		netdev_err(dev, "failed to change MTU\n");
+		/* Reconfigure BM to the original MTU */
+		mvpp2_bm_update_mtu(dev, dev->mtu);
+	} else {
 		port->pkt_size =  MVPP2_RX_PKT_SIZE(mtu);
-		goto out_start;
 	}
 
-	/* Reconfigure BM to the original MTU */
-	err = mvpp2_bm_update_mtu(dev, dev->mtu);
-	if (err)
-		goto log_error;
-
-out_start:
-	mvpp2_start_dev(port);
-	mvpp2_egress_enable(port);
-	mvpp2_ingress_enable(port);
+	if (running) {
+		mvpp2_start_dev(port);
+		mvpp2_egress_enable(port);
+		mvpp2_ingress_enable(port);
+	}
 
-	return 0;
-log_error:
-	netdev_err(dev, "failed to change MTU\n");
 	return err;
 }
 
-- 
2.21.0

