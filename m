Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD1CC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF5320673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="Rkao9Ua4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfJHKDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:03:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38585 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfJHKDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:03:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id w12so18676955wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Zm1oD2YPpnvV6YakavKzVpnK4fLOSQuFI8POFOm+BgU=;
        b=Rkao9Ua4L/sySmqvnb8TZGuINuG6hD9q7FqLAZnIxz1ERaWSRaRNRLHlXT4tBtxnWR
         M/oN1IHhHov21J+SFjEyk6RBghtxK88tMaBfjoC+KBQb4uwa2vgpnEbpxJ4C0HkikFna
         xN4BS8T0BVqp+WUsPcTrZeUtnaJMDbbDQx4SYGWEz0PsoIADwxHPjZCaBs5EX5bIIea6
         KaCweg2dX/vSIwk+yM6HluXopkLf53ScBzwzjHz/NiivjTJqhggmBoT5PPfhrGOp9Pun
         8c/4p3dsPYT4Wu/AV/uHxZjcRW1wZyTbEwc4ZAFuBYDztdv7U2y0qGR6ubxouqL6dgvQ
         uAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Zm1oD2YPpnvV6YakavKzVpnK4fLOSQuFI8POFOm+BgU=;
        b=F10ielmuhr/7mCEsmOrfpLU55CpYd5IDPCsa89r813otEfk6fKciKR8LQDg+JTq9YU
         Ml6nkONEKyYr4qSlhyMdXbl3Nsg+1XwMcYramaZzbBwmTkTwWBcPCSiNTS6ojxSYRLEo
         ZSQQ/+uqHoiA/U2/I+HaSGkq10BVS3C11LDdlX5ZrKIlXr52f8Z4AvXFhZFk8LoLUMrn
         R5yC2rt0QXIrsEk/ZXlSQtGv+X5YvtjvhX7Oxij0d4GeWOwQJa51dyje3OnB6YXgEcfF
         R1AUr/gCD8EOD1RR1xOd+pwb3jm0NVqmYqLEuKLKMIy/COgAKqez+tY4/KGLvHShKEZm
         FUdQ==
X-Gm-Message-State: APjAAAWaNgs6DR8hQOWNk0HtJ3dbaSOvmfPzYii/aM0yxs8Y47BF59FK
        yJ28zP4nGUDjD7Le7VbR+D6Q1KmSQ0jcg+I1
X-Google-Smtp-Source: APXvYqxN/urYjYdn0O5hbBdPh2O99QiqVyek+CNncFzEGNcIWNZ18ZGA+FwJkm5BgnPRQWu5WHDetg==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr27681765wrq.35.1570528986511;
        Tue, 08 Oct 2019 03:03:06 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id r18sm3385759wme.48.2019.10.08.03.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 03:03:05 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] microblaze: defconfig: Enable devtmps and tmpfs
Date:   Tue,  8 Oct 2019 12:03:00 +0200
Message-Id: <980101fbea44e14bec2354e718238742e6bc5f05.1570528975.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>

Currently dropbear does not run in background because devtmps and tmpfs
is not enabled by default. Enable devtmps and tmpfs to fix this issue.

Signed-off-by: Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/configs/mmu_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/configs/mmu_defconfig
index 654edfdc7867..b3b433db89d8 100644
--- a/arch/microblaze/configs/mmu_defconfig
+++ b/arch/microblaze/configs/mmu_defconfig
@@ -33,6 +33,8 @@ CONFIG_INET=y
 # CONFIG_IPV6 is not set
 CONFIG_BRIDGE=m
 CONFIG_PCI=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
@@ -73,6 +75,7 @@ CONFIG_UIO_PDRV_GENIRQ=y
 CONFIG_UIO_DMEM_GENIRQ=y
 CONFIG_EXT2_FS=y
 # CONFIG_DNOTIFY is not set
+CONFIG_TMPFS=y
 CONFIG_CRAMFS=y
 CONFIG_ROMFS_FS=y
 CONFIG_NFS_FS=y
-- 
2.17.1

