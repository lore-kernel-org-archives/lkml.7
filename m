Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F62AC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0161C2067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TGay/en3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfD1SJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 14:09:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41918 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfD1SJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 14:09:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so4060630pgs.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dHsNtb0xgYr6CS23JfuP3XA67ia9/nQ2eypCoJ7bg1Q=;
        b=TGay/en3NKW/4hdmiDm4PYTJAZbkQJ4iOhsOztVRV4arO0RQS/ag5eNIuVZNlv2BjM
         LqXYuCrjm2hp51+qkTtOCNaYUoGxyv7BlUM6asQ8qOZ+jHpjNQ+iFuXm7JKPubV+OnS5
         KBGFBpMYh3IbYn6vZ6x3PkCUdeGFXsjekdoBE7Nq31iEFyNPcYGJIq9YEn70E9AO56HA
         UvfAgwya+bBBqVpLHt73jYtHpt0KAeObP5hObu5PngG+u3BGL1k2QINBhyw1WN3Gc12d
         nqJ6CCjb8bSvQ4eDySvM+ROOvyy1IlKjkkPKSezePhgtPNnQNDDKjCZzeic4C8zqerB3
         caYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dHsNtb0xgYr6CS23JfuP3XA67ia9/nQ2eypCoJ7bg1Q=;
        b=L4bZVMm3Js1trCSQH54s3GCnDfXMCJBtByJhCmIQSQ+3p069eUV9uI+tcRAO2ZN9pp
         +26wfsSHqjtOIvRqqLjOyCb5CCbNXyy8dZyQpnGtq4li12km+n45RKGLyS4hWm5s2CYH
         qMYCjwI30Uqa25IgKI1nDjmnUTihDp/N9vqej9VcOGLxtaRlJHTo7aCRBxezXbGlLVYC
         lVkBYLmN/zTwzjYvlS1t/0F4UBbBHw0Kspl6HlDBWeyrNofkJrJ1/HY0mUwQ4lMwPp1K
         bWyDRxDhCthb59zTk2WEKaD7e9NHhWJgWLFwyCBdbZPN0GBjrKFQ2toD6SkzIgg8uJU6
         mW/Q==
X-Gm-Message-State: APjAAAWFuq+sTc+9Vb9ZWjb7on/QLGY8d2NTh7cryGWzwjDtPFIS/z+f
        ZjQbqU/bOY2qhmT0IuFn0c9bSw==
X-Google-Smtp-Source: APXvYqwyli87GbccvSIz+mSfhVCyvulkUz3OjuKOQcL1lU+PFd3c/qyeIGLDq7Rqy29KcxfEgMdeJA==
X-Received: by 2002:a65:41ca:: with SMTP id b10mr55977365pgq.256.1556474969402;
        Sun, 28 Apr 2019 11:09:29 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id l2sm36177136pgl.2.2019.04.28.11.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Apr 2019 11:09:28 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, richard@nod.at
Cc:     palmer@sifive.com, paul.walmsley@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v2 0/3] add support for is25wp256 spi-nor device.
Date:   Sun, 28 Apr 2019 23:39:13 +0530
Message-Id: <1556474956-27786-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch set is tested on HiFive Unleashed board and is based on mainline
kernel v 5.1-rc5. Its intended to add support for 32 MB spi-nor flash
mounted on the board. Memory Device supports 4/32/and 64 KB sectors size.
The device id table is updated accordingly.

Flash parameter table for ISSI device is set to use macronix_quad_enable
procedure to set the QE (quad-enable) bit of Status register.

With issi_lock and unlock schemes support for block protection is added 
in patch 2 and 3.
These patches are extended from base work done in a patch at following commit:
https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b

Erase/Read/Write operations are verified on HiFive Unleashed board using  mtd and flash utils (v1.5.2):
1. mtd_debug  	:Options available are : erase/read/write.
2. flashcp	:Single utility that erases flash, writes a file to flash and verifies the data back.
3. flash_lock	:Lock flash memory blocks.
4. flash_unlock: Unlock flash memory blocks.

Unlock scheme clears the bit protection bits of all blocks in the Status register.
Lock schemes in patch  3 is based on stm_lock mechanism. With current implementation entire flash memory
gets protected.

Block protection schemes are tested with flash_lock and unlock utils.

Revision history:
V1<-> V2:
-Incorporated changes suggested by reviewers regarding patch/cover letter versioning, references of patch.
-Updated cover letter with description for flash operations verified with these changes.
-Add support for unlocking is25xxxxxx device
-Add support for locking is25xxxxxx device.

v1:
-Add support for is25wp256 device.

Sagar Shrikant Kadam (3):
  mtd: spi-nor: add support for is25wp256
  mtd: spi-nor: add support to unlock flash device.
  mtd: spi-nor: add locking support for is25xxxxx device

 drivers/mtd/spi-nor/spi-nor.c | 116 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/mtd/spi-nor.h   |   2 +
 2 files changed, 117 insertions(+), 1 deletion(-)

-- 
1.9.1

