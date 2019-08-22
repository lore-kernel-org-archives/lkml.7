Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC18C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58A4233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="idQ8iW2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbfHVOZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:25:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40264 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfHVOZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:25:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id c3so5618648wrd.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 07:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9OVx3jQWP4kZ5xJyqef16dDp2+r5/pkxkhk8LNAWmX4=;
        b=idQ8iW2xtN9Z7AliSk77ovUIB903UmaYQgKv3ApPk4O3q0V27W7ZDIobQ4+dlnAMiH
         cHbKdpngCnKxltSls1Y7TZXrbhU1iazWGtK96aKaaXSSWHc67X3E6Xl9RjMIylZOCkpO
         SHe2quUdPXW2RYKDJTf1SnjXzxANBS3R++T+aaNHCdOGH1KIkoSSS0FP+rfQu0/1Vf4g
         codkCiEWII91vRMM1SLUswJkkI//E4JAuruZMlk0uxgkqrSR9peFGZV98FGd5ScnoGz4
         BAj9fMJ0xoNrRvwOEIs2jB2bw5eEYGkRFzgU3Y5GC3cwdcSiRYRNTQwAy2QlVCsuh/bB
         uf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9OVx3jQWP4kZ5xJyqef16dDp2+r5/pkxkhk8LNAWmX4=;
        b=HLsinj6R+awJOj/awPslST5TvJwMNGilV7z0GvvnhtK+gAXPjtZsXdLw5BsCLo0+A/
         Ry44QoZb78f0qmlEAws6+ZQz6YSiutlO5IVjwT3XYby/NYseiUXm8hjPtJOamWWXnFe8
         lDNkSPUn0fp/jJcZZy/ZwoollmgYGrlu4ulqEeV5KfkQnjhgRP8uZWVHWfwmgPfqpwqb
         PUV4VlsN6Fu3EM/PDElRNqFd/G29YvCRufF/nYSHHXD6Vs+bW0rTqLWYUR9OdFh9PTaR
         cmIRIbS0MBZVeTLVVD2qdbx6jYd9JPpOzwzgdJkU8PD5axWbm0pzHYksPx6O8c8yRLDX
         6+zg==
X-Gm-Message-State: APjAAAXnZAZ+Ka4quAW67za8wfVoFMnOV0SEcI7w1aTcnO3+HMIVX+Xq
        5oQHE0Wud4uz2RElPjagbbiVTg==
X-Google-Smtp-Source: APXvYqx3a41MFNhYZEgCdkzdje7C0zBjdhT4MO5uJCc4++EvcwS9Uz/v1rJGzSeEpyFmCrumGT1VbQ==
X-Received: by 2002:adf:f281:: with SMTP id k1mr47694586wro.154.1566483898729;
        Thu, 22 Aug 2019 07:24:58 -0700 (PDT)
Received: from bender.baylibre.local (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d17sm25806547wrm.52.2019.08.22.07.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 07:24:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] arm64: meson-sm1: add support for DVFS
Date:   Thu, 22 Aug 2019 16:24:49 +0200
Message-Id: <20190822142455.12506-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following DVFS support for the Amlogic G12A and G12B SoCs, this serie
enables DVFS on the SM1 SoC for the SEI610 board.

The SM1 Clock structure is slightly different because of the Cortex-A55
core used, having the capability for each core of a same cluster to run
at a different frequency thanks to the newly used DynamIQ Shared Unit.

This is why SM1 has a CPU clock tree for each core and for DynamIQ Shared Unit,
with a bypass mux to use the CPU0 instead of the dedicated trees.

The DSU uses a new GP1 PLL as default clock, thus GP1 is added as read-only.

The SM1 OPPs has been taken from the Amlogic Vendor tree, and unlike
G12A only a single version of the SoC is available.

Dependencies:
- patch 6 is based on the "arm64: meson: add support for SM1 Power Domains" serie,
	but is not a strong dependency, it will work without

Neil Armstrong (6):
  dt-bindings: clk: meson: add sm1 periph clock controller bindings
  clk: meson: g12a: add support for SM1 GP1 PLL
  clk: meson: g12a: add support for SM1 DynamIQ Shared Unit clock
  clk: meson: g12a: add support for SM1 CPU 1, 2 & 3 clocks
  clk: meson: g12a: expose SM1 CPU 1, 2 & 3 clocks
  arm64: dts: meson-sm1-sei610: enable DVFS

 .../bindings/clock/amlogic,gxbb-clkc.txt      |   1 +
 .../boot/dts/amlogic/meson-sm1-sei610.dts     |  59 +-
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  69 +++
 drivers/clk/meson/g12a.c                      | 544 ++++++++++++++++++
 drivers/clk/meson/g12a.h                      |  26 +-
 include/dt-bindings/clock/g12a-clkc.h         |   3 +
 6 files changed, 697 insertions(+), 5 deletions(-)

-- 
2.22.0

