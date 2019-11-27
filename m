Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F49DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A76021556
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888178;
	bh=4Bq9zUx7ceP48+ET5OQc8d7++KgI10SHReEseY/1MN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lol313CSg4g5ldqXXIopxIxkAzlttZZwah/FAvRYtSyPjbvjDECI4qVnLS2apUpoS
	 S3Pk70iWgG7lTWAQ/gk6CSFDuSLqVkH/lWl4QlSD47eS6TPjPn5uT/Y9DxjfgTYXXb
	 Fkeefm8sbpahvX5t6/wtiaA9GXKjxzJH2W2xv5Pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfK0U4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:56:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730746AbfK0U4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:56:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB057215F1;
        Wed, 27 Nov 2019 20:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888172;
        bh=4Bq9zUx7ceP48+ET5OQc8d7++KgI10SHReEseY/1MN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7EgxXbLx+BN8oZ4RBi7M08M4v5bVTFntMVsO5UxlxF6YW+IBvUFkGDdHE/zHVqsp
         fzM2tRET1FE4BbRr4c9S/B6gL5aRnyn4EoXMApyP9+zMtIKc+VG/Chze71uveAPfr1
         bqIzkKT84ldLXefJeWQ7gn0duJDboci1Q5ufSEBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 032/306] powerpc/boot: Fix opal console in boot wrapper
Date:   Wed, 27 Nov 2019 21:28:02 +0100
Message-Id: <20191127203117.097130733@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Stanley <joel@jms.id.au>

[ Upstream commit 1a855eaccf353f7ed1d51a3d4b3af727ccbd81ca ]

As of commit 10c77dba40ff ("powerpc/boot: Fix build failure in 32-bit
boot wrapper") the opal code is hidden behind CONFIG_PPC64_BOOT_WRAPPER,
but the boot wrapper avoids include/linux, so it does not get the normal
Kconfig flags.

We can drop the guard entirely as in commit f8e8e69cea49 ("powerpc/boot:
Only build OPAL code when necessary") the makefile only includes opal.c
in the build if CONFIG_PPC64_BOOT_WRAPPER is set.

Fixes: 10c77dba40ff ("powerpc/boot: Fix build failure in 32-bit boot wrapper")
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/boot/opal.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/boot/opal.c b/arch/powerpc/boot/opal.c
index 0272570d02de1..dfb199ef5b949 100644
--- a/arch/powerpc/boot/opal.c
+++ b/arch/powerpc/boot/opal.c
@@ -13,8 +13,6 @@
 #include <libfdt.h>
 #include "../include/asm/opal-api.h"
 
-#ifdef CONFIG_PPC64_BOOT_WRAPPER
-
 /* Global OPAL struct used by opal-call.S */
 struct opal {
 	u64 base;
@@ -101,9 +99,3 @@ int opal_console_init(void *devp, struct serial_console_data *scdp)
 
 	return 0;
 }
-#else
-int opal_console_init(void *devp, struct serial_console_data *scdp)
-{
-	return -1;
-}
-#endif /* __powerpc64__ */
-- 
2.20.1



