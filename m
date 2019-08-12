Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB08C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134E320820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZRtFtRvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfHLWgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:36:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44036 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfHLWgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:36:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id c81so1417712pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6mriydnSdub6NLxi9wqFzvu5hE6ZUJo3BQ8+EaefM4=;
        b=ZRtFtRvm1oV6CJpoQ2JmmiXx4skqxreM/j5Eq1L3u7P6MBUgm98D6eStmtXDzSdAx2
         d0Tztc4qqhTp3f4DyRhQ7LXQvDzFhawgKNNGLy3/oHYyFx/u0l911wkAhjuwi52HkAmP
         VhzhDXCzfRJ9JQbU5ilewfYrPvXB6sZ09Ajek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6mriydnSdub6NLxi9wqFzvu5hE6ZUJo3BQ8+EaefM4=;
        b=sidFWSTeMFNPCFJb4lD6EIiRLehbfE4AFKJGNjBUInZ14vVa6W+SVJCXzN46ziiXyc
         b6L1zCC/DgU8YmKS4Joa3MeZguDnnvjg5fRo8nXBdNAQau+4T4YugedYY0CovzS9thXt
         94yIcrU4x2+UKbqfApzkSLcTKYGNu6pDxzD1hX3JhS5eWuwTcpkn6kCjogEyTTdkpS0F
         Vw4wPiQLjraWZPivgR2sKx9lq+JezwSM+Jj4XPGs0PdP7zzpE5EejDX2K9bgc8CDIesu
         DeyWsxfMy5O+H7swBy0DXpEs3K3KPrJ1nmCD7MY+BaaF0ASMfobfECqiriTzrOVAv57q
         W5yw==
X-Gm-Message-State: APjAAAViTTmVHx2m/PiPzvmVQF69s9FuugSoXaUBPpndXCMVL6pMPAfd
        ckVJ+dFrEHTJhLQ+1kbQ5W1HEA==
X-Google-Smtp-Source: APXvYqzmFOkbH6SBGaWwWz4cygxr9IHT2YmFXmQSOx4uGKqh6XAch5qOBif62M+Lb7U9C95PfCgqJA==
X-Received: by 2002:a63:211c:: with SMTP id h28mr31780020pgh.438.1565649384405;
        Mon, 12 Aug 2019 15:36:24 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b6sm93911594pgq.26.2019.08.12.15.36.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 15:36:23 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH v4 0/6] tpm: Add driver for cr50
Date:   Mon, 12 Aug 2019 15:36:16 -0700
Message-Id: <20190812223622.73297-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the the H1 secure microcontroller
running cr50 firmware found on various recent Chromebooks. This driver
is necessary to boot into a ChromeOS userspace environment. It
implements support for several functions, including TPM-like
functionality over a SPI interface.

The last time this was series sent looks to be [1]. I've looked over the
patches and review comments and tried to address any feedback that
Andrey didn't address (really minor things like newlines). I've reworked
the patches from the last version to layer on top of the existing TPM
TIS SPI implementation in tpm_tis_spi.c. Hopefully this is more
palatable than combining the two drivers together into one file.

[1] https://lkml.kernel.org/r/1469757314-116169-1-git-send-email-apronin@chromium.org

TODO:
 * Add a patch to spit out WARN_ON() when TPM is suspended and some
   kernel code attempts to use it
 * Rework the i2c driver per Alexander's comments on v2

Changes from v3:
 * Split out hooks into separate patches
 * Update commit text to not say "libify"
 * Collapse if statement into one for first patch
 * Update commit text on first patch to mention flag
 * Drop TIS_IS_CR50 as it's unused

Changes from v2:
 * Sent khwrng thread patch separately
 * New patch to expose TPM SPI functionality from tpm_tis_spi.c
 * Usage of that new patch in cr50 SPI driver
 * Drop i2c version of cr50 SPI driver for now (will resend later)
 * New patch to add a TPM chip flag indicating TPM shouldn't be reset
   over suspend. Allows us to get rid of the cr50 suspend/resume functions
   that are mostly generic

Changes from v1:
 * Dropped symlink and sysfs patches
 * Removed 'is_suspended' bits
 * Added new patch to freeze khwrng thread
 * Moved binding to google,cr50.txt and added Reviewed-by tag from Rob

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>

Andrey Pronin (2):
  dt-bindings: tpm: document properties for cr50
  tpm: add driver for cr50 on SPI

Stephen Boyd (4):
  tpm: Add a flag to indicate TPM power is managed by firmware
  tpm: tpm_tis_spi: Introduce a flow control callback
  tpm: tpm_tis_spi: Add a pre-transfer callback
  tpm: tpm_tis_spi: Export functionality to other drivers

 .../bindings/security/tpm/google,cr50.txt     |  19 +
 drivers/char/tpm/Kconfig                      |   9 +
 drivers/char/tpm/Makefile                     |   1 +
 drivers/char/tpm/cr50_spi.c                   | 372 ++++++++++++++++++
 drivers/char/tpm/tpm-interface.c              |   8 +-
 drivers/char/tpm/tpm.h                        |   1 +
 drivers/char/tpm/tpm_tis_spi.c                |  98 +++--
 drivers/char/tpm/tpm_tis_spi.h                |  37 ++
 8 files changed, 502 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
 create mode 100644 drivers/char/tpm/cr50_spi.c
 create mode 100644 drivers/char/tpm/tpm_tis_spi.h


base-commit: 0ecfebd2b52404ae0c54a878c872bb93363ada36
prerequisite-patch-id: ce0cac49be5e67df1427e4207cf38c6e31091445
-- 
Sent by a computer through tubes

