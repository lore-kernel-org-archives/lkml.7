Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AF8C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DF32082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nFQ4Ekck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfFMSJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:09:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39712 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbfFMSJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:09:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so12323672pfe.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kxoc9uaFTrXitgGYEWP1umI8D3nYTFG7/XndbmYY6a0=;
        b=nFQ4EkckPxw0WF0MFLIMBWkPAPG+G/Am9yz3ZWwP3J+255TSNgezoU085vQrU4CYJc
         BUTYSLyr8z9cPfE3d216HI5JKug0qawJ4t5hsdHfXZyDmyukCy2JV60La7QzJQZpiL8c
         qMUnTB2Q9imqjjbDI7O9sqLnY9/oaSeV4LM2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kxoc9uaFTrXitgGYEWP1umI8D3nYTFG7/XndbmYY6a0=;
        b=hodSMD4Tan29mG1q1DqVG1PmQngQNz263CtNOEnw69akSAmqXgcZV0yvUDTw2VgC1M
         moY4Fqf1fh4CAXcy1ulnolxWjy7Wd8Tc7WGswEUHFm9/lk61uhi9d64s2WCkwt1oXpmo
         jRTGB/OnNK1JPNlSuVGUQIW6epB0tdyVJQFunnHjG1afdT52T1CzREYxAz5Xxe/1WYME
         9oj0lFU9LmGjabYjuehq1v3/hHkH+/8MYFIMxf/J3OABBhIjrQGkF39anvHQ6fbYp2en
         4e2ieKWPNByebje0T2UUeTKYqqHXQBf8CCX/2eRwQ26xD711TbHIHBPHMfZK0yd9gPO2
         eJ3w==
X-Gm-Message-State: APjAAAXeA9v2EH3vMrT9N0G0PLjj41ozlKxRelngl6rFjnBPXDxALAR0
        IIFxqlPp4qNFpULApki7JPGuaA==
X-Google-Smtp-Source: APXvYqxbswxJpCXA0mUnDfPLybphcnLW3OQWcfcV2c3w4Dhlexa68Sj6OQyYRUkDZU2Xd8Mtu2574w==
X-Received: by 2002:a63:1a5e:: with SMTP id a30mr30997431pgm.433.1560449372553;
        Thu, 13 Jun 2019 11:09:32 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b15sm454449pff.31.2019.06.13.11.09.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 11:09:32 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        devicetree@vger.kernel.org, Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 0/8] tpm: Add driver for cr50
Date:   Thu, 13 Jun 2019 11:09:23 -0700
Message-Id: <20190613180931.65445-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
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
functionality, and supports SPI and I2C interfaces.

The last time this was series sent looks to be [1]. I've looked over the
patches and review comments and tried to address any feedback that
Andrey didn't address (really minor things like newlines). The first
three patches add a couple pre-requisite core changes so that the
drivers can be merged. The last two patches add some sysfs attributes
and make symlinks so that ChromeOS userspace works.

[1] https://lkml.kernel.org/r/1469757314-116169-1-git-send-email-apronin@chromium.org

Andrey Pronin (7):
  tpm: block messages while suspended
  tpm_tis_core: add optional max xfer size check
  tpm_tis_spi: add max xfer size
  dt-bindings: tpm: document properties for cr50
  tpm: add driver for cr50 on SPI
  tpm: add sysfs attributes for tpm2
  tpm: add legacy sysfs attributes for tpm2

Duncan Laurie (1):
  tpm: Add driver for cr50 on I2C

 .../bindings/security/tpm/cr50_spi.txt        |  19 +
 drivers/char/tpm/Kconfig                      |  26 +
 drivers/char/tpm/Makefile                     |   3 +
 drivers/char/tpm/cr50.c                       |  39 +
 drivers/char/tpm/cr50.h                       |  30 +
 drivers/char/tpm/cr50_i2c.c                   | 704 ++++++++++++++++++
 drivers/char/tpm/cr50_spi.c                   | 450 +++++++++++
 drivers/char/tpm/tpm-chip.c                   |   4 +-
 drivers/char/tpm/tpm-interface.c              |  16 +-
 drivers/char/tpm/tpm-sysfs.c                  | 138 +++-
 drivers/char/tpm/tpm.h                        |  29 +-
 drivers/char/tpm/tpm_tis_core.c               |   9 +-
 drivers/char/tpm/tpm_tis_core.h               |   1 +
 drivers/char/tpm/tpm_tis_spi.c                |   1 +
 include/linux/tpm.h                           |   2 +
 15 files changed, 1455 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/cr50_spi.txt
 create mode 100644 drivers/char/tpm/cr50.c
 create mode 100644 drivers/char/tpm/cr50.h
 create mode 100644 drivers/char/tpm/cr50_i2c.c
 create mode 100644 drivers/char/tpm/cr50_spi.c


base-commit: f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a
-- 
Sent by a computer through tubes

