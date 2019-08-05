Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B95C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 02:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0797E20644
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 02:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFVQKv/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfHECO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 22:14:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35442 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfHECO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 22:14:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id n4so3582170pgv.2;
        Sun, 04 Aug 2019 19:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=mXck+7yixSQbGeYYGZ+JiOZc4vrwYTsXa1d6rhW0au0=;
        b=gFVQKv/z4hkyO8ZnZlCGUK+FIPH3aqtCeDyUzEgYYsBEWinPU90nKiSb05CUBG01M1
         oxEgMeb9nQJKz8Rb+HQHx6kRjoJLP1S14blrbtciru0z2KimZ45bVOpsebMYLUALwrrR
         rf7dJmzlnaA1k61gjjVygTYmZs9B6RvBwQTZlWq3lMLSqVu7UJP/houJiz8wHY29TjxQ
         WrZ9fD5NqIyt3QvcboZq/UIhWAyZdzO9+/b3WHRpCgsYEL2fxT728QR1WCetpsMPWEzf
         JzOBdEXS5aEz17iQmyjAZnvp/fj2omrn+uaM+kT71QYo1NZrhrBt1LGoKYGDZi7LNTWP
         EgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=mXck+7yixSQbGeYYGZ+JiOZc4vrwYTsXa1d6rhW0au0=;
        b=jZiLHRkbLWPNS6jf8X6B1vor+y6fzJ8Osjmyo1K9bFxrgEXMfhEXfw32uOFWaBQ1pS
         Pz52hyr1kYhh23qkGcXlO93sF7DAUvDrHAT5VAO0UchKoRajnRXIf171avLgvEUnK4lW
         SELznKNmzmXXGkAHItqAD9Gmr2/SBO33ZKvbcT/ttmTalWt+/1SHiWyLD5Y0hXmyqMlK
         T8gIWbNg1rdNFGKtJNi8p8aqIBuzUKuvwz/GF79BbHuKuCT0eB3ErLjeXOr4SFZ7/y7v
         YjguDsc1A2g3okzLpZ4G1orP/r8dK0UWzlDkfbyS25QPim6Dx/fPUjCnfdWm8jtehFej
         zKYg==
X-Gm-Message-State: APjAAAWu6Pq+y1Hwecms1qWk9Qh6TF+12RvBP8a+/8RSfA///+PXWXx6
        BUmxqPewr9zahRcyVR/PTZc=
X-Google-Smtp-Source: APXvYqxadHWrRXOwCfVTIVVI7+IRK+OOgL1y3k1/uMmWy9vfvOPgbD29sDXeI3YFCqubPAgaJjVW2A==
X-Received: by 2002:a65:4948:: with SMTP id q8mr3418751pgs.214.1564971267607;
        Sun, 04 Aug 2019 19:14:27 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b14sm16640636pga.20.2019.08.04.19.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 19:14:26 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>
Subject: [PATCH] sh: Drop -Werror from kernel Makefile
Date:   Sun,  4 Aug 2019 19:14:23 -0700
Message-Id: <1564971263-21562-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a035d552a93b ("Makefile: Globally enable fall-through
warning"), all sh builds fail with errors such as

arch/sh/kernel/disassemble.c: In function 'print_sh_insn':
arch/sh/kernel/disassemble.c:478:8: error: this statement may fall through

Since this effectively disables all build and boot tests for the
architecture, let's drop -Werror from the sh kernel Makefile until
the problems are fixed.

Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sh/kernel/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index 59673f8a3379..ef65f0625c6c 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -47,5 +47,3 @@ obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
 obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-coherent.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
-
-ccflags-y := -Werror
-- 
2.7.4

