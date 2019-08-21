Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AEBC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B981122D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hgz89Dj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfHULl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:41:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37905 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfHULl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:41:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id m125so1794195wmm.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 04:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8o3T2t5tz7Ixcjhq857p3V1LeL5QkE3oMH88PryfCM=;
        b=hgz89Dj8EeATIFFjaX2KCz0C0uNpZrY6QVX6pEY33E64+i8O/OuKaESi3p4fdK2r2Z
         z3pwPkLNuACjxRRfK4Nyn8j3lYz5gApK5BBWdosClSfrsvnto88TYv8GANdPhaDUuceH
         nyQ63eaHKAYQvJQPOp4SwMw6BLc3jg2z7K0fsqMvovx5oLxNLr1t2u0WJcKEqaVKOevR
         F8kZvLViHXnGIECx0lXkgBtF0PgZTrEcICBkcoFQz3no1rTFrj8SY3GMtJsyAHjkLlKb
         nmi8SBh8WYSmiqhszrysruibpzkQDDZxec3PiA1PWdpURj/yr1KzA+Yxc5RLUU1iDi4C
         o4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8o3T2t5tz7Ixcjhq857p3V1LeL5QkE3oMH88PryfCM=;
        b=VgUxBUXIJn7Lpxw3N/bypM/E/jy2yjvytLNC6ay9lO53ni8UyeYK9zEXN3OQ971d56
         saHw4XuWifcZS7szz2q+xWFs5wW7b2ErUW2J5ZU9dZLsdZhrJMoG+60l72VGpae236UG
         9dDFlr+DZCwtn8vi3GlMoGtZW54ygKkvNerUMxDnNjLt+brcPOCYx8Lmi40bJSpmbfmX
         rG76Q8zWMU+or+0q1f5S6x6wc0UUYegwXGQtbg4jgxOz4ZVsfBK0YZ0gO9oTtbsUvJ+e
         x1tkm7IZcIlTWVtcYHC5iZoDMU4rqb7mIxfCvlR8AjEp9a/SsOej1X9QWNwjkDPQKal0
         E+8g==
X-Gm-Message-State: APjAAAWz0p4XmjQYyDmL9NcetH6hHpU0+fyD4gOoDXgZAxpPbDkTQ+mO
        J3jUisnVK/dcG/gkBC2MW/+CHA==
X-Google-Smtp-Source: APXvYqzrf0tMJG6BPFz3rwTLTrCXMVxjFRd5KCZ5s+IEF3EuyTik4+AtnX+i6dCshLvZBUUTBNaCMg==
X-Received: by 2002:a1c:b6d4:: with SMTP id g203mr5595031wmf.100.1566387683719;
        Wed, 21 Aug 2019 04:41:23 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g12sm24049686wrv.9.2019.08.21.04.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 04:41:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, ulf.hansson@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] arm64: meson: add support for SM1 Power Domains
Date:   Wed, 21 Aug 2019 13:41:16 +0200
Message-Id: <20190821114121.10430-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces a new "Everything-Else Power Domain Controller"
designed to handle all the different non-Always On peripherals like :
- VPU
- Ethernet Memories
- USB, PCIe, Audio, NNA on SM1

The current "gx-vpu-pwrc" process has been integrated to support the VPU
and the other power domains in a single driver.

Support for SoC domains has been made generic and easily extendable.

In order to restart from clean architecture :
- the PWRC node has been moved into the HHI simple-mfd, this suits much
  better than beeing in the AO RTI simple-mfd
- a brand new yaml bindings schemas has been written
- reset-names has been added to clarify which resets are needed, so we can
  dispatch them to domains

For G12A, the PWRC now offers support for the ethmac memory power domain.

For SM1, it also offers support for PCIe, USB, NNA, ethmac and Audio power
domains.

The DOS domains has been excluded for now, but can be added very easily.

GX hasn't been integrated for now, but it would follow the same scheme
as G12A support.

Neil Armstrong (5):
  dt-bindings: power: add Amlogic Everything-Else power domains bindings
  soc: amlogic: Add support for Everything-Else power domains controller
  arm64: meson-g12: add Everything-Else power domain controller
  arm64: dts: meson-sm1-sei610: add HDMI display support
  arm64: dts: meson-sm1-sei610: add USB support

 .../bindings/power/amlogic,meson-ee-pwrc.yaml |  93 +++
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  92 +--
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |   9 +
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |   9 +
 .../boot/dts/amlogic/meson-sm1-sei610.dts     |  28 +
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  15 +-
 drivers/soc/amlogic/Kconfig                   |  11 +
 drivers/soc/amlogic/Makefile                  |   1 +
 drivers/soc/amlogic/meson-ee-pwrc.c           | 560 ++++++++++++++++++
 include/dt-bindings/power/meson-g12a-power.h  |  13 +
 include/dt-bindings/power/meson-sm1-power.h   |  18 +
 11 files changed, 801 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
 create mode 100644 drivers/soc/amlogic/meson-ee-pwrc.c
 create mode 100644 include/dt-bindings/power/meson-g12a-power.h
 create mode 100644 include/dt-bindings/power/meson-sm1-power.h

-- 
2.22.0

