Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FF9C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2259720665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FDJPC7yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfHMTL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:11:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37413 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHMTLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:11:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id 129so5222986pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 12:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OUQw1gzY+2u1O9xiTfFMM+UyeEs+TCFLOE05raHDrEk=;
        b=FDJPC7ypuE9mls/enQE4a/f5cvsRt5EgFgfdHAFW7EbY0yOkFxAY56g3jBNt72xTYy
         RB5xl/ko8wqEtGBZN50hgF+AwhGON6FD7+YkCFI1j3x65J86h1ouy6kq6/IiVdsohlfh
         7FxMs60Yco75c8f3sjMePu4pW79u9l6J7fBaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OUQw1gzY+2u1O9xiTfFMM+UyeEs+TCFLOE05raHDrEk=;
        b=ebJKmcFnzW5xHcJA7I7wiuaGPKlhb3HNPtrs22ZAWPmo95rydT+19DTKMwXH06ZDkA
         uJon9M5npKEQsacLZnR5tZ/MlOX5ES9BolFvVk7JQalnDrLxvmgx/AiKF6e5uaOkrhdf
         0CthYT806vnQFGhiyrvu90LHXv6mKyA0+yOiOzyjWXaizegZ8Rn9Zoi3eyiTTS0dumLH
         7LZ9HjEyaUkzR9tfk5gY74Qhf+BQNBSaRMk73x4+r01+ICG+yfrFXrYoRavDubukNiHB
         FyBWGAYrxD+ZAw2/27EddyZ8CkzdJXZ2LDwrR0+Kh+fhiJ+gzB8jGTU1KYoMC2fjDefV
         s3hw==
X-Gm-Message-State: APjAAAWvQoNKqEqsYBCk/IBB0ogkSbtYeMA9EgH0VJm0wT2batKCDYu7
        iL+Fl/DWY/NuRuLgODc83f3+Tw==
X-Google-Smtp-Source: APXvYqzlu/F8V1w3r2GIwuoeaxUHJxJy7XCMy3Xw/LHRtkB/82GTcqpB5crY4+VYjjUXwn46miSYIw==
X-Received: by 2002:aa7:91cc:: with SMTP id z12mr42474700pfa.76.1565723515189;
        Tue, 13 Aug 2019 12:11:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id z63sm84970326pfb.98.2019.08.13.12.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 12:11:54 -0700 (PDT)
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
Subject: [PATCH v6 0/4] net: phy: Add support for DT configuration of PHY LEDs and use it for RTL8211E
Date:   Tue, 13 Aug 2019 12:11:43 -0700
Message-Id: <20190813191147.19936-1-mka@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a generic binding to configure PHY LEDs through
the device tree, and phylib support for reading the information
from the DT. PHY drivers that support the generic binding should
implement the new hook .config_led.

Enable DT configuration of the RTL8211E LEDs by implementing the
.config_led hook of the driver. Certain registers of the RTL8211E
can only be accessed through a vendor specific extended page
mechanism. Extended pages need to be accessed for the LED
configuration. This series adds helpers to facilitate accessing
extended pages.

Matthias Kaehlcke (4):
  dt-bindings: net: phy: Add subnode for LED configuration
  net: phy: Add support for generic LED configuration through the DT
  net: phy: realtek: Add helpers for accessing RTL8211x extension pages
  net: phy: realtek: Add LED configuration support for RTL8211E

 .../devicetree/bindings/net/ethernet-phy.yaml |  59 ++++++++
 drivers/net/phy/phy_device.c                  |  72 +++++++++
 drivers/net/phy/realtek.c                     | 137 ++++++++++++++++--
 include/linux/phy.h                           |  22 +++
 4 files changed, 275 insertions(+), 15 deletions(-)

-- 
2.23.0.rc1.153.gdeed80330f-goog

