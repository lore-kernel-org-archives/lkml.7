Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1111CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 23:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54212084F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 23:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="KYGfyOZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfCQXFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 19:05:35 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:58974 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfCQXFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 19:05:35 -0400
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 855F25C2627;
        Mon, 18 Mar 2019 00:05:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1552863933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcN5oRaCf1KipPxN5WZEyVpOx82lejkz6+QtS/hDQRM=;
        b=KYGfyOZVJzxU5DL3XHIdwbjgIYiY2FextGXIEPXCiEKB7vDwq2B3khnqKsp4uWesP9s0e4
        w7Zh0ZLWSxS8C3NoYrRbbLysZduYglOZLxM7TZvG+83QnL8OG1OiHf2lG+MmJAC7q8NoiZ
        w4MTcz05TO8qGfubbp8EQBHq0u2HsNg=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     robin.murphy@arm.com, will.deacon@arm.com, ndesaulniers@google.com,
        natechancellor@gmail.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        nicolas.pitre@linaro.org, thierry.reding@gmail.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 2/2] ARM: drop -mauto-it
Date:   Mon, 18 Mar 2019 00:05:27 +0100
Message-Id: <a5a1563967a9d9ff30b39559cdf9dfb997970401.1552863571.git.stefan@agner.ch>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <e3f3bf27430712ee88c0b600f3d62cb86d327b75.1552863571.git.stefan@agner.ch>
References: <e3f3bf27430712ee88c0b600f3d62cb86d327b75.1552863571.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assembler option -mauto-it is no longer a valid option. The last
remaining references have been removed from the documentation in
July 2009 [0].

The currently supported binutils version is 2.20 (released in
September 2009) or higher where gas supports -mimplicit-it=always.
Drop the fallback to -mauto-it and use -mimplicit-it=always only.

[0] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=529707530657a333a304c651c808ea630c955223

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes in v2:
- Drop $(comma) since we are no longer use the call to as-option.

 arch/arm/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index df3ad82d312c..eb9d38e77cf0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -113,8 +113,7 @@ CFLAGS_ABI	+=-funwind-tables
 endif
 
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
-AFLAGS_AUTOIT	:=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mauto-it)
-CFLAGS_ISA	:=-mthumb $(AFLAGS_AUTOIT)
+CFLAGS_ISA	:=-mthumb -Wa,-mimplicit-it=always
 AFLAGS_ISA	:=$(CFLAGS_ISA) -Wa$(comma)-mthumb
 # Work around buggy relocation from gas if requested:
 ifeq ($(CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11),y)
-- 
2.21.0

