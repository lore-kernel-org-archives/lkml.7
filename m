Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A7FC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4563721670
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNmKw5zO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfE1XCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 19:02:10 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:43207 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfE1XCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:02:10 -0400
Received: by mail-pg1-f182.google.com with SMTP id f25so90990pgv.10;
        Tue, 28 May 2019 16:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y/VOH6BvU/MWPvpHKCihH6D4NzgFmU0S2a+uGKoSxfM=;
        b=eNmKw5zOX7VdVJiTD0KDJa2omjSljFW6i4sFokUXCH8wI7sLNt0tMSdOBdJRA8viui
         C7+Hp5hJLhBbMCxOip/hGk7I7rdVpbXQfFZVnRcxEfaEyVhMZd5x/0lkYRVRjDSVmcox
         9w5dG2U1HdT1w19sLw0VBhFC2/e6GQMvxj0hzzHkfmremQoeNhcH9SDj4TtiBGaxbuvV
         Uy1GAy4RN6yezwjD93ML2baFzYrvwjJveYM7mfD1S6n1qn/GnVXEZS4IYmPnxmY3f5Ty
         8ozY77T60MEEV1ZBgc+FSadZg8V5O8PPuMc7YbyD7U79k7Fp52mLh+FF9QURK02+gNYu
         HSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y/VOH6BvU/MWPvpHKCihH6D4NzgFmU0S2a+uGKoSxfM=;
        b=GUs+3x5VI4ppUJRBlSpnBkSjbTWyw9hmQJTlsOWmZsviM6FKpg+qk9IizQ2nDp4VNF
         9R4V312rOIcwOquowf863KfcRG1Tw6KHcjxuxuSWVtp7MSqESTUtlYWJDGziSoYvVRVi
         wkLzQo9djjrAxigB2kQu0xrfjeMXOt4sNRfLvgTcVEPtLT9ROksfN4/o8ZsejXnFJCqX
         Ww2hJZAd5mJtQvCTHIyDv5yfXQ1sNufbcsGL23Vycu69rtkJad63A3xgYfI0xnPBX2Vh
         kd7Xlb22yvUigbJL4OtXfiOmiDwUgdvBUcsJjBcK1zv2NS2zHNmqHinr/3eXLqaIt0XP
         QFFg==
X-Gm-Message-State: APjAAAWZXGQlMrijyUvWyeqy7X8qh/nykPz88KiwVNkFKs75R7M80Uy4
        CzLtfzv5ONXzwb1vD2uqu6A=
X-Google-Smtp-Source: APXvYqyONKApZkIGfVf/LX9HEQp9b/iDe48sxTs5HbirhNZWpS4vHTMCWPP7vA0NgN+hnrgi52F81w==
X-Received: by 2002:a63:5607:: with SMTP id k7mr81068244pgb.118.1559084528905;
        Tue, 28 May 2019 16:02:08 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j13sm14369573pfh.13.2019.05.28.16.02.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 16:02:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE), Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/7] ARM: dts: Broadcom: Fix W=1 DTC warnings
Date:   Tue, 28 May 2019 16:01:27 -0700
Message-Id: <20190528230134.27007-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series attempts to fix the most obvious W=1 DTC warnings for
Broadcom SoCs DTS files. Stefan, if you could do the same for all
bcm283* that would be fantastic.

Thank you!

Florian Fainelli (7):
  ARM: dts: Fix BCM7445 DTC warnings
  ARM: dts: Cygnus: Fix most DTC W=1 warnings
  ARM: dts: bcm-mobile: Fix most DTC W=1 warnings
  ARM: dts: BCM53573: Fix DTC W=1 warnings
  ARM: dts: BCM63xx: Fix DTC W=1 warnings
  ARM: dts: BCM5301X: Fix most DTC W=1 warnings
  ARM: dts: NSP: Fix the bulk of W=1 DTC warnings

 arch/arm/boot/dts/bcm-cygnus-clock.dtsi            | 12 ++++++------
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  6 +++---
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  9 +++------
 arch/arm/boot/dts/bcm11351.dtsi                    | 12 ++++++------
 arch/arm/boot/dts/bcm21664-garnet.dts              |  2 +-
 arch/arm/boot/dts/bcm21664.dtsi                    | 10 +++++-----
 arch/arm/boot/dts/bcm23550-sparrow.dts             |  2 +-
 arch/arm/boot/dts/bcm23550.dtsi                    |  8 ++++----
 arch/arm/boot/dts/bcm28155-ap.dts                  |  2 +-
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts        |  4 +---
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts        |  4 +---
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  |  4 +---
 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts    |  4 +---
 arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts    |  4 +---
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts       |  4 +---
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       |  4 +---
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        |  4 +---
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     |  4 +---
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      |  4 +---
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        |  4 +---
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts |  4 +---
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts  |  4 +---
 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts      |  4 +---
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts      |  4 +---
 arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts |  4 +---
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |  4 +---
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts    |  4 +---
 arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts      |  4 +---
 arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts      |  4 +---
 arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts      |  4 +---
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      |  4 +---
 arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts   |  4 +---
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts       |  4 +---
 arch/arm/boot/dts/bcm47094-phicomm-k3.dts          |  4 +---
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts      |  4 +---
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts       |  4 +---
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts           |  4 +---
 arch/arm/boot/dts/bcm5301x.dtsi                    | 10 ++++------
 arch/arm/boot/dts/bcm53573.dtsi                    |  2 +-
 arch/arm/boot/dts/bcm63138.dtsi                    |  9 +++------
 arch/arm/boot/dts/bcm7445-bcm97445svmb.dts         |  2 +-
 arch/arm/boot/dts/bcm7445.dtsi                     |  8 ++++----
 arch/arm/boot/dts/bcm911360_entphn.dts             |  2 --
 arch/arm/boot/dts/bcm947189acdbmr.dts              |  4 +---
 arch/arm/boot/dts/bcm953012er.dts                  |  4 +---
 arch/arm/boot/dts/bcm953012k.dts                   |  2 +-
 arch/arm/boot/dts/bcm958522er.dts                  |  2 +-
 arch/arm/boot/dts/bcm958525er.dts                  |  2 +-
 arch/arm/boot/dts/bcm958525xmc.dts                 |  2 +-
 arch/arm/boot/dts/bcm958622hr.dts                  |  2 +-
 arch/arm/boot/dts/bcm958623hr.dts                  |  2 +-
 arch/arm/boot/dts/bcm958625hr.dts                  |  2 +-
 arch/arm/boot/dts/bcm958625k.dts                   |  2 +-
 arch/arm/boot/dts/bcm963138dvt.dts                 |  2 +-
 arch/arm/boot/dts/bcm988312hr.dts                  |  2 +-
 55 files changed, 83 insertions(+), 153 deletions(-)

-- 
2.17.1

