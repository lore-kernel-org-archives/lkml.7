Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E33DC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326F4208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mp3lCcnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfHOAKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 20:10:49 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39956 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfHOAKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:10:48 -0400
Received: by mail-qk1-f201.google.com with SMTP id g125so579046qkd.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 17:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lGPm9MxbmAUQCAKDVOCo9m8+lWvsCTcXX7D5eQLMP4k=;
        b=Mp3lCcnBAHWzuwotdFJ22/AnWkFC0KJLTXRTjmTsZog9RCRoX7t4+uC3KkmfklMhZA
         xfixkm4outUQ2EvOnnh9fqnqogx0m/bINTwQ9Hi+JHx8RqDqpGBid4/RJAvE9HQL9i1L
         IRH/tAgSGu0tLg17w59p/VfJInZcgQoviKmW1elQsFCquQQpOZhvMNDvW4OCyawK5MAK
         rQFwua4Qk3tqpabsg9uCU6tUlXj1fErtnuCV2HdNPppRsyy1cZmip0OxAcFbxfNTtXvE
         wPaB55GpTTPCqJ7XJqbFBEVxuvgRD1Boq64oKXwC2+aTuJp+VM34PCHcV+LiiuQoNx9e
         ZTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lGPm9MxbmAUQCAKDVOCo9m8+lWvsCTcXX7D5eQLMP4k=;
        b=ZLVeXWasvNCBfQjDWkM3E29JkrmSwX7EfEsrA0zxzLEwhmagD0mmpFoMZQ1ikhyiW2
         QQJGM7bdNqcAYulReKZ+/U2Y6Wed+QVITv3RwZ8m1hWEaTEJXM2ceG8vQjj+fg87RnFt
         akR16kAdYyKXwZ56b7zJfzXmRxS9byhtwAM6MEsxGAzvXTt5SNRDDdDhfzq3uBJJfS0t
         aj7F6VNqQJa7er2+dfPigjWRjUsY9cFFQe/+O5e8dTYvZCXChJAVSGzbmFornTW+MB/Q
         vDTWUFwvdq5cf96b3zygAwjUtOpTudVzEpHl/P08XgosxVar6L5AeMESbWww4f53EF0W
         UX6Q==
X-Gm-Message-State: APjAAAUglj+0RA7Xe1SfBjK8WwvN3WHRg1hSZWb8RNi94u2aNUXb8h3B
        1wwRo+deJLiCq0JKokMhzCt83C/BJQSB+Cab1Q==
X-Google-Smtp-Source: APXvYqz9Ui9f44A9T7dzKwgLs4cZuRrliuHzLHIwhhWkG/wEx/eeWTDelEvSgYt0nTo+rRU82eHwlulVhw1WZVWTjg==
X-Received: by 2002:a37:4c92:: with SMTP id z140mr1741376qka.245.1565827847608;
 Wed, 14 Aug 2019 17:10:47 -0700 (PDT)
Date:   Wed, 14 Aug 2019 17:10:43 -0700
Message-Id: <20190815001043.153874-1-wsommerfeld@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH] ipvlan: set hw_enc_features like macvlan
From:   Bill Sommerfeld <wsommerfeld@google.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Petr Machata <petrm@mellanox.com>
Cc:     Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        YueHaibing <yuehaibing@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        Mahesh Bandewar <maheshb@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bill Sommerfeld <wsommerfeld@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow encapsulated packets sent to tunnels layered over ipvlan to use
offloads rather than forcing SW fallbacks.

Since commit f21e5077010acda73a60 ("macvlan: add offload features for
encapsulation"), macvlan has set dev->hw_enc_features to include
everything in dev->features; do likewise in ipvlan.

Signed-off-by: Bill Sommerfeld <wsommerfeld@google.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 1c96bed5a7c4..887bbba4631e 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -126,6 +126,7 @@ static int ipvlan_init(struct net_device *dev)
 		     (phy_dev->state & IPVLAN_STATE_MASK);
 	dev->features = phy_dev->features & IPVLAN_FEATURES;
 	dev->features |= NETIF_F_LLTX | NETIF_F_VLAN_CHALLENGED;
+	dev->hw_enc_features |= dev->features;
 	dev->gso_max_size = phy_dev->gso_max_size;
 	dev->gso_max_segs = phy_dev->gso_max_segs;
 	dev->hard_header_len = phy_dev->hard_header_len;
-- 
2.23.0.rc1.153.gdeed80330f-goog

