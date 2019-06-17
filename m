Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE450C46477
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0602208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AmGxu5F0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfFQTaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:30:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35862 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbfFQTaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:30:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so3185890wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 12:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EkTsmPm54nV9I4eCV7klbBI2xmAyNZbDf6YnrgHdVW0=;
        b=AmGxu5F0KkO3GEQ+Ip9mfFWBY+gHo846Sjgr7/Mu/jH0pE9VoO7pZ8yAl7ZzP1xgNv
         oM1KZ0aJNGsTRu6qeMpzYy5xBvKeV/zhKXEfoRZCSPXxxuw+lE1meqg9Ldgwb/8SLQKP
         PX9onnzJjT7tzw5wGIhQwOQ2F7fcB9J6k387s9l30NMFJ0RJiY8x4Jo7ZP5QFD7jVjVG
         DBP4xEwe3rQX/S4eCkfcidL0fqh2msiwMk3NV1xO5kc53n6n/FJUQ4Ku6+rs/vKVVvw8
         gJBxdh+YyBGwEIv8EOEGhEAY3sqkh5Qt2YBAEF98qNIc8yykvpK3RydN2xGe37fzTojI
         tLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EkTsmPm54nV9I4eCV7klbBI2xmAyNZbDf6YnrgHdVW0=;
        b=l0InBvjKmz/qVef3mpRCaqjWB3PsC7fXQORfVtyr8eDsudI3Cel9rcmwxjYEFi+IqR
         bDEBBGTtYqoBsGQQdFtNb/KwpgAaxsAII2ReotaBpqablvYPSgW/ODllrv0D1ptKZ4/f
         3Gw4Wg6M5u6+wjtF/FOM3ZDyoc77ovLdKDfpih55mM7XD9olrvIT+YRbywdOcN7gfV2j
         jR3EgkhRZVz5H+FGS10yQPo4CgVuGZ0G1u4GAly1U0N4K1tGkXu4UDq9y2mLFZKgAgy/
         ccTljbTnM91+66C9dJuxQsjc109t746bcjID6ikHIZnS2xe9NWl6Ua2KCUV3d2NdjqO2
         /lcg==
X-Gm-Message-State: APjAAAVPElj9WdxgHRiJyvA26zdYPwdS8WeeVgN1qT5PC2cFfD8P8LiF
        WFFhRoHd8WtBLv+BpZUZnL4JXQ==
X-Google-Smtp-Source: APXvYqyX0kVbSqS7aC4sfwCCNuTTDSn5b7E8alU67haUiF3ORjBg9no+KsXo3NxLtJPX9fne/yCrhw==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr7631641wrs.97.1560799797685;
        Mon, 17 Jun 2019 12:29:57 -0700 (PDT)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com (cust-west-pareq2-46-193-13-130.wb.wifirst.net. [46.193.13.130])
        by smtp.googlemail.com with ESMTPSA id u18sm9412034wrr.11.2019.06.17.12.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jun 2019 12:29:57 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 3/3] riscv: defconfig: enable SOC_SIFIVE
Date:   Mon, 17 Jun 2019 21:29:50 +0200
Message-Id: <1560799790-20287-4-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560799790-20287-1-git-send-email-lollivier@baylibre.com>
References: <1560799790-20287-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SOC_SIFIVE so the default upstream config is bootable on the SiFive
Unleashed Board.
And have basic support for future boards based on the same SoC.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---
 arch/riscv/configs/defconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 4f02967e55de..6e3e37aa8fd1 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -12,6 +12,7 @@ CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_BPF_SYSCALL=y
+CONFIG_SOC_SIFIVE=y
 CONFIG_SMP=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -49,8 +50,6 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
-CONFIG_SERIAL_SIFIVE=y
-CONFIG_SERIAL_SIFIVE_CONSOLE=y
 CONFIG_HVC_RISCV_SBI=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_DRM=y
@@ -66,9 +65,6 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
 CONFIG_VIRTIO_MMIO=y
-CONFIG_CLK_SIFIVE=y
-CONFIG_CLK_SIFIVE_FU540_PRCI=y
-CONFIG_SIFIVE_PLIC=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_AUTOFS4_FS=y
-- 
2.7.4

