Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B01C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45B72178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHfr/Fy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389228AbfKGOO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:14:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41213 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389032AbfKGOO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:14:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so3186670wrm.8;
        Thu, 07 Nov 2019 06:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SySlf9LlN4iQ5DOxcm689bd9gGZWJLbEiQiXadmQ1Pk=;
        b=UHfr/Fy0eKNYcLbTRmDFkD8ByLbeJuZ98PewgJnQ9K47BY1w6YNNND/1frcRFyjHYs
         ykqLJocw8egu1fRyxlZkcz9UWGaPlleM7yTcft6cZIXFqB6A2yo6aIBWX8+R1hM2XhWo
         5exEx26Z6Qvoo62u6gmzfkHWLvNa5ncHQKYxImXIWbhffMRQHk/bhDwe2ysIVZWakJW0
         h+f/th2fALLj8N3unjhmpXSGtR/s7yp5oMwkriW9fTWoGEZYrexFikYEyjesQM9Zm65Q
         YWO4i+iMmmOAAOTOBhzi8THEfdgTj6R9BqZiik9wy7sHGRchD4hMvevOHnGJua2e6gap
         2W9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SySlf9LlN4iQ5DOxcm689bd9gGZWJLbEiQiXadmQ1Pk=;
        b=dmHE7U+Jd2cJjfb5Aw2idLePZc1clqB3Cd0M8Xfwpehjfx6bLWiWxgUBUBqOOup/lL
         EzOIrxqQFrbaEMmUcX3KRFTyVBnxmlu0DNmkNRrRwqgrvQkuhzq92uTmrx5ui3FWccHO
         IfK2kv/N+q4UOR66crewvgfYX3/JZdA2kgN9msu5PDl7KPko8Do2C5gyxD+FqCtH32o7
         jhFBfF/pIINlUcAKwnbm0App/ECe5MnlxAK6nd42Z1IyXB0pzUH6WviM/oULy85M3Fl+
         NIgsOx6VcU8mD/Ev1x+nZrWBgchG4FzwNnpjMU9q0xmHoRfOQPQJ2zE9L+pcQQEuWg4o
         08AQ==
X-Gm-Message-State: APjAAAXLMG0SAgX4NjHZwrclSPlrZ7YHfRtWslHNIJhHWT4nrApmME74
        5nddyPFe3GEMEN6ogEbSESIxaUOvO+8=
X-Google-Smtp-Source: APXvYqz3a62TlecYMknedHe56Nzvz4QPMUm0c4y7nxYBP+UKHA+WI3HCrJm0EKZ9PUZYV+Hho7vQ5w==
X-Received: by 2002:a05:6000:11c4:: with SMTP id i4mr3054296wrx.277.1573136063599;
        Thu, 07 Nov 2019 06:14:23 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id b1sm2453888wrw.77.2019.11.07.06.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 06:14:22 -0800 (PST)
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
Subject: [PATCH 00/13] phy: usb: Updates to Broadcom STB USB PHY driver
Date:   Thu,  7 Nov 2019 09:13:26 -0500
Message-Id: <20191107141339.6079-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add support for 7216 and 7211 Broadcom SoCs which use the new
  Synopsis USB Controller.
- Add support for USB Wake
- Add various bug fixes.

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
 drivers/phy/broadcom/phy-brcm-usb.c           | 264 +++++++++--
 6 files changed, 938 insertions(+), 185 deletions(-)
 create mode 100644 drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c

-- 
2.17.1

