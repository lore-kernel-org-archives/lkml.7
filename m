Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD19C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360B622BE8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="edh9Q/nT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfGYWge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:36:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36199 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfGYWge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:36:34 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so100810342iom.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 15:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=nlrgc3XP///cXkj+Yu47zEDSpxWwFMEQoIXOJqQtEs8=;
        b=edh9Q/nTB28aapBqaGJrUwVC4YldhLZQXUdWG9P/jholJQh/T7dI2MsA9ti5OewBbT
         pSwVbNxTaKDukE/FZzdQq2iXTb9jRPKE3ZY0b8wxbIBQ//o5KFIYKBevGAc1x9wewtVB
         tXcw5RyIZrJMUZAGiNNtVQUNXx1qEzHdpQ1Atp+PdW1W6bxPFS08ksjS6kxLbIPzMhjw
         6wr7giY2zxeaOye0oLuRwr8gvrNn2vfJIMw6xaVocjRlUCC0TBf610nIAoTz4OgRGlFe
         5eP84GWop+APeaGrjKkSnv4YNvcZXPluVxak1Z2nCmrzT4MvkjoBpjlF0iW00rgLLwXA
         5lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=nlrgc3XP///cXkj+Yu47zEDSpxWwFMEQoIXOJqQtEs8=;
        b=WBPy2Qg1j+u1y/SGWz49q+Oa3DQyP6o5gFfovRCtYsSNfmXi28LjwZoJUnHWzKYXE+
         kc5tbJ0l9W4Rq00XIYNfnTSqwKjA7x6+0tiDskB0wRYcKtM/yzyLKkWr4yCEAfNJn+Tl
         HX8+sFcBiFrVaspneF8FJtRZLGQL2D8Lli+1h6AImToGAx45H9s0asesGUshYkGMG7PR
         7bAdmQI4BWctkKaPnns5LPr3++j4E9RAupHcFTJTwEy8nMVWRo6NOHBGIJhD4COO775m
         Xk8z8Ie+KHUcT9Ln1fJnr7i6Y/6VlevB5FsJb75w19HKP9pMt/5MJuyc1wujejnlmyOD
         k7Pw==
X-Gm-Message-State: APjAAAUSUVMbLxj/3lMHsnsO6V/ycfLHRer9sfWrdLtNznutIxNAV1cm
        x7XFZ6t8vJCfwAFZ3fyYk3tJdQ==
X-Google-Smtp-Source: APXvYqwGdKrLMK8/VhIuZJOtHErkOj9DQrk7CUrGldHTNrmyITpvd7CaE15zTO/7L/PhzJX7ULSyLw==
X-Received: by 2002:a5d:9bc6:: with SMTP id d6mr14846311ion.160.1564094193396;
        Thu, 25 Jul 2019 15:36:33 -0700 (PDT)
Received: from localhost (67-0-24-96.albq.qwest.net. [67.0.24.96])
        by smtp.gmail.com with ESMTPSA id n26sm37422886ioc.74.2019.07.25.15.36.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 15:36:32 -0700 (PDT)
Date:   Thu, 25 Jul 2019 15:36:31 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: defconfig: align RV64 defconfig to the output of
 "make savedefconfig"
Message-ID: <alpine.DEB.2.21.9999.1907251535421.32766@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Align the RV64 defconfig to the output of "make savedefconfig" to
avoid unnecessary deltas for future defconfig patches.  This patch
should have no runtime functional impact.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/configs/defconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index b7b749b18853..93205c0bf71d 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -34,6 +34,7 @@ CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCIE_XILINX=y
 CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_SD=y
@@ -53,6 +54,8 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_HVC_RISCV_SBI=y
+CONFIG_SPI=y
+CONFIG_SPI_SIFIVE=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_DRM=y
 CONFIG_DRM_RADEON=y
@@ -66,8 +69,9 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
+CONFIG_MMC=y
+CONFIG_MMC_SPI=y
 CONFIG_VIRTIO_MMIO=y
-CONFIG_SPI_SIFIVE=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_AUTOFS4_FS=y
@@ -83,8 +87,4 @@ CONFIG_ROOT_NFS=y
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_DEV_VIRTIO=y
 CONFIG_PRINTK_TIME=y
-CONFIG_SPI=y
-CONFIG_MMC_SPI=y
-CONFIG_MMC=y
-CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_RCU_TRACE is not set
-- 
2.22.0

