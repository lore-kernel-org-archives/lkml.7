Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3C8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027B22183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="g/Sm8U2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfC2OPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:15:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36023 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbfC2OPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:15:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so2821164wrd.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bExmUihlojOJWJX0CUX8FKYpFpDddupLfDG529pJpzQ=;
        b=g/Sm8U2S9xlkqAbA1k9ap39rlQXWapDtM+NsjWba0s2K/qaa4rvrkeqGsD7TQqkXV/
         KPVRT5AjP72EXtkQkHWLhQ/yWGBoJz8AS9rNlQZL3htDoPIowtVrmIsDmO3vk1/rtvGz
         izBlUfl2Jpegp8YukK7dFSF+7MSgj6mVts8kPEQddqBQ6OE5ycEFZLY5I0c4lJaVq+Gn
         R5rBQ8P/d/XZYCeJdqgsY+RMKiT/zsnhva59juQAN6HdSxp86alO126LN94IeA/yH5BQ
         +dMUMzSxH+mTLzaxKo6Ajx418gqq6fZTccspYuDoRn3Y5IIix/5a187VEb9cR3SLZOLI
         Q42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bExmUihlojOJWJX0CUX8FKYpFpDddupLfDG529pJpzQ=;
        b=nx3AtrgU2FeCU5gySBo4owyERzYyv7jWKt0UX31w05YDus05vaKgAq8fX941qsYr3e
         szU63Q8knNkelZILySZ4Bv6XXCYIMty87fZI7te6pxxi0Xo11aUnST+dqhjLqrr8iyfF
         Ovy7X8zMlYJXKoI5aCPvwGvOZzJRK1fhC8yLZ8N0T+bHGPFBNVLhffd2BoNXl5g67DTF
         sXxfiT3vCr+mbQ/Auishl15vsq3c2p5j7zbkEWlG1hHYJiCpkhqcD1Rujs0l8li4on63
         Qs7tnFKpcrPLAxOWSKwa3mkcdXd75m7nwJzRIXV4c9SChG+tcVl/CP7WxXIxhtr2jkBs
         NdZw==
X-Gm-Message-State: APjAAAXhZvag7IOhbYv6Kf1RWZyRvUD2Gi0zWjfIgpwXdlCfYfpSA46C
        IsxmK3oedUm8TsYsXIymXViiIw==
X-Google-Smtp-Source: APXvYqxgaOW6G4ZVwbyC2eivSdpIAv2a2MY70WF0EGGyQajxt1WUL27rRuCeJBZjm/vsm9f0bdj8wQ==
X-Received: by 2002:adf:dd49:: with SMTP id u9mr29632628wrm.316.1553868919236;
        Fri, 29 Mar 2019 07:15:19 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id 67sm2464333wmz.41.2019.03.29.07.15.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 07:15:18 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH net-next v2 0/3] net: phy: add Amlogic g12a support
Date:   Fri, 29 Mar 2019 15:15:09 +0100
Message-Id: <20190329141512.29867-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the necessary bits to support network on the Amlogic
g12a SoC family.

Only the internal PHY and related MDIO mux needed to be addressed.
The GMAC remains compatible with axg SoC family

This series has been tested on the u200 (S905D2) with both the internal
and external (Realtek) PHYs.

Change since v1 [0]:
* drop '_' from function name unrelated to locking
* fix peripheral clock disable on error
* fix variable declaration reverse Xmas trees
* fix Kconfig dependency on CCF
  (Actually needed for 'struct clk_hw', Thx Andrew !)
* Minor fix in the DT exemple as reported by Rob

[0] https://lkml.kernel.org/r/20190314140135.19184-1-jbrunet@baylibre.com

Jerome Brunet (3):
  dt-bindings: net: phy: add g12a mdio mux documentation
  net: phy: add amlogic g12a mdio mux support
  net: phy: meson-gxl: add g12a support

 .../bindings/net/mdio-mux-meson-g12a.txt      |  48 +++
 drivers/net/phy/Kconfig                       |  10 +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/mdio-mux-meson-g12a.c         | 379 ++++++++++++++++++
 drivers/net/phy/meson-gxl.c                   |  14 +
 5 files changed, 452 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt
 create mode 100644 drivers/net/phy/mdio-mux-meson-g12a.c

-- 
2.20.1

