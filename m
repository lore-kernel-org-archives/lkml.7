Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD12C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F96D20815
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="F0OuPbca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfE0MnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:43:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54935 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfE0MnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:43:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id i3so16016197wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 05:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKi6i530JJNrkfWp8zdTE/DlNf+AJ6vpEuNiHI586GM=;
        b=F0OuPbcaU47Vw5cIofDI7N8sCg5q5HjGbe75cSt5fxbmgeL/gwFfe0z2Wex7Xk06+v
         KyG3eIWcX65wfRkP5yFfwX2MTmFf4YvIPSZ1sfR1vF1vL5KWjLpfqFxNLMzGW92WyTZ0
         xQHBioJ2CSnMfPDUutyRdQFF8edHOg7JnkFzKVpAXmvHIL4ES9prSLURjwD+JEwbDGxK
         ixEefmZ8lZXsS+0UWbqOEroGQcLF9GJipI2ge/K4pAZ7ZxZs8O4K2GqhChbwBA2HoQIf
         KPQrFoIVhCSob5K6Aky/XPD+3Qw/jM0QmRhk1va3R4IzLIYlAEQiAuh2kDeG0+YVUM8H
         IzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKi6i530JJNrkfWp8zdTE/DlNf+AJ6vpEuNiHI586GM=;
        b=bJhBNQSnS7X4ssFq7hDShCJ5rqmePTCAZWKhcMvTymBC2gMZee3qcG0TEuXNiKPAZE
         8+2wcFpI+5wRo9SUtQ9ykgAHAU3NURYV05qvFgy6JH8KnQ6Jmipkum7UF3GNbT7nuOO2
         l9kdInnsQ4MXtUP0OFg5+u3lSm1GCEDBQ/gXu/9b114JLaY62ZsDz2e/TGIE1TJXmJzZ
         STf/CITkb1prHg+X40hMvc8OQM8SUBVTofrJ5b7L4V6nHcZrbK/SY28Z+Az/zATsy960
         pjtvhVcSNWWrqbs/7gJYXJHyI33933/4Vbapq2BDB6p84TSfrSlYexOir5qbcl/wsjPh
         ZcWA==
X-Gm-Message-State: APjAAAXiVRcjXA88g1glGHFdA/+cRzxaUSlDbe+tzRbOEF2O3bjhjM/x
        +kPdk/IMFJc2CT3KmpVH+1GiIg==
X-Google-Smtp-Source: APXvYqwLlj5CMrnZHpa7NOKgj27nP4BBbZEUNpyia+Gjsf8jHnw5YAJDwN7ERYC5zPTVIVnhO1qS3g==
X-Received: by 2002:a1c:c706:: with SMTP id x6mr9242682wmf.35.1558960990603;
        Mon, 27 May 2019 05:43:10 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm11494930wrt.45.2019.05.27.05.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 05:43:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] mmc: meson-gx: add dram-access-quirk support
Date:   Mon, 27 May 2019 14:43:04 +0200
Message-Id: <20190527124307.32075-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Amlogic G12A SoC family, (only) the SDIO controller fails to access
the data from DRAM, leading to a broken controller.

Add the amlogic,ddr-access-quirk property so signal this particular
controller has this bug and needs a quirk to work properly.

But each MMC controller has 1,5KiB of SRAM after the registers, that can
be used as bounce buffer to avoid direct DDR access from the integrated
DMAs (this SRAM may be used by the boot ROM when DRAM is not yet initialized).

The quirk is to disable the chained descriptor for this controller, and
use this SRAM memory zone as buffer for the bounce buffer fallback mode.

The performance hit hasn't been evaluated, but the fix has been tested
using a WiFi AP6398S SDIO module, and the iperf3 Bandwidth measurement gave
55.2 Mbits/sec over a 63 Hours long test, with the SDIO ios set as High-Speed
at 50MHz clock. It gave around 170 Mbits/sec as SDR104 and 200MHz clock.

Changes since v1:
* use DRAM instead of DDR, added details in bindings on internal DMA controller
* fix probe() to not try to unallocate bounce buffer on error
* replace DT patch adding SDIO property to patch adding SDIO controller

Jerome Brunet (1):
  arm64: dts: meson: g12a: add SDIO controller

Neil Armstrong (2):
  dt-bindings: mmc: meson-gx: add dram-access-quirk property
  mmc: meson-gx: add dram-access-quirk

 .../bindings/mmc/amlogic,meson-gx.txt         |  4 ++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 37 ++++++++++
 drivers/mmc/host/meson-gx-mmc.c               | 70 +++++++++++++++----
 3 files changed, 96 insertions(+), 15 deletions(-)

-- 
2.21.0

