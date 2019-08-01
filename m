Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A264C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D848206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B4uOlTCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbfHATIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:08:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35033 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388392AbfHATII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:08:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so28417417pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hx9o90A7y9Lqi0bsW+AYCfLx5zEgBR2s/MHaOJZ+Odg=;
        b=B4uOlTCntU3Vd6DbT7HMq33aP15Z6dAhQKsPtvLjqymcjYhhYFIzxmLKJ0GxUFlps5
         nSrfB6UE3ajVLcDoQjMzgJhgSJ+GrWpgdqH+FTHjP9TpDap99LhK22LbNrgAYbGJtL+K
         bsnQDJ0jjmmgT8N6b9OkR8UYlV7MNWZbH6tFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hx9o90A7y9Lqi0bsW+AYCfLx5zEgBR2s/MHaOJZ+Odg=;
        b=Pz9cB1uQZjqSpCVz2kyMJphHou4Ca1H06rOWFYwXOorZhvo/12ZHCY7pDBAz3Izk4z
         inCuY+Fg28T3sQhxQKgoP4J1UM77Mvb5+DS02dVxmlwAPPKUCBgJ5SY3CxDQ2uOkWcoE
         obodToQUl4kdHNJE5X1X6iLRojp8qQEO27lDfhjLGWJm/cDiOHzYRtIiIcrmNNBSYOIn
         tN9r6ZgnMnzSj+rNMMS5gBXQzy1fLF+aAIcQ5yF+EkeyPvuLkwMUNxQXwXdYEGW20iV1
         6BtJabTM4xx7FJnfgdl8+0GyQTv8JC03kYOuBsx+C+Fjor0EntFExNElGaomuhwUrkfY
         o6pg==
X-Gm-Message-State: APjAAAXyJEEwLQXZgw5Z30ZdaQ8iJwK3qby92Uk2rZy4OmTvPESeHeZ/
        ZCRRaFX9TpF+5CVi8t2LZeEt0w==
X-Google-Smtp-Source: APXvYqwRicFNmz4AgkUWxNKTeN7RdaR/ysKRKSpwCSZMzo2trQXy+pSb+B3RKJmiboxDVO/pWZO/3w==
X-Received: by 2002:a17:90a:b883:: with SMTP id o3mr331219pjr.50.1564686487466;
        Thu, 01 Aug 2019 12:08:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p27sm108790378pfq.136.2019.08.01.12.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 12:08:07 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 3/4] net: phy: realtek: Add helpers for accessing RTL8211E extension pages
Date:   Thu,  1 Aug 2019 12:07:58 -0700
Message-Id: <20190801190759.28201-4-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801190759.28201-1-mka@chromium.org>
References: <20190801190759.28201-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTL8211E has extension pages, which can be accessed after
selecting a page through a custom method. Add a function to
modify bits in a register of an extension page and a helper for
selecting an ext page. Use rtl8211e_modify_ext_paged() in
rtl8211e_config_init() instead of doing things 'manually'.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v4:
- don't add constant RTL8211E_EXT_PAGE, it's only used once,
  use a literal instead
- pass 'oldpage' to phy_restore_page() in rtl8211e_select_ext_page(),
  not 'page'
- return 'oldpage' in rtl8211e_select_ext_page()
- use __phy_modify() in rtl8211e_modify_ext_paged() instead of
  reimplementing __phy_modify_changed()
- in rtl8211e_modify_ext_paged() return directly when
  rtl8211e_select_ext_page() fails
---
 drivers/net/phy/realtek.c | 48 +++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index a669945eb829..e09d3b0da2c7 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -53,6 +53,36 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, RTL821x_PAGE_SELECT, page);
 }
 
+static int rtl8211e_select_ext_page(struct phy_device *phydev, int page)
+{
+	int ret, oldpage;
+
+	oldpage = phy_select_page(phydev, 7);
+	if (oldpage < 0)
+		return oldpage;
+
+	ret = __phy_write(phydev, RTL821x_EXT_PAGE_SELECT, page);
+	if (ret)
+		return phy_restore_page(phydev, oldpage, ret);
+
+	return oldpage;
+}
+
+static int rtl8211e_modify_ext_paged(struct phy_device *phydev, int page,
+				     u32 regnum, u16 mask, u16 set)
+{
+	int ret = 0;
+	int oldpage;
+
+	oldpage = rtl8211e_select_ext_page(phydev, page);
+	if (oldpage < 0)
+		return oldpage;
+
+	ret = __phy_modify(phydev, regnum, mask, set);
+
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
 static int rtl8201_ack_interrupt(struct phy_device *phydev)
 {
 	int err;
@@ -184,7 +214,7 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 
 static int rtl8211e_config_init(struct phy_device *phydev)
 {
-	int ret = 0, oldpage;
+	int ret;
 	u16 val;
 
 	/* enable TX/RX delay for rgmii-* modes, and disable them for rgmii. */
@@ -213,19 +243,9 @@ static int rtl8211e_config_init(struct phy_device *phydev)
 	 * 2 = RX Delay, 1 = TX Delay, 0 = SELRGV (see original PHY datasheet
 	 * for details).
 	 */
-	oldpage = phy_select_page(phydev, 0x7);
-	if (oldpage < 0)
-		goto err_restore_page;
-
-	ret = __phy_write(phydev, RTL821x_EXT_PAGE_SELECT, 0xa4);
-	if (ret)
-		goto err_restore_page;
-
-	ret = __phy_modify(phydev, 0x1c, RTL8211E_TX_DELAY | RTL8211E_RX_DELAY,
-			   val);
-
-err_restore_page:
-	return phy_restore_page(phydev, oldpage, ret);
+	return rtl8211e_modify_ext_paged(phydev, 0xa4, 0x1c,
+					 RTL8211E_TX_DELAY | RTL8211E_RX_DELAY,
+					 val);
 }
 
 static int rtl8211b_suspend(struct phy_device *phydev)
-- 
2.22.0.770.g0f2c4a37fd-goog

