Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9213DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676592461E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pA4q1aPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfFDIOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:14:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39374 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfFDIOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:14:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2so12212249pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jV8VCHbj6Lro7TEgyHmuW7nfZ6KFGO5pn05b2o6Dgbc=;
        b=pA4q1aPO8wMBceIMuXHnOPs76k27i1v3HVZe3OwTff0Uk2bwwhPFnu0KC3WuR8DbH/
         9w//GwDJeRxrS0rTh0SXzdvWeGVZ1VhgS2slFROTSH00X4uM9SQN0HX366tQlowjAHVC
         A0/bdTjSJnoKpFyEiixiNEVytwUWAO5WtmcOr9iUdqUMzKxZZQ42fSyB43Xp8mpZSa6C
         nbV9mcCGlv33QQrUS6I+IgCne11HKrnL+QzlMsefZlb++xKAZPYQvXfuAT71o6UbZiaA
         uE6c0QB8KkiK/pL4WV6phIA1mdodo8jgXn3ay2M5KnKla72LPKtnAXWsI5zVjRH3syqk
         645g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jV8VCHbj6Lro7TEgyHmuW7nfZ6KFGO5pn05b2o6Dgbc=;
        b=F1tu8F34SMlot/Hkx0Y4CtpjUj/PNHU6jssOg1PXdrbpQtVOgwyHy0riApr5dPMuF0
         fC9MtnWDZQFTtUuSO8xtxaABrShsWKHUS10Ac7FHvDcWQU28xbVTDKuA0OuiPhscFOOf
         oytwuhtgABU6MXMJgMEbye565KR26O+NuGPO4MiYoVJ7y2tbX1R7ouD4Vybz3qYZ3Jym
         t+irUOFmPlCrYnqadKUwNZxNBxp7vLaGi9nKyConpJIFHarzuWVe80R/je/7c/8dxz5z
         N3FM2oPnI6aT4vrhO04TSOAnCNyojol9+xcG3stQGZrZbpZt+jimi6Cpi26Lq5VGWLAp
         uC7g==
X-Gm-Message-State: APjAAAWBNGEEwJlxqkEX3hNRX57IjB2K1B16QmktnmfopHkGTjDkoShB
        FmYRBB2PK3e4iefFeLjA63UHtQ==
X-Google-Smtp-Source: APXvYqyBT1jr5sCtI1Qrr8XvCjo0MKf4W3aMfwPavowCyU4VjHK9RS0I0j58WrwdIf8NNGx3+0mwsw==
X-Received: by 2002:a62:e303:: with SMTP id g3mr35873984pfh.220.1559636088227;
        Tue, 04 Jun 2019 01:14:48 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j4sm14818804pgc.56.2019.06.04.01.14.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 01:14:47 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/9] Add SD host controller support for SC9860 platform
Date:   Tue,  4 Jun 2019 16:14:20 +0800
Message-Id: <cover.1559635435.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds optional clock support, HS400 enhanced strobe mode support,
PHY DLL configuration and other optimization to make the SD host controller
can work well on the Spreadtrum SC9860 platform.

Changes from v1:
 - Add acked-tags from Adrian.
 - Fix one mistake by changing MMC_TIMING_MMC_HS to MMC_TIMING_SD_HS in patch 8.

Baolin Wang (9):
  mmc: sdhci-sprd: Check the enable clock's return value correctly
  dt-bindings: mmc: sprd: Add another optional clock documentation
  mmc: sdhci-sprd: Add optional gate clock support
  mmc: sdhci-sprd: Implement the get_max_timeout_count() interface
  mmc: sdhci-sprd: Add HS400 enhanced strobe mode
  mmc: sdhci-sprd: Enable PHY DLL to make clock stable
  dt-bindings: mmc: sprd: Add PHY DLL delay documentation
  mmc: sdhci-sprd: Add PHY DLL delay configuration
  arm64: dts: sprd: Add Spreadtrum SD host controller support

 .../devicetree/bindings/mmc/sdhci-sprd.txt         |   19 +++
 arch/arm64/boot/dts/sprd/whale2.dtsi               |   35 ++++
 drivers/mmc/host/sdhci-sprd.c                      |  171 +++++++++++++++++++-
 3 files changed, 217 insertions(+), 8 deletions(-)

-- 
1.7.9.5

