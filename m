Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113E2C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20F7206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aom89KfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfHAKn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 06:43:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37015 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbfHAKn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:43:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id z28so14645358ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 03:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xJ+XW7erGOKB1qLPzmBxeO8g/P30n/FrQ5rJ6pbczJM=;
        b=Aom89KfQg4zR8rFKZ7WwksWEApb+WF09Q42ttz2qRwj/xSkGBGezOX+UtiYKI/hUml
         Do5bTuWh0t94mXcdLlZXXflSRP+PEOuuypvp9qDJOB3khN6LTQcSlKhVgksalzc5gqCr
         u8z9/fKrkR5wjGzeI6QvFIhVFK920BSw6fUS/vl4oQlni0DwQnCrtgqqiajBWorsj3vB
         Wmw0NdA5mrbzo6hCIkcYI+y27N7FSap7EEb+jIeLPoUNJAfs7Sl4K21CQ7zAORLIEzXa
         8Z+PkfpLf3kNT6j2Yx4U2lpuRgVxesgZXbqznFUFPp7oqm+5i6qSsCLqVJXZaT1w7wmG
         HKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xJ+XW7erGOKB1qLPzmBxeO8g/P30n/FrQ5rJ6pbczJM=;
        b=f8mjS9J7EjaLjUf8IBmGHtR2VtXk7i8cy44nOl0mB8bzE3LyypNhjmcS4uUqff/sMz
         oq4kE1i7VRkEHc7qIv4FNkt7FQQCFEoN1xRLYb3NSwrypGSU9hmX7Ci1SIam8sM+AE10
         m1zgbSJF0mBJJLijbSpVP0OgKFki5yx7vdEgmjsc8HAIWjLIyJh6DG9wcJ1B4t1sElXq
         eRKnWooflBUytX/+R6PSC1UPfvN/WfR3KW85XyDVF/T26P6l6UtzcPdljR4BvtcMGM2v
         J0f+/3ghNReW18BfFdwftVr0iVLPZ50MdqDbUU5XZNml3POZC9iT8mdjCxnrqA6dVBDC
         KOlA==
X-Gm-Message-State: APjAAAW6jmbTplS2gwgB9QWXezoDaLRptrDrtf+8T5YgwQJn/jnMLN0Q
        YGR5zvA8vUh35tqWdSQ9KPWoSA==
X-Google-Smtp-Source: APXvYqwr7N8nUcsTaa9qhK5CVPXKHkU82/bKtDqYW2xoBvPPjubmYiblEAF8FQu67NzuuouKXRNRGw==
X-Received: by 2002:a2e:8ecb:: with SMTP id e11mr9432739ljl.218.1564656205540;
        Thu, 01 Aug 2019 03:43:25 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id u15sm14569573lje.89.2019.08.01.03.43.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 03:43:24 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.3-rc3
Date:   Thu,  1 Aug 2019 12:43:19 +0200
Message-Id: <20190801104319.25247-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.3-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc1

for you to fetch changes up to 3a6ffb3c8c3274a39dc8f2514526e645c5d21753:

  mmc: mmc_spi: Enable stable writes (2019-07-22 15:31:00 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-sprd: Add a missing pm_runtime_put_noidle() to fix deferred probe
 - dw_mmc: Fix occasional hang after tuning on eMMC
 - meson-mx-sdio: Fix misuse of GENMASK macro
 - mmc_spi: Fix CRC problems for writes by using BDI_CAP_STABLE_WRITES

----------------------------------------------------------------
Andreas Koop (1):
      mmc: mmc_spi: Enable stable writes

Baolin Wang (1):
      mmc: host: sdhci-sprd: Fix the missing pm_runtime_put_noidle()

Douglas Anderson (1):
      mmc: dw_mmc: Fix occasional hang after tuning on eMMC

Joe Perches (1):
      mmc: meson-mx-sdio: Fix misuse of GENMASK macro

 drivers/mmc/core/queue.c         | 5 +++++
 drivers/mmc/host/dw_mmc.c        | 3 +--
 drivers/mmc/host/meson-mx-sdio.c | 2 +-
 drivers/mmc/host/sdhci-sprd.c    | 1 +
 4 files changed, 8 insertions(+), 3 deletions(-)
