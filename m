Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EC3C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D0A25C3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="hZaEcrWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfEaHrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:47:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41741 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfEaHrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:47:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so5797631wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 00:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=dzpfityjiyVjBLgLIDdS7jy7fuGuzY8jJendAr5fdaU=;
        b=hZaEcrWuUar2mSp1ulSSIeJ12sn8rUP1OAZf+IIRLpBbnKhQSP9vi0gQXR0j1ER0LX
         ltI4MssBF2CzGdisONdQnG4gD88VboWQpwTL4trObnfDYR3Sl/QFjKXn9dby4LOS043X
         3Rops2zaYBopA+JOQ7ZNXWXkJsaNcBwiOE/9T0nsnPbNUxOwEAvapWcICHZuH3or8+mt
         8ZX1Pgan+DnhKlHYud7azYM+juhUDqlDTTbFLwWum0uUKv/+cLO6k9tuvm6x+605IMli
         yWW9EQXOgkBgS7mI9g53fdyB525QQpsuP4QZcJVDgLZkUqMELDZVpMazCy6hyuS6Ffg1
         +64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dzpfityjiyVjBLgLIDdS7jy7fuGuzY8jJendAr5fdaU=;
        b=OKPY9gUfKjtQ+ODAHHvcl7T1Zffb1NcTfaK6ZIMPyHMb0XAim5sERV6TzvVLvuWact
         4rplFCgBJ9esEhGx7lqDUz5QkGOYM4Uy45QvZFCrN3Oc3T1u4jBgDhK8ttKAkwAisgnd
         vtsbYXN62khHJw5/B8qd3HfChHDsGkM0Qc5kd+a1n08LuxVeopodKKSBKpJ5ldu/qz9u
         863r0XS4OekfwOa86yTnWj3CtEqeZVQsFjvnx1HNzUzWkX+eSfPIHaGEeqdBL6fY72S0
         ctWDSrmwD6Rs5Ijaz8Vucglii9AJPhUpCFkvol+EVs3qz2rCEpuKmSrSpU0UjfFLutcb
         ZQIA==
X-Gm-Message-State: APjAAAWRWzSrWm1yREBN6b6L4IieYMjc80qC7wYzJRU57rxuY9taW423
        G+kCRnLHhLH5nQJ4VzrBZgiuNQ==
X-Google-Smtp-Source: APXvYqyOtIS/CRng6RAf7TVt12TGYUminrxW7vT1l9v+5dGgwHi0wPivDQp+dRnsatvgBKL/P8MrvQ==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr5380589wru.301.1559288863582;
        Fri, 31 May 2019 00:47:43 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id a4sm11022778wrf.78.2019.05.31.00.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 00:47:43 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] net: phy: support C45 phys in SIOCGMIIREG/SIOCSMIIREG ioctls
Date:   Fri, 31 May 2019 10:47:27 +0300
Message-Id: <20190531074727.3257-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change allows phytool [1] and similar tools to read and write C45 phy
registers from userspace.

This is useful for debugging and for porting vendor phy diagnostics tools.

[1] https://github.com/wkz/phytool

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/phy/phy.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index e8885429293a..3d991958bde0 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -407,6 +407,7 @@ int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
 	struct mii_ioctl_data *mii_data = if_mii(ifr);
 	u16 val = mii_data->val_in;
 	bool change_autoneg = false;
+	int ret;
 
 	switch (cmd) {
 	case SIOCGMIIPHY:
@@ -414,12 +415,28 @@ int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
 		/* fall through */
 
 	case SIOCGMIIREG:
+		if (mdio_phy_id_is_c45(mii_data->phy_id)) {
+			ret = phy_read_mmd(phydev,
+					   mdio_phy_id_devad(mii_data->phy_id),
+					   mii_data->reg_num);
+			if (ret < 0)
+				return ret;
+			mii_data->val_out = ret;
+			return 0;
+		}
 		mii_data->val_out = mdiobus_read(phydev->mdio.bus,
 						 mii_data->phy_id,
 						 mii_data->reg_num);
 		return 0;
 
 	case SIOCSMIIREG:
+		if (mdio_phy_id_is_c45(mii_data->phy_id)) {
+			ret = phy_write_mmd(phydev,
+					    mdio_phy_id_devad(mii_data->phy_id),
+					    mii_data->reg_num,
+					    mii_data->val_in);
+			return ret;
+		}
 		if (mii_data->phy_id == phydev->mdio.addr) {
 			switch (mii_data->reg_num) {
 			case MII_BMCR:
-- 
2.11.0

