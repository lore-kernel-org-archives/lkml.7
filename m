Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C622EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983022073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6zlGdOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfLJNX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:23:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37086 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJNX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:23:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so20165112wru.4;
        Tue, 10 Dec 2019 05:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cBnDmOd1oyAwvS/dO5tRG/7xWRMnlpmBTWuorHo1pdg=;
        b=S6zlGdOf2taVM7tSfma9ybnx61nuzOAp7XkqvWLHCdLaJBnwwh/xBFqv/dJLT2b286
         dqAaJj7OTDZHfBJmnAXED9wMc2a5Q86Lau/qG6OAb38OPkgKAuDfmQ86j0cCTZ6XQQgt
         iz2ZkJSeGLBRXbJkueaNlHreuiLIq36eq6erjWu2iax4mAyINQo9/Wn5/XXtCAOrDWsE
         Pl+POaPn5FFf7+7jbxvieygirsduRn5HR8iOl7xl+7D41Y5Hq1kxEZkAeBi5Brb2VvLz
         KEJdIE0npUn8ltDsO7IDNZKOpKeGyeJUh2C5bNJHYBRl8Lbm/Mxa2YYUZZ8s93FxX4+N
         Fl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cBnDmOd1oyAwvS/dO5tRG/7xWRMnlpmBTWuorHo1pdg=;
        b=KZmaLUs5ZiJkRvuOx1VUcDbLzXnnYolgYcUpHjgh+YLs4SCAFXBoLDNfRZsDo2ugqC
         D4dCWTekBa6qW6Urc1zpbVq9dMI9zpVE1FeX8sfapBbDFLytI6WXB8TNAf9sXKIB7XCl
         ctTVx6H4M4SNdcE8tNI4U12itf8d8F8ANuAKmTlL44lh2iLNjjywzq+kugaVceH/8DvE
         OIcWn1Z8fRau2htFcJTKIv1qEyLl/XActv1a2mlbwXd/jtohASnGvP0lfKYYgbFQgNba
         cIAygq0bWYj8J8VA+tptQ1TFBpt5kys7OlPo6aEs2xh7GAo7ptVfXVIFpXkuDKdzDJ5e
         u/kw==
X-Gm-Message-State: APjAAAXU0ZrF0tCIL/L4FE8FaoEzh3ZHqjsZRf6BpsN1iFT+ESmxTxgO
        E9S9xCopdjMeIoDEUfz48tZxrMyVMQ8=
X-Google-Smtp-Source: APXvYqzK2JasnRBelbXspNc6ewhYIQKQQzH4s2L6GUsgHLkz3gIP7kiOBBpxBAXF2wVXbsdxtQ32uQ==
X-Received: by 2002:a5d:558d:: with SMTP id i13mr189956wrv.364.1575984204569;
        Tue, 10 Dec 2019 05:23:24 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id s82sm3101680wms.28.2019.12.10.05.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 05:23:24 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 00/13] phy: usb: Updates to Broadcom STB USB PHY driver
Date:   Tue, 10 Dec 2019 08:21:19 -0500
Message-Id: <20191210132132.41509-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains various updates to the Broadcom STB USB Driver.
The updates include:
- Add support for 7216 and 7211 Broadcom SoCs which use the new
  Synopsis USB Controller.
- Add support for USB Wake
- Add various bug fixes.

v3 - Rebase to v5.5-rc1

v2 - Changes based on review feedback
- Add vendor prefix to DT property "syscon-piarbctl"
- Use standard "wakeup" instead of "wake" for DT "interrupt-names"

Al Cooper (13):
  phy: usb: EHCI DMA may lose a burst of DMA data for 7255xA0 family
  phy: usb: Get all drivers that use USB clks using correct
    enable/disable
  phy: usb: Put USB phys into IDDQ on suspend to save power in S2 mode
  phy: usb: Add "wake on" functionality
  phy: usb: Restructure in preparation for adding 7216 USB support
  dt-bindings: Add Broadcom STB USB PHY binding document
  phy: usb: Add support for new Synopsis USB controller on the 7216
  phy: usb: Add support for new Synopsis USB controller on the 7211b0
  phy: usb: fix driver to defer on clk_get defer
  phy: usb: PHY's MDIO registers not accessible without device installed
  phy: usb: bdc: Fix occasional failure with BDC on 7211
  phy: usb: USB driver is crashing during S3 resume on 7216
  phy: usb: Add support for wake and USB low power mode for 7211 S2/S5

 .../bindings/phy/brcm,brcmstb-usb-phy.txt     |  69 ++-
 drivers/phy/broadcom/Makefile                 |   2 +-
 .../phy/broadcom/phy-brcm-usb-init-synopsis.c | 414 ++++++++++++++++++
 drivers/phy/broadcom/phy-brcm-usb-init.c      | 226 +++++-----
 drivers/phy/broadcom/phy-brcm-usb-init.h      | 148 ++++++-
 drivers/phy/broadcom/phy-brcm-usb.c           | 269 ++++++++++--
 6 files changed, 943 insertions(+), 185 deletions(-)
 create mode 100644 drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c

-- 
2.17.1

