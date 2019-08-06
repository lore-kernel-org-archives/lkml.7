Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9750C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0FD21872
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nobdHh1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfHFWHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:07:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42977 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfHFWHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:07:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so42301228pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 15:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSLa4pNiWVqg5KmBwta4Nm3QMlIdwSyFGBhxf3tLV/w=;
        b=nobdHh1wZax0LZlHpwPnDw9QdBVGA+CFBO3iOVA5rcN2zefAZuJwnaAme81Si9+Rnu
         zEd23EfqY2WNKdV1vgdFtmiB3Bz7PRont0luEkFLeH5UiVuGlSYTmSqCGAtURyXmljU+
         +mesW+29QPYEFsItnyEshD9M2CkbBC5ggtsVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSLa4pNiWVqg5KmBwta4Nm3QMlIdwSyFGBhxf3tLV/w=;
        b=pfdYnKuW/yLRjV4Y0U+0sFQD6+UtNJMFOEzY00ukpHOuZWTBuXnK+ewvd1Vcaiigss
         5g/UgqeYu9x0r4YRN1OzcgU6eafGBKFakFRx8FjbX74tho3PB/RW0sHbuHSDndXNU2ua
         PJX2clJJlFhzkQAX5ScwFYBYYD65rXiNj6r4Ox/SGQz18eYaqjfbVYYyMabWMD44YSWF
         eufOXJ11ZD+fqwu465IZkbGZ82gH9Ry4eYD+2KAU3/exjkpl05BOw+iDetA+IZLrTpeG
         au/xI8SuQene9d9hMC0JIGayO/7kDP0cFk7TqEeF4d+zH8sbSYFKJra5jJusdPdz/dYu
         v3Bw==
X-Gm-Message-State: APjAAAW/trwauCwGGK1qhTz5DBpeaORqZyDQE3w/+mSI/8LjFjCs6mwx
        Kn3cKCdkdskS7EDLAPI6LWQsnw==
X-Google-Smtp-Source: APXvYqwARHzSNZo9u5RkbmGoO6mXRD9rKbrWfywdzN9ynPSoFRLViJ20FSU0eMGbIyWZ9RTdfBZXPw==
X-Received: by 2002:a17:90a:206a:: with SMTP id n97mr5279752pjc.10.1565129272082;
        Tue, 06 Aug 2019 15:07:52 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p7sm98982509pfp.131.2019.08.06.15.07.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 15:07:51 -0700 (PDT)
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
Subject: [PATCH v3 0/4] tpm: Add driver for cr50
Date:   Tue,  6 Aug 2019 15:07:46 -0700
Message-Id: <20190806220750.86597-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
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

Stephen Boyd (2):
  tpm: Add a flag to indicate TPM power is managed by firmware
  tpm: tpm_tis_spi: Export functionality to other drivers

 .../bindings/security/tpm/google,cr50.txt     |  19 +
 drivers/char/tpm/Kconfig                      |   9 +
 drivers/char/tpm/Makefile                     |   1 +
 drivers/char/tpm/cr50_spi.c                   | 373 ++++++++++++++++++
 drivers/char/tpm/tpm-interface.c              |   8 +-
 drivers/char/tpm/tpm.h                        |   1 +
 drivers/char/tpm/tpm_tis_spi.c                |  98 +++--
 drivers/char/tpm/tpm_tis_spi.h                |  37 ++
 8 files changed, 503 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
 create mode 100644 drivers/char/tpm/cr50_spi.c
 create mode 100644 drivers/char/tpm/tpm_tis_spi.h


base-commit: 0ecfebd2b52404ae0c54a878c872bb93363ada36
prerequisite-patch-id: ce0cac49be5e67df1427e4207cf38c6e31091445
-- 
Sent by a computer through tubes

