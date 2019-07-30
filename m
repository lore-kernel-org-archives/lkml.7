Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2EBC7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91954206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9qU2szS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfG3EoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 00:44:19 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:46811 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfG3EoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 00:44:18 -0400
Received: by mail-vk1-f194.google.com with SMTP id b64so12526107vke.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 21:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d6rjIgo3Vi+suTjkC1h224KoPvKAJrv1+GATOVWvv+c=;
        b=b9qU2szS1N5oiCMNf2LCtIshtSE43S8VHtG1ncGc0M5oww14K731lyVUtLVpBmQKWE
         hzbAPThCAFOy0EWBlWYsxB8rNpS0UPOhot+SYXXr5yqT1tCbtjcCuYOjBcePHbC9rdQS
         G4XhGJ5oZaiuPcfNZQTuzyCoyVv3V0MMQHZyJAow31HnMCT+5DyNh+AktECRT8pGoXSW
         EI8PYmO1Jsz2dlefa61JtUdVZhmbVBdXeC5EhFeXu6PeyH2ZWWKWtjQXvIPRPju9Qgxk
         w/5klbqYApugKd6ZRbqLq14j0az9UW5FL3b7zzQEuE25wLjKSW+7zuMGu2M9HEPz3PAv
         QBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d6rjIgo3Vi+suTjkC1h224KoPvKAJrv1+GATOVWvv+c=;
        b=NaI3WuFhYQja/GXUrhCycQrubetxZ62H+WYT+OHiQ0N1OFNOhwaDHOTYnKgvibn/he
         AU7mCfgq132fHH2hv88hk0IrGBzrnK/eLF8a6xD4FIuWlvM4dX/D3JBOSOAMeXUd5y4v
         axeG9m+QfkQOh4yS5ebulEqO+PH3GwORBjIVRFOhRluBHi+4dFfSw933UhHnX+IvjrGl
         XY5NUj9UZUNgeu9awGJBM+EoAEV1QvTKp4BUzjy2URYbB6LUI1CvgxS2GqMm3wCQQu6l
         tBvIF2qV4WbZ141Q7QfqZm6XY9js5SZR7rHtpmCoFjpE7/G5q6dlp7rvk4or1Y3DTlHz
         mmJw==
X-Gm-Message-State: APjAAAUSZgNcGipDmc4tHjlyuNSFMf//SJUNfM+MCXcncOucGejUbclU
        sjVD2oLmO60ZSKN6utRjDnA=
X-Google-Smtp-Source: APXvYqw7o5XOlRVC1x5vjuCDZSNhKzcBq5UM33yBZVByZLEjGcAj/apcYqtE+eWCzuD/LcmWXaauYA==
X-Received: by 2002:a1f:2b07:: with SMTP id r7mr44503723vkr.65.1564461857826;
        Mon, 29 Jul 2019 21:44:17 -0700 (PDT)
Received: from asus-S451LA.lan ([190.22.43.156])
        by smtp.gmail.com with ESMTPSA id f14sm15103387vsk.10.2019.07.29.21.44.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 21:44:17 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     linux@armlinux.org.uk, michal.simek@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Araneda <luaraneda@gmail.com>
Subject: [RFC PATCH] ARM: zynq: Use memcpy_toio instead of memcpy on smp bring-up
Date:   Tue, 30 Jul 2019 00:43:26 -0400
Message-Id: <20190730044326.1805-1-luaraneda@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a kernel panic (read overflow) on memcpy when
FORTIFY_SOURCE is enabled.

The computed size of memcpy args are:
- p_size (dst): 4294967295 = (size_t) -1
- q_size (src): 1
- size (len): 8

Additionally, the memory is marked as __iomem, so one of
the memcpy_* functions should be used for read/write

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---

For anyone trying to reproduce / debug this, it panics
before the console has any output.
I used JTAG to find the panic, but I had to comment-out
the call to "zynq_slcr_cpu_stop" as it stops the JTAG
interface and the connection is dropped, at least with OpenOCD.

I run-tested this on a Digilent Zybo Z7 board
---
 arch/arm/mach-zynq/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index a7cfe07156f4..407abade7336 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -57,7 +57,7 @@ int zynq_cpun_start(u32 address, int cpu)
 			* 0x4: Jump by mov instruction
 			* 0x8: Jumping address
 			*/
-			memcpy((__force void *)zero, &zynq_secondary_trampoline,
+			memcpy_toio(zero, &zynq_secondary_trampoline,
 							trampoline_size);
 			writel(address, zero + trampoline_size);
 
-- 
2.22.0

