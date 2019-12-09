Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B2DC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64FD207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GLHn4fQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfLIOim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:38:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40660 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfLIOil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:38:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so15172572wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cBqTABWZ+ZZCrDrvCJZd3L6J/4+9OYW3UqzkltB5htI=;
        b=GLHn4fQG5MI+I7kOYuwC5z2loyC593VLmWl8yBYzKhVeIYIeZqMnHEqM2tGkjsIwgp
         lMdDHEFl+ezZ450T8+PoldBwpcxcmT9WEgfvJ6O0op8NDEmDXKDNoH1M9YLtCxTQ1H/9
         gNwRH4eKuCEiz2v0eqc9Qm463GlhnXrTAf9oA38s9eSgv77UKU8grp6MaGQcNZe9sjv3
         26HpSckezY3kA4duIiFiTWVGZ1p/0/fvAywUkX+DVAcox9wa+MWee+zKJLZG218olUqh
         Ub72P+Jk5tz5hxvZv9NeMHwI/qI9oL7TUIkQ0APOsA5Mjl1tFCWrlt70HYlJOl1JsANe
         aJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cBqTABWZ+ZZCrDrvCJZd3L6J/4+9OYW3UqzkltB5htI=;
        b=TduxKvGG6joDuxXcH+aC0pPNZd64wSJukb/8zLpf6JtLgaETZhU5bmECkcog566jsL
         VTVfDISxIHoCdjGovAZacD6iuJVJHHSTWwwYPO60InKbhBCtMwuG4aHyRrBXPI42nKwz
         fx95EOF/U4UUYzA4lPWX4g4bqyGAMbbtgb2ITnod8J2oFoRlsWhUX3kKiZmLUnoGmoc4
         1etx1Qq5fcFbZl68v6WzsNiWMmQwoG/MvnKPu6ZVV62qIQKdg6QuR6uBvYxQnH7x+WaB
         RfzD4MbNkiciAhAEesNaf3rQXnmBgjGvxJJlLyDSS1noSYOw0z6LGzb2xJwoxamsqv02
         a5UQ==
X-Gm-Message-State: APjAAAWnG4HW+l216S0hlyqVPgLLBz49yxx7aS/3zgt8ZJ+JRHZfo1G/
        9cRY+zEHFMoI6voUB59RXNq9lQ==
X-Google-Smtp-Source: APXvYqwGYN2n6j3C3EWapKILsGIzaO9pt+mhMY2VFgpzwkhHEAMXtc5+UgL4/PtdZtWIzErOYURcLg==
X-Received: by 2002:a05:600c:2101:: with SMTP id u1mr25097414wml.43.1575902319910;
        Mon, 09 Dec 2019 06:38:39 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a1sm1904165wrr.80.2019.12.09.06.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:38:39 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] arm64: dts: meson: add libretech-pc support
Date:   Mon,  9 Dec 2019 15:38:32 +0100
Message-Id: <20191209143836.825990-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support the new libretech PC platform, aka tartiflette.
There is two variants of this platform, one with the S905D and another
with the S912.

Changes since v1 [0]:
 * update adc keys
 * add phy irq pinctrl configuration
 * update leds description

[0]: https://lkml.kernel.org/r/20191206100218.480348-1-jbrunet@baylibre.com

Jerome Brunet (4):
  arm64: dts: meson: gxl: add i2c C pins
  arm64: defconfig: enable FUSB302 as module
  dt-bindings: arm: amlogic: add libretech-pc bindings
  arm64: dts: meson: add libretech-pc boards support

 .../devicetree/bindings/arm/amlogic.yaml      |   2 +
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../dts/amlogic/meson-gx-libretech-pc.dtsi    | 375 ++++++++++++++++++
 .../amlogic/meson-gxl-s905d-libretech-pc.dts  |  16 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |   9 +
 .../amlogic/meson-gxm-s912-libretech-pc.dts   |  62 +++
 arch/arm64/configs/defconfig                  |   2 +
 7 files changed, 468 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-libretech-pc.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dts

-- 
2.23.0

