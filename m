Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C6EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDAD2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OV0ixlMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406299AbfHIKBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 06:01:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39609 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfHIKBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:01:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so91489260ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 03:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pg4XtA+SLXLzi6cetxivjFuoLtXdpkbDdVYr7VT2SpY=;
        b=OV0ixlMxJ78+G+mzjCxfvoi/QFApRzxYxo73BN4Iw2aGxmZi9pEm9P9Z0Iqy/Ylc0K
         QicaYcnvM3WdyQeczJ1la+M5adWB6HcOG3TBjwvKCBlO1waiz0NvmDQp+3dkNaXH6CQ4
         tPApB0dE81dc5dJzui/jEjmbbrmAKH7BFY4164pN/y6CqvOWGgNID1AUUp3LInxs4I2u
         +4V21lAxOih31dPzG0gxHHak55IsasO8gM16Nq11AN5JaVVHgibpTV/xcMzw2DErL8Ls
         FNG+/mgTYViQgQjH4fUr2slfMl/XZ4R5WdaSbKmvC/6Hml0HqfPa5rzfdCVQu5n3L0zK
         h2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pg4XtA+SLXLzi6cetxivjFuoLtXdpkbDdVYr7VT2SpY=;
        b=hWEuSJ2XKFAEuT7CYQGspdO3z93LpsdZkIRneLr9ZaPyxsgZBryFbywfsWYMbUNS0v
         V8uIG2YBpbhDsZrCowTmKpV6JI1vytFHEqBIyp6kSZroBngTw6NmGI9djghi2YwrlnQB
         NDgABwa3uCUWi1XoqwpXXZYZtfem0q/wA8qa7e/niynBM5HCJcopBzQYKTWOIYVOoeGx
         9//+Rcg4eBD2JAismGp/f3rlRLHDjq1cVb0IlDUNKCal0C1XHbbVHdG1gTpjwzXRWA6H
         5VnR0n5yGJMQeOeyd3qbppdpE9CSglzY1H81Bet7AVqt33Qq0bz8pqK6Ihn5HyKqg5Zr
         7G4w==
X-Gm-Message-State: APjAAAWqjo0vyPz/pWvqc9UVo6RGdIMxa4qrVvYf27aCmZVWJzTJP/zQ
        dEn1ebu1qYbAlN4FmgrtIY1HqA==
X-Google-Smtp-Source: APXvYqwo9Be0wGp47XSaXElvSTAeHX/Cqr/OrCwxyl6LPCE3+XV76iOxjrsetOV6TOEC5eQTioYcdA==
X-Received: by 2002:a2e:3e01:: with SMTP id l1mr10780346lja.208.1565344913095;
        Fri, 09 Aug 2019 03:01:53 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id i123sm2654114lfi.72.2019.08.09.03.01.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 03:01:52 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.3-rc4
Date:   Fri,  9 Aug 2019 12:01:49 +0200
Message-Id: <20190809100149.7027-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.3-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc3

for you to fetch changes up to b803974a86039913d5280add083d730b2b9ed8ec:

  mmc: cavium: Add the missing dma unmap when the dma has finished. (2019-08-06 18:59:14 +0200)

----------------------------------------------------------------
MMC host:
 - cavium: Fix DMA support
 - sdhci-sprd: Fix soft reset when runtime resuming

----------------------------------------------------------------
Baolin Wang (1):
      mmc: sdhci-sprd: Fix the incorrect soft reset operation when runtime resuming

Kevin Hao (2):
      mmc: cavium: Set the correct dma max segment size for mmc_host
      mmc: cavium: Add the missing dma unmap when the dma has finished.

 drivers/mmc/host/cavium.c          | 4 +++-
 drivers/mmc/host/sdhci-acpi.c      | 2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 drivers/mmc/host/sdhci-of-at91.c   | 2 +-
 drivers/mmc/host/sdhci-pci-core.c  | 4 ++--
 drivers/mmc/host/sdhci-pxav3.c     | 2 +-
 drivers/mmc/host/sdhci-s3c.c       | 2 +-
 drivers/mmc/host/sdhci-sprd.c      | 2 +-
 drivers/mmc/host/sdhci-xenon.c     | 2 +-
 drivers/mmc/host/sdhci.c           | 4 ++--
 drivers/mmc/host/sdhci.h           | 2 +-
 11 files changed, 15 insertions(+), 13 deletions(-)
