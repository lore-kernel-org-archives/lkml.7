Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF364C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A475B2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FfBTSa+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388823AbfDRM10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:27:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39575 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388375AbfDRM1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:27:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so2748282wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9eboMfFTp0flkemmTJjhK8is1SRUoqUCaMOvhGUXhug=;
        b=FfBTSa+du3ERXocDZ4ekzbJrSxzAa5Ro16ukXiL+GcQhQyXCb0LEalP39dyp3CjGCL
         KPw3JtDZJfOYaWCRDz19DxeDgAiYSCniYYk0+yDA8rgX9EdWpOjZRAjWAXZJNl+JnFfy
         vYLQhCUmAuU1FF0rY1g0LTCgqnHJSvtYJL2k9Ix6g0TnGvj9GULquXoGEe9ehJQRBKRw
         KQCcVZR7PQ8lkbAlKxzYFboumm2vdaYNMzDut/2l5TshWm14CG5GCzlRGenLuJ7fx6uH
         k1LcAsp1vxXAm1N9JLTNeeCzBOGq5Q0Iwhwhs1RJ7DHhKIE5OLgluMPdhaFJgHota2oC
         q/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9eboMfFTp0flkemmTJjhK8is1SRUoqUCaMOvhGUXhug=;
        b=foBsnaTGD6XfQOKxa+0S6sdCjFWe1UjGa46Z3Y+m8ZulRg33kDeguPGMpI7wn725ol
         2iWpsGjiDWxVksx3P2WKYNBFjIPT8Hy+gwakzzPQGgDdbFk0kOJyb+Qsuo5h+Ef26doX
         rrdqf3mc6k3b+/gOazWp8xlaht8Voh4jDfCGFhAobBZn2IBcj9qk+3SR8783275OJWvV
         CLmFiTs/eN++woFGZmqJmnWSArI0OkqQtQwzlQ2MjHkqrBHfLi9URZEq6rsZ3lB/VOar
         clIZN3YI2DDmfTcrmrvjphfq1qgaIRKWNmXXN0QyCbDWReEcvgBsgdTXAFWKKP9ij7nJ
         85Eg==
X-Gm-Message-State: APjAAAVpyy0TOOGyP8iXyvUIUnT/BMz2FWRhEODANXt8HtgBrCCvg9iH
        g6+DSLNCQXvWDxsTDFVCSB0ZZQ==
X-Google-Smtp-Source: APXvYqyPEqM58O7ljaAPBE6bcldBRkQXUtMCsspe8+UqFdVrJvhwSEUBvVZLzZU2RF6S9jF2iuKavQ==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr5924157wrj.66.1555590444085;
        Thu, 18 Apr 2019 05:27:24 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z14sm1510110wro.81.2019.04.18.05.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 05:27:23 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patchwork-bot+notify@kernel.org
Subject: [PATCH 0/6] arm64: dts: meson: mmc clean-up
Date:   Thu, 18 Apr 2019 14:27:08 +0200
Message-Id: <20190418122714.30805-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset is bunch of clean-up found while debugging meson mmc.

* The first 2 patches address the libretech-cc which actually uses 1.8v
  eMMC modules.
* Patch 3 is a pin bias fixup depending on mmc pins.
* Patch 4 lower the mmc max frequencies on gx chips. It was not easy
  to spot but, according to the datasheet, the maximum UHS rate
  supported by these chips is 100MHz (SDR50). This explains why we
  never really managed to get a stable SDR104. SDIO is limited to HS.
* Patch 5 adds missing pinctrl definition on the vim2
* Patch 6 remove hs400 from the supported modes of the vim2. This mode is
  mode reliable enough with HW/SW ATM.

When/If the series on the mmc drivers goes through, I'll send the
following updates:
* Push odroid-c2 eMMC max rate from 100Mhz to 200Mhz. With the new tuning
  method, this mode is finally stable on the OC2 (so far...)
* Enable SD UHS modes on the odroid-c2
* Enable SD UHS DDR50 on the nanopi k2

Jerome Brunet (6):
  arm64: dts: meson: libretech-cc: set eMMC as removable
  arm64: dts: meson: libretech-cc: switch eMMC to 1.8v
  arm64: dts: meson: fix mmc pin bias
  arm64: dts: meson: fix mmc v2 chips max frequencies
  arm64: dts: meson: vim2: add missing clk-gate pinctrl
  arm64: dts: meson: vim2: remove sd hs and hs400 modes from emmc

 .../arm64/boot/dts/amlogic/meson-axg-s400.dts |  4 +--
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 31 ++++++++++++----
 .../boot/dts/amlogic/meson-gx-p23x-q20x.dtsi  |  4 +--
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts |  5 ++-
 .../dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  2 +-
 .../boot/dts/amlogic/meson-gxbb-p20x.dtsi     |  2 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi |  4 +--
 .../boot/dts/amlogic/meson-gxbb-wetek.dtsi    |  4 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   | 35 +++++++++++++------
 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts |  2 +-
 .../amlogic/meson-gxl-s905x-libretech-cc.dts  | 14 ++++----
 .../amlogic/meson-gxl-s905x-nexbox-a95x.dts   |  2 +-
 .../dts/amlogic/meson-gxl-s905x-p212.dtsi     |  4 +--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    | 35 +++++++++++++------
 .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 15 ++++----
 .../boot/dts/amlogic/meson-gxm-nexbox-a1.dts  |  2 +-
 .../boot/dts/amlogic/meson-gxm-rbox-pro.dts   |  4 +--
 17 files changed, 109 insertions(+), 60 deletions(-)

-- 
2.20.1

