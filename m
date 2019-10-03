Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBB6C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4D42133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OCRvgB+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfJCJ3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:29:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36909 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfJCJ3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:29:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id p14so1212459wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 02:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAQr2icY8DdB2jeIUQKDN7MkB84NLHg1L9AcC/sK07Q=;
        b=OCRvgB+P5OQDUcSd2HBI7DWP9QrfYRabJZtBudna32yoS1Mwp+kr9SjKglzFfOsrOJ
         NsOHCDQIddt5MFe/1YLcqXc25yaSsSK/QwCl/5Awfs6BjoIoeiSz++0B1txEiAzl00Rj
         54q9lpd52RKq+ILyYJWVU0S92CFpIP2Ho1P26+h4s1vx7GL20zt8mcnq27e4C02EWMIx
         d1Smd6ZZxmMpA1aTNuzPZ0VTeHuCbhje1s0Fz50qHCFlwLr6ivYpIBHtcdOaNfQtRqd3
         z6wQYVuEXH57O7EV/i/Dr0lD5fiKypBKlmnY03ndUoh7tY1CsRSW3qrm3qEY9VLk4gfN
         wP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAQr2icY8DdB2jeIUQKDN7MkB84NLHg1L9AcC/sK07Q=;
        b=YPBiP7o3chJm7VSJx0+zY+0qbiCPg4j6g2TODIxBJd1bPJ7Ivv+VJsZcYCgU/VpNsk
         gFwweOjmQGP8Zz2AwsvnvdSSiIf/5H2tzCsPlM/8fps6tAm9tqCiiHwePyHg6cl1Qbx5
         OdlxHOYpGVPt/pKs4D0Kgguy7VvyXIZCxgL+ZqZ0ua/W461+Bl8EAKIWwD+NH8haXecL
         8rX6B9eZiDJ1ZdHz7D3/5BCbglO6DiI6LXZGQj9zGDZ3QiBd2Hrh3FlGVUXYYX4vlNOL
         XGRO2gJYOnALEIuVYuaE3dgg6SuGR3WwzLp4iJq1s/awIdUdQAWmeIG2Qi01Pn1a7hfA
         ZbTg==
X-Gm-Message-State: APjAAAX1Qo8qVJ59sq8CHZokFKYfPLrIqtwM2NacjLUz8Dy34mhqLO9Z
        ddeihREKhZoIxtzhwmMwzwEScA==
X-Google-Smtp-Source: APXvYqznjMs8ajQPeMj8So5M/Rn6IkOFkynRcrkMEyfaYSRD2NVySc9mOdnkkKVEVarN5bh+jmsmBw==
X-Received: by 2002:a05:6000:1046:: with SMTP id c6mr6868600wrx.189.1570094962224;
        Thu, 03 Oct 2019 02:29:22 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id u83sm10554259wme.0.2019.10.03.02.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 02:29:20 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 0/2] drivers: make early_platform code SuperH-specific
Date:   Thu,  3 Oct 2019 11:29:11 +0200
Message-Id: <20191003092913.10731-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Some time ago I started a discussion about the need for a proper early device
probing mechanism[1]. One that would be based on real platform drivers and
support both platform data and device tree.

While we're far from reaching any consensus on the implementation, Arnd
suggested that I start off by moving the SuperH-specific early platform
drivers implementation to arch/sh[2].

This series is the first attempt at making way for a new, less hacky
implementation.

The first patch moves all the early_platform code to arch/sh.

The second patch prefixes all early_platform symbols with 'sh_'.

[1] https://lkml.org/lkml/2018/4/26/657
[2] https://lkml.org/lkml/2018/4/27/239

v1 -> v2:
- certain drivers are compiled for arm/mach-shmobile too - we need to
  add ifdefs for CONFIG_SUPERH around early_platform calls

v2 -> v3:
- added a stub for is_early_platform_device() which always returns false
  on non-SuperH architectures

v3 -> v4:
- rebased on top of v5.4-rc1
- removed patches that are already upstream from the series

Bartosz Golaszewski (2):
  drivers: move the early platform device support to arch/sh
  sh: add the sh_ prefix to early platform symbols

 arch/sh/drivers/Makefile               |   2 +-
 arch/sh/drivers/platform_early.c       | 347 +++++++++++++++++++++++++
 arch/sh/include/asm/platform_early.h   |  61 +++++
 arch/sh/kernel/cpu/sh2/setup-sh7619.c  |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh3.c     |   1 +
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh7710.c  |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh7720.c  |   3 +-
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c |   3 +-
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  |   9 +-
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |   3 +-
 arch/sh/kernel/cpu/sh5/setup-sh5.c     |   3 +-
 arch/sh/kernel/setup.c                 |   3 +-
 arch/sh/kernel/time.c                  |   5 +-
 drivers/base/platform.c                | 288 --------------------
 drivers/clocksource/sh_cmt.c           |  13 +-
 drivers/clocksource/sh_mtu2.c          |  13 +-
 drivers/clocksource/sh_tmu.c           |  14 +-
 drivers/tty/serial/sh-sci.c            |  11 +-
 include/linux/platform_device.h        |  64 +----
 40 files changed, 525 insertions(+), 387 deletions(-)
 create mode 100644 arch/sh/drivers/platform_early.c
 create mode 100644 arch/sh/include/asm/platform_early.h

-- 
2.23.0

