Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87709C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 08:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469EA206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 08:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gP3TUJwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfCJIJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 04:09:04 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:33284 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfCJIJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 04:09:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id ADBFB956
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 08:09:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 82zoxFo0DPwr for <linux-kernel@vger.kernel.org>;
        Sun, 10 Mar 2019 03:09:02 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 7984D938
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 03:09:02 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id f10so1732422ioj.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 00:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UA+r0i/2/g9hcSMLNzAL0Ejv+ZZ8EOzLQPzPSXxyBdQ=;
        b=gP3TUJwITBxralS50u2r2ilu6AX6TUZdty/+e8+4eCy21D41SN9C5xy0nEU5CTx9Um
         IWcpoq08sgCUX7r5WbrCrQHqnGhT3yQr6rKnkljHY+2ZNtoraoWe47fFF/GH7YSJtl6E
         NsFfNo1JNRWL45Sgstb9f14ixwuu/SycYgPBBdLY/D7CzdPhjurlIqiCMB0bSXpDM73l
         Ovpcn0Co2s6TXtByweXJCzUQERQ2AFdWBbSLbSLYRNEVTuctJGdI1jSA1sdLnbEjjDVF
         Nf+PlSKPRzt5vz05etIROPFC3l5Q9vE/NdZ4IRTxsYP/w7XEx+NujDunBj8E715nt77u
         BBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UA+r0i/2/g9hcSMLNzAL0Ejv+ZZ8EOzLQPzPSXxyBdQ=;
        b=fMTpUvQ1urdZ45MnnsbUWbOsFmEx7AKqgypOZqWtl5jJXFAruIgPyCaGN9vvyj+wO8
         WaLxc6/ZbTIpOSfZ/nt3xeskJGCukze/pXnfZA838K2wNGLHqrLgFK/8zPtU8muUX9+m
         UHnVYhVOuLiJRvinzdf6XX02vamohGgcJy0EULNv9ivU2It4p6u6gu6raRmrvjjmVkW6
         Z+HsJsRWxa6hl1Lk9EOsZYkS6p9szYeOL4Tx/GYVodnmCYCz3OEBEctNYXmG1b9VK+9L
         ojCVw3Ufo+/aiQ+9F/sCKfvjpNCAjlO8qz7Gnm4Y9seCzO5Ce3SSL6Go1L5u7eyuyWun
         QGqw==
X-Gm-Message-State: APjAAAXAMGumcRUdJRUbSDjB32NgdJXyzUjp7hBUatXzqUMWFLJZ9Hc3
        pcDBfAJHjhSSgb1ZKv0KRg8dLkhro+3ruZU395FLhThS7d0D0/+njxU6WoGn59eFRQ43D38KnLv
        iQ6MQ9VFF63VEsMG4lTLFWcz1a6q+
X-Received: by 2002:a05:660c:128e:: with SMTP id s14mr14396898ita.158.1552205342029;
        Sun, 10 Mar 2019 00:09:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqzB+Vg1iwUpvaJs2gWzWHCS9ywq4s+YCEzrZRxoKsxo8GmChVPCcTTtXh47+fCiI80zcz8emA==
X-Received: by 2002:a05:660c:128e:: with SMTP id s14mr14396886ita.158.1552205341809;
        Sun, 10 Mar 2019 00:09:01 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id b36sm5462256itd.2.2019.03.10.00.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 00:09:01 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: lan9303: fix missing error handling
Date:   Sun, 10 Mar 2019 03:08:56 -0500
Message-Id: <20190310080856.4440-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both lan9303_phy_write and regmap_write may fail. The fix adds
the error handling to print error messages upon failure.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/dsa/lan9303-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index 2ffab7ee3d80..3f5e89f431f9 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1072,6 +1072,10 @@ static void lan9303_adjust_link(struct dsa_switch *ds, int port,
 		ctl &= ~BMCR_FULLDPLX;
 
 	res =  lan9303_phy_write(ds, port, MII_BMCR, ctl);
+	if (res) {
+		dev_err(ds->dev, "lan9303_phy_write failed: %d\n", res);
+		return;
+	}
 
 	if (port == chip->phy_addr_base) {
 		/* Virtual Phy: Remove Turbo 200Mbit mode */
@@ -1080,6 +1084,8 @@ static void lan9303_adjust_link(struct dsa_switch *ds, int port,
 		ctl &= ~LAN9303_VIRT_SPECIAL_TURBO;
 		res =  regmap_write(chip->regmap,
 				    LAN9303_VIRT_SPECIAL_CTRL, ctl);
+		if (res)
+			dev_err(ds->dev, "regmap_write failed: %d\n", res);
 	}
 }
 
-- 
2.17.1

