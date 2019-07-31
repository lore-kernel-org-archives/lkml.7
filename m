Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1813FC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E254E208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0BPP66us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfGaPfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:35:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50720 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfGaPfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:35:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so61331057wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7WLjxnI8g1thWsUDdq2Hfl/ujp9OHSJIwkbSbhOm62c=;
        b=0BPP66usc+st7NTNLiYHcT9I5K1u3a3FEnCC+97RYYsl5JXVb4fBlUXZzVS5LwBf7n
         JTbKUH4p+DVBgg45Nl6ztxJKXrgO+YkenDp/0q8Eh3Ydn+k4m+f/ktpR+xKmoRLE+g6+
         4X6jN7AGogvDcQWFlsSg8svTa1InuOjfbGbKMGHVxQbsqoGXyDdABcwqcJIHeSKTXv69
         /gefxIJ4R8j1z5lsN+g3Z+OwfZVRSfu+Vqw4JiTWNhmI7MuIho7o3To837fdMnqrN7jP
         Sd5lBLUmT8egE95rs1uVvzchYHQ3G/g+300vxT6y+sc00+5YRAV/HDgkPf/iOGFu/oY9
         aMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7WLjxnI8g1thWsUDdq2Hfl/ujp9OHSJIwkbSbhOm62c=;
        b=Wx5YA9oeyuXixTBBP1jYpCRHFyvaEDenJUDuzmohdwXmSr29ys4d8o6sG4TLzeDBn7
         CP/azseBVEY6JGuyPFscVr0NGlXPyiksIIpeenfqRrx5Ko/BbbjtGoe+/EHuhaEvfGKF
         uI/Bi9RJhW91SMmx8A6UWO6zeLG2XpgxrJhc5Y2I1EwRp+smjmAMyNlx77f6163XbHKh
         7d/CbY/no+zvOMJABRvkeeAAMtusTdZgqn1HKmmRVKBMoS0avdwb89m/BUFSpPH9yTfO
         UbnVXxMSrVaZHb4FrrbIhIu09vilNfMVyH6PWN6hWz6zq5CZPcZGd/BSBpXbGAcOSQ7a
         0BfQ==
X-Gm-Message-State: APjAAAWiqMVPI7fp5DQQg2AuWkT9Q0HnKWFDHyBazzj26LGe/z3O4rXF
        KxzDj0xIgE1r62VI2FB82+65ig==
X-Google-Smtp-Source: APXvYqwwJjY3FtKTWbfPIEqttUCqL8C62yZwUYcZbMGgyaXoMKyDjYkpr7m8Tzh4baLNN8dmQs3MwA==
X-Received: by 2002:a05:600c:c6:: with SMTP id u6mr114781417wmm.153.1564587331749;
        Wed, 31 Jul 2019 08:35:31 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i13sm62834396wrr.73.2019.07.31.08.35.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 08:35:30 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/6] Add support of New Amlogic temperature sensor for G12 SoCs
Date:   Wed, 31 Jul 2019 17:35:23 +0200
Message-Id: <20190731153529.30159-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchs series add support of New Amlogic temperature sensor and minimal
thermal zone for SEI510 and ODROID-N2 boards.

First implementation was doing on IIO[1] but after comments i move on thermal framework.
Formulas and calibration values come from amlogic.

Changes since v1:
  - fix enum vs const in documentation for compatible
  - fix error with thermal-sensor-cells value set to 1 instead of 0
  - add some dependencies needed to add cooling-maps

Dependencies :
- patch 3,4 & 5: depends on Neil's patch and series :
              - missing dwc2 phy-names[1]
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

 .../bindings/thermal/amlogic,thermal.yaml     |  58 +++
 MAINTAINERS                                   |   9 +
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  22 ++
 .../boot/dts/amlogic/meson-g12a-sei510.dts    |  56 +++
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |  60 ++++
 drivers/thermal/Kconfig                       |  11 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/amlogic_thermal.c             | 332 ++++++++++++++++++
 8 files changed, 549 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
 create mode 100644 drivers/thermal/amlogic_thermal.c

-- 
2.17.1

