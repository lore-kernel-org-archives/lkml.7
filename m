Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F0CC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F387C2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jlVfevWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438100AbfFLKs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:48:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40674 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438001AbfFLKsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:48:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so6488032pla.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 03:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6OgmzXKxvgHJ1sM8mE9nEpUkTFx5pfDiK3sCa407yTI=;
        b=jlVfevWxi9+GHeQZP8m+0MbI5NR4vR+IREfTBAOj2OboeNZDVA4nxenqfLYyOKDq5F
         JeoDtJu+hrSbOEFMQjWeesrzt5vBQ2csZv990giHqN3wpTPlHjduFKCLaGqEo8UCvTq8
         QQ7BxZbf+VXSquO1Xf9dh7nIJOAfiqSIi9DLfs9NGZ9D4/hJqRJxu8m6c/wLj/vF9XKD
         5VUC8mr+iHQw6992UHBtbED8NAPFiGe1jSC42MO1sNDuIvzZXfvXGpCxvWzUQCditt4i
         iHCfvWNV63siJnF4yzudfhPzyY2Uzssec2ZOvS8HmBmgQLTZN1VVUPsYlZv9FnG1IhnS
         EImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6OgmzXKxvgHJ1sM8mE9nEpUkTFx5pfDiK3sCa407yTI=;
        b=sJKaLcF6aqOUMw5zbvleroVhV6BUAp4BWOjhCpred36c5nmEF8ua7o+Vma+mbYQq3h
         9R0JmRew9H8wdbv0EM5shTYsGKik3WNm+6l0BzUTzxjZR6VIKryWjMa/5oIFw2UuZSz1
         uwDkyCP28mxKfjDMDgjX+3QnLZdVAIEXE8qcqgV7/RdX74JzmQJAR9AzGZ16gUNODx7W
         4lflEHwMfUD4fgNqJ+6TyrB8hTHLiKd53jBdvatYwGex3Hmf3rjSm0KubSrX+LyG2Ehx
         FUqNxNvixKTk9jKesyfpm4wgp9gyGRz1nM+xxoWe2mdP3EyzgGjDSdxho97f5nHBeR9y
         f9fg==
X-Gm-Message-State: APjAAAW2cK0YCtSc1yt+PthLhSUcky/ctkemEzcvAkxZWwUUvwua/bbN
        2IkMVoem6HfahcdVUWbO/JRnbA==
X-Google-Smtp-Source: APXvYqyRNQn4HyUUaAoD5W3dTl5pCJH+6plRQxAR5F5uu/22Q/Cjtya5G0BA+cILNrTl2XlFiIPJDw==
X-Received: by 2002:a17:902:a513:: with SMTP id s19mr27330778plq.25.1560336535093;
        Wed, 12 Jun 2019 03:48:55 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id y22sm12241561pfm.70.2019.06.12.03.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Jun 2019 03:48:54 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
        wesley@sifive.com, Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v5 0/3] mtd: spi-nor: add support for is25wp256 spi-nor flash
Date:   Wed, 12 Jun 2019 16:17:53 +0530
Message-Id: <1560336476-31763-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch set is tested on HiFive Unleashed A00 board and is based on mainline
kernel v5.2-rc1. Its intended to add support for 32 MB spi-nor flash
mounted on the board. Memory Device supports 4/32/ and 64 KB sectors size.
The device id table is updated accordingly.

Flash parameter table for ISSI device is set to use macronix_quad_enable
procedure to set the QE (quad-enable) bit of Status register.

A unilaterlay block unlocking scheme is added in patch 2.

These patches are based on original work done by Wesley Terpstra and/or Palmer Dabbelt:
https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b

Erase/Read/Write operations are verified on HiFive Unleashed board using  mtd and flash utils (v1.5.2):
1. mtd_debug  	:Options available are : erase/read/write.
2. flashcp	:Single utility that erases flash, writes a file to flash and verifies the data back.
3. flash_unlock: Unlock flash memory blocks.Arguments: are offset and number of blocks.
3. flash_lock: 	 Lock flash memory blocks. Arguments: are offset and number of blocks. 

Unlock scheme clears the protection bits of all blocks in the Status register.

Lock scheme:
A basic implementation based on stm_lock scheme and is validated for different number of blocks passed
to flash_lock. ISSI devices have Top/Bottom area selection in "function register" which is OTP memory.
 

Revision history:

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

 drivers/mtd/spi-nor/spi-nor.c | 348 +++++++++++++++++++++++++++++++++++-------
 include/linux/mtd/spi-nor.h   |   7 +
 2 files changed, 304 insertions(+), 51 deletions(-)

-- 
1.9.1

