Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52E9C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6579821670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5U/Qd71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfFZOnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:43:39 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:43051 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfFZOnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:43:37 -0400
Received: by mail-wr1-f43.google.com with SMTP id p13so3028269wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:openpgp:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=a0aJVqJyT5MmKtZII2ijjYUZNDOY4sPy/JeG3YUx5EQ=;
        b=g5U/Qd71YEZWr5cNPBwqduTOi64n06knfd4jA5VjBzk2L8yBuKhdMF5gWANL7rYtct
         6Tjh+5jZ0po2NhdcKJlrcr6czKsWaS7xAxHkWMMnzgn4HAIdtTWNcf4p0HVn63dhsMwY
         33NH4wJka5/kGfJDaF/71CLUBvipsvmiJhLOK0O2noe5B1zycWwgHQybkd+fZigwsq1w
         auc1wpoJcKmf3efEloabTZtWk8NPm7bPZO3XHeYn7YpjzG7E1IOxDxjYS4POJU8USVKF
         vAK2xWHv1ijkhbouSu2kDg2yqOiONI95WfwMz74hRX8u5buwcD/xfCmtPkNtiQp/+h5W
         iUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=a0aJVqJyT5MmKtZII2ijjYUZNDOY4sPy/JeG3YUx5EQ=;
        b=e5VBVyVxu17TLnNXFHy0DwTvbrr6MZsfSpaTI5YzznztF2mGKdWSsendjzWGhCHVv/
         Pl51paVmeCrxNqG1wKh4UhjVGDyMD7U/spvIxB78qXTi1oM1TtXMowpHRtzmKIyQAoa0
         xjp805y+hanyxWOl2NhKhZtoy5nDW9QhBCBq1Sh/i5U/OLEbPXM4RLvcqHbi+vvPKk5R
         BN20t2opASVCZE5wK51uWjbPkWizSva9My4OuGhYKdxOaPw59VbmzbNkl9FzCXaV+9iA
         FRo6YZLZGCrWhDFu0Rv39NSZqvcQy44L4pkQl3PdtyJT2JJXwxAJ0Glb1zK0GALhGIcP
         fehA==
X-Gm-Message-State: APjAAAWKwjaaIimvNL7l5Q0/4WwAYdh1tQ3UL8ztfKEdC6BIqviBEF5p
        CTkULND1ABCMAKDSAg8r/K6ndw==
X-Google-Smtp-Source: APXvYqwoujdheiu3IZi+NVZAnPGgok4brVslaGL2oaqdz9vdPt6P9yDNugOFPDcw7rENSgUvR+qCkA==
X-Received: by 2002:adf:e843:: with SMTP id d3mr4123599wrn.249.1561560214800;
        Wed, 26 Jun 2019 07:43:34 -0700 (PDT)
Received: from [192.168.0.41] (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.googlemail.com with ESMTPSA id k125sm2750090wmf.41.2019.06.26.07.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:43:34 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bai Ping <ping.bai@nxp.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v5.4
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
Date:   Wed, 26 Jun 2019 16:43:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,


The following changes since commit d48e0cd8fcaf314175a15d3076d7a1e71bd4e628:

  timekeeping: Boot should be boottime for coarse ns accessor
(2019-06-25 08:54:51 +0200)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git tags/timers-v5.4

for you to fetch changes up to a2e1bb44a35d84bc760a0553fb1e36fecc25a623:

  Merge branch 'timers/drivers/davinci' into timers/drivers/next
(2019-06-26 16:24:33 +0200)

----------------------------------------------------------------
This version contains the following changes:

 - Rewrite of the davinci timer resulting to an immutable branch to be
   shared with davinci platform specific tree (Bartosz Golaszewski)

 - Cleanup and improvements of the tegra timer (Dmitry Osipenko)

 - Add new nxp system counter timer (Bai Ping)

 - Increase priority for exynos_mct to take over the initialization
   of the IP the arch ARM timer depends on (Marek Szyprowski)

 - Change macro use _BITUL() by BIT() on arc timer (Masahiro Yamada)

 - Implement the delay timer on ixp4xx (Linus Walleij)

 - Add the SPDX license identifier on the meson timer (Neil Armstrong)

----------------------------------------------------------------
Andrew Murray (1):
      clocksource/drivers/arm_arch_timer: Extract elf_hwcap use to
arch-helper

Bai Ping (1):
      clocksource/drivers/sysctr: Add nxp system counter timer driver
support

Bartosz Golaszewski (2):
      clocksource/drivers/davinci: Add support for clockevents
      clocksource/drivers/davinci: Add support for clocksource

Daniel Lezcano (1):
      Merge branch 'timers/drivers/davinci' into timers/drivers/next

Dmitry Osipenko (17):
      clocksource/drivers/tegra: Support per-CPU timers on all Tegra's
      clocksource/drivers/tegra: Unify timer code
      clocksource/drivers/tegra: Reset hardware state on init
      clocksource/drivers/tegra: Replace readl/writel with relaxed versions
      clocksource/drivers/tegra: Release all IRQ's on request_irq() error
      clocksource/drivers/tegra: Minor code clean up
      clocksource/drivers/tegra: Support COMPILE_TEST universally
      clocksource/drivers/tegra: Lower clocksource rating for some Tegra's
      clocksource/drivers/tegra: Rename timer-tegra20.c to timer-tegra.c
      clocksource/drivers/tegra: Restore timer rate on Tegra210
      clocksource/drivers/tegra: Remove duplicated use of per_cpu_ptr
      clocksource/drivers/tegra: Set and use timer's period
      clocksource/drivers/tegra: Drop unneeded typecasting in one place
      clocksource/drivers/tegra: Add verbose definition for 1MHz constant
      clocksource/drivers/tegra: Restore base address before cleanup
      clocksource/drivers/tegra: Cycles can't be 0
      clocksource/drivers/tegra: Set up maximum-ticks limit properly

Linus Walleij (1):
      clocksource/drivers/ixp4xx: Implement delay timer

Marek Szyprowski (1):
      clocksource/drivers/exynos_mct: Increase priority over ARM arch timer

Masahiro Yamada (1):
      clocksource/drivers/arc_timer: Use BIT() instead of _BITUL()

Neil Armstrong (1):
      clocksource/drivers/timer-meson6: Update with SPDX Licence identifier

 .../devicetree/bindings/timer/nxp,sysctr-timer.txt |  25 ++
 arch/arm/include/asm/arch_timer.h                  |  10 +
 arch/arm64/include/asm/arch_timer.h                |  13 +
 drivers/clocksource/Kconfig                        |  14 +-
 drivers/clocksource/Makefile                       |   4 +-
 drivers/clocksource/arc_timer.c                    |   3 +-
 drivers/clocksource/arm_arch_timer.c               |  15 +-
 drivers/clocksource/exynos_mct.c                   |   4 +-
 drivers/clocksource/timer-davinci.c                | 369 ++++++++++++++++++
 drivers/clocksource/timer-imx-sysctr.c             | 145 +++++++
 drivers/clocksource/timer-ixp4xx.c                 |  16 +-
 drivers/clocksource/timer-meson6.c                 |   5 +-
 drivers/clocksource/timer-tegra.c                  | 416
+++++++++++++++++++++
 drivers/clocksource/timer-tegra20.c                | 379
-------------------
 include/clocksource/timer-davinci.h                |  44 +++
 include/linux/cpuhotplug.h                         |   2 +-
 16 files changed, 1060 insertions(+), 404 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
 create mode 100644 drivers/clocksource/timer-davinci.c
 create mode 100644 drivers/clocksource/timer-imx-sysctr.c
 create mode 100644 drivers/clocksource/timer-tegra.c
 delete mode 100644 drivers/clocksource/timer-tegra20.c
 create mode 100644 include/clocksource/timer-davinci.h

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

