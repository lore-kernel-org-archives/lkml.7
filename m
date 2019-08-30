Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB14C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2C322CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfPabs5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfH3Hl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:41:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33509 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfH3Hlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:41:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id z17so5597180ljz.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 00:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PHzpuIcTRjA1mq8KL5MN0wJTgcqsL2rY6mp+YXB52Ls=;
        b=hfPabs5hMPL1EJxJkAJjbgTZUMT+5b1e3bLviGhv9lgFwvTGdleR3fO8EI20ZW4355
         UEEbFWGrQNXnAtb4gagdSUl261WsGq6GKEeen2ycendY/OatHM5RrjTlDDLYkatxbdlW
         B/NR9cK4bMa3SvLVZ4ec+BKSX1KFNshlwWvc1oX3IbwEEHkFGnDpnHNlYdiNotdOUN3R
         NEtZIU35z9GnyGsAVjQSdVzYzcjoY0SViHowyfnc2t/no0u5E26YbmChxVnLwpvYEh+E
         Vt2KVQEByvtuJ+duAeYBHa6BZEyPNj7/4M8vDOiWZQGSCDSFVIpvJn7wsqGahqXx+874
         50Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PHzpuIcTRjA1mq8KL5MN0wJTgcqsL2rY6mp+YXB52Ls=;
        b=f2VS2guCwZU3k2QWhdMQX5SwmLSUPBQr/9sEtBJRo4SNVaVrE1csBRH6Mqkd8k77yY
         CeooYb9aE6VwxQ/KkL0pbxv741GxLAI7qop3E6aSDnUa3KOK7p5+H9Cn7XXgVl4kStLG
         f/KcTaPOFgntns+JX7UHboeHtJxecOYbw6/HIlZIUP4ewilRWpsWKVsZCDoFbx0vo6/g
         R+UflsPVDMv8CWsceNblm8MEFEhai3jf1WEHzkxoghVyqLu5cHe97z4Q2sRqT1RDthzx
         EJTpvEb4zZ5wlA6GUb1FwgMX1PZB4NM8ixRQ4AUzHq/XnQY4ROPxw418NNHJGBfO0YIE
         YhTw==
X-Gm-Message-State: APjAAAW6Wh9igre5CytSf021IfOMjRtenMIv3B854fF9uPRKRoexiFN0
        uHFy3PGvMqP0HKk1ZX8qc4vQaA==
X-Google-Smtp-Source: APXvYqyMKbsWiChlmyh4S1z7TBoAjspNNmohTUFxHh0jW3nfrhk/M/R0o7Ru4+/2nY1j8l+PByVLjQ==
X-Received: by 2002:a2e:8085:: with SMTP id i5mr7888581ljg.23.1567150909990;
        Fri, 30 Aug 2019 00:41:49 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id u13sm714119ljj.40.2019.08.30.00.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 00:41:49 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.3-rc7
Date:   Fri, 30 Aug 2019 09:41:47 +0200
Message-Id: <20190830074147.3691-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.3-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc5

for you to fetch changes up to e73a3896eaca95ea5fc895720502a3f040eb4b39:

  mmc: sdhci-cadence: enable v4_mode to fix ADMA 64-bit addressing (2019-08-30 09:17:53 +0200)

----------------------------------------------------------------
MMC core:
 - Fix init of SD cards reporting an invalid VDD range

MMC host:
 - sdhci-sprd: Fixes for clocks, card-detect, write-protect etc
 - sdhci-cadence: Fix ADMA 64-bit addressing
 - sdhci-tegra: Re-allow writing to SD card when GPIO pin is absent
 - sdhci-of-at91: Fix eMMC init by clearing HS200 cap as it's not supported

----------------------------------------------------------------
Chunyan Zhang (5):
      mmc: sdhci-sprd: fixed incorrect clock divider
      mmc: sdhci-sprd: add get_ro hook function
      mmc: sdhci-sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
      mms: sdhci-sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
      mmc: sdhci-sprd: clear the UHS-I modes read from registers

Dmitry Osipenko (1):
      Revert "mmc: sdhci-tegra: drop ->get_ro() implementation"

Eugen Hristev (1):
      mmc: sdhci-of-at91: add quirk for broken HS200

Masahiro Yamada (1):
      mmc: sdhci-cadence: enable v4_mode to fix ADMA 64-bit addressing

Ulf Hansson (1):
      mmc: core: Fix init of SD cards reporting an invalid VDD range

 drivers/mmc/core/sd.c            |  6 ++++++
 drivers/mmc/host/sdhci-cadence.c |  1 +
 drivers/mmc/host/sdhci-of-at91.c |  3 +++
 drivers/mmc/host/sdhci-sprd.c    | 30 +++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci-tegra.c   | 14 ++++++++++++++
 5 files changed, 49 insertions(+), 5 deletions(-)
