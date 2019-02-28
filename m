Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3D4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B4520C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfWwrqtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfB1Xtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:49:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38743 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfB1Xtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:49:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so10488631pgl.5;
        Thu, 28 Feb 2019 15:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cfeWYDhvrY7EVRmRpIjDOElTmvmNnMw6E+QdE24yh/E=;
        b=nfWwrqtQvbDAzHdIGV8h5jIBUStU7xeay5fYDOjqTpEfu+1jqv96nKnrcfv+3yEESP
         07Wylj6B/lu3d/qIc5hZBt+7ItmK1jqlhE0hgcEDGMR+3EZdY3j6ThjxdnUu2xnVxE0F
         DD0d69gUVH0BdArMD52BHlrxWBxW6CQUshG7e/f0BB4CdjBF796O5QGTXAAl5/e7owVq
         wqbgEL8Hmna0xbBid1bmmZkU5/2ovviz9EHpif/0z7RDn0JKS13mIn5ZWeEO6y+ynZ4i
         5iUGkupQ6yPziOSQgUy98VM+Oz8v3dhwOaH7BpOL67WY0zgZVynrrKNxI3BLURJjTja7
         zVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cfeWYDhvrY7EVRmRpIjDOElTmvmNnMw6E+QdE24yh/E=;
        b=HXeKIMrz7O5rJlQ+832ssR9ePUvuMgs5O6MWhth0mpMEqfq5qSQXgq/vbJcqig154q
         qDjWzqNMqbEHSsZ4dswQ1FB1pui/KH5gPCz4jq4KMk7CzUNA/I974LJuUMMsznyr9DhM
         mE4RwYUXCGVZuYYL1swDEsMD75ZlC1a2ssK+blCVMolXTiRDnWZi4hIu9UU14n7/6WwV
         pv9LAEbT6rVv3cPf0UwFJ05b5ktJFUmnXl3H9wsgX5zPlHJF+jn8CPuU5gK/jS0Jm0zJ
         rVZ4n4VjREVxuRZ7r0RefiBs8i1l+JsqUlIg3PZrYhUBEHjiomMAADsI4TB/BaJE+Zwo
         mFFw==
X-Gm-Message-State: APjAAAXeKE2xXr54l6Fa9oRBezMbFVIH9lRnM/pGg0plG4xlPOSXKo87
        /bEcnIwu/OHfuGJ6KfAE5KOfRCEp
X-Google-Smtp-Source: APXvYqyia1iF62CPcghu/mkR16mwEx6Z7AVmgtfWvmUYfidbGZThkkVd6pUd0Ji9mDsEoplReIAvuw==
X-Received: by 2002:a63:e310:: with SMTP id f16mr1746826pgh.93.1551397789653;
        Thu, 28 Feb 2019 15:49:49 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q207sm24090667pgq.88.2019.02.28.15.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 15:49:48 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: Do not configure VLAN ID 0
Date:   Thu, 28 Feb 2019 15:49:36 -0800
Message-Id: <20190228234936.1593-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because we skip the prepare phase, we would not get a chance to have the
port_vlan_prepare() callback return -EOPNOTSUPP and tell us about that.
This causes problems with mv88e6xxx which specifically checks for VLAN
ID = 0. Turns out we do not actually need to program that VLAN ID since
it should be the default one for switches anyway.

Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Fixes: 061f6a505ac3 ("net: dsa: Add ndo_vlan_rx_{add, kill}_vid implementation")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 1808a2cd6872..ec54d579645a 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -996,6 +996,9 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 	struct bridge_vlan_info info;
 	int ret;
 
+	if (vid == 0)
+		return 0;
+
 	/* Check for a possible bridge VLAN entry now since there is no
 	 * need to emulate the switchdev prepare + commit phase.
 	 */
@@ -1029,6 +1032,9 @@ static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
 	struct bridge_vlan_info info;
 	int ret;
 
+	if (vid == 0)
+		return 0;
+
 	/* Check for a possible bridge VLAN entry now since there is no
 	 * need to emulate the switchdev prepare + commit phase.
 	 */
-- 
2.17.1

