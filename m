Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A889CC00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C652215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEXPB5wZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgAFBgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:36:06 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39687 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgAFBeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:34:46 -0500
Received: by mail-lf1-f68.google.com with SMTP id y1so35320857lfb.6;
        Sun, 05 Jan 2020 17:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CkOxMb8MLB/z4Q/y2dHyNNeQ96KLRUp7GW5wicnZ/Co=;
        b=gEXPB5wZoCjRBYNpi5yemWO85whmF6IFyO7yOxC3A00Kv8UpN0HX9SMsLg3ksCFpV1
         mNCi73WMakKkwcerlaoHZRVx5gnT8TbdXs4QQtDHDWP2jMaQKq1NSzl51IpovaOu8Yfu
         pQcI6d6a95zMGeRdYJy5DEuJTzMD69/1b0dl3U253RneD/egE3D4wR+BQumgLWkap3O8
         PBPpKFyKv2lPUcglmGxjLQNSbdUHixRpuk4wscsIUDBGMTasax2gnRrDUbr9XiIj/p7B
         Ka7/shjJtiW1cVzYFgINJol9k+ulCceoaX/k9ngICvmSuImjj8L2pUqEf1oUVF2arO9p
         FBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CkOxMb8MLB/z4Q/y2dHyNNeQ96KLRUp7GW5wicnZ/Co=;
        b=aMepnaVkNlIpqVUoGc/P3xSA1cgExfVAmSuvwimAmQQCqNRFqZNEhDXQt3KlkglkYa
         8DHeKgTHN2MTgBnloaFaDuTCrwvqJ3veEY4ZblN0WOAGF7KAABjO4a/BJTY7tNHUDaL/
         S+HlWJRXbHdlhGMkEjh1e3S4zyukeKx4xPfin+q1EDw9en88D66UExJLeyOd8+0xQCP0
         aee3Y+QwmVgmFboRsuLBkZBbq3Ee73g+VBOX9YM75Ghc7oQB5cmxQ8Arb76MBa+ExrET
         x4UfYirWegreuRaTOfm4u+2imQgdfY8ANrot8KqVAWgPxNoiS2nIhK3K8N4T9uaAF3Et
         cRNQ==
X-Gm-Message-State: APjAAAVVAUGFmaz0zYDU+PFMRRkIU5nZxNFv0NRD1SwTrxCm9SnMx5gY
        zrVOa6qC0MKM4tIB5/EcyuW8Rg69
X-Google-Smtp-Source: APXvYqznR+oyJpYX509o8r8Sw5SiTXqU+JN9HQTo/g0PhBrrGBJWw0KgiqOzDzxer3ZO1aw0SQXIiA==
X-Received: by 2002:a05:6512:244:: with SMTP id b4mr54406085lfo.85.1578274484369;
        Sun, 05 Jan 2020 17:34:44 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:43 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/20] usb: phy: tegra: Keep track of power on-off state
Date:   Mon,  6 Jan 2020 04:34:00 +0300
Message-Id: <20200106013416.9604-5-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106013416.9604-1-digetx@gmail.com>
References: <20200106013416.9604-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHY driver should keep track of the enable state, otherwise enable
refcount is screwed if USB driver tries to enable PHY when it is already
enabled. This will be the case for ChipIdea and Tegra EHCI drivers once
PHY driver will gain support for the init/shutdown callbacks.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c   | 30 ++++++++++++++++++++++++++----
 include/linux/usb/tegra_usb_phy.h |  1 +
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 99acfde4ab8d..88466c7f13e6 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -785,18 +785,40 @@ static void tegra_usb_phy_close(struct tegra_usb_phy *phy)
 
 static int tegra_usb_phy_power_on(struct tegra_usb_phy *phy)
 {
+	int err;
+
+	if (phy->powered_on)
+		return 0;
+
 	if (phy->is_ulpi_phy)
-		return ulpi_phy_power_on(phy);
+		err = ulpi_phy_power_on(phy);
 	else
-		return utmi_phy_power_on(phy);
+		err = utmi_phy_power_on(phy);
+	if (err)
+		return err;
+
+	phy->powered_on = true;
+
+	return 0;
 }
 
 static int tegra_usb_phy_power_off(struct tegra_usb_phy *phy)
 {
+	int err;
+
+	if (!phy->powered_on)
+		return 0;
+
 	if (phy->is_ulpi_phy)
-		return ulpi_phy_power_off(phy);
+		err = ulpi_phy_power_off(phy);
 	else
-		return utmi_phy_power_off(phy);
+		err = utmi_phy_power_off(phy);
+	if (err)
+		return err;
+
+	phy->powered_on = false;
+
+	return 0;
 }
 
 static int	tegra_usb_phy_suspend(struct usb_phy *x, int suspend)
diff --git a/include/linux/usb/tegra_usb_phy.h b/include/linux/usb/tegra_usb_phy.h
index 0c5c3ea8b2d7..3ae73bdc6245 100644
--- a/include/linux/usb/tegra_usb_phy.h
+++ b/include/linux/usb/tegra_usb_phy.h
@@ -78,6 +78,7 @@ struct tegra_usb_phy {
 	bool is_ulpi_phy;
 	int reset_gpio;
 	struct reset_control *pad_rst;
+	bool powered_on;
 };
 
 void tegra_usb_phy_preresume(struct usb_phy *phy);
-- 
2.24.0

