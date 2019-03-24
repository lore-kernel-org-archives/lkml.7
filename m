Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9F3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFCD222EC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hs3OUz0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfCXPLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:11:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36327 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXPLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 11:11:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so6487408wml.1;
        Sun, 24 Mar 2019 08:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1iOOQJkzqOi5ynjs0xO8WYzOHUwCsH2EAzRs/Ax8GJE=;
        b=hs3OUz0JbxZxme1r8SwQL0kZwc6wySPZXX9gIRv7FU+yXvG2XCjdHfMktnUdqRcyI3
         w1Co1Y+luHghdARp5MuWen7kUR6+n3IySEG1lXnPrjBk5BNZoX3xBeh3o17WR1OhRoCP
         XshgrjbDjUejPMI8YQhFPUlgEFyzbFTxi8Z1KAwaWGrU1hS1fvU0VLiwUbhklWY7Zqov
         O7j272zDZtSLuOQ/JDkHC6/vOWXLAAQNM1QfjQBBCBW92I69YYpCqWsTRthXQ1Zt4C1u
         RKgPpywTHqMeal6CdAPEuw5sU3iB7ySblKZWqH4TgAdR+meV6bER4Edn+rxLho9FwrhJ
         SRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1iOOQJkzqOi5ynjs0xO8WYzOHUwCsH2EAzRs/Ax8GJE=;
        b=fJidNiaXtFKFQIrPef/wyDxXrubNWosxfvZCw5RZtTpWWp+QE8N8K0+kxeN9g6w27Y
         KK1m0CCZVTVmRcCKhyZwokRmJ7WZNddRdNZdQ+0CyckTLgO+X9Jqk0VHLy0ZQws+xFKS
         L+9Ha5R+0VGboVXyEMY6MUNaet3FeODf6gdqJOAUMBGc/xbCMI5jk24mgA17CB2ffbRx
         6S3FvH5V9tllQ5OE5bmh5O5Cx/q5utBGZOMwVcrBPtGdnhqVQSs7Puff7jHjeRAESGb2
         0y9nadcH0OKGZNOlCFarpKULnkT67Cew2TSF/rDZDlXODAgWj0dwWp8luWzAhn7Vb+zO
         ImUQ==
X-Gm-Message-State: APjAAAUAul56OikLmsnwAdCDWMcxwa3a/D1dtT7U50gr5hsoPhuM3+a0
        ncY+WGrVrXYtb2ErGnM/OAE=
X-Google-Smtp-Source: APXvYqywixNeYOzIbg+q68/qtFvRc6hmSkULAK2cS8wT1U0oQ6U1t3UZUj7/NyH/qQsskEZbNUp3sA==
X-Received: by 2002:a1c:ef1a:: with SMTP id n26mr9184065wmh.67.1553440293194;
        Sun, 24 Mar 2019 08:11:33 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD7399900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d739:9900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id 66sm13697730wmd.3.2019.03.24.08.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 08:11:32 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/4] clk: meson8b: add the VPU clock tree
Date:   Sun, 24 Mar 2019 16:11:00 +0100
Message-Id: <20190324151104.18397-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the VPU clock tree for Meson8, Meson8b and Meson8m2.
The VPU clock tree is slightly different on all three SoCs. The details
are explained in patch #4.

Meson8m2 requires the previously unsupported "gp_pll" PLL. This PLL only
exists on Meson8m2 - Meson8 and Meson8b don't have it.
A separate clk_hw_onecell_data is introduced for Meson8m2 (using the
compatible string which is already available) to account for this SoC
specific clock setup.

dependencies:
This series is meant to be applied on top of my other patch from [0]:
  dt-bindings: clock: meson8b: drop the "ABP" clock definition

changes since v1 at [1]:
- fixed typo in the subject of patch #2 (spotted by Neil)
- collected Reviewed-by tags from Neil (thank you!)


[0] https://patchwork.kernel.org/patch/10860387/
[1] https://patchwork.kernel.org/cover/10860401/


Martin Blumenstingl (4):
  dt-bindings: clock: meson8b: export the VPU clock
  clk: meson: meson8b: use a separate clock table for Meson8m2
  clk: meson: meson8b: add support for the GP_PLL clock on Meson8m2
  clk: meson: meson8b: add the VPU clock trees

 drivers/clk/meson/meson8b.c              | 422 ++++++++++++++++++++++-
 drivers/clk/meson/meson8b.h              |  12 +-
 include/dt-bindings/clock/meson8b-clkc.h |   1 +
 3 files changed, 433 insertions(+), 2 deletions(-)

-- 
2.21.0

