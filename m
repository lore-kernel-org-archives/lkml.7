Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FB6C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112BD20874
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z99wNxVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfDJA7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:59:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50220 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfDJA52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so669880wmi.0;
        Tue, 09 Apr 2019 17:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HKX8imsOzQFpPB7ctb0KuPzSZ6AlqS16QMZ5wNtKVQM=;
        b=Z99wNxVY4h6+VY8M+/Y7CggjoI0tgh5aWDFMWI2Ej8YB1/0X1zwWBZIQF5vFebe7q4
         B3N1pJKIa5SbEHLwMvduRZORFjDhskKKiGuHABE61TILea5jZsWXNvWWulmxq/zraJBg
         zZwfbrQsUCKYP2QWSwlfqe95HXVUjZ/TM3MQOuKNpQPQwySZ38o7U49hhN5JpBrUBzw9
         1HpYpuH2xidf77HyvXiq2ybNAN00O0ZIKLF7bd1noSVTN4MFtbauGGOnIpxrIIjbO7GD
         UykFFNExAC2PTJy72Qnbs8O+eV3p0WcIUBnMSFOxPvIDaUscE7OLEN5Pcj47iw3t3PNW
         buNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HKX8imsOzQFpPB7ctb0KuPzSZ6AlqS16QMZ5wNtKVQM=;
        b=WyZBMqjb8ycPmw9dqAX6rGTnfoozU+QKtCFBGYvvaz88IKLCatglK5Uaik87G8oTGG
         ybK0k8kGGnW9qvDL262mQ9HJVfpAQixZ3EIn+qkbNzhKdc8WZTCIfybAYnD2cr4VMoC1
         xZvhr5SsytPycFksT6r/t/DBY+UuiJMuXfpQ84z/AXCO0Ok2xBSlWpe35gmaW19+wYWD
         LPLWFRXW2FmREzHkUaYzKhJ/Ezeycd+FZ8hKdal06JhWXNDh6NH2bIaLpbaoNfindWaI
         lxn8UStL21G2QI4dqDFjdC5nn5iGl5CTOslC8zEWuLtK8nvIQ+TBnBWyt5Vlu0HgGfIN
         Q2dA==
X-Gm-Message-State: APjAAAXapZsjqtwD66nSSnevbDFJT/yjs9QBHAFdzlw7LesrB/JYU8h5
        C0CIDPgQINniQuI62+ZGWf8=
X-Google-Smtp-Source: APXvYqyP7xry1bGi3/TGTRA95cT5LqHoDvXmiaOPfs68Z4d4Xw33feSthHBbHNTam0ekKdBja6Lj6A==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr701658wmi.1.1554857846755;
        Tue, 09 Apr 2019 17:57:26 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:26 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 06/22] net: dsa: Call driver's setup callback after setting up its switchdev notifier
Date:   Wed, 10 Apr 2019 03:56:44 +0300
Message-Id: <20190410005700.31582-7-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the driver to perform some manipulations of its own during
setup, using generic switchdev calls. Having the notifiers registered at
setup time is important because otherwise any switchdev transaction
emitted during this time would be ignored (dispatched to an empty call
chain).

One current usage scenario is for the driver to request DSA to set up
802.1Q based switch tagging for its ports.

There is no danger for the driver setup code to start racing now with
switchdev events emitted from the network stack (such as bridge core)
even if the notifier is registered earlier. This is because the network
stack needs a net_device as a vehicle to perform switchdev operations,
and the slave net_devices are registered later than the core driver
setup anyway (ds->ops->setup in dsa_switch_setup vs dsa_port_setup).

Luckily DSA doesn't need a net_device to carry out switchdev callbacks,
and therefore drivers shouldn't assume either that net_devices are
available at the time their switchdev callbacks get invoked.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:
More verbiage in commit message.

 net/dsa/dsa2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index fe0a6197db9c..f4277ee314da 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -366,14 +366,14 @@ static int dsa_switch_setup(struct dsa_switch *ds)
 	if (err)
 		return err;
 
-	err = ds->ops->setup(ds);
-	if (err < 0)
-		return err;
-
 	err = dsa_switch_register_notifier(ds);
 	if (err)
 		return err;
 
+	err = ds->ops->setup(ds);
+	if (err < 0)
+		return err;
+
 	if (!ds->slave_mii_bus && ds->ops->phy_read) {
 		ds->slave_mii_bus = devm_mdiobus_alloc(ds->dev);
 		if (!ds->slave_mii_bus)
-- 
2.17.1

