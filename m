Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD258C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0565217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVh3Jshn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgABRYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 12:24:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51743 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgABRYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 12:24:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id d73so6203307wmd.1;
        Thu, 02 Jan 2020 09:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=42dwpj2phdMjOSELCxAZ6AzEGwc9EnCl2bkK3fX11KY=;
        b=sVh3Jshn/DL4f/94oNWjZJSmDuhy0L71kNBispSrJKtlZw6uVXxdlcfD3v+SqkaMt+
         68K5P/ZsuDb5yB5LrzO1lHhPS3BNDUnECf0syOVRZ9/iCSuBlDB869EaHCbVS1NiAU/g
         Fq33rOS8y/DrCiMALb9u5vYc+1g4Btdq6ABIJdagnXyiXhRh3Bj5qByi3rBfB/kBU3Y5
         u+OlHgsIaCyqdNDv4pHn7hRHSmJmplYjgxnppT053ktpej2SksAlfAJpepJauOI1Lxxu
         y7lAi26xXAtL/h9E4SAgzE+61nel7GVI9lqwdDXcI/hqeKDa/Qgpec60Q4gPqavwO1BM
         An1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=42dwpj2phdMjOSELCxAZ6AzEGwc9EnCl2bkK3fX11KY=;
        b=Fv1Kub3B+BVDeyXAHlytolicWuBXOJhv7fqPe4S+hEzzSzJtscw4k0jkbo8Xc/TDYv
         csgwOv7yaZmfBVPoowdd8p0nnvP9SqymtrYe6JMqrZ4PwKo++keBBVLUmIWZwzfAIMyt
         n9LAQfQUPSRcIxQsHfMcclDBoge0m+S74j1DX6nf2qbL5x5UNoZGqyYfUqv3moNp+MDz
         gabjJ/i4BeAydD0IDnjkOxpOTqeHNvRd6bxJ1smf5R8eluTyhJhIS1/KhNoQJErJJas6
         Obegkety3wxLGFIcmME1VvQl++RpoKjzyjObQ97xQPu/2Xs3mMiRM22F7vfumyUlfB6k
         WOVg==
X-Gm-Message-State: APjAAAU3YoyAaj08fnDiltKQuWXd8B/PJR6sBqnbtvYTf684AL3y+q0W
        kHTp/QlY3navAdhuOYGXU50Rv0gUrTDUO5MG
X-Google-Smtp-Source: APXvYqxAd8hiehTngHSKl/CLbnA2H62XBgtY/wopB6fuVOhJuP1jHOwqsPSfDwMQ1Nghr/CaB4zuKQ==
X-Received: by 2002:a1c:a382:: with SMTP id m124mr15439329wme.90.1577985860536;
        Thu, 02 Jan 2020 09:24:20 -0800 (PST)
Received: from amanieu-laptop.home ([2a01:cb19:8051:6200:3fe7:84:7f3:e713])
        by smtp.gmail.com with ESMTPSA id z21sm9480328wml.5.2020.01.02.09.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 09:24:20 -0800 (PST)
From:   Amanieu d'Antras <amanieu@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>, stable@vger.kernel.org,
        Amanieu d'Antras <amanieu@gmail.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH 5/7] riscv: Implement copy_thread_tls
Date:   Thu,  2 Jan 2020 18:24:11 +0100
Message-Id: <20200102172413.654385-6-amanieu@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102172413.654385-1-amanieu@gmail.com>
References: <20200102172413.654385-1-amanieu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required for clone3 which passes the TLS value through a
struct rather than a register.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
Cc: linux-riscv@lists.infradead.org
Cc: <stable@vger.kernel.org> # 5.3.x
---
 arch/riscv/Kconfig          | 1 +
 arch/riscv/kernel/process.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d8efbaa78d67..d6c3d44f96b5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -64,6 +64,7 @@ config RISCV
 	select SPARSEMEM_STATIC if 32BIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
+	select HAVE_COPY_THREAD_TLS
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 95a3031e5c7c..817cf7b0974c 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -99,8 +99,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	return 0;
 }
 
-int copy_thread(unsigned long clone_flags, unsigned long usp,
-	unsigned long arg, struct task_struct *p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
+	unsigned long arg, struct task_struct *p, unsigned long tls)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 
@@ -121,7 +121,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 		if (usp) /* User fork */
 			childregs->sp = usp;
 		if (clone_flags & CLONE_SETTLS)
-			childregs->tp = childregs->a5;
+			childregs->tp = tls;
 		childregs->a0 = 0; /* Return value of fork() */
 		p->thread.ra = (unsigned long)ret_from_fork;
 	}
-- 
2.24.1

