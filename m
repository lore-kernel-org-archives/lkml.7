Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E717CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C038320673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="D26PYrCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbfFTPAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:00:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37462 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfFTPAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:00:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so3510135wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iGJO1VOPXnwiO9fEhZqN6X/eRe30yCuqhTibmCsxXjw=;
        b=D26PYrCydSgAvlyMXHUOVwEHkqVfkO3eIU+Hw97fyOOaJhSd3TTaERMVpGTO01BA/a
         WTSvDNybjRgNPVBPg4AKhb1YAxpFMudHhPqlYRRljgWdVKAIU/KpiTqqKN8rXdc89coc
         oj2pe8nJd5BX4Oh6O9WDO/g+AzqTXdUweRXgwg987O3Rw6EetJEkL3LvTo2QJI4PK6H4
         zfrTGY5oSiQlU1ea/EeeFjW50K9hvMIaICcKbSXt7380xxh5jQw7tq6m+aokZ30/c5+Q
         mg0UYoiwFRcvvdV0ToIAJ90+6wcvCSVLdZLbbLXCfMKQ6eRNoe+8rSMk9w0tkffrhgHu
         j5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iGJO1VOPXnwiO9fEhZqN6X/eRe30yCuqhTibmCsxXjw=;
        b=A9MOwlxZMtZoQgkt3VQ+ESatUcbEvvTo0r8PlJd0p3pMlkz2dAmedv9ltXxKFPM2rL
         i+/OvgYy7pzO8zHKM35AJXdinlsv+Q7eGYrS9oGgPlc4Fpol//gwtoMFoZwqB9eKvqxZ
         Lggh+q91BbvG4G5Iax8gKscdEJHEWaFb8DE4TMDsVJegtybRNjQIpQeEasaJ/F8qUWBB
         dlq9JxNegDuoADDlD5HyaM3ifRCi+Pc4B9YfwxAcLOIKGuKZWabIRUrqamagpfHo6x7t
         ABLtDTkgR55QK4StvPvTx98QuDQ1L1qEFtY0w/+jDcoig5fH6w61lF+oiCK3LOxjF0lJ
         4MNg==
X-Gm-Message-State: APjAAAVPiggBxS1I3tlMCb5DcDtVNciNHYrV6a4GdIvGzO0vxUbyZlMt
        Z/h52RIxsSHBL3BubiufUM0T2A==
X-Google-Smtp-Source: APXvYqzq+mH4AFjJmn1fukJcLa9bYkZIAjP8/Kwk4UdxGe4R+GJgHf3rpGNNqIIgdGkyOTXdsm/tQw==
X-Received: by 2002:a1c:5546:: with SMTP id j67mr71050wmb.80.1561042820164;
        Thu, 20 Jun 2019 08:00:20 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o126sm6802520wmo.1.2019.06.20.08.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 08:00:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT 00/14] arm64: g12a: add support for DVFS
Date:   Thu, 20 Jun 2019 16:59:59 +0200
Message-Id: <20190620150013.13462-1-narmstrong@baylibre.com>
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

[1] https://patchwork.kernel.org/patch/11006835/
[2] https://patchwork.kernel.org/patch/11006835/

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

 .../boot/dts/amlogic/meson-g12-common.dtsi    | 2464 +++++++++++++++++
 .../boot/dts/amlogic/meson-g12a-sei510.dts    |   55 +
 .../boot/dts/amlogic/meson-g12a-u200.dts      |   55 +
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   |   52 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 2462 +---------------
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |   96 +
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  141 +-
 drivers/clk/clk.c                             |    5 +
 drivers/clk/meson/clk-regmap.c                |   10 +-
 drivers/clk/meson/clk-regmap.h                |    5 +
 drivers/clk/meson/g12a.c                      |  500 +++-
 drivers/clk/meson/meson-eeclk.c               |    6 +
 drivers/clk/meson/meson-eeclk.h               |    1 +
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    |    9 +
 drivers/soc/amlogic/meson-clk-measure.c       |   14 +-
 include/dt-bindings/clock/g12a-clkc.h         |    1 +
 include/linux/clk-provider.h                  |    1 +
 17 files changed, 3412 insertions(+), 2465 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi

-- 
2.21.0

