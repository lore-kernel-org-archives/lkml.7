Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5132BC74A2E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E562064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562770968;
	bh=/i4JXgB4sZ2vSeHXCXQIBb9tN9aVxb6IM52GY++PlDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pPCl5WfiZXPhKgdx5I/ScZoCCVGKshy52ZoLRskdMkzTFsS5IkEquguClv4/IFxad
	 WkI4uEly0tRmNColMoF66UZZSjwmxxP3hqQ2P9/cpB2F9fTtjQZMNC+nrxE02DGTkx
	 +aQkHIKG2WXjG2XRJSNamfXJdZbf6P/++kySkbas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfGJPCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfGJPCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:02:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B930D2084B;
        Wed, 10 Jul 2019 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562770965;
        bh=/i4JXgB4sZ2vSeHXCXQIBb9tN9aVxb6IM52GY++PlDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZIIY7PfX62bM+EVib+sl/5YFDjLTilwAY54IKf/6nBR1jxj5G/gAJTwXEprXvmCnh
         IYg08DpeHYErhUq2QG5tsHXhxjGsSfjlWnvEPOA9cVQ7Rm/spfYLYUwsOD+rTi2Fsg
         N3CsyPiZZl+kl7RsU3sM5ASvzJEpFnu6ZyCReJTM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>,
        Jo-Philipp Wich <jo@mein.io>,
        =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 02/11] MIPS: fix build on non-linux hosts
Date:   Wed, 10 Jul 2019 11:02:29 -0400
Message-Id: <20190710150240.6984-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710150240.6984-1-sashal@kernel.org>
References: <20190710150240.6984-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>

[ Upstream commit 1196364f21ffe5d1e6d83cafd6a2edb89404a3ae ]

calc_vmlinuz_load_addr.c requires SZ_64K to be defined for alignment
purposes.  It included "../../../../include/linux/sizes.h" to define
that size, however "sizes.h" tries to include <linux/const.h> which
assumes linux system headers.  These may not exist eg. the following
error was encountered when building Linux for OpenWrt under macOS:

In file included from arch/mips/boot/compressed/calc_vmlinuz_load_addr.c:16:
arch/mips/boot/compressed/../../../../include/linux/sizes.h:11:10: fatal error: 'linux/const.h' file not found
         ^~~~~~~~~~

Change makefile to force building on local linux headers instead of
system headers.  Also change eye-watering relative reference in include
file spec.

Thanks to Jo-Philip Wich & Petr Štetiar for assistance in tracking this
down & fixing.

Suggested-by: Jo-Philipp Wich <jo@mein.io>
Signed-off-by: Petr Štetiar <ynezz@true.cz>
Signed-off-by: Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/compressed/Makefile                 | 2 ++
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 3c453a1f1ff1..172801ed35b8 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -78,6 +78,8 @@ OBJCOPYFLAGS_piggy.o := --add-section=.image=$(obj)/vmlinux.bin.z \
 $(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.bin.z FORCE
 	$(call if_changed,objcopy)
 
+HOSTCFLAGS_calc_vmlinuz_load_addr.o += $(LINUXINCLUDE)
+
 # Calculate the load address of the compressed kernel image
 hostprogs-y := calc_vmlinuz_load_addr
 
diff --git a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
index 542c3ede9722..d14f75ec8273 100644
--- a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
+++ b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
@@ -13,7 +13,7 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include "../../../../include/linux/sizes.h"
+#include <linux/sizes.h>
 
 int main(int argc, char *argv[])
 {
-- 
2.20.1

