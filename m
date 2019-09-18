Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B2CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B1721907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iq0ETXiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfIRQCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:02:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42744 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfIRQCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:02:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id z12so84747pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O0JULxyEuBt2bswXbV1mUisUvjzYzJbnFnOiO1qK1jE=;
        b=iq0ETXiLVRgUSKQ6Z1wMvovQZ4EZ4pTFUSJJTilQGGk0fWZYfeaGUmL1tchviOrQY6
         6nsEA19QfBMlY3GpuFu2vFKzBVIevRyRnU0IaK3yq+qxJAK3wWgv3dvVny8/P342+0Af
         kLYsVDv/Hn8+6fnOL5RPdidVRurCwMBl2dcfvO2GjvG/9Y+/TEZChc8qh/ARhfFFGhFi
         TIDXcR9egAnheBcAr5KRfFipY2rnr4SpyU8Tbbqh4Z6KjRKrQ4R8O/7zweNaJpY27PdP
         cSEwhjN9temzqC1UFH9foSUR12cv+81JEU6s2m9RiAmUjGwOTn5qk6EhXtsL2DVDkQjD
         ZY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O0JULxyEuBt2bswXbV1mUisUvjzYzJbnFnOiO1qK1jE=;
        b=EiRJCG6nO02e4N9NM3SI1XPUx8yfqdX01CWJgMCcJLJ1TDFtphj2HVpZTqGN2c/3kz
         WWDHMwpSzk/lVuJg88KcvxuG5/I/RzO0lB9XQmzasjKOnTm5N9D8GQegCXjvYpPLhHIe
         GkD+o0RlEa6Th+MJCXITmOpc+I7snErBwpd60mFS5Q4XRmryZOiEcaibytcEq3odzz3K
         7JygnMQTSmTClTfAddo/L7LwYRYliwxtxj8oG2KHiTkIZh0n9fTai2Uh+Z64ySp+yexC
         D4hNRDidLghBq+N99kUFN0EWClmUE0D4uhO9UHI+YKjO2Mi+GGuIXoIGt8eRp4f3HlaP
         e3nw==
X-Gm-Message-State: APjAAAXYvOp4lVCNNHQHZCL+mXSwQJesioTMfUJY7cE92RMdsb2jfQVy
        3CMTfA7mxiFWGZUAaOtUdcZU5w==
X-Google-Smtp-Source: APXvYqxijAc8QHbhEzCSfCLDeLG8JsdVIvOc0MS1Md26rXzG+YeKiRSsZhQytHD/3ElWAx2AhYI+fw==
X-Received: by 2002:a17:90a:8a02:: with SMTP id w2mr4601632pjn.131.1568822534950;
        Wed, 18 Sep 2019 09:02:14 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id g12sm9872379pfb.97.2019.09.18.09.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 09:02:14 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v9 0/2] mtd: spi-nor: add support for is25wp256 spi-nor flash
Date:   Wed, 18 Sep 2019 21:31:43 +0530
Message-Id: <1568822505-19297-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series adds basic support for 32MiB spi-nor is25wp256 present on HiFive
Unleashed A00 board. The flash device gets BFPT_DWORD1_ADDRESS_BYTES_3_ONLY
from BFPT table for address width, whereas the flash can support 4 byte
address width, so the address width is configured by using the post bfpt
fixup hook as done for is25lp256 device in
commit cf580a924005 ("mtd: spi-nor: fix nor->addr_width when its value
configured from SFDP does not match the actual width")

Patches are based on original work done by Wesley Terpstra and/or
Palmer Dabbelt:
https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b

Erase/Read/Write operations are verified on HiFive Unleashed board using  mtd and
flash utils (v1.5.2):
1. mtd_debug  	: Options available are : erase/read/write.
2. flashcp	: Single utility that erases flash, writes a file to flash and verifies the data back.

The changes are available under branch dev/sagark/spi-nor-v9 at
https://github.com/sagsifive/riscv-linux-hifive 

Revision history:
V8<->V9:
-Rebased this series to mainline v5.3-rc8
-Corrected number of sectors in the spi nor id table for is25wp256 device as suggested in the review.
-The lock/unlock scheme in the V8 version of this series needs to have a more generic approach.
 These protection scheme patches are not included in this series, will submit those separately.

V7<->V8:
-Rebased this series on mainline v5.3-rc4.
-Removed remaining func_reg reference from issi_lock as updating OTP region was dropped as part of V6.
-Updated Reviewed-By tags to 1st and 2nd patch.

V6<->V7:
-Incorporated review comments from Vignesh.
-Used post bfpt fixup hook as suggested by Vignesh.
-Introduce SPI_NOR_HAS_BP3 to identify whether the flash has 4th bit protect bit.
-Prefix generic flash access functions with spi_nor_xxxx.

V5<->V6:
-Incorporated review comments from Vignesh.
-Set addr width based on device size and if SPI_NOR_4B_OPCODES is set.
-Added 4th block protect identifier (SPI_NOR_HAS_BP3) to flash_info structure 
-Changed flash_info: flag from u16 to u32 to accommodate SPI_NOR_HAS_BP3
-Prefix newly added function with spi_nor_xxx.
-Dropped write_fr function, as updating OTP bit's present in function register doesn't seem to be a good idea.
-Set lock/unlock schemes based on whether the ISSI device has locking support and  BP3 bit present.

V4<->V5:
-Rebased to linux version v5.2-rc1.
-Updated heading of this cover letter with sub-system, instead of just plain "add support for is25wp256..."

V3<->V4:
-Extracted comman code and renamed few stm functions so that it can be reused for issi lock implementation.
-Added function's to read and write FR register, for selecting Top/Bottom area.

V2<->V3:
-Rebased patch to mainline v5.1 from earlier v5.1-rc5.
-Updated commit messages, and cover letter with reference to git URL and author information.
-Deferred flash_lock mechanism and can go as separate patch. 

V1<-> V2:
-Incorporated changes suggested by reviewers regarding patch/cover letter versioning, references of patch.
-Updated cover letter with description for flash operations verified with these changes.
-Add support for unlocking is25xxxxxx device.
-Add support for locking is25xxxxxx device.

v1:
-Add support for is25wp256 device.

Sagar Shrikant Kadam (2):
  mtd: spi-nor: add support for is25wp256
  mtd: spi-nor: fix nor->addr_width for is25wp256

 drivers/mtd/spi-nor/spi-nor.c | 9 ++++++++-
 include/linux/mtd/spi-nor.h   | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
1.9.1

