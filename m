Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2390BC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DE62070B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HmyRHspE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfFURNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:13:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32900 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFURNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:13:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so3948828pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cAVJVLYMlpM1X+6nsKRtAyIYN/69csfPCrR5GNpvyWk=;
        b=HmyRHspEmnFmc6bYH0mcIxtmVoCG4E/7Na+MHf887uUTVRbj1E9lKP6pWZweKUsg1X
         WplLECJZQLyYro69Uj75TjacZgzrM52CBI3qhH77U0uG51rrLdr7q44xdGHBu3pzlsGk
         4b1nY+FsXWQciU7loQQ5Dvozx2E3/mxv0AHWcTgtCzc0NSIxGwC9aMahSRfgKSKZcYGx
         LVd9WfCKrPZddURlTfj7CTFbkwxJeHPznvbmvKYYolx7DhVjkT0D3IoV29AEORev7LUE
         QxuU+mVXs/feV22t2F5gVjGZ5Fvt5E5a+EMD0L+N+yiiWoBy36VHYxW4is3TKW7C04HT
         irXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cAVJVLYMlpM1X+6nsKRtAyIYN/69csfPCrR5GNpvyWk=;
        b=CdbvWnwy4i6Xli/pKgTGk3ob3gSiW4S+gn0b/J9fKyr3vTI9GYIqKovaagyYMD5AuG
         D02Osycg/HH5O3eNRrJbe2snjvFdttSfJ/FdHglb8EP7a2atfRHHTgOOsYT3PVitYMcT
         AjySc7d9oLGWnPbu6Ndi0+IWxEjsolN79ohfnHhnFyuR7qOWUcCS+lQAIc+aaW0pG/t3
         wBRuqxhMUnREPBBl6+i54byyELaFuy1YiGEBsA4DKyIHtq9k3NDipzKVi9pBu0bI0iT5
         1S1WtC8bJaqkpREfNAAu8RP1+temyov4p3BS+Y39kMfpW/k8ouJ4cI5T7rq2H513/3GS
         Heag==
X-Gm-Message-State: APjAAAVQ8eBXFBn+NvigmWkVnjbXvhswq1bCmKiajf+zdoKY3wxHHeuz
        QbPzW0LDhCdWfNEB8XnZsNLq6A==
X-Google-Smtp-Source: APXvYqzPHD9SouhFBvVoB7Ko52w+lG58OoHxYUuvUiO43hMwqmb/kI3RrEjuhpsiBOQvpaZ5fzJy6Q==
X-Received: by 2002:a63:5202:: with SMTP id g2mr19423642pgb.386.1561137231320;
        Fri, 21 Jun 2019 10:13:51 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id t5sm3496190pgh.46.2019.06.21.10.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Jun 2019 10:13:50 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v6 0/3] mtd: spi-nor: add support for is25wp256 spi-nor flash
Date:   Fri, 21 Jun 2019 22:43:28 +0530
Message-Id: <1561137211-12406-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch set is tested on HiFive Unleashed A00 board and is based on
mainline kernel v5.2-rc1. Its intended to add support for 32 MB spi-nor
flash mounted on the board. Memory Device supports 4/32/ and 64 KB sectors
size. The device id table is updated accordingly.

Flash parameter table for ISSI device is set to use macronix_quad_enable
procedure to set the QE (quad-enable) bit of Status register.

A unilaterlay block unlocking scheme is added in patch 2.

These patches are based on original work done by Wesley Terpstra and/or
Palmer Dabbelt:
https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b

Erase/Read/Write operations are verified on HiFive Unleashed board using  mtd and flash utils (v1.5.2):
1. mtd_debug  	:Options available are : erase/read/write.
2. flashcp	:Single utility that erases flash, writes a file to flash and verifies the data back.
3. flash_unlock: Unlock flash memory blocks.Arguments: are offset and number of blocks.
3. flash_lock: 	 Lock flash memory blocks. Arguments: are offset and number of blocks. 

Unlock scheme clears the protection bits of all blocks in the Status register.

Lock scheme:
A basic implementation based on stm_lock scheme and is validated for different number of blocks passed
to flash_lock. ISSI devices have top/bottom area selection in "function register" which is OTP memory.

The changes along with other relevant patches are available under 
branch dev/sagark/spi-nor_v5.2-rc1 at:
https://github.com/sagsifive/riscv-linux-hifive 
 

Revision history:
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


Sagar Shrikant Kadam (3):
  mtd: spi-nor: add support for is25wp256
  mtd: spi-nor: add support to unlock flash device
  mtd: spi-nor: add locking support for is25xxxxx device

 drivers/mtd/spi-nor/spi-nor.c | 342 +++++++++++++++++++++++++++++++++++-------
 include/linux/mtd/spi-nor.h   |   8 +
 2 files changed, 294 insertions(+), 56 deletions(-)

-- 
1.9.1

