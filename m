Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4D9C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8B922D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E0MgQD/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfHUOUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:20:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35134 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUOUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:20:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so2351293wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9hgbbdW56kZ9dbt4pURRNeqYEzO7tOgAeaDiUmq4v1w=;
        b=E0MgQD/1DR5lR/EVgfVAzXNjcUBnyq4K7Ghg+Niucl7aAj3rOqg3UJg7t1gBQ2yrb2
         OZLhhSeoR2nsOxtm+miQ2krAI5eyTGHczpNeSNkmY0eEHzuFfUfjl+GLIG1lZ+rzmdKo
         Olh11zxk7rTUK4QUx+w5VTNTZ64pgdRc/lwZ9D+myQk1L9yXgGaVeeoPttE7pNJjYU1/
         FFodCccBS/7U0y200sFowkpauy+YDx8PHdmt0luiyhpc0Rqs18q+jChaZ7WYjxlDINjE
         d3QGYwJpL292p2LjxUAKUgpJ61vJrlRRyVUBAiJWUySDIAVNuqcmuOQWuFpIIl6Mb2Dh
         PSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9hgbbdW56kZ9dbt4pURRNeqYEzO7tOgAeaDiUmq4v1w=;
        b=DssV0uFBItZaU2s++b88Q5NIYw4TASYw6cYLY+tMb/kOgP0rajN+f0vwowTzA433Ql
         lc3H6cI2gV9f/6Luj4oOiQiERaS22e4j84nrZz4i2LFDYlla5ZYiMBErkiSRUjXbGL0D
         izrdXekH9O3mdr7pcrMRYOshlfO4AM23UBUUs3cboCqZdV8biYPvkLAly9BkWX16H5Gl
         338zW1mpG8FQi8BuuZ8xa3styXJ485RQtt7hdawt51gio3LBO9nudfCZl4KkWCLsLtmM
         DSjfCTOvciHfHUsQz6pPt6t/e8xKFnUsdcCRSMfVrBcJJ4auNGUgfcH4B7oWeXhTQaF6
         pt1w==
X-Gm-Message-State: APjAAAX248zpik+v/WuLDO+G3H2RBWXrS5XwwmK+15/s9FXlemOxt07e
        +QC7YSQULULfr+7u1ja/yD1Umw==
X-Google-Smtp-Source: APXvYqy+BKmYE4t79zuMDWuHtMYIbNyIVmEb2qK2hKucfvDuuOO+H7pzCxk9BLseZMyZsL1udITvhw==
X-Received: by 2002:a7b:c8cb:: with SMTP id f11mr322764wml.138.1566397252864;
        Wed, 21 Aug 2019 07:20:52 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o9sm33418939wrm.88.2019.08.21.07.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:20:52 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 00/14] arm64: dts: meson: fixes following YAML bindings schemas conversion
Date:   Wed, 21 Aug 2019 16:20:29 +0200
Message-Id: <20190821142043.14649-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first set of DT fixes following the first YAML bindings conversion
at [1], [2] and [3].

After this set of fixes, the remaining errors are :
meson-axg-s400.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'
meson-g12a-sei510.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'
meson-g12b-odroid-n2.dt.yaml: usb-hub: gpios:0:0: 20 is not valid under any of the given schemas
meson-g12b-odroid-n2.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'
meson-g12a-x96-max.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'

These are only cosmetic changes, and should not break drivers implementation
following the bindings.

Changes since v1 at [4]:
- Added suggested commit text from Martin in patches 1 & 2
- Fixed NanoPi K2 model name

[1] https://patchwork.kernel.org/cover/11083597/
[2] https://patchwork.kernel.org/cover/11103229/
[3] https://patchwork.kernel.org/cover/11083649/
[4] https://patchwork.kernel.org/cover/11094063/

Neil Armstrong (14):
  arm64: dts: meson: fix ethernet mac reg format
  arm64: dts: meson-gx: drop the vpu dmc memory cell
  arm64: dts: meson-gx: fix reset controller compatible
  arm64: dts: meson-gx: fix spifc compatible
  arm64: dts: meson-gx: fix watchdog compatible
  arm64: dts: meson-gx: fix mhu compatible
  arm64: dts: meson-gx: fix periphs bus node name
  arm64: dts: meson-gxl: fix internal phy compatible
  arm64: dts: meson-axg: fix MHU compatible
  arm64: dts: meson-g12a: fix reset controller compatible
  arm64: dts: meson-g12a-x96-max: fix compatible
  arm64: dts: meson-gxbb-nanopi-k2: add missing model
  arm64: dts: meson-gxbb-p201: fix snps,reset-delays-us format
  arm64: dts: meson: fix boards regulators states format

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  6 +++---
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   |  2 +-
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |  7 +++----
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     | 19 +++++++++----------
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts |  1 +
 .../dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  4 ++--
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  |  4 ++--
 .../boot/dts/amlogic/meson-gxbb-p201.dts      |  2 +-
 .../boot/dts/amlogic/meson-gxbb-p20x.dtsi     |  4 ++--
 .../meson-gxl-s905x-hwacom-amazetv.dts        |  4 ++--
 .../amlogic/meson-gxl-s905x-nexbox-a95x.dts   |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |  5 +----
 13 files changed, 31 insertions(+), 35 deletions(-)

-- 
2.22.0

