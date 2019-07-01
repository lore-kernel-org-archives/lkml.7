Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC26C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC80213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y/+nvdVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfGAJNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:13:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37292 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbfGAJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:13:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so15009243wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 02:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h5u4pWU3fhpBiHxumPv/qTZvnc0aCekcJz77EzSTwqA=;
        b=Y/+nvdVSW313vqjXZLRZxPJSbMTY9V5q7d9kbNc707FQ5DLekBH9JBsqxcqQSdcpsG
         fa9fbsfFISHQYuSag01PKjhD83+23p8PsdwbCp6pLzymoDUwiIVRvK4/+jpO8JTVE1+a
         VvVSu1ae4DHEwx1lAL0LzX6VXG4GNQybC3ts7Z2vwR2gFq4KUWAJMLBjtMaGjD6NVTdv
         OLEZU+KjrXbbZtizvbXrdIf3H1cn0/yYeD4OJUF9i7JYk1covruE8wiu3q+SvWM7oq1l
         b38IsjfQaAtcb9JYO7ZSRG5G0gWBlvmfIWH+SxRWLqT1JkrWBCVlFXlw0AkG+l+Tc+88
         +p3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h5u4pWU3fhpBiHxumPv/qTZvnc0aCekcJz77EzSTwqA=;
        b=rxECGquohLRAMVZSH/12hmiWlLMrwk3w9NFU+X1oAMM+YmyoQwv+TmDJv4ryI6FEB6
         1AO/HvYhm/YZJpgOizbRQo0CPfbB9rWF9rGhiflk0Kffv+K6KFFJ548qKSO2o6GfrtpF
         n6ddLLH6j8OSBONjdEhtj61+jDuNhIxHQGHdKyGUZ3WxZHzB5wIJfRHwKUcippVaCEV5
         COfzI4nWYM+B4ElIi/Ye3l0Hv2a7rzvddeFiAWiw5oyoObKlo85yWwaSwtxS8mw/8glb
         VRSH0AevLWBktM30IW8KUslq44XPj8QzZkr3UadV1Yv9yuggZQFv8QrGm5eqnyZYrp8h
         b+4Q==
X-Gm-Message-State: APjAAAWQeLCNtXuUQ+j1wnUt0ihzLjvj50ZqDMqEg8xieI9nXLkRuRqR
        fZ399SADILgoUwXMwFI/8qEfP/bXinI=
X-Google-Smtp-Source: APXvYqz2UhQEnseZ8WNhpF/O9vEWNicypD7qyv62oJG8BxzOAHVHA2jQIKd9fwd+Rev2X/o90QCKlw==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr15810427wmg.69.1561972390865;
        Mon, 01 Jul 2019 02:13:10 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id i16sm6305659wrm.37.2019.07.01.02.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 02:13:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT v3 00/14] arm64: g12a: add support for DVFS
Date:   Mon,  1 Jul 2019 11:12:44 +0200
Message-Id: <20190701091258.3870-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The G12A/G12B Socs embeds a specific clock tree for each CPU cluster :
cpu_clk / cpub_clk
|   \- cpu_clk_dyn
|      |  \- cpu_clk_premux0
|      |        |- cpu_clk_postmux0
|      |        |    |- cpu_clk_dyn0_div
|      |        |    \- xtal/fclk_div2/fclk_div3
|      |        \- xtal/fclk_div2/fclk_div3
|      \- cpu_clk_premux1
|            |- cpu_clk_postmux1
|            |    |- cpu_clk_dyn1_div
|            |    \- xtal/fclk_div2/fclk_div3
|            \- xtal/fclk_div2/fclk_div3
\ sys_pll / sys1_pll

This patchset adds notifiers on cpu_clk / cpub_clk, cpu_clk_dyn,
cpu_clk_premux0 and sys_pll / sys1_pll to permit change frequency of
the CPU clock in a safe way as recommended by the vendor Documentation
and reference code.

This patchset :
- introduces needed core and meson clk changes
- adds support for the G12B second cluster clock measurer ids
- protects clock measurer from cooncurent measures
- adds the clock notifiers
- moves the G12A DT to a common g12a-common dtsi
- adds the G12A and G12B OPPs
- enables DVFS on all supported boards

Dependencies:
- PWM AO input order fix at [1]
- PWM enhancements from Martin at [2]

Changes since RFT/RFC v2 at [4]:
- Rebased on linux-amlogic v5.3/dt64 and clk-meson v5.3/drivers trees
- fixed mesure/measure in patch 5
- added Kevin's review tags

Changes since RFT/RFC v1 at [3]:
- Added EXPORT_SYMBOL_GPL() to clk_hw_set_parent
- Added missing static to g12b_cpub_clk_mux0_div_ops and g12a_cpu_clk_mux_nb
- Simplified g12a_cpu_clk_mux_notifier_cb() without switch/case
- Fixed typo in "this the current path" in g12a.c
- Fixed G12B dtsi by adding back the sdio quirk
- Fixed G12A dtsi unwanted sdio quirk removal
- Fixed various checkpatch errors

[1] https://patchwork.kernel.org/patch/11006835/
[2] https://patchwork.kernel.org/patch/11006835/
[3] https://patchwork.kernel.org/cover/11006929/
[4] https://patchwork.kernel.org/cover/11017273/

Neil Armstrong (14):
  pinctrl: meson-g12a: add pwm_a on GPIOE_2 pinmux
  clk: core: introduce clk_hw_set_parent()
  clk: meson: regmap: export regmap_div ops functions
  clk: meson: eeclk: add setup callback
  soc: amlogic: meson-clk-measure: protect measure with a mutex
  soc: amlogic: meson-clk-measure: add G12B second cluster cpu clk
  clk: meson: g12a: add notifiers to handle cpu clock change
  clk: meson: g12a: expose CPUB clock ID for G12B
  arm64: dts: move common G12A & G12B modes to meson-g12-common.dtsi
  arm64: dts: meson-g12-common: add pwm_a on GPIOE_2 pinmux
  arm64: dts: meson-g12a: add cpus OPP table
  arm64: dts: meson-g12a: enable DVFS on G12A boards
  arm64: dts: meson-g12b: add cpus OPP tables
  arm64: dts: meson-g12b-odroid-n2: enable DVFS

 .../boot/dts/amlogic/meson-g12-common.dtsi    | 2416 ++++++++++++++++
 .../boot/dts/amlogic/meson-g12a-sei510.dts    |   55 +
 .../boot/dts/amlogic/meson-g12a-u200.dts      |   54 +
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   |   52 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 2455 +----------------
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |   96 +
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  145 +-
 drivers/clk/clk.c                             |    6 +
 drivers/clk/meson/clk-regmap.c                |   10 +-
 drivers/clk/meson/clk-regmap.h                |    5 +
 drivers/clk/meson/g12a.c                      |  500 +++-
 drivers/clk/meson/meson-eeclk.c               |    6 +
 drivers/clk/meson/meson-eeclk.h               |    1 +
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    |    9 +
 drivers/soc/amlogic/meson-clk-measure.c       |   14 +-
 include/dt-bindings/clock/g12a-clkc.h         |    1 +
 include/linux/clk-provider.h                  |    1 +
 17 files changed, 3390 insertions(+), 2436 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi

-- 
2.21.0

