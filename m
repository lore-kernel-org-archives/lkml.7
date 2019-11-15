Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8251C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A452072B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qghhLRcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKOSnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:43:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37760 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfKOSnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:43:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id t1so12058635wrv.4;
        Fri, 15 Nov 2019 10:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=agn5/+Ff+txwdkMYcl4dOnRhb7wogId0OeGIrqnhFKE=;
        b=qghhLRcUIuP5ShnvL5clvj3Ew+W2ALCsWLbLPM5QqviPGCT6qn4NScW27VVUpaWPBk
         oRX4p3UTPSZyh7vPQiuQ1wf/uuMAaSy/g22p8175W0zkubhz2MyZjvTCHzgj6jix46DC
         bsSZj457R7IXZ5QzFQt2gdQG/XYQPgwMUdMOW/bLoTjvagllAaG4FWlUBcyf3svP2Uos
         zhucpOF6ai8fgq8revALwXVvlcgwOrDZhSHakMbY5qClrkRHY3ZQ22jTwkqBtahuWNA4
         c6A7xwWeg3hkZc4EeObtUrt1h/lff185xMTq6j/LVzK43QgO87l8qh5NkIeM2Af7kbr4
         EzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=agn5/+Ff+txwdkMYcl4dOnRhb7wogId0OeGIrqnhFKE=;
        b=jjYDmJDKV1zrA9g2xAyKis/LqkqK1YZDj2Ip4RlisN2LQfIiGEbZoiVmIsAzwG0IKS
         /R661KZFPgA+YfDJvo7aeKI8dr/MckiiwM2+a0OJpUUISbRqbCUdQhcBwKV/LUn0kK3s
         c6OB6WJ/OituuIDgAQ30g57pzg4B1rR1RAFXmtESJOxQFdw0Nx8U3H+VahwAq0vR1e3k
         7pzxt6ibsYEIdotHCXfcILkC7UifggAITVxnOodUTcMNFG2KSAW2Wq9yH5XW8UgJkhDJ
         QAjkuZvchTepCvlAw3LTjelT0DDOaDQbj5lHGkboTJNzARayE/pGcyhJytNeh0S5jM0k
         OCmw==
X-Gm-Message-State: APjAAAUbCiT7fRexzM62iHWizqcSEUkh0kh3AYkMXZIPAQvOKAq9tDoj
        zQBopFfM8IQ7K6N5stgAjvnvStYx
X-Google-Smtp-Source: APXvYqy8rxlKN7DI2hT1o5s1rEAFlbHl7k3byVewAXowFyTRy4yq+mLGaWY+rDbAndFm3NdD3POjTg==
X-Received: by 2002:adf:e386:: with SMTP id e6mr16077536wrm.397.1573843410941;
        Fri, 15 Nov 2019 10:43:30 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id g138sm2620989wmg.11.2019.11.15.10.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 10:43:30 -0800 (PST)
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
Subject: [PATCH v2 00/13] phy: usb: Updates to Broadcom STB USB PHY driver
Date:   Fri, 15 Nov 2019 13:42:10 -0500
Message-Id: <20191115184223.41504-1-alcooperx@gmail.com>
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

