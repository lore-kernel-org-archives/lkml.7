Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF56C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1435B20843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="F9HZc8MV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfDWJPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:15:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53925 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWJPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:15:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so17706655wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEpgBoCDht4RP4PwgNxCA0pxhZltSrLODlaosGYp0d8=;
        b=F9HZc8MVHjpTa9CRrAQafrQVIrBphyy7Lb0h2edvMuDsCMf0gYRMn1Tohm/Mhjvinw
         1bwktUtXC1keeIQuGnhcP1/WSj6C3I21plZB+V9YSgilJHqbWYefnNsb7ehTpE4TOrjm
         c9cntMdXWsFNuZ9wmfya+JtUz/prIGzLSwk5/ARl3UqgL9HPvIIoVzt/5uLb81m2k7Ww
         hhlAZ53aQAw2Nr5T2EUiil3kx0WsjAxFhQZCAIuRc97qEo8pC92NDX7oCjwsOmycibq1
         hnteGomN54Z5k9AKKoi8AI6HkQj9tYW6QFnWKj+ZHZuabvizTw/gQTdHXZSifEDUN/n1
         QS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEpgBoCDht4RP4PwgNxCA0pxhZltSrLODlaosGYp0d8=;
        b=NWaS1culagCwwrAlY+J7A+6jHbEwBD42m/N5k9JC9Tc3rQdUq+mYQchjk4ZxVCLhl+
         cxmuSv2FuYptx8o6Herb7xlQDxibkaFcy2Ue2UUBe+0CnwRtdNzJbNk8jhDNUWD/WrjB
         IKrBlCiwU46x13Fvzu4eF8zVhtm6w46WugvVUA8aAaCqgNe9xuy6XQiZWVfPJB3C9BRR
         hxlMPLa8Usce3dQCdjnlx5tiCwAP0CemAcE5vJEgGaw5pwFCdxnLJMdmYinvGbfW7I8s
         bUl1p13J+SKtQdRAaA7fgm7E1E1pHjYoRNfp6aE7uDQBRkgacnxGorxQQGUJvzJrz6sC
         OiSQ==
X-Gm-Message-State: APjAAAUPteyDQcs1GB3/sSIJ/YBbzFwSNjkxPF/RQKpZ2XS0Tcftd8RG
        gT9kiEYgkRkB/uA5RIrCdm5ZQw==
X-Google-Smtp-Source: APXvYqzLM5So+4KWpmNl1mDMA2rbtz4sa3W1/fPFvpctQtpkvQqBfU0YMiTAxzFUAPYVRa9YQsnyvg==
X-Received: by 2002:a7b:c086:: with SMTP id r6mr1388086wmh.123.1556010907660;
        Tue, 23 Apr 2019 02:15:07 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t17sm12241272wrr.26.2019.04.23.02.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 02:15:06 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] arm64: Add initial support for Odroid-N2
Date:   Tue, 23 Apr 2019 11:14:57 +0200
Message-Id: <20190423091503.10847-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds basic support for :
- Amlogic G12B, which is very similar to G12A
- The HardKernel Odroid-N2 based on the S922X SoC

The Amlogic G12B SoC is very similar with the G12A SoC, sharing
most of the features and architecture, but with these differences :
- The first CPU cluster only has 2xCortex-A53 instead of 4
- G12B has a second cluster of 4xCortex-A73
- Both cluster can achieve 2GHz instead of 1,8GHz for G12A
- CPU Clock architecture is difference, thus needing a different
  compatible to handle this slight difference
- Supports a MIPI CSI input
- Embeds a Mali-G52 instead of a Mali-G31, but integration is the same

Actual support is done in the same way as for the GXM support, including
the G12A dtsi and redefining the CPU clusters.
Unlike GXM, the first cluster is different, thus needing to remove
the last 2 cpu nodes of the first cluster.

G12B clock driver is very close, the main differences are :
- the clock tree is duplicated for the both clusters, and the
  SYS_PLL are swapped between the clusters
- G12A has additional clocks like for CSI an other components

Dependencies :
- Patch 1, 3, 4, 5, 6 : None
- Patch 2 : Depends on Guillaume's Temperature sensor Clock patches at [4]

Changes since v1 at [3]:
- Renamed the g12b cpu clocks like g12a counterparts
- Rebased clock patches on top of Guillaume's Temperature sensor Clock patches at [4]
- Added AO-CEC-B support to N2 DTS

Changes since RFC at [1]:
- Added bindings review tags
- Moved the fclk_div3 CRITICAL flags to the gate
- Removed invalid CRITICAL flags on the cpu clocks

[1] https://lkml.kernel.org/r/20190327103308.25058-1-narmstrong@baylibre.com
[2] https://lkml.kernel.org/r/20190325145914.32391-1-narmstrong@baylibre.com
[3] https://lkml.kernel.org/r/20190404150518.30337-1-narmstrong@baylibre.com
[4] https://lkml.kernel.org/r/20190412100221.26740-1-glaroque@baylibre.com

Neil Armstrong (6):
  dt-bindings: clk: meson: add g12b periph clock controller bindings
  clk: meson: g12a: Add support for G12B CPUB clocks
  clk: meson: g12a: mark fclk_div3 as critical
  dt-bindings: arm: amlogic: add G12B bindings
  dt-bindings: arm: amlogic: add Odroid-N2 binding
  arm64: dts: meson: Add minimal support for Odroid-N2

 .../devicetree/bindings/arm/amlogic.txt       |   6 +
 .../bindings/clock/amlogic,gxbb-clkc.txt      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 185 +++++++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  82 ++++
 drivers/clk/meson/g12a.c                      | 453 ++++++++++++++++++
 drivers/clk/meson/g12a.h                      |  20 +-
 7 files changed, 747 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi

-- 
2.21.0

