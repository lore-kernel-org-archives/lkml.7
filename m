Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BED6C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D0F206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7xqOm6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgABRY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 12:24:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42307 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgABRYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 12:24:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so39885991wro.9;
        Thu, 02 Jan 2020 09:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iynuWkDBVTaiEzHNP7sxuTkwJnSTns6zopxJWRhFfwM=;
        b=t7xqOm6OFo39bFTfx2QgOe5P+nWEAEOUff1YJ0pwLEf6Fv1AZqBvjPowdPWbEO6KoE
         Z/9uqLpZ0LzZIHVqJdI3giZkl0gpTCdkocT04PmvIu3PBgyLagUCnjv8kczWyoppCDIb
         c+NcxYZMBC+gUNbOk83IsiTHaC/tQCl5z1POP8n+zKVYYQhHZMeRKB9wA0qZH/BOmGuO
         6f/ycMdHuWvmwKljtf3dL3ThfirhWgPclMEjQIVSrR/x+EB+tMFBtxl8HMCyBqFzMh3m
         qIMRPCxHGm/bcYwCdocfZnXu1WaNpkCBc0ZTiDueiQ4IL3xgm0F28WsImiKxy6Bappvr
         O7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iynuWkDBVTaiEzHNP7sxuTkwJnSTns6zopxJWRhFfwM=;
        b=idwZSWrxhbUNDzNF+WsR46ElZHzBSrFJ+E27qM29DPnWqjOyGG7kWWK8r5c76XF4i1
         FBhdJvL94cIkzTejVqau0xmSh7TgughoPXfbzj2AqFPjpGnNnVVgvndKKV4fzPX/Tl/E
         IEbK3SMxnS9JUJnmfoH/WUFVVEY/fqIKd5XbQkCC+0UoS6hIUYJ51xJQG7ebxb/NzehJ
         hewBxYr9FsLT1qEdfuEnmmEFWl1B/0D4AL8EZ8s9vUCl0x4DsEr5dH/42IRFdhajiXQK
         BE6U93c5ezaZ+umed7V+LhhvTmPL4DoBoDn9WNUTrzf/9NxCqb/RybXX6FrOGJmiILLy
         gghw==
X-Gm-Message-State: APjAAAUBFKfgjAB3eFl7JaeRzEBVJGLj5BUvXVz62q2gaO1fZDWgUW8Y
        VGQhTVspjSDqojGk7+1MVDrRf2c8uTE3xp6W
X-Google-Smtp-Source: APXvYqyGvFmZbRqFUgjsGsKZXKYs8CPJrTsut+rS8ZrZ5qhYlWYH9pC/PaHj2Q9P1tF2BhjHeQQ/qg==
X-Received: by 2002:adf:f484:: with SMTP id l4mr83117692wro.207.1577985858109;
        Thu, 02 Jan 2020 09:24:18 -0800 (PST)
Received: from amanieu-laptop.home ([2a01:cb19:8051:6200:3fe7:84:7f3:e713])
        by smtp.gmail.com with ESMTPSA id z21sm9480328wml.5.2020.01.02.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 09:24:17 -0800 (PST)
From:   Amanieu d'Antras <amanieu@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>, stable@vger.kernel.org,
        Amanieu d'Antras <amanieu@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/7] arm64: Implement copy_thread_tls
Date:   Thu,  2 Jan 2020 18:24:08 +0100
Message-Id: <20200102172413.654385-3-amanieu@gmail.com>
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
Cc: linux-arm-kernel@lists.infradead.org
Cc: <stable@vger.kernel.org> # 5.3.x
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/kernel/process.c | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1b4476ddb83..e688dfad0b72 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -138,6 +138,7 @@ config ARM64
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING
+	select HAVE_COPY_THREAD_TLS
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 71f788cd2b18..d54586d5b031 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -360,8 +360,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 
 asmlinkage void ret_from_fork(void) asm("ret_from_fork");
 
-int copy_thread(unsigned long clone_flags, unsigned long stack_start,
-		unsigned long stk_sz, struct task_struct *p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long stack_start,
+		unsigned long stk_sz, struct task_struct *p, unsigned long tls)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 
@@ -394,11 +394,11 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		}
 
 		/*
-		 * If a TLS pointer was passed to clone (4th argument), use it
-		 * for the new thread.
+		 * If a TLS pointer was passed to clone, use it for the new
+		 * thread.
 		 */
 		if (clone_flags & CLONE_SETTLS)
-			p->thread.uw.tp_value = childregs->regs[3];
+			p->thread.uw.tp_value = tls;
 	} else {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->pstate = PSR_MODE_EL1h;
-- 
2.24.1

