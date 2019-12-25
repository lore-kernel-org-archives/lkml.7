Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214F5C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 02:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CFC20679
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 02:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdALMCXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfLYC7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 21:59:42 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38059 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfLYC7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 21:59:42 -0500
Received: by mail-pj1-f65.google.com with SMTP id l35so1901546pje.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 18:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=7nuZCmofGKzlwBIrUtx9+xXC2rtz5xbgMfAxHfQhopg=;
        b=SdALMCXAVU+WmgT7SdCPo8T7YUFkAqo78sHZBDPqKcPfb0pHSebzvwxDizTAN5o33k
         Xc4SB2vWDll6qVjQB/LSZ1R1dEDj6BoNikCjibjnBpLiPxKrgpuIVIbcu+NYiTAMKlgR
         ZPHS70IUiut/x44G6bEtMElLSEhZ1V+rc5+wiBdMNVFkBwOr4xUhzWAcBt0dnMaPUloO
         scL8YERWSUC/fy0qIM1ES1FTlWAhnbM4VET6GzqrOYF3GCIeysWfDwzN+ONlbAB0/Epx
         vWxNJK1PgaleoTDYSIkc5/VuiitEB4mif59a40MHgClxP47DIzTt7fG2baoRpwitRkF7
         YKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=7nuZCmofGKzlwBIrUtx9+xXC2rtz5xbgMfAxHfQhopg=;
        b=OqMoqsuSGAKESHEzKs96YlRZBT3yR2cxw6lt0h8MHqqY4rhpIN3MAQs/nq3OZSKZOZ
         Dek3webS3Q3mMWVnEa0Y8B1/MGb6lislIoys5pED27n5GMeixDb/5QZd8p90u6NC40jq
         Hyed2Kj89joKuiTHmZknWQMg+JBPNpb+46nv3caScKk8xJ1lWmroED1lYQyxaHdOZDkT
         1xkKwBd1m8/ktYRNTtfPcVD9itWreLuEncVdTIIFgRotGBJp/TbVToDCrej0XJ/B6vsX
         ZlQa84sPSoVUJ0y7n0fZ8zPM3x6+0bCXwwThKrM8XCc6a91UgQBKgmETJ3NGSr/GfHsH
         rX6Q==
X-Gm-Message-State: APjAAAWugCpewLNrXcK3SNRdMG73Xlqp+KdjnRLquQbxA1EUZ1EuBagB
        2xGtXrjieDe5W+BWLXMWKsw=
X-Google-Smtp-Source: APXvYqys4aYLLyESGItdQnJRkesq6ONgL3NXfKj544HJN4rh5QYA1j7sdRBPrcwNBHwf4EylFnYVsQ==
X-Received: by 2002:a17:90a:d985:: with SMTP id d5mr10463606pjv.73.1577242781676;
        Tue, 24 Dec 2019 18:59:41 -0800 (PST)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d2sm4849443pjv.18.2019.12.24.18.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 18:59:41 -0800 (PST)
From:   Kever Yang <kever.yang@rock-chips.com>
To:     heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        Kever Yang <kever.yang@rock-chips.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "rockchip: make sure timer7 is enabled on rk3288 platforms"
Date:   Wed, 25 Dec 2019 10:59:08 +0800
Message-Id: <20191225025908.25305-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2a9fe3ca84afff6259820c4f62e579f41476becc.
All the U-Boot version for rk3288 including mainline, rockchip
legacy/next-dev, have init the timer7, so no need to init it in kernel
again.

One more reason is that if  we enable the trust for rk3288, then timer7 is
not able to be accessed in kernel.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 arch/arm/mach-rockchip/rockchip.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index f9797a2b5d0d..f6e1851ed46a 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -21,31 +21,8 @@
 #include "core.h"
 #include "pm.h"
 
-#define RK3288_TIMER6_7_PHYS 0xff810000
-
 static void __init rockchip_timer_init(void)
 {
-	if (of_machine_is_compatible("rockchip,rk3288")) {
-		void __iomem *reg_base;
-
-		/*
-		 * Most/all uboot versions for rk3288 don't enable timer7
-		 * which is needed for the architected timer to work.
-		 * So make sure it is running during early boot.
-		 */
-		reg_base = ioremap(RK3288_TIMER6_7_PHYS, SZ_16K);
-		if (reg_base) {
-			writel(0, reg_base + 0x30);
-			writel(0xffffffff, reg_base + 0x20);
-			writel(0xffffffff, reg_base + 0x24);
-			writel(1, reg_base + 0x30);
-			dsb();
-			iounmap(reg_base);
-		} else {
-			pr_err("rockchip: could not map timer7 registers\n");
-		}
-	}
-
 	of_clk_init(NULL);
 	timer_probe();
 }
-- 
2.17.1

