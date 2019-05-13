Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFA7C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8305220989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sbkFKWTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfEMJQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:16:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37783 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfEMJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:16:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id e15so1941916wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UzIz/OqhDW/aA2hwotioqmyYDuvBlglmy6CuzpgH6sA=;
        b=sbkFKWThl7SS5AJ0CygWfFeJN0O3kIB0+t9Vbb1WtqGtQop4D5UImzY3w/2zHaMszb
         i2J54jvYjY1fOlF5bA35RWmnT98jFKLSLvIVLSoO8PP7D/ve/VhZTo9Fimdobt4oUfxj
         m3qq17QF4zEeIsIs6qRq8mwYn0tpc2oCkLBj67jRJQr0z3IsE0KK+xb/bLvr4OTQ25Yd
         TQJIUmCvXxM0oUoDJa0Q6k8FlYO168/Gr9T74jKF2s0r9JAXBQ2YZGvd90GfTBMB+NwJ
         5R9/9u5Rl+S6WAEuxnfUAfG+bb0Vhht4Z7X7nKNIvwjnhJSabOZHL5GqZ43vGh9ohjih
         NK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UzIz/OqhDW/aA2hwotioqmyYDuvBlglmy6CuzpgH6sA=;
        b=m3A+V/Q/6U/EPe8NWx6Xv+Gy3IZ+Bz+A4NOTTUabGOCahysfaZJpmMaKzY744/t59H
         bfoiVnCT0gTdH5ZJWi+7UxTBcc4rxOkI5Nlq8X6RZnHh5EJF6gKvndYDhI1HMhDN/6nx
         yjQKuTJLrx6a/HtJ+lK1nlfDzFDMQpX59TMEYOSvjuVlbwgWHzt25AxeK/89ekuw54oE
         P82t0K1Gj4xYex4KMTD3CD+MHJvpXEsH+TfqBjYcMw4fbKCi46FW0l7MOO44Zi9IIpMV
         +No8UuEI+hZ+s6kdq/gsr+EGEcdjh4iOirVL89ZnAPT1yk7moxkYllUnVI8Ctn3RkcoC
         BSKA==
X-Gm-Message-State: APjAAAWx7RQ7t83ew3cWtW9vhckUCtD/SV6tUsOh1hrEOVXfYwORfFGt
        KoszKU3Un1mkfN7dAhGGKniNKw==
X-Google-Smtp-Source: APXvYqwNxZZ6JRa6sE/oBLQu/a8gQ1CyT8Fbo4TsPCi5L/1sJXP8vvCMf7wXzFjAVlU30do7KcyBFg==
X-Received: by 2002:adf:f44b:: with SMTP id f11mr93972wrp.128.1557738958141;
        Mon, 13 May 2019 02:15:58 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g10sm10795091wrq.2.2019.05.13.02.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 02:15:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, khilman@baylibre.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mmc: meson-gx: add ddr-access-quirk support
Date:   Mon, 13 May 2019 11:15:45 +0200
Message-Id: <20190513091548.16674-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Amlogic G12A SoC family, (only) the SDIO controller fails to access
the data from DDR, leading to a broken controller.

Add the amlogic,ddr-access-quirk property so signal this particular
controller has this bug and needs a quirk to work properly.

But each MMC controller has 1,5KiB of SRAM after the registers, that can
be used as bounce buffer to avoid direct DDR access from the integrated
DMAs (this SRAM may be used by the boot ROM when DDR is not yet initialized).

The quirk is to disable the chained descriptor for this controller, and
use this SRAM memory zone as buffer for the bounce buffer fallback mode.

The performance hit hasn't been evaluated, but the fix has been tested
using a WiFi AP6398S SDIO module, and the iperf3 Bandwidth measurement gave
55.2 Mbits/sec over a 63 Hours long test, with the SDIO ios set as High-Speed
at 50MHz clock. It gave around 170 Mbits/sec as SDR104 and 200MHz clock.

Neil Armstrong (3):
  dt-bindings: mmc: meson-gx: add ddr-access-quirk property
  mmc: meson-gx: add ddr-access-quirk
  arm64: dts: meson-g12a: add ddr-access-quirk property to SDIO
    controller

 .../bindings/mmc/amlogic,meson-gx.txt         |  4 ++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |  1 +
 drivers/mmc/host/meson-gx-mmc.c               | 65 +++++++++++++++----
 3 files changed, 57 insertions(+), 13 deletions(-)

-- 
2.21.0

