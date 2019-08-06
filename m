Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669B2C32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377DE20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QrHunvwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbfHFNFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:05:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37894 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbfHFNFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:05:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so55046138wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=aOEiMClLlNGKFVgF1uc0XEaaUElK/j2HAOeb7aEDvFU=;
        b=QrHunvwKeKucFciStUYnaBDIvwjbtVpPHlnqiz3nLHv64cImQ6ZWapGOmwJODU4VLP
         ZPiVt2SwMBihahTHWCN8XcNpI7HrQmpTJ9Nt97qmanE1n8BPpAj6nVn0N9iOrtOR0tjK
         Xe7xUq7BxMHTpM7mc/qVw/xUG7J5a5cMVEgnDkCyi0zvvRYU4jsTYBbPEsKrHRuOrtmK
         T76ta9UFaZaEqXcNeykmL0Mtxlem0QkosHKK/Jbaa6eUCG96kG1nCSfnulsxCeMpCW83
         4NxW5N1Of460J2bRdadsQd8c5hT74maA0jDsrCLx6tBs96NuNwmYViLWPg0Mn67OE90j
         2yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aOEiMClLlNGKFVgF1uc0XEaaUElK/j2HAOeb7aEDvFU=;
        b=gD3PuJRJJPHOwS2CYZ0TW+hV801kNbimN9X8GcwJ7KdBbyXCjdxaNoR1XDyAiTJWcV
         Ji3gOPI+F9vp3nD6UDU9GQE0UOiRc2MEj/vUjAzvkRIg8+A5mBJTxdDe4oIzYYZDQGRJ
         822W56hnO22t7wLV3xVFtE/Eybfe9CvfRiKuiRDZcETggan5iAUlESiHoDpjR8jPFX8D
         106TRUgBYEUPgya709+LzdOQWyPFmD7MUqtdkERxWsvQSXYp2n36zFFcG8kKk0kIXUps
         0/4LRdbZ7G1OjWLItGe9ZxsEaassUnExpy971qqxHxvGpPLEZaOVQmHXFqSPm9LK3cYu
         QUHA==
X-Gm-Message-State: APjAAAWt9BpaICEOALV+c83DhWNAQZPN88I4FYeh6VL7+nMb+2KGCQ/G
        lIN0t0DJYn04zm07q4SApY2U3k3HvMc=
X-Google-Smtp-Source: APXvYqzZdDSexSvzr2ocbt3H/8w9W8songZyclA+NoREaLstGEeN4Xmf95HAcs1eq0OWGBEqyn2/kw==
X-Received: by 2002:a05:600c:2182:: with SMTP id e2mr4842124wme.104.1565096710025;
        Tue, 06 Aug 2019 06:05:10 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j33sm201888738wre.42.2019.08.06.06.05.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 06:05:07 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/6] Add support of New Amlogic temperature sensor for G12 SoCs
Date:   Tue,  6 Aug 2019 15:05:00 +0200
Message-Id: <20190806130506.8753-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchs series add support of New Amlogic temperature sensor and minimal
thermal zone for SEI510 and ODROID-N2 boards.

First implementation was doing on IIO[1] but after comments i move on thermal framework.
Formulas and calibration values come from amlogic.

Changes since v2:
  - fix yaml documention 
  - remove unneeded status variable for temperature-sensor node
  - rework driver after Martin review
  - add some information in commit message

Changes since v1:
  - fix enum vs const in documentation
  - fix error with thermal-sensor-cells value set to 1 instead of 0
  - add some dependencies needed to add cooling-maps

Dependencies :
- patch 3,4 & 5: depends on Neil's patch and series :
              - missing dwc2 phy-names[2]
              - patchsets to add DVFS on G12a[3] which have deps on [4] and [5]

[1] https://lore.kernel.org/linux-amlogic/20190604144714.2009-1-glaroque@baylibre.com/
[2] https://lore.kernel.org/linux-amlogic/20190625123647.26117-1-narmstrong@baylibre.com/
[3] https://lore.kernel.org/linux-amlogic/20190729132622.7566-1-narmstrong@baylibre.com/
[4] https://lore.kernel.org/linux-amlogic/20190731084019.8451-5-narmstrong@baylibre.com/
[5] https://lore.kernel.org/linux-amlogic/20190729132622.7566-3-narmstrong@baylibre.com/

Guillaume La Roque (6):
  dt-bindings: thermal: Add DT bindings documentation for Amlogic
    Thermal
  thermal: amlogic: Add thermal driver to support G12 SoCs
  arm64: dts: amlogic: g12: add temperature sensor
  arm64: dts: meson: sei510: Add minimal thermal zone
  arm64: dts: amlogic: odroid-n2: add minimal thermal zone
  MAINTAINERS: add entry for Amlogic Thermal driver

 .../bindings/thermal/amlogic,thermal.yaml     |  54 +++
 MAINTAINERS                                   |   9 +
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  20 ++
 .../boot/dts/amlogic/meson-g12a-sei510.dts    |  56 +++
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |  60 ++++
 drivers/thermal/Kconfig                       |  11 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/amlogic_thermal.c             | 336 ++++++++++++++++++
 8 files changed, 547 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
 create mode 100644 drivers/thermal/amlogic_thermal.c

-- 
2.17.1

