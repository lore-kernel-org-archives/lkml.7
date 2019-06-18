Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F719C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C15620863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560884747;
	bh=vK8tc7Kd1ER0oaq0T5vbExeB1V5IbhRIZBrXithdRSM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qQ6Fec2pb5+IjC5mJ1XDk3G6Hxt3mzMV2dQP/hHAZN8ehje6gO25YqwdvFch/7Tjq
	 qUjQewTqhjWvbhmMkIR7adAsH4Rb8w1tccxmsrijjBnRh4LeQ/7EnfTU10swDkB/Mu
	 DkRys+B8L30kzZcdlFzUNVoLb0DCVPFJv6cuZ9GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbfFRTFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 15:05:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfFRTFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 15:05:45 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9939220B1F;
        Tue, 18 Jun 2019 19:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560884744;
        bh=vK8tc7Kd1ER0oaq0T5vbExeB1V5IbhRIZBrXithdRSM=;
        h=From:To:Cc:Subject:Date:From;
        b=gFY5e132yO4yupLmLmnqzmDydMEQ4VP+fUPR85du/PyG0jwiZmvr1iSWYTUiTRtAK
         z4i3BdnIg3UmIccOouDtHfQ6KI/izeu1wMHR/y6EbSarhsOPoHYIYCWMjI3/wG7Hoz
         hFvxW+ldZQGwE5xx/t/7C5DY17w8/U+ekqdHTsj4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Olof Johansson <olof@lixom.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Joseph Kogut <joseph.kogut@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RFT 00/10] ARM/arm64: dts: exynos: Add support for Mali
Date:   Tue, 18 Jun 2019 21:05:24 +0200
Message-Id: <20190618190534.4951-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Inspired by patch from Joseph Kogut [1], let's add support for Mali GPUs
to most of other boards.  However it was tested only on Odroid U3
(Exynos4412) and not fully because requirement of special Mesa drivers
with Lima support.

Even without tests it brings full description of hardware and replaces
some out-of-tree downstream code (e.g. in Tizen).

Comments and tests are welcomed.

[1] https://patchwork.kernel.org/patch/10996887/

Best regards,
Krzysztof


Krzysztof Kozlowski (10):
  dt-bindings: gpu: mali: Add Samsung compatibles for Midgard and Utgard
  clk: samsung: Add bus clock for GPU/G3D on Exynos4412
  ARM: dts: exynos: Fix language typo and indentation
  ARM: dts: exynos: Add GPU/Mali 400 node to Exynos3250
  ARM: dts: exynos: Add GPU/Mali 400 node to Exynos4
  arm64: dts: exynos: Add GPU/Mali T760 node to Exynos5433
  arm64: dts: exynos: Add GPU/Mali T760 node to Exynos7
  ARM: multi_v7_defconfig: Enable Panfrost and LIMA drivers
  ARM: exynos_defconfig: Enable Panfrost and LIMA drivers
  arm64: defconfig: Enable Panfrost driver

 .../bindings/gpu/arm,mali-midgard.txt         |  1 +
 .../bindings/gpu/arm,mali-utgard.txt          |  1 +
 arch/arm/boot/dts/exynos3250-artik5.dtsi      |  5 ++
 arch/arm/boot/dts/exynos3250-monk.dts         |  5 ++
 arch/arm/boot/dts/exynos3250-rinato.dts       |  5 ++
 arch/arm/boot/dts/exynos3250.dtsi             | 33 ++++++++++++
 arch/arm/boot/dts/exynos4.dtsi                | 29 +++++++++++
 arch/arm/boot/dts/exynos4210-origen.dts       |  5 ++
 arch/arm/boot/dts/exynos4210-trats.dts        |  4 ++
 .../boot/dts/exynos4210-universal_c210.dts    |  5 ++
 arch/arm/boot/dts/exynos4210.dtsi             | 36 +++++++++++--
 .../boot/dts/exynos4412-itop-scp-core.dtsi    |  5 ++
 arch/arm/boot/dts/exynos4412-midas.dtsi       |  5 ++
 .../boot/dts/exynos4412-odroid-common.dtsi    |  5 ++
 arch/arm/boot/dts/exynos4412.dtsi             | 32 ++++++++++++
 arch/arm/configs/exynos_defconfig             |  3 +-
 arch/arm/configs/multi_v7_defconfig           |  3 +-
 .../dts/exynos/exynos5433-tm2-common.dtsi     |  5 ++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    | 51 +++++++++++++++++++
 .../boot/dts/exynos/exynos7-espresso.dts      |  5 ++
 arch/arm64/boot/dts/exynos/exynos7.dtsi       | 11 ++++
 arch/arm64/configs/defconfig                  |  2 +-
 drivers/clk/samsung/clk-exynos4.c             |  1 +
 include/dt-bindings/clock/exynos4.h           |  1 +
 24 files changed, 251 insertions(+), 7 deletions(-)

-- 
2.17.1

