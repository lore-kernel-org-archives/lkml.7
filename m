Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E15BC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 06:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672102082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 06:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="NYIYk4Yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfEPGnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 02:43:42 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:36330 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfEPGnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 02:43:35 -0400
Received: by mail-pf1-f169.google.com with SMTP id v80so1310427pfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 23:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PQnz2nT/KjUKXeHjaBR81zMUbHzh45bNsq/83y1hyFY=;
        b=NYIYk4Yjkv66dEcU3KgIVlzPX+MS4Dh1JbpbaHYMRZrHb8UswXQgoqFLVAwvBF6fY2
         HiGXQi5PNGKstKPY9zh9H/RWxkCtTtDYbwRNbVKzECD3aJiseJ0R5/O7ukdAdtEYt12Y
         ZrzwhZE1qJqX0/zDOpzIXwzjigFlKvNmMMJ3rSm7zHrvgufbPbTsE8FwMLZ3Z2FKUWX5
         M5ygQdQDLMU9JJvH5x8XmeYTF1z7SvnfAl8481ZCizQdqsJxXZGpW82+7/iHLdTHWRk+
         gQv+XtCw/8SPyyTe7XDm0Ti+IAGKj9vW0hFbSHg8FKPmAcm9LHS4X8f7lKNVQlNywO0i
         Z79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PQnz2nT/KjUKXeHjaBR81zMUbHzh45bNsq/83y1hyFY=;
        b=cpUIHGKgsNGq6x8SJYkm9TipuGVsfvHXVCyVAbX4GOk95PJ6mOWLxsADNuy3mpjRhs
         /68JXagSIERbJ7DxlbRgbsaE1LKjY45BpHvy7Y+hQgeUJeYjrOywTa8agpV+REtZjq//
         UoIjNZ9/bBFtmg8O8xUWl77FaVBwXt3LQhnvNXsxTDHpNM/hv0F9nQbvmGw5E5IKFfDt
         stj7NL6HOfkcT6LtL0mYcuHkkfBjVuegf+4BKI/X/EpERF55GBl+6WXveFfIgJnSFNaM
         mD1vvTdmYkY5Ph1JbCRn3kOHwxw8pRbxsHX3s7hAI+1NfCjImu0gB+px6ATRLcQ3FlUY
         ltVg==
X-Gm-Message-State: APjAAAX9tm6Hr555j2dCLVZ0XKGAO4zXDEIKn0bAJy5t3Fns/46Y9rsH
        /Aduof63WcQS5KnRObnLSsW+/Q==
X-Google-Smtp-Source: APXvYqyaVixdyLVdneqZdfKmvJqCzMfXuFHlfYgDiH4+VC14F/TyNFkNjTkGtNIplKl6Gu9jfwXAdg==
X-Received: by 2002:a63:2cc9:: with SMTP id s192mr6303754pgs.24.1557989014876;
        Wed, 15 May 2019 23:43:34 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id w194sm11196050pfd.56.2019.05.15.23.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 23:43:33 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 4/4] ARM: SoC defconfig updates
Date:   Wed, 15 May 2019 23:43:04 -0700
Message-Id: <20190516064304.24057-5-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190516064304.24057-1-olof@lixom.net>
References: <20190516064304.24057-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Mostly the usual churn due to options being reordered or not added
in the right locations.
- Some various enabling of new drivers, etc.

... i.e. the usual updates, nothing particularly sticks out.

----------------------------------------------------------------

The following changes since commit 75ea84dcdb9cc6fa227385e796ea4ae90bb333c8:

  Merge tag 'armsoc-drivers' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-defconfig

for you to fetch changes up to 85200317b324924be3bc72b7bfcce219020ced9c:

  Merge tag 'v5.2-rockchip-defconfig32-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/defconfig

----------------------------------------------------------------

Biju Das (3):
      arm64: defconfig: enable RX-8581 config option
      ARM: shmobile: Enable PHY_RCAR_GEN3_USB2 in shmobile_defconfig
      ARM: shmobile: Enable USB [EO]HCI HCD PLATFORM support in shmobile_defconfig

Brian Masney (1):
      ARM: qcom_defconfig: add options for LG Nexus 5 phone

Dinh Nguyen (3):
      arm64: defconfig: enable PCIE_ALTERA
      arm64: defconfig: enable fpga and service layer
      arm64: defconfig: include the Agilex platform to the arm64 defconfig

Enric Balletbo i Serra (1):
      ARM: multi_v7_defconfig: Enable missing drivers for supported Chromebooks

Geert Uytterhoeven (3):
      ARM: shmobile: defconfig: Refresh for v5.1-rc1
      ARM: shmobile: defconfig: Enable support for CFI NOR FLASH
      ARM: multi_v7_defconfig: Enable support for CFI NOR FLASH

Jagan Teki (1):
      arm64: defconfig: Enable SPI_SUN6I

Jon Hunter (2):
      arm64: defconfig: Enable Tegra HDA support
      arm64: defconfig: Add PWM Fan support

Martin Blumenstingl (1):
      ARM: multi_v7_defconfig: enable the Amlogic Meson ADC and eFuse drivers

Olof Johansson (11):
      Merge tag 'amlogic-defconfig' of https://git.kernel.org/.../khilman/linux-amlogic into arm/defconfig
      Merge tag 'arm64_defconfig_for_v5.2' of git://git.kernel.org/.../dinguyen/linux into arm/defconfig
      Merge tag 'multi-v7-defconfig-for-v5.2-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/defconfig
      Merge tag 'tegra-for-5.2-arm-defconfig' of git://git.kernel.org/.../tegra/linux into arm/defconfig
      Merge tag 'tegra-for-5.2-arm64-defconfig' of git://git.kernel.org/.../tegra/linux into arm/defconfig
      Merge tag 'sunxi-config64-for-5.2' of https://git.kernel.org/.../sunxi/linux into arm/defconfig
      Merge tag 'renesas-arm64-defconfig-for-v5.2' of https://git.kernel.org/.../horms/renesas into arm/defconfig
      Merge tag 'renesas-arm-defconfig-for-v5.2' of https://git.kernel.org/.../horms/renesas into arm/defconfig
      Merge tag 'qcom-defconfig-for-5.2' of git://git.kernel.org/.../agross/linux into arm/defconfig
      Merge tag 'mvebu-arm64-5.2-1' of git://git.infradead.org/linux-mvebu into arm/defconfig
      Merge tag 'v5.2-rockchip-defconfig32-1' of git://git.kernel.org/.../mmind/linux-rockchip into arm/defconfig

Pascal Paillet (1):
      ARM: multi_v7_defconfig: Enable support for STPMIC1

Thierry Reding (4):
      Merge tag 'multi-v7-defconfig-for-v5.2-signed' of git://git.kernel.org/.../tmlind/linux-omap into for-5.2/arm/defconfig
      ARM: tegra: Update default configuration for v5.1-rc1
      ARM: tegra: Enable Trusted Foundations by default
      ARM: Enable Trusted Foundations for multiplatform ARM v7

Thomas Petazzoni (1):
      arm64: defconfig: enable mv-xor driver

Tony Lindgren (2):
      ARM: multi_v7_defconfig: Update for dropped options
      ARM: multi_v7_defconfig: Update for moved options

Valentin Schneider (1):
      arm64: defconfig: Update UFSHCD for Hi3660 soc


 arch/arm/configs/multi_v7_defconfig | 150 +++++++++++++++++--------------
 arch/arm/configs/qcom_defconfig     |  13 ++-
 arch/arm/configs/shmobile_defconfig |  13 ++-
 arch/arm/configs/tegra_defconfig    |  36 ++++----
 arch/arm64/configs/defconfig        | 100 ++++++++++++---------
 5 files changed, 177 insertions(+), 135 deletions(-)
