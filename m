Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79802C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC672086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i030CmbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfCQWzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 18:55:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32943 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfCQWza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 18:55:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so9949876pfd.0;
        Sun, 17 Mar 2019 15:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xxZ65DY7vxzATnUhNfFZNHDdifRft9qO1lmQBG3z9uE=;
        b=i030CmbErJdZChB/eUQ+tc3k4gzpI9/QWDthVCe1pH9/Yl9Dfu799E6MtCiZs4xtpd
         lKeAb+t4v1e4mB3EeOsMN9XIbYsk7Cu59/PkcJ6hsdO3tCjaU0JdNtMZ+6ddqLXp+LiX
         3+90tCjCG+gG3Zr/tlNY6v6BoW6KLnrQ79pa/iiG9Szck5gOwOQndlj4ZnU7F2pajvCY
         UCHOUMfBg2I7y2O+kjfo4jeuhLSniJ+tw7PY5ALFcBRXbYTue1VeiOpNgkrysujX3IL1
         MGb4Ac9vPw/hM3gf7/Va35MjRKscwBqk0ENkid3eS3q3dX07g5UadBANqrkAONSqasM1
         zTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xxZ65DY7vxzATnUhNfFZNHDdifRft9qO1lmQBG3z9uE=;
        b=fjAwGAulza3q+ETlu1VvxSZGub+11mEz0GAdYhFJ8mgIR0wwj4ilJeqax4sca6r2O9
         Da0Ua5CZsHXjeKdfXoFCbUSECyqTwAm4IuALNh4zjdUKQVlxHpIqza4dbNSvAKnZAKLp
         pcVWEWxF7GiiPibUA32gk/76KlZE22l6aMFFrFRI3xFQyAkyebaox7cqbyYxIoZUs08z
         W0yw4ZLXO45jHo6We9L8s5n2nxi0ZAoKzYAWBXnk0kIubAfsKQvt5rUQ35olF5ObfDJp
         og6QkxsTmpe8mE+sa5qQoboM6MCVAjZk0h3fn53hL/4HnGJPeKW8u/61hql3hKx0oBaC
         tO7w==
X-Gm-Message-State: APjAAAXgso3mYelvBrnl5us0Dv8wezMK08Yi5zVJ2us2owbUCsAA2TLz
        LeHyCPMx9Evdrv3xNZ8MPeA=
X-Google-Smtp-Source: APXvYqyjxAXIRBL0cf7PsMl+P8ChgEkfMOxc7Y64lrxiqcH7X6vW4XW6aKmF8dO6iaTANkgcJc281Q==
X-Received: by 2002:a65:4381:: with SMTP id m1mr13863218pgp.97.1552863329779;
        Sun, 17 Mar 2019 15:55:29 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-37-86.pppoe.spdop.ru. [94.29.37.86])
        by smtp.gmail.com with ESMTPSA id v2sm13738838pfg.118.2019.03.17.15.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 15:55:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/7] Support Trusted Foundations firmware on Tegra30
Date:   Mon, 18 Mar 2019 01:52:03 +0300
Message-Id: <20190317225211.23091-1-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds support for the Trusted Foundations firmware on
NVIDIA Tegra30. Pretty much all of Tegra30 consumer devices have that
firmware and upstream kernel can't boot on those devices without the
firmware support. This series was tested on Nexus 7, TF300T and Ouya
Tegra30 devices.

Changelog:

v10:    - Removed duplicated message about keeping L2C disabled when
          CONFIG_TRUSTED_FOUNDATIONS=n as was suggested by Michał Mirosław
          in the review comment to v9.

v9:     - Rebased on recent linux-next, resolved one conflict.

v8:     - Replaced BIT() macro with a definition provided by cache-l2x0.h
          in the "Support L2 cache maintenance" patch as was suggested by
          Russell King in the review comment to v7.

v7:     - Fixed kernel booting with CONFIG_TRUSTED_FOUNDATIONS=n by
          providing a dummy L2C write_sec implementation in the
          "Support L2 cache maintenance" patch.

        - Minor clean up: no static variables anymore, replaced
          white spaces with a tab in one place, etc.

        - Added Michał's and Robert's Tested-by/Signed-off-by to the
          patches.

v6:     - One patch got messed up accidentally in v5, this is fixed now.

        - Squashed "Support L2 cache maintenance done via firmware" patch
          into the "Add firmware calls..." patch.

        - The l2x0_init() firmware callback is now invoked unconditionally
          because it is always a NO-OP on T114+ and is a NO-OP on T20/30
          if firmware node is missed in device-tree, hence there is no
          need to check the machine's DT compatible as it was done in the
          previous versions of the series.

v5:     - Fixed machine hanging on disabling D-cache during suspend,
          turned out there are slight variations in behaviour between
          firmware version in regards to cache-management. Thanks to
          Robert Yang for reporting the problem and helping with the
          solution.

v4:     - Fixed Thumb2-kernel hanging on Tegra20, turned out it was not a
          good idea to switch CPU into Thumb2 mode right after jumping into
          the reset handler.

        - Moved LP2-mode-set firmware call invocation to a later stage to
          better replicate what downstream kernel does. This change was
          suggested by Robert Yang and fixes system hang on Ouya game
          console.

        - Added references to the original work made by Michał Mirosław
          into commit messages of the relevant patches.

v3:     - Implemented suspend-resume support.

        - Reworked arm/firmware/trusted_foundations.c a tad. Now cache
          is getting properly initialized, cache enabling / disabling is
          supported.

v2:
        - The "Don't apply CPU erratas in insecure mode" patch got some
          cleanup, in particular resolved the messiness in
          __tegra_cpu_reset_handler_data.

        - Added a comment to tf_cache_write_sec(), justifying the warning
          message.

Dmitry Osipenko (7):
  ARM: trusted_foundations: Support L2 cache maintenance
  ARM: trusted_foundations: Make prepare_idle call to take mode argument
  ARM: trusted_foundations: Provide information about whether firmware
    is registered
  ARM: tegra: Set up L2 cache using Trusted Foundations firmware
  ARM: tegra: Don't apply CPU erratas in insecure mode
  ARM: tegra: Always boot CPU in ARM-mode
  ARM: tegra: Add firmware calls required for suspend-resume on Tegra30

 arch/arm/firmware/trusted_foundations.c    | 75 +++++++++++++++++++++-
 arch/arm/include/asm/firmware.h            |  2 +-
 arch/arm/include/asm/trusted_foundations.h | 23 +++++++
 arch/arm/mach-tegra/cpuidle-tegra114.c     |  3 +-
 arch/arm/mach-tegra/pm.c                   | 49 ++++++++++++++
 arch/arm/mach-tegra/reset-handler.S        | 50 +++++++++++----
 arch/arm/mach-tegra/reset.c                |  3 +
 arch/arm/mach-tegra/reset.h                |  9 ++-
 arch/arm/mach-tegra/sleep-tegra20.S        |  4 ++
 arch/arm/mach-tegra/sleep.S                | 14 ++--
 arch/arm/mach-tegra/tegra.c                |  2 +
 11 files changed, 212 insertions(+), 22 deletions(-)

-- 
2.20.1

