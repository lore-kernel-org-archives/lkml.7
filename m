Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0669C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C7A22297
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BGRcWBHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389131AbfHGRFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:05:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34228 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389099AbfHGRFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:05:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so41747977plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hOVkpljzYUmTwIx0wK5I0XqpoB+svzyJi3RWI0VTg84=;
        b=BGRcWBHnJhM6VxYGEIiHSWiRcwKmpraw9Ixza8jIf2ICJ+MiTBnbiFtNtTFglbmeSl
         DCiVQaXc3P3PPj0j4s0lSkvmbGP6M1hOyKgK7G5pT78NWptZC1cTLLKQLrXCXnFVNc30
         dqlwp2YE4YZ1dKSdBgo8EUerLNlL0ST8OPtDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hOVkpljzYUmTwIx0wK5I0XqpoB+svzyJi3RWI0VTg84=;
        b=JEjUDQjNzocvoVDGtwD1ItNuUSp1yEKZVBD/7lJv44RqOVwo1n0c7bfRKryLw4g/fQ
         0ddWKfqThfXm5V2v7ie3M8z+idfX4L/V8tBjVhaEnTsOO1UAA45lG8TwUjzZQknUiMVV
         ZyPEY3KmN3zO8Avlp9EtZ68WljUcBuKiqA0tSy+0YSrJf0Lwj8gT4NF8uPdbtMNkvWgh
         4mearRrNxZMvp+ts/zhSo8CVvkzdJ/I6WvCGxMhChS+YzVcqqh7RqZ/Dm30gVh+6kUHm
         SvedtGmPfnUQXq8TVn3/eS+oDtNYd/qZ+DW6sQUmrWsXgVy2Jzhq/Te+rYKaSjYEao00
         7Kww==
X-Gm-Message-State: APjAAAXsKNcoAX0qJ8HyoqIBro8q8stp/SM9oQ4FG9pBs3lK7JtcTX4P
        YNW14zli9XoHp76Z02/V9a/TVw==
X-Google-Smtp-Source: APXvYqyoJ2RmE6G+aeUGVjoAnFTrrVbiHhXfMAQNWIyweFTLc7SkfqVWa2cWFVHFBqK0BMw+WGFWfA==
X-Received: by 2002:a17:902:7b98:: with SMTP id w24mr8863485pll.163.1565197501710;
        Wed, 07 Aug 2019 10:05:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e10sm95041792pfi.173.2019.08.07.10.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 10:05:01 -0700 (PDT)
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
Subject: [PATCH v5 3/4] net: phy: realtek: Add helpers for accessing RTL8211x extension pages
Date:   Wed,  7 Aug 2019 10:04:48 -0700
Message-Id: <20190807170449.205378-4-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190807170449.205378-1-mka@chromium.org>
References: <20190807170449.205378-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some RTL8211x PHYs have extension pages, which can be accessed
after selecting a page through a custom method. Add a function to
modify bits in a register of an extension page and a helper for
selecting an ext page. Use rtl8211x_modify_ext_paged() in
rtl8211e_config_init() instead of doing things 'manually'.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v5:
- renamed 'rtl8211e_<action>_ext_page' to 'rtl8211x_<action>_ext_page'
- updated commit message

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

Changes in v3:
- use the new function in rtl8211e_config_init() instead of
  doing things 'manually'
- use existing RTL8211E_EXT_PAGE instead of adding a new define
- updated commit message

Changes in v2:
- use phy_select_page() and phy_restore_page(), get rid of
  rtl8211e_restore_page()
- s/rtl821e_select_ext_page/rtl8211e_select_ext_page/
- updated commit message
---
 drivers/net/phy/realtek.c | 47 +++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index a669945eb829..a5b3708dc4d8 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -53,6 +53,36 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, RTL821x_PAGE_SELECT, page);
 }
 
+static int rtl8211x_select_ext_page(struct phy_device *phydev, int page)
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
+static int rtl8211x_modify_ext_paged(struct phy_device *phydev, int page,
+				     u32 regnum, u16 mask, u16 set)
+{
+	int ret = 0;
+	int oldpage;
+
+	oldpage = rtl8211x_select_ext_page(phydev, page);
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
@@ -184,7 +214,6 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 
 static int rtl8211e_config_init(struct phy_device *phydev)
 {
-	int ret = 0, oldpage;
 	u16 val;
 
 	/* enable TX/RX delay for rgmii-* modes, and disable them for rgmii. */
@@ -213,19 +242,9 @@ static int rtl8211e_config_init(struct phy_device *phydev)
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
+	return rtl8211x_modify_ext_paged(phydev, 0xa4, 0x1c,
+					 RTL8211E_TX_DELAY | RTL8211E_RX_DELAY,
+					 val);
 }
 
 static int rtl8211b_suspend(struct phy_device *phydev)
-- 
2.22.0.770.g0f2c4a37fd-goog

