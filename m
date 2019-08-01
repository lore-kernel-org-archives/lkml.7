Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF44C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D926206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gwmU6JeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388390AbfHATIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:08:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36185 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfHATIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:08:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so34607021pfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=apkwzGP4IobB8/NNejp9mcACeRe6NRoi/dm5PJtLiA0=;
        b=gwmU6JeVACTqTalB1fGyyUE6Y+PbXjWGBdnnjoYJZifDNfOrVBs4HCjUYw4malCPHU
         f0ZFovJlm75tpLkdzNnowpiCbLTcFWATBF2cpd2dPKrlDsLaUB9EeHKVXssTlrS3VPB9
         i7pbNRebrh+9jkSTAT+8daVEXlN257aIGmvQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=apkwzGP4IobB8/NNejp9mcACeRe6NRoi/dm5PJtLiA0=;
        b=hvfWoBMBQHlYGHSrE9oVlyRrQIubWATbnb+Y+QPBAQOoldfp5Dg/dO1liFYLb1QDyh
         y9U2NiFocONCFVCCxJNadaHTiOttRrzyhwIhcWqQKByjbxNk92RqrpO1/L8GChj/maNw
         RS5DMQMpkKHEuLU5GvETz3PfMg0om1/L37cPIY2Kw845Xubrc4inXkiq0vDIQgXqI4nk
         h2MAAHFC8bIjw0oggsTCvbxoas+bUI2oGdttujgzZIf3J1ObbG2CZnoyo3+A0qvHAtK9
         dj9NpebzEMSU53C6YARSwz/qJUBcEfqhyGQPZbQi9n2maayllppv3B1tkKjnGXnjUPdU
         3rlw==
X-Gm-Message-State: APjAAAVtCRgrkj8GP/lPboctvr/OSuEbHneL2B5MdI9xHGp+L14KjzIc
        4WyyM2AvYY+rO0yo+pw7VOPYXA==
X-Google-Smtp-Source: APXvYqwGmPzsXWqQYmOZgCmSxakHKaF9ifqiLM5iTU08exAKI7L24QVO19d4DMzQIqU0FNUHp7xulA==
X-Received: by 2002:a62:ac1a:: with SMTP id v26mr56239768pfe.184.1564686483222;
        Thu, 01 Aug 2019 12:08:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id z6sm42715452pgk.18.2019.08.01.12.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 12:08:02 -0700 (PDT)
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
Subject: [PATCH v4 0/4] net: phy: realtek: Enable configuration of RTL8211E LEDs
Date:   Thu,  1 Aug 2019 12:07:55 -0700
Message-Id: <20190801190759.28201-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Realtek RTL8211E allows customization of the PHY LED behavior,
like which LEDs are on for certain link speeds and which LEDs blink
when there is traffic. By default EEE LED mode is enabled, in which
a blinking LED is on for 400ms and off for 2s. This series adds a
generic device tree binding for configuring PHY LEDs and adds LED
configuration support for the RTL8211E PHY.

Certain registers of the RTL8211E can only be accessed through
a vendor specific extended page mechanism. Extended pages need
to be accessed for the LED configuration. This series adds helpers
to facilitate accessing extended pages.

Matthias Kaehlcke (4):
  dt-bindings: net: phy: Add subnode for LED configuration
  net: phy: Add function to retrieve LED configuration from the DT
  net: phy: realtek: Add helpers for accessing RTL8211E extension pages
  net: phy: realtek: configure RTL8211E LEDs

 .../devicetree/bindings/net/ethernet-phy.yaml |  47 +++++
 drivers/net/phy/phy_device.c                  |  50 ++++++
 drivers/net/phy/realtek.c                     | 169 ++++++++++++++++--
 include/linux/phy.h                           |  15 ++
 4 files changed, 266 insertions(+), 15 deletions(-)

-- 
2.22.0.770.g0f2c4a37fd-goog

