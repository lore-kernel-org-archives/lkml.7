Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACFCC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41FB20823
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfGYXPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:15:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39074 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfGYXPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:15:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id u25so35748744wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 16:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ck441Qj9jL1H01OefMYtBUDrpsMMGmY/zScqF+3gCpk=;
        b=uZ6pl8c3ivbGABDZgmC/gscItIPQEcMmKIIMYl2M/lqQUUupcvwFY9OEhZgx0Y39NF
         nRZANhBUEpgg0bHBbybxHdXmq5jJskaIPrf2Tp4KxDBHJHM86Up1JZZlShAZVHb8gL/W
         iPjtzTuIDFoznwrfmJxEUr3li1YK7AuRfiFRLf489+LYJelXn2bSJM8Gvr3Stkznlrda
         04YaZSd/rib+UpjRTbkRWj/gc3iOt8fhbTySFU/kw92vjQjvhqrEfWhVaOIhXoWdZTfj
         B5iYl/GKrhSW2RBaitmdZDUrbvrSMuuEQ8J0Q5p1QIuYnFp5/iF4SLbdtC3KtAdc2QtH
         0GGQ==
X-Gm-Message-State: APjAAAU3dm7IXjjz5dIJrtlfiSGCeXpTsaQkTSItwVFh+UrIll20u1HB
        Bjw6rvBFWBMqp2/SnApBTNtniw==
X-Google-Smtp-Source: APXvYqytyJUpKevgoV3T4HW3iBeKwgkT4O3GKaE9aTEYwfBtFogyYBWWmoBnzhNSuDlKhf6m2MvUoA==
X-Received: by 2002:a1c:f90f:: with SMTP id x15mr4620092wmh.69.1564096551576;
        Thu, 25 Jul 2019 16:15:51 -0700 (PDT)
Received: from mcroce-redhat.homenet.telecomitalia.it (host21-50-dynamic.21-87-r.retail.telecomitalia.it. [87.21.50.21])
        by smtp.gmail.com with ESMTPSA id v23sm44657202wmj.32.2019.07.25.16.15.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 16:15:50 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] mvpp2: document HW checksum behaviour
Date:   Fri, 26 Jul 2019 01:15:46 +0200
Message-Id: <20190725231546.23878-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware can only offload checksum calculation on first port due to
the Tx FIFO size limitation. Document this in a comment.

Fixes: 576193f2d579 ("net: mvpp2: jumbo frames support")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index d8e5241097a9..2f7286bd203b 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -843,7 +843,10 @@ static int mvpp2_bm_update_mtu(struct net_device *dev, int mtu)
 		/* Add port to new short & long pool */
 		mvpp2_swf_bm_pool_init(port);
 
-		/* Update L4 checksum when jumbo enable/disable on port */
+		/* Update L4 checksum when jumbo enable/disable on port.
+		 * Only port 0 supports hardware checksum offload due to
+		 * the Tx FIFO size limitation.
+		 */
 		if (new_long_pool == MVPP2_BM_JUMBO && port->id != 0) {
 			dev->features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
 			dev->hw_features &= ~(NETIF_F_IP_CSUM |
-- 
2.21.0

