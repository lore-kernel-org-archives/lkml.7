Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEB4C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0522148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdIN33a4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfDHPYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:24:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33967 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfDHPYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:24:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id r186so219796wmf.1;
        Mon, 08 Apr 2019 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wFfQFYhzVKybR7ShGqdiFGDsFXlBts8TqRP5EzjTyGM=;
        b=tdIN33a4npqYexQ8y+rzxJzPI+teXixArrHHEO0ksBwyPCnL+AdYGSNeGWbi06PARz
         IbP7G0aJjxdCCufSjhFDE4T8dig6A0YRk2r7pkpBPl8fO+m76Mm9BNS1pzc1UVg0UU3X
         tOqbhMC/LS/Wg86yg0Acct1znY7v+2sZAULgPAf+flj09/Qzyt6Jy68UccS+1LQgsd/I
         dcuu+2TcMd0MgM/HiBWrcLGdzo/B1N8BBWwX283XijKY4Krrallls8AphCI7y9wPY5+9
         ReaUbUvchF2doeYU+AKPzP8q+TxCks/ylJEoB2cqOMAg3iIPhPnQHG3tJ5iAimH/D/4c
         8etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wFfQFYhzVKybR7ShGqdiFGDsFXlBts8TqRP5EzjTyGM=;
        b=rvWvxdEt6ZyvrNpAULFhvunQaSKj9wCR82vyIABEm3LEZXfQMsQ7i1pc+til1b0Zmb
         L7oZxp2+ds2wNvbYL5+ey+YVgkXWRF9CI0rZ7hJcU8gBmKo+4Mjw6tKqzixR3eIxX/M7
         naaErJ1Q61rf/n2y0BT9NmZTGR+HayTtPAAKdQ9pvTSYVFb8gO2RmwffEoZ6JqSxzEvJ
         9Rh34kDhPmFNrIhtZ00xnBkddVLosGebZsRzS9Fxttq2hdhCa9FNiiM9p8GtF9nbGxEw
         KJuRNW2Yf32P+jk3IMZRZST3AKOuAI3bihV9yL2MEohjOA8GhOEUlAplCqHF8PNv4FFy
         J7HA==
X-Gm-Message-State: APjAAAW6H/EvHmm8/sU/7zetRMxouOFwMWZNTKpumqn8Ozx1FDXmicVM
        BP+0SW28LT/7ZPryX2osd/Y=
X-Google-Smtp-Source: APXvYqyeX5Xx+9mmYV9zOm6LwfEWwhYVz+jDlL8Kxr0vooUFOtuLDkO9SbBCHYfVAnhgm2pknRUL6Q==
X-Received: by 2002:a1c:f310:: with SMTP id q16mr17496477wmq.102.1554737072745;
        Mon, 08 Apr 2019 08:24:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id o12sm32137298wrx.92.2019.04.08.08.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:24:31 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 0/6] Add Beelink GS1
Date:   Mon,  8 Apr 2019 17:27:49 +0200
Message-Id: <20190408152755.17405-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Jagan and Icenowy, most of this device-tree is taken from their works
on the Orange Pi One Plus and Pine H64.

PLEASE NOTE that I don't own an OrangePi nor a Pine H64 and PIO regulators for
these board has not been tested !
Please add a tested-by on these commits 5 and 6 before merging it.

Changes in v4 (Thanks to Maxime Ripard):
 - fix incorrect mmc_pins label
 - remove default rx/tr timing in emac
 - consistency in commit titles

Changes in v3 (Thanks to Maxime Ripard):
 - remove PL regulator
 - separate patch for sunxi.yaml
 - collect reviewed-by

Changes in v2 (Thanks to Maxime Ripard):
 - move MMC pinctrl to SOC dtsi
 - add board to Sunxi YAML file
 - add PIO/R_PIO regulators
 - remove always_on from SDIO regulators

Clément Péron (6):
  arm64: dts: allwinner: h6: move MMC pinctrl to dtsi
  dt-bindings: vendor-prefixes: add AZW
  arm64: dts: allwinner: h6: Introduce Beelink GS1 board
  dt-bindings: arm: sunxi: Add Beelink GS1 board
  arm64: dts: allwinner: h6: orangepi: Add PIO regulators
  arm64: dts: allwinner: h6: pine64: Add PIO regulators

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   | 260 ++++++++++++++++++
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  19 +-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  21 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |   4 +
 7 files changed, 305 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts

-- 
2.17.1

