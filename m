Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31559C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 10:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01867208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 10:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LtxOhFbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfEKKIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 06:08:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44888 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfEKKIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 06:08:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id z16so4220265pgv.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 03:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=E5geVYX9r/xsvJ70+OdlPhioxAfQpMPDLT7rfOEjAm8=;
        b=LtxOhFbURtgfMCom19ZCiUacoeYWIn8cJxzwlQharVdF3wmpg5BQQuJgU2AKE3bD9y
         oB1oo/3YjImBtD6YKyU6JEGvVVLjyerFlIoZGngZwv0eWTTldIl2wXbsDaGIg6L983Tc
         x/TeeMqAXUoSn+6nWuTbZ2DkQ5EC6emHROz98kmohi824KJKuwujwozDF3m92yAEZEMH
         fJFNFo97kek7dQ+6ExSm+DYnPbVu59SlVr+o7L1OkplFl6m3qpCWGxGOL4Y2ce4jTEmY
         u+DbGyqPRGL5uzyhLEja+rJQ+pA0f4yoOSIZ7flZnPz/mU/aHc+jD7thzo4p1x83kcOM
         76+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E5geVYX9r/xsvJ70+OdlPhioxAfQpMPDLT7rfOEjAm8=;
        b=TaIijYrjFiFuu0nfRVkhaZPg7sIT05C48eO4kjZch7za9i1hyP5CoqkB7Qx5jrD+0N
         gYbt+g8zfPMyynxyX5KA3NrInCNmBhtQ5AzhA5wxxsESDPyp+rnJCDKH7hqVlnRnSKFe
         8XLv3vNSpByk4IOxFQXzN0iJSPibqrXBgrco3Bz9SXeVwdxvWPj4rF9D+8sBfEyPUJii
         KYZgNcYANxLRvviSNdl5oA6h5Ae0386IbOHqDX0NONdAv8DBJWz5r0YEqpeyvdwhb8t8
         5sDtXF3LlLti2lDD6x6bYNhE55REqTOm8ScQ9/8Q5XEtcWbtGJ74n+IwRnHt1IMDLFCW
         mKqg==
X-Gm-Message-State: APjAAAWQG1wlTAPvZ8GhUA1yTGnnGIQrKwD/sy3KnhudF5qwIF2i5T/n
        vFksVbM3cLMPVYg6O5XOm5NTog==
X-Google-Smtp-Source: APXvYqzpwuyZCUbxoXTRRlV2LAERUlKeBv3bavf54tfet+HlCK62FtD1WBpOvt13aXglcRjgzEbdNQ==
X-Received: by 2002:a62:6444:: with SMTP id y65mr21031241pfb.148.1557569298344;
        Sat, 11 May 2019 03:08:18 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id c129sm16951836pfg.178.2019.05.11.03.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 May 2019 03:08:17 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, richard@nod.at, palmer@sifive.com,
        aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v4 0/3] add support for is25wp256 spi-nor device.
Date:   Sat, 11 May 2019 15:38:05 +0530
Message-Id: <1557569288-19441-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch set is tested on HiFive Unleashed board and is based on mainline
kernel v5.1. Its intended to add support for 32 MB spi-nor flash
mounted on the board. Memory Device supports 4/32/and 64 KB sectors size.
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
V3<->V4:
-Extracted comman code and renamed few stm functions so that it can be reused for issi lock implementation.
-Added function's to read and write FR register, for selecting Top/Bottom area.

V2<->V3:
-Rebased patch to mainline v5.1 from earlier v5.1-rc5
-Updated commit messages, and cover letter with reference to git URL and author information.
-Deferred flash_lock mechanism and can go as separate patch. 

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

 drivers/mtd/spi-nor/spi-nor.c | 345 +++++++++++++++++++++++++++++++++++-------
 include/linux/mtd/spi-nor.h   |   7 +
 2 files changed, 301 insertions(+), 51 deletions(-)

-- 
1.9.1

