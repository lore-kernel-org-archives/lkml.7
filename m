Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71580C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454C425087
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1Iu0YTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfFCTEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:04:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37346 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFCTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:04:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id 131so4743910ljf.4;
        Mon, 03 Jun 2019 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t7rhVtFUtXBw/lf8LHeh6OAS84syCgQdznpIyj0FjEk=;
        b=H1Iu0YTWpc8i3DtuIS9EgzwQYZDE5z1R7rkVf6O/Et2ksvY2hmjSeQfH+ZE45JpJM5
         nArP6LHiXMKP5eGq9a2zwuJ1e5JcnFoLf3teQRgHI12Nxsi2tQ88FQt5nm3YOQ35mI9x
         U+CkXEqeXuDRv+sHZenbWnN0x/iFCP/1XpzqxU5pRrz61Zbjrk0pA3vtwG/OdO47S+aT
         7RDpiVGb9BZNfWdTEfIL8U2l2JtNTzfOJ0L7T6WNFLfH/tNQgv6S2Zmgxle0GmFKdVcz
         9DJ7TMYxyWTGiD77SKMZhELuwq1Gj5VSaUgRJLjIT0DDm7WVgSrgckHvcEcGqHYv9itM
         +zJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t7rhVtFUtXBw/lf8LHeh6OAS84syCgQdznpIyj0FjEk=;
        b=PGYcAUNeKwgrkfLQW5a0KGZFD7BoQLja8oXx3OGdHIXKE9dEtueF9wCbToDo26niGB
         hdqtpLhG96/UPdEZEbf9QcL09ANpWA7FwZW3NKDOixBU5hvL02tU6CXxSNEGB8uKzpPN
         sQvz/f46xVgfj1uX6dFmoquLfg4eR3xHtj8Ud0xs2ASfPlPTdqhtNo2AX2OK/Hk1KyXZ
         3pF9eJX8FTAoS/5jHDTBaWoGNdv31PXi60wTgiNnX6vDYqce1wKs29qzOA3F326ORO1R
         hQE7FPDauULLJHpXxhyvKckVU4wjvaO2OwnSAcYkie5obtbcMQhZcvuEO3s+caq8hb7E
         S6ag==
X-Gm-Message-State: APjAAAXrJ0VsweiHWFtJ4x8pJMva4bdBJSo6JlkGL4nPl1Itbtb8t7J+
        Mrv9IBpgxZxMNz8fOpqLzRs=
X-Google-Smtp-Source: APXvYqwMxFjSOlkMO2M/hnaHAJhz6XFwDjeLkN0Li6GoRXRKvAd4FxkNfCSV0jF+yMF9tTycCD1wbQ==
X-Received: by 2002:a2e:8197:: with SMTP id e23mr15054298ljg.28.1559588646774;
        Mon, 03 Jun 2019 12:04:06 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id l22sm2768805ljb.39.2019.06.03.12.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 12:04:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/10] NVIDIA Tegra clocksource driver improvements
Date:   Mon,  3 Jun 2019 21:59:38 +0300
Message-Id: <20190603185948.30438-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series primarily unifies the driver code across all Tegra SoC
generations. In a result the clocksources are allocated per-CPU on
older Tegra's and have a higher rating than the arch-timer where
appropriate, the newer Tegra210 is getting support for microsecond
clocksource and the driver's code is getting much cleaner.

The series was extensively tested on Tegra20 and Tegra30.

Changelog:

v4: In the comment to v3 Peter De Schrijver pointed out that arch-timer
    isn't affected by DVFS changes and thus it is preferred over tegra-timer
    on [T114, T210). Added new patch to address that: "Lower clocksource
    rating for some Tegra's".

    Daniel Lezcano suggested that it will be worthwhile to rename driver's
    source file as driver now covers more SoC generations than it initially
    did. Hence the new "Rename timer-tegra20.c to timer-tegra.c" patch.

v3: Fixed compilation on ARM64. Turned out that it doesn't have the
    delay-timer, thanks to Nicolas Chauvet for the report.

    Added new "Support COMPILE_TEST universally" patch for better
    compile-test coverage.

v2: Rebased on recent linux-next. Now all of #ifdef's are removed from the
    code due to the recent patch that generalized persistent clocksource.

    Couple other minor cosmetic changes.

Dmitry Osipenko (10):
  clocksource/drivers/tegra: Support per-CPU timers on all Tegra's
  clocksource/drivers/tegra: Unify timer code
  clocksource/drivers/tegra: Reset hardware state on init
  clocksource/drivers/tegra: Replace readl/writel with relaxed versions
  clocksource/drivers/tegra: Release all IRQ's on request_irq() error
  clocksource/drivers/tegra: Minor code clean up
  clocksource/drivers/tegra: Use SPDX identifier
  clocksource/drivers/tegra: Support COMPILE_TEST universally
  clocksource/drivers/tegra: Lower clocksource rating for some Tegra's
  clocksource/drivers/tegra: Rename timer-tegra20.c to timer-tegra.c

 drivers/clocksource/Kconfig                   |   2 +-
 drivers/clocksource/Makefile                  |   2 +-
 .../{timer-tegra20.c => timer-tegra.c}        | 296 +++++++++---------
 3 files changed, 148 insertions(+), 152 deletions(-)
 rename drivers/clocksource/{timer-tegra20.c => timer-tegra.c} (54%)

-- 
2.21.0

