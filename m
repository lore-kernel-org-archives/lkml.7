Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A55BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B8421726
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JvmXI4ID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392493AbfHWHC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:02:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35123 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389293AbfHWHC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:02:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so8038548wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vS6xmM1o4WiYAtnye6AaJ1yvjVsYp/heWNStiuUNd54=;
        b=JvmXI4IDuugnF0UEeIOn4C9BrsVkHnPQSawVawISluQUAsOo5lwzWS7ylrKoKm79Ax
         MtG+Ecfz3F8/PO7H+WQKxCXrRGfjinkUy8yePNuykncOuBtVBS140o4XEjcsHPlyLgrx
         CM6KsFCCOs3iql0c4n4ysGcuhAUDJWqv25PUplxEM9quaKrjs5AOQj+Xs6PMg2pGSOzM
         kDsQax7XlQGqmGI2xjPfk2xZr0js4NCHf0rliNWrKNmR0lJBDIJK3ekx1Rthvr0Y4pcf
         YC6eTbJXnb6QXE+0YK0JMp6acJt7izrmdkv3drqeBMf2voNQFgi7ZySr6YR+D89m29Dm
         fHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vS6xmM1o4WiYAtnye6AaJ1yvjVsYp/heWNStiuUNd54=;
        b=AXgbvZAFi62HMf1geECeNxKUDjSFfBdgYKc4qVa/ooN+J0uumTbxy9Sx/HchyJGatt
         Th02zHYkWwL9oye2oYGBGD09jZbh4GsEahA8r5BBNaaWtzIWm5sQJaNJPxFIxltgCIDq
         sOlHFEvgbQmgyJlio4QKGgK5m64ukO1KHuaaO/M8mFq8/LFmKN0wMF0xWpq1gFoEcQMV
         L5e9hKZMcH6e8FK/yERmdOksMZTIj4yuz4GGlMD84+HxqT/21WjX4FExp6oqnus+Tg5L
         yH/3zpMb/K4xGXhLlH2Mb+ncd5TVAm7gMtlrJf8Hf5l7JghUyEjP9pYTFJRtf4VHxWUa
         3Ovw==
X-Gm-Message-State: APjAAAWCyFmau4twaTz2Ru28ezoXeqbmzdPK53ruGXo1CmVataYmybGT
        nXlaXuqBrv/yRqxshgtZNXxXAg==
X-Google-Smtp-Source: APXvYqx9lHpHGea6NolLMfr9QDp+D+dEO0xlkR9VntWGjp8ouTua1i3g1Oom7QpRBdEEJ8oV8s2e2A==
X-Received: by 2002:a7b:c649:: with SMTP id q9mr3153030wmk.108.1566543774241;
        Fri, 23 Aug 2019 00:02:54 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm1741833wmg.45.2019.08.23.00.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 00:02:53 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RESEND PATCH v2 00/14] arm64: dts: meson: fixes following YAML bindings schemas conversion
Date:   Fri, 23 Aug 2019 09:02:34 +0200
Message-Id: <20190823070248.25832-1-narmstrong@baylibre.com>
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

Changes since v2 at [5]:
- Rebased on khilman's v5.4/dt64 tree
- Collected Acked-by and Reviewed-by tags from martin

Changes since v1 at [4]:
- Added suggested commit text from Martin in patches 1 & 2
- Fixed NanoPi K2 model name

[1] https://patchwork.kernel.org/cover/11083597/
[2] https://patchwork.kernel.org/cover/11103229/
[3] https://patchwork.kernel.org/cover/11083649/
[4] https://patchwork.kernel.org/cover/11094063/
[5] https://patchwork.kernel.org/cover/11106927/

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
  arm64: dts: meson-gxbb-p201: fix snps, reset-delays-us format
  arm64: dts: meson: fix boards regulators states format

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  6 +++---
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  7 +++----
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   |  2 +-
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

