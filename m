Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D7EC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF81020880
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555256905;
	bh=jj/osOfrMbaVR874KqsBMMoruvoKmyRyDfQEHMEario=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=atJMCuqGhgY93pHmsmL1RSwf4Nnhj8Q+Y0+BjQk32MwTsAuvgPwlkccQVU5Z65nFZ
	 UGUEGWhcW5TZ4cfosjiu62Vn6hmJLCIvDRQsEEkcikB0RWCQI1SeDUXo9sW6KoXfIl
	 5IxrebEFyyaaUg95vyNV0aYq0A63ZhhB6HvPkTSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfDNPsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 11:48:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfDNPsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 11:48:20 -0400
Received: from localhost.localdomain (unknown [194.230.158.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67C332148E;
        Sun, 14 Apr 2019 15:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555256899;
        bh=jj/osOfrMbaVR874KqsBMMoruvoKmyRyDfQEHMEario=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FIN/93v+4m2zlWg3jlrAsHNdrMjBTXeeV4/M9Q0L6THwyKpO/qHcRP8SI5z72XUOg
         g4/XoRXHqcIxkJzUkd42ymqzkmIBTDhqJLpIXtyXyrhTrUF0JJaLSlID57asCLn9nR
         t/9OhLmH5eu3z/wc8+izpd+rVbAv7vYNYGXANHvc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/3] ARM: samsung: Changes for v5.2
Date:   Sun, 14 Apr 2019 17:48:05 +0200
Message-Id: <20190414154805.10188-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190414154805.10188-1-krzk@kernel.org>
References: <20190414154805.10188-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.2

for you to fetch changes up to 7676e667c841375b41d9438b559756141aa93d0e:

  ARM: s3c64xx: Tidy up handling of regulator GPIO lookups (2019-04-14 12:53:03 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v5.2

1. Cleanup in mach code.
2. Add necessary fixes for Suspend to RAM on Exynos5422 boards (tested
   with Odroid XU3/XU4/HC1 family).  Finally this brings a working S2R
   on these Odroid boards (still other drivers might have some issues
   but mach code seems to be finished).
3. Require MCPM for Exynos542x boards because otherwise not all of cores
   will come online.
4. GPIO regulator cleanup on S3C6410 Craig.

----------------------------------------------------------------
Charles Keepax (1):
      ARM: s3c64xx: Tidy up handling of regulator GPIO lookups

Joonyoung Shim (1):
      ARM: exynos: Add CPU state management for Exynos542x under secure firmware

Marek Szyprowski (5):
      ARM: exynos: Move Exynos542x CPU state reset to pm_prepare()
      ARM: exynos: Add Exynos SMC values for secure memory write
      ARM: exynos: Fix undefined instruction during Exynos5422 resume
      ARM: exynos: Fix infinite loops on CPU powerup failure
      ARM: exynos: Set MCPM as mandatory for Exynos542x/5800 SoCs

Wen Yang (1):
      ARM: exynos: Fix a leaked reference by adding missing of_node_put

 arch/arm/configs/exynos_defconfig            |  1 -
 arch/arm/configs/multi_v7_defconfig          |  1 -
 arch/arm/mach-exynos/Kconfig                 | 12 ++-----
 arch/arm/mach-exynos/Makefile                |  2 +-
 arch/arm/mach-exynos/common.h                |  1 +
 arch/arm/mach-exynos/exynos.c                |  3 ++
 arch/arm/mach-exynos/firmware.c              |  1 +
 arch/arm/mach-exynos/mcpm-exynos.c           | 13 +++++++-
 arch/arm/mach-exynos/platsmp.c               |  9 ++++-
 arch/arm/mach-exynos/smc.h                   |  7 ++++
 arch/arm/mach-exynos/suspend.c               | 49 ++++++++++++++++++++++++----
 arch/arm/mach-s3c64xx/mach-crag6410-module.c | 14 ++++++--
 12 files changed, 89 insertions(+), 24 deletions(-)
