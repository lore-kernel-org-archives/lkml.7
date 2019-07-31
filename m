Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F3EC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43186206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wq+OcFSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfGaMOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:14:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44883 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfGaMOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:14:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so69403908wrf.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=LjD7zv10OSEEYASmHj/VO2M7lzphFAaxTy5j9pYxJDo=;
        b=wq+OcFSyqHwlGFEmAGphrBhbP+jw2ZeUDJvnr2ryt0UBu4Kc8BRJiGhW6nT4CpumyV
         SKOb8IQMeNonlQPsKhQERiB/vwfGBTE0wB75t/eaDiGV22IphLZrF1IBc1ENghpzhQel
         ZYhMZKVg3ke0P91tgzfMITOJuO4O8bOJTwI3GPQteEg68oqQb8yfK6SSaGQ0qaQazN8x
         8t8ESnrCXgYEnHfjqb7iJQmssQOB0Al/KAIWguYzWba4gqqGSoYAoZAqEzF9AsSUX7Up
         WaZ6pwGSnfOltvm6IF58V/oAvcv+TGqUo0y3gUuOSsOl361ChIoMnUMxB5ahxtY1gEQj
         ooJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LjD7zv10OSEEYASmHj/VO2M7lzphFAaxTy5j9pYxJDo=;
        b=KVEYEnUn4TKD9W11SxLnhl1BywThg68KKFmHkOB+Y1bTYEOPUaOwn50TVi/dexIB6g
         mP5jXS53XZrTED96m8hWvtoURSYF9uXmNd6YYAOHV4e0drO8/0fvRufQzaCMm0EnLXhi
         Y0lfXPZ8aIElWWav1i02vdzNVkA5kiA0iZajPq28zM/9ZM8A232+uFRkuXK3mGzBnyI5
         qyJXH0jkmvjNV1gWzWXCMY5FjFXFVhD+3brDsXlaOjdv1IU9/IRbkHml5T5bBjjdC1xU
         gIMwh9SpEl1iyNitHQ6TFt35kpElXJpXenIynZzkOxghbi0yBmFArGVjMj5B0ckGqW+Y
         BZvQ==
X-Gm-Message-State: APjAAAUpadYxJymn91cmyFobAFO9AZVAcI7y3GlDnmrlkZLMyvLyuXvP
        pN0p1JdopcORBuh3yvyB5U9+ig==
X-Google-Smtp-Source: APXvYqxJbSn0OApVvnN6CpKmYBH7g0bhbbP4QJ0hUCNLf17qIH6FUg3NTYWzUkcC4F/NvISPNemGcw==
X-Received: by 2002:adf:db46:: with SMTP id f6mr5645832wrj.212.1564575253424;
        Wed, 31 Jul 2019 05:14:13 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a64sm3613713wmf.1.2019.07.31.05.14.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:14:10 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/6]  Add support of New Amlogic temperature sensor for G12 SoCs
Date:   Wed, 31 Jul 2019 14:14:03 +0200
Message-Id: <20190731121409.17285-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchs series add support of New Amlogic temperature sensor and minimal
thermal zone for SEI510 and ODROID-N2 boards.

First implementation was doing on IIO[1] but after comments i move on thermal framework.
Formulas and calibration values come from amlogic.

Dependencies :
- patch 3: depends on Neil's patchs :
              - missing dwc2 phy-names[1] 
              - rework on G12 DT[2]

[1] https://lore.kernel.org/linux-amlogic/20190604144714.2009-1-glaroque@baylibre.com/
[2] https://lore.kernel.org/linux-amlogic/20190625123647.26117-1-narmstrong@baylibre.com/
[3] https://lore.kernel.org/linux-amlogic/20190729132622.7566-2-narmstrong@baylibre.com/

Guillaume La Roque (6):
  dt-bindings: thermal: Add DT bindings documentation for Amlogic
    Thermal
  thermal: amlogic: Add thermal driver to support G12 SoCs
  arm64: dts: amlogic: g12: add temperature sensor
  arm64: dts: meson: sei510: Add minimal thermal zone
  arm64: dts: amlogic: odroid-n2: add minimal thermal zone
  MAINTAINERS: add entry for Amlogic Thermal driver

 .../bindings/thermal/amlogic,thermal.yaml     |  58 +++
 MAINTAINERS                                   |   9 +
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  22 ++
 .../boot/dts/amlogic/meson-g12a-sei510.dts    |  13 +
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |  13 +
 drivers/thermal/Kconfig                       |  12 +-
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/amlogic_thermal.c             | 335 ++++++++++++++++++
 8 files changed, 462 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
 create mode 100644 drivers/thermal/amlogic_thermal.c

-- 
2.17.1

