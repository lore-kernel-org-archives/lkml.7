Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03E9C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99B420578
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U/XOvAkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfHMMkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:40:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44701 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfHMMkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:40:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so51207197pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 05:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KVZnxnUbFwopH7NNhojLQDNj9y3nnNivvk1W1witOgo=;
        b=U/XOvAkto76hnCevvoC/5/rtW7J6QZciIx5h49m8IL4C2vBI1rUgpXQrHdy7HGpIqk
         RFdQzcy4WgApGBenPv7sNk4Ckv8wYWx01KuPQf9qIgdX0UKeKxR7EB8X3iontLS74xN2
         GrUNHazK4Peb2kuq9fhzcVAqFzVeIVLzj6ZZKwMiNDapdJWtKw87BKWgw6toBnGG3gXp
         ZnfFkoGB4ATIgqn3Q3N1lIFGU01iXiVbu20PMohPLe+l1MjlFbe28LgS3KGnjepbzkFC
         R1zNywKrCLk4X+t8V9noHortqqeiMHteo8CvdfQDzM8U3rzpIlfS4+7yIAsC24dr74ls
         sU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KVZnxnUbFwopH7NNhojLQDNj9y3nnNivvk1W1witOgo=;
        b=YhCDzKSMIWjWpjKaNdrSG8CHPbLI/wxgcqLXBy3evi7swcE8ZT5wxQFIHWhvTpQ0FF
         TsLJ7rlANOsEzwMtJzQmg72tNeCOEGieRmMP3vAVBVUxifB0NpOGmxOGZbOUolCaxUv8
         hp8l9Hy6x4m1E2PA1gMkmDSlsDzhfV4imnoxfH9KOe7TBgeQzCUuFV9rCBlogE0MKz72
         +fozaADFCMJtmWfFS3z5An8X/XCiGFyt51oWaCe2ib6wy/W+rUeS7sA0/nWDKXha9toP
         lyP5EitgS3AYuY1PugB8DO5baB2jY9hA/r3shQy3c7v/o6iRde1IRNShu/2atOEhK8K+
         fNsA==
X-Gm-Message-State: APjAAAUCqN5WCTpKDVDW6lBP+MWn6eh4XP3lMNXuQo4bOQg58V2Ynj7S
        c4X3SBrZUQq7QBLbyxntVwcIHA==
X-Google-Smtp-Source: APXvYqx7/hg2KWFFBaloEUPQNr8woydBtcGX9MHQc6SQy4rdPTOlGyQhQbZn12CourIRoRBXgF5Gxg==
X-Received: by 2002:a17:90a:9f46:: with SMTP id q6mr2001132pjv.110.1565700009363;
        Tue, 13 Aug 2019 05:40:09 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id v145sm14758467pfc.31.2019.08.13.05.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 05:40:08 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v8 0/4] mtd: spi-nor: add support for is25wp256 spi-nor flash
Date:   Tue, 13 Aug 2019 18:08:11 +0530
Message-Id: <1565699895-4770-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series adds support for 32MiB spi-nor is25wp256 present on HiFive
Unleashed A00 board. The flash device gets BFPT_DWORD1_ADDRESS_BYTES_3_ONLY
from BFPT table for address width, whereas the flash can support 4 byte
address width, so the address width is configured by using the post bfpt
fixup hook as done for is25lp256 device in
commit cf580a924005 ("mtd: spi-nor: fix nor->addr_width when its value
configured from SFDP does not match the actual width") 

Patches 1 and 3 are based on original work done by Wesley Terpstra and/or
Palmer Dabbelt:
https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b

Erase/Read/Write operations are verified on HiFive Unleashed board using  mtd and
flash utils (v1.5.2):
1. mtd_debug  	: Options available are : erase/read/write.
2. flashcp	: Single utility that erases flash, writes a file to flash and verifies the data back.
3. flash_unlock : Unlock flash memory blocks. Arguments: are offset and number of blocks.
3. flash_lock   : Lock flash memory blocks. Arguments: are offset and number of blocks. 

The Unlock scheme clears the protection bits of all blocks in the Status register.

Lock scheme:
A basic implementation based on the stm_lock scheme and is validated for a different
number of blocks passed to flash_lock. ISSI devices have top/bottom area selection
in function register which is OTP memory so we are not updating the OTP section
of function register.

The changes along are available under branch dev/sagark/spi-nor-v8 at:
https://github.com/sagsifive/riscv-linux-hifive 
 
Revision history:
V7<->V8:
-Rebased this series on mainline v5.3-rc4.
-Removed func_reg reference from issi_lock as updating OTP region was dropped as part of V6.
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


Sagar Shrikant Kadam (4):
  mtd: spi-nor: add support for is25wp256
  mtd: spi-nor: fix nor->addr_width for is25wp256
  mtd: spi-nor: add support to unlock the flash device
  mtd: spi-nor: add locking support for is25wp256 device

 drivers/mtd/spi-nor/spi-nor.c | 342 +++++++++++++++++++++++++++++++++++-------
 include/linux/mtd/spi-nor.h   |   8 +
 2 files changed, 299 insertions(+), 51 deletions(-)

-- 
1.9.1

