Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1743AC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E405321841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYN27ktB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfFNRth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:49:37 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42582 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfFNRtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:49:35 -0400
Received: by mail-qk1-f194.google.com with SMTP id b18so2201002qkc.9;
        Fri, 14 Jun 2019 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wRAhZhrLfLhhdV/Rq1dlOYLTb1hbSAlGeDPpuNAv19w=;
        b=WYN27ktBEvZ17pvuTBeb8VPMh14T/DwYMafCxoLupBFHzYclpiMQ3kEY9pYz+v+rce
         rQUojwVQpkHhE2h3N+cErrXj1XcpssfhEunAR7KYq4R67IVm06h9ypkWFMg7LJAtaMGt
         z9unkhSBrF61q4BDu8Tn3fNv77e1Cwq/XM8J4HL1czm4IE83W2y9HVC4yb0GSrVNEeDk
         39BtBWqXOeEF/4g5fpfJw5LNbJqQ6tC/RJak/5CJJ1tDiOYyheXWuisS8+aPUUu2H95K
         z8U0LnK32oA2MmCp5CrjXHco0wKMPof7FpABTsPEBBEIc58CC/cnmimUb9eHSJAHmRYW
         OgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wRAhZhrLfLhhdV/Rq1dlOYLTb1hbSAlGeDPpuNAv19w=;
        b=rVHuGS+2IrUnWNph9NmVshTNAitJGkNhGnoXDVqYVNqA0PfIZ5FvPKaRUINTC9ZYld
         m3zCcjHBJTexZXYTHac14s+Ri2dej92Yy1KPK/bcOXaI1mJMGyI/oXgVqf2/uqxx6/n/
         vlnGaS6zX4cICuLQvWvL0w88bElVJW4+R9wka3M1mgUkE1YdZHZTsyu9hU5zmuKpmK+f
         JeCAEhP0B7NXyXkx8V12hoYZFQf0+HJ7s5YfBCnvRujvD4POMkLD3gbiukSnbUwfjlTf
         8KNIWB/bjr3dFjD/XJ/U6YJO7yqF96irrokcl1BAH71ae5XF+oToUIYGahkjsaSMzeDt
         XVmw==
X-Gm-Message-State: APjAAAXXcopddsC0Uci6dDJF61zWrcqAf+H8A/a1qeZuYBExdMtF+KP7
        BccsnLMWf4OjGUe/hHiFVfkhCwcDjIo=
X-Google-Smtp-Source: APXvYqyn694Htit39U1sPkMzwhGTOKbQfkn8EbEZCaIKSU9wfrjy0WdUQ2SVGfYw9QS5ZKOEwrDR/Q==
X-Received: by 2002:ae9:e842:: with SMTP id a63mr74198002qkg.143.1560534574016;
        Fri, 14 Jun 2019 10:49:34 -0700 (PDT)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id h26sm2751888qta.58.2019.06.14.10.49.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 10:49:33 -0700 (PDT)
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, f.fainelli@gmail.com,
        andrew@lunn.ch
Subject: [PATCH net-next v2 3/4] net: dsa: make dsa_slave_dev_check use const
Date:   Fri, 14 Jun 2019 13:49:21 -0400
Message-Id: <20190614174922.2590-4-vivien.didelot@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614174922.2590-1-vivien.didelot@gmail.com>
References: <20190614174922.2590-1-vivien.didelot@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The switchdev handle helpers make use of a device checking helper
requiring a const net_device. Make dsa_slave_dev_check compliant
to this.

Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 289a6aa4b51c..cb436a05c9a8 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -22,7 +22,7 @@
 
 #include "dsa_priv.h"
 
-static bool dsa_slave_dev_check(struct net_device *dev);
+static bool dsa_slave_dev_check(const struct net_device *dev);
 
 /* slave mii_bus handling ***************************************************/
 static int dsa_slave_phy_read(struct mii_bus *bus, int addr, int reg)
@@ -1408,7 +1408,7 @@ void dsa_slave_destroy(struct net_device *slave_dev)
 	free_netdev(slave_dev);
 }
 
-static bool dsa_slave_dev_check(struct net_device *dev)
+static bool dsa_slave_dev_check(const struct net_device *dev)
 {
 	return dev->netdev_ops == &dsa_slave_netdev_ops;
 }
-- 
2.21.0

