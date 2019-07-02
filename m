Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B090BC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7123A21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="M/zho78z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfGBSkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 14:40:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42588 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBSkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 14:40:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id t132so4739171pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 11:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hG1JsQUy046szRFDOIEOc0GrqgtZ4N9C6eAqGmFMcZg=;
        b=M/zho78zeJOQugBcdoK7P7W4WUEDOlNbsVIincCdzc7egd5SueogZzrbLrF9qFqxIf
         zUuXIONh6LZN8s6e87uNdUj2AJp2KzRUirGiAl1Y7YW3J5ZPIa/KgyvZtGTuB0Hr6LbA
         +vmf1fMprr5qs2SgZf1NbEMO+7lbfI9GIMLESzki905WvFh1ELaBYDQZxGM5a1rdM/T9
         ztveeivAxZt0qeBazc9JAWkCR8zh77uqMArfEwhtdwvqe+EFAxEVuQeWNUqLTDAXIPtT
         sOA5EdfthaVkfPc5v5AeIvevLh5/s5A4R1IxC0wnZTfkeiPGL+o+Rmk/CG6JcqZCBPwE
         ZPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hG1JsQUy046szRFDOIEOc0GrqgtZ4N9C6eAqGmFMcZg=;
        b=qV21vFUD3xDeHg4yYI02iDe/RIEMZmB3ul1ecBw+PI1oTVTEzhDA69BQnKkZTssPWF
         /NMBQvBU7kagD5r4m6CANZDj5cYQ24LdDUi8JXSwYUFfzdm0p88siovpS+0KWrsbqdsh
         CAK6nIDjRRTzXNGTVaEC2wH4BGisczMjkkluChYbYp+cUrh3n1wfEAfgaKg2NSzn2PAD
         2WZaDCpGMuHH68k8wsFAjIbFdXXD6mBU++zEVvcNmkiS0TRrKW5byb3PYAgJMtoBUDQ8
         CF8IyvQn5DjuRkzbn8cnr0NfRgPzcwaR+MGeWyml+Zyufn9sIAyG6x38n+BCWsfy9jWD
         V32A==
X-Gm-Message-State: APjAAAXUsCE7tb19rb7rUnO9ZUadJx18T0205K59Zfe8vX5Y/5zveZxO
        omHnICTRuujQPbkAxDbxC44/bQ==
X-Google-Smtp-Source: APXvYqzsMlaSyc7pZIJYDjprnLyGQKCrS/C/7bgqbvBj63BhfUiyhW4J4JPtfydDsSsZis7KAagqgA==
X-Received: by 2002:a63:1e0b:: with SMTP id e11mr9709204pge.402.1562092804922;
        Tue, 02 Jul 2019 11:40:04 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id e10sm15065327pfi.173.2019.07.02.11.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jul 2019 11:40:04 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v7 0/4] mtd: spi-nor: add support for is25wp256 spi-nor flash
Date:   Wed,  3 Jul 2019 00:09:01 +0530
Message-Id: <1562092745-11541-1-git-send-email-sagar.kadam@sifive.com>
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
configured from SFDP does not match the actual width") queued in
spi-nor/next branch [1].

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
in function register which is OTP memory. so we are not updating the OTP section
of function register.

The changes along are available under branch v5.2-rc1-mtd-spi-nor/next at:
https://github.com/sagsifive/riscv-linux-hifive 
 
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/log/?h=spi-nor/next

Revision history:
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

 drivers/mtd/spi-nor/spi-nor.c | 343 +++++++++++++++++++++++++++++++++++-------
 include/linux/mtd/spi-nor.h   |   8 +
 2 files changed, 300 insertions(+), 51 deletions(-)

-- 
1.9.1

