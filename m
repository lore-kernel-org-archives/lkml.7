Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA112C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787B12075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370176;
	bh=xEFKpPn8bHMEXj7bVbtkrCgxQJM6q8M+7oxgv+7zqas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ts+fq6lF5Bz6uNqup9k/9Yswn2xL65DHDO4diGkI7BhRh9HHJg6Y6Fg+Uw/KeymLf
	 IkTbRlj+kuumcq2zj3NUHzWbsn7EkB9e+2Wa8w9RrH9fFG7a/hioSROS2kx9Ql4KXe
	 djHgg2iYJXAB38pDOT+lmuMIeNMKcK2dTp3kZVJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733266AbfDDJ3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733064AbfDDJKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:10:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1802C20693;
        Thu,  4 Apr 2019 09:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369047;
        bh=xEFKpPn8bHMEXj7bVbtkrCgxQJM6q8M+7oxgv+7zqas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxEAjx1e4XkO6TNsc1TqDrSWtfwiyCSWvzqYIPdCUElDTGukpGiZMa412nMmUkpSK
         wex+8A7J3Kz31klq+4hTCQJ/iRVJVIw4kDsgVwpRk/EHqUV6ouZBtWE+PsS5PuK6t6
         MO43BnPFNegsepoS2ebLHmmNOm7dkglszNnK3ubM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 078/246] ARM: 8845/1: use unified assembler in c files
Date:   Thu,  4 Apr 2019 10:46:18 +0200
Message-Id: <20190404084621.866345019@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b7e8c9397cd4efe6567d2728f091f1b728025533 ]

Use unified assembler syntax (UAL) in inline assembler. Divided
syntax is considered deprecated. This will also allow to build
the kernel using LLVM's integrated assembler.

When compiling non-Thumb2 GCC always emits a ".syntax divided"
at the beginning of the inline assembly which makes the
assembler fail. Since GCC 5 there is the -masm-syntax-unified
GCC option which make GCC assume unified syntax asm and hence
emits ".syntax unified" even in ARM mode. However, the option
is broken since GCC version 6 (see GCC PR88648 [1]). Work
around by adding ".syntax unified" as part of the inline
assembly.

[0] https://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html#index-masm-syntax-unified
[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88648

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/copypage-v4mc.c | 3 ++-
 arch/arm/mm/copypage-v4wb.c | 3 ++-
 arch/arm/mm/copypage-v4wt.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index b03202cddddb..f74cdce6d4da 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -45,6 +45,7 @@ static void mc_copy_user_page(void *from, void *to)
 	int tmp;
 
 	asm volatile ("\
+	.syntax unified\n\
 	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
 1:	mcr	p15, 0, %1, c7, c6, 1		@ 1   invalidate D line\n\
 	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
@@ -56,7 +57,7 @@ static void mc_copy_user_page(void *from, void *to)
 	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
 	subs	%2, %2, #1			@ 1\n\
 	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
-	ldmneia	%0!, {r2, r3, ip, lr}		@ 4\n\
+	ldmiane	%0!, {r2, r3, ip, lr}		@ 4\n\
 	bne	1b				@ "
 	: "+&r" (from), "+&r" (to), "=&r" (tmp)
 	: "2" (PAGE_SIZE / 64)
diff --git a/arch/arm/mm/copypage-v4wb.c b/arch/arm/mm/copypage-v4wb.c
index cd3e165afeed..6d336740aae4 100644
--- a/arch/arm/mm/copypage-v4wb.c
+++ b/arch/arm/mm/copypage-v4wb.c
@@ -27,6 +27,7 @@ static void v4wb_copy_user_page(void *kto, const void *kfrom)
 	int tmp;
 
 	asm volatile ("\
+	.syntax unified\n\
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
 1:	mcr	p15, 0, %0, c7, c6, 1		@ 1   invalidate D line\n\
 	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
@@ -38,7 +39,7 @@ static void v4wb_copy_user_page(void *kto, const void *kfrom)
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
 	subs	%2, %2, #1			@ 1\n\
 	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	ldmiane	%1!, {r3, r4, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
 	mcr	p15, 0, %1, c7, c10, 4		@ 1   drain WB"
 	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
diff --git a/arch/arm/mm/copypage-v4wt.c b/arch/arm/mm/copypage-v4wt.c
index 8614572e1296..3851bb396442 100644
--- a/arch/arm/mm/copypage-v4wt.c
+++ b/arch/arm/mm/copypage-v4wt.c
@@ -25,6 +25,7 @@ static void v4wt_copy_user_page(void *kto, const void *kfrom)
 	int tmp;
 
 	asm volatile ("\
+	.syntax unified\n\
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
 1:	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4+1\n\
@@ -34,7 +35,7 @@ static void v4wt_copy_user_page(void *kto, const void *kfrom)
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
 	subs	%2, %2, #1			@ 1\n\
 	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	ldmiane	%1!, {r3, r4, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
 	mcr	p15, 0, %2, c7, c7, 0		@ flush ID cache"
 	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
-- 
2.19.1



