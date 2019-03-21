Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42242C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F33D218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y01//rTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfCUOIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:08:07 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36157 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCUOIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:08:07 -0400
Received: by mail-it1-f193.google.com with SMTP id h9so4262662itl.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9bmNiIiYSXpSlnRBJipd8bRpL/IMsEPjbQrVWRlU9SA=;
        b=Y01//rTPbngFSq90gH9Jj3dsTnZ7npVWDfSa5XJqB1jqgDIVW/ma+/9HIqe1Jq0yVQ
         1ChUKezanZFgLrRhGcAAfNchmtSwQhSHIPeaXrjBc14jVj9AeTZILmbl/ayhBZPCTeNt
         vJoiVs8+/qg4Me+L/z1EKZdjf6+0RT4YNO6C598ryFMX/+iuDl+letV6BkYe/gOmaM+6
         na4NjbJc7gQetfRz8iug8ldX+G5nG42u0rv8s4dxbRBzBtYYuNkXEguGcYPAZxcX7I0y
         7LUuZECxDw44/E8g1MnAuJ+7M5dVEdrkE2Nul9yiVhCgKWfPN+C5T0EYnl0211+MjGxe
         xapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9bmNiIiYSXpSlnRBJipd8bRpL/IMsEPjbQrVWRlU9SA=;
        b=MVYEsdZMkO1W5UQuFz7Y6lqlQkXezeZKG/KdhSrJ35k8BMmzf/RZE28ImSxEoXwfQh
         TAvk4LpKZjkvzeBJmC2NvoS0dCPfdkuRFcbv4o1kWr55w70JTJe9FgfGMJ6sCKNoO6xQ
         rsjUny81hGQeZdKn+EY64cn+LPuYTyxF9akhitXklJQGSk4RIVmxC8fKdZqj6yzN0uJI
         W2+BhAoDLaoL4y/oyzND9eDwgWOE2gypjAzvo2RCiZzUSuyq7aD0mR02IUbPPmWGWjjA
         YCRybBApwofBKVEgHf/G4to5cN9D/EV2WjEqCLx99zCcCp1vOtQxOzaxcEKtReMMxKCk
         Q4mw==
X-Gm-Message-State: APjAAAULl5LkXTQSr3D2KJ2ehSGw2/xslk5G6Ts5k7sz5elSVAOW+sNd
        OU9dLfGSY9EPxddtDT5TSy4=
X-Google-Smtp-Source: APXvYqwFhJPs7goQYEMFuIxFu8aqoCXUg8e6hxXxqICqYk+N01ZnAuWy9jfLcfsNrRrowbfiIgnCeA==
X-Received: by 2002:a24:b501:: with SMTP id v1mr2835950ite.174.1553177286009;
        Thu, 21 Mar 2019 07:08:06 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id l19sm2101442iob.46.2019.03.21.07.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:08:05 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH] mips: ralink: allow zboot
Date:   Thu, 21 Mar 2019 08:07:47 -0600
Message-Id: <20190321140747.10927-1-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architecturally, there's nothing preventing compressed images from
working.  Bootloaders built with support for the various compression
methods can decompress and run the kernel.  In practice, many
bootloaders do not support compressed images, but kernels for those
boards should just not be compressed.

Tested on an MT7688 with U-Boot doing LZMA decompression of uImage.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4a5f5b0ee9a9..b286fbbd9699 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -619,6 +619,7 @@ config RALINK
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_MIPS16
+	select SYS_SUPPORTS_ZBOOT
 	select SYS_HAS_EARLY_PRINTK
 	select CLKDEV_LOOKUP
 	select ARCH_HAS_RESET_CONTROLLER
-- 
2.21.0

