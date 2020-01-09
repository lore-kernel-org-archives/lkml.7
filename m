Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C51C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE16B20661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="v9fnq5/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbgAIN3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:29:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42741 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgAIN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:29:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so7366657wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LeCOJsegsX9ulDaZM7NL+WaD4FSb3jvx0nwI6fIifdA=;
        b=v9fnq5/HPFByZxwI00WPY6zovNS68zvnGe5jz1jhFyLuC6buzKp49JUO/3A/2f41Jl
         sY03l79BGy+DC+sySd1oRvRkBxwwIj8Hg+x20jeisHL6cvGZKhHBPP1Mn4+MiEzNndHD
         Jrbmi47ghqNCHQvkaAXXVN8UfCOFGS863mDbb3N2Bb+PjT6Qd25wvwkwHB3PoTaq+st0
         EsYbGZIQaRDZYDmXAzFCwdjdBAh5PZiUO4Vg4hBeAEtMrzcSW3ZqSvBw+XDHkTW5Vf9c
         s3U+LWrGIKjnCBsU23UEheg4jtu0cWZmQjLDi3ENrTD678ECxGzE42cvjz5xb+igJtoh
         IxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LeCOJsegsX9ulDaZM7NL+WaD4FSb3jvx0nwI6fIifdA=;
        b=XE10pHlF2k61isGIfjAwqjTvTmqN1qZYTFl+ppk2j+24tJFyTHWQPRQ+uL5LAKVu+Y
         8jQ7ylbPwrMwDYE4rjBedltryN9M+qOohJhBqN8LRI2oDVaA++vcS2+mOWHQxcAVWjCQ
         AKHFaVTBuJTE40gr2/oZsMQjt8PQBMlZsvi7pw1WPactNCpLjJdo8n0Tx++8TMjok/EL
         OmizH5OkBhIwghfVTcLG0FfONz77fN4AbeghYx13JtXKpW1sZlWbm0gUgi1PpNNamZgb
         7bwvPjjnnln4oXc6fDo6xfsa9raPEfnvILh1xfADN0DqBqGFJcORdjnSbpp+X7viG1L6
         XCVA==
X-Gm-Message-State: APjAAAXLc+S80e5Qtk3wuPCfD1F++cMYqb+d/XMOtTCnIkYu9DCmYjpq
        cHqMKLnFWzSojoAd4U8GGHfIdVg/f6J9eg==
X-Google-Smtp-Source: APXvYqzcczVY04puWu5OvRFstw0G3xfRrB0/WUNp7quD+IeVGyJBmzWBCYjvUh0N0h5BMN9JZDqzGw==
X-Received: by 2002:a5d:5044:: with SMTP id h4mr10727999wrt.4.1578576555877;
        Thu, 09 Jan 2020 05:29:15 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id t8sm8425532wrp.69.2020.01.09.05.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 05:29:15 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Manish Narani <manish.narani@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>
Subject: [PATCH] microblaze: defconfig: Disable EXT2 driver and Enable EXT3 & EXT4 drivers
Date:   Thu,  9 Jan 2020 14:29:06 +0100
Message-Id: <f9bbfa27026d0f596dbc0a9c2e1253575d6cc82e.1578576542.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Narani <manish.narani@xilinx.com>

As EXT4 filesystem driver is used for handling EXT2 file systems as
well. There is no need to enable EXT2 driver. This patch disables EXT2
and enables EXT3/EXT4 drivers.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/configs/mmu_defconfig   | 2 +-
 arch/microblaze/configs/nommu_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/configs/mmu_defconfig
index b3b433db89d8..0e2f5e1fd1ef 100644
--- a/arch/microblaze/configs/mmu_defconfig
+++ b/arch/microblaze/configs/mmu_defconfig
@@ -73,7 +73,7 @@ CONFIG_FB_XILINX=y
 CONFIG_UIO=y
 CONFIG_UIO_PDRV_GENIRQ=y
 CONFIG_UIO_DMEM_GENIRQ=y
-CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_TMPFS=y
 CONFIG_CRAMFS=y
diff --git a/arch/microblaze/configs/nommu_defconfig b/arch/microblaze/configs/nommu_defconfig
index 377de39ccb8c..8c420782d6e4 100644
--- a/arch/microblaze/configs/nommu_defconfig
+++ b/arch/microblaze/configs/nommu_defconfig
@@ -70,7 +70,7 @@ CONFIG_XILINX_WATCHDOG=y
 CONFIG_FB=y
 CONFIG_FB_XILINX=y
 # CONFIG_USB_SUPPORT is not set
-CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_CRAMFS=y
 CONFIG_ROMFS_FS=y
-- 
2.24.0

