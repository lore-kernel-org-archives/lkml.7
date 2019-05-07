Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89C2C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88B02087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LcspjzYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfEGPql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:46:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41378 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEGPqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:46:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id d9so8385379pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:from:to:cc:subject:date:message-id;
        bh=AyxScH4NIE4sDe1p/0kXATnx4Yd1gHetw4ugG+CXftg=;
        b=LcspjzYTpm18fBxDLtdVlOSLYgih/UOIl8y2xm86Shd54JuFLAbjRuZJsh7/UJROFW
         TtPG3dZCOLd3NNoEul47o9myIkAwvByEQcLu1SVAeEFQ3dYwmEQe2TjcZkXAt8F96qzm
         m1bi5u09yD15mF9UitMHo4z+MNjDAqwkwSCXkNMppq2snlQsOkVdmKMDPENoU43mV7+L
         RzfwzYC8qqQM7ryF6MyV/7SwGQIPHoB/YzUQMpD8PmNZ4S8CadI+FEHvI2Sbv59AL5vH
         C1i10OgAXmZLSd450lkDBFZGCG8h/znBvgvuZLKNKvyS6oFP0RmLcCe3dPQ26CPTyW9W
         x7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=mime-version:x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AyxScH4NIE4sDe1p/0kXATnx4Yd1gHetw4ugG+CXftg=;
        b=qqax+oEj1hfLS51Gxf44C9k+SxTOycALp1FmujaWL0dWJ771RiMMHTUYMI3fzUEIij
         M96xKDEbJwXrSlRhehTUKsr7pDMBzR3e6C1Qw2B8ZMIOUQmyo/X7FU5jwqzMLckxjWf9
         Il9CwZonRYGVfp3DKliAZ+gQ3NENFZuVSs5xAaA76E1UierBnTXzh2SDdhB4GpNM6UYI
         Pnve7ptCiL55e8Fbsu4um4W6VtDLh6MuAi3NRDhfrQVaNaeXNghHZ71Gn/bMrhmlt491
         cKIsZ7ZC5GDK6CKprjqsAhSCW8t3u9R1yd1kcIoTgrtnVHQJ2jyGSGAWwc/lwmdiD3LV
         14Sg==
MIME-Version: 1.0
X-Gm-Message-State: APjAAAWxfVgEwSRUJ6ZnHE3351j6Whbs1zuCqpbgk9hiV1/GTn5nmxRk
        7p2fHPT/SMSIxuPKLLfsiILXmMEgWILxdwvL9WZ3/8O2ioNfPjddwgH8prGycjJIDoI0eJbsLmE
        P/reT0SOwZLx4AXjwqw==
X-Google-Smtp-Source: APXvYqxkIWDXrclgUoj+jqcoyhO6CLT/D3zJ0ThibTrmWBC8R5Y1pe8PKcAAb/jfMzxK3ee5u+CN2w==
X-Received: by 2002:a17:902:29c9:: with SMTP id h67mr41070276plb.114.1557243998932;
        Tue, 07 May 2019 08:46:38 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id 5sm15482096pfs.17.2019.05.07.08.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 08:46:38 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, richard@nod.at, palmer@sifive.com,
        aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v3 v3 0/3] add support for is25wp256 spi-nor device.
Date:   Tue,  7 May 2019 21:16:00 +0530
Message-Id: <1557243963-14140-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
Content-Type: text/plain; charset="US-ASCII"
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
3. flash_unlock: Unlock flash memory blocks.
3. flash_lock: 	 Lock flash memory blocks. 

Unlock scheme clears the protection bits of all blocks in the Status register.

Lock scheme:
It is a basic implementation similar to stm_lock scheme and is validated for different number of blocks passed
to flash_lock.

Revision history:

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

 drivers/mtd/spi-nor/spi-nor.c | 110 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/mtd/spi-nor.h   |   2 +
 2 files changed, 111 insertions(+), 1 deletion(-)

-- 
1.9.1


-- 
The information transmitted is intended only for the person or entity to 
which it is addressed and may contain confidential and/or privileged 
material. If you are not the intended recipient of this message please do 
not read, copy, use or disclose this communication and notify the sender 
immediately. It should be noted that any review, retransmission, 
dissemination or other use of, or taking action or reliance upon, this 
information by persons or entities other than the intended recipient is 
prohibited.
