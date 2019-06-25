Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E907C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C88320663
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iXxC3b2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFYVE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:04:58 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:57050 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfFYVE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:04:57 -0400
Received: by mail-pl1-f202.google.com with SMTP id o6so9858064plk.23
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HoLOG72+3lkaAV6Y6OdGRg3DmNGZd9sNYaOXLu26Ri4=;
        b=iXxC3b2pI79w4JiYlTG7X6Y1lI3tTwIpbI+mFRBtcxsy+TDbY24OTyx8XqsdXKcFai
         dP0ls6p4D60qx4UuVrDtqsByvQmeveUXtNtf6fuD3cIXfIp2Qhd94RYDgy+YH6utmfKb
         gWoPN6IIsSpDWPiLZI3gNr8v8CfOpqv62mEi47Jpht1mouKA+GY25mDNvy3UsAijKIZd
         CwlwVxbUvyN6nwNAjFVuVMLQkUNP3EsoHuvtUovY8usGc5BJGmWHq2V+jM4yW3ZMNOxF
         0a7nhNwTbogb+WA/G460UjKNDg/pYXd+kV74ofbAqv0xzFgKMVWGNwzeCckNBu/jKXRL
         obPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HoLOG72+3lkaAV6Y6OdGRg3DmNGZd9sNYaOXLu26Ri4=;
        b=RaI/+LOAFvz0UTk+TGTpeyh0rYu10FDIAeyxyfmYGCRUUovqauYUzEwftHURArQoxk
         lrYrLE3rwMDDiJOaBG45NT4Uz3UTptMEOarhAfdpatLuu1QjKf59Spdq+dXosuw00tfd
         0kawZ4lE0IB/ulPdxEy2sTsnMVxTVkHPEO+UXqyNjl0c1LHyeJQHC03019r4Z8rygB2Z
         Ar8JGhAoOXblNa02cVk5QGvoe+5hWZRRWYGZcxDubjh1sMcOx4wtJJt25ljmFDz3KAjA
         sASavJebOx15urHymYmZ1gxV/ZUuHB/GAFIqmyMckzlynj8dnPlY2kkVFM2JODhOmO2L
         K6Sw==
X-Gm-Message-State: APjAAAVviuCxAj3R0nGBUSQ5akonbgrMByMUJIrvh1U7tVvfsrS9ClTl
        tOt/m2d9nZt8OC1OTsckWjutZv7EDzZqwfjcASk=
X-Google-Smtp-Source: APXvYqyvpOUTtppsbsaJH/XnhifiqOT1lCdoynQlcEy37F5rlc4dQDPnt3QeVlEuBFY2ZFM/Yg7ZCQkznTZyASQyLyw=
X-Received: by 2002:a63:f342:: with SMTP id t2mr38294443pgj.83.1561496696611;
 Tue, 25 Jun 2019 14:04:56 -0700 (PDT)
Date:   Tue, 25 Jun 2019 14:04:39 -0700
Message-Id: <20190625210441.199514-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] ARM: Kconfig: default to AEABI w/ Clang
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     linux@armlinux.org.uk
Cc:     clang-built-linux@googlegroups.com, broonie@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang produces references to __aeabi_uidivmod and __aeabi_idivmod for
arm-linux-gnueabi and arm-linux-gnueabihf targets incorrectly when AEABI
is not selected (such as when OABI_COMPAT is selected).

While this means that OABI userspaces wont be able to upgraded to
kernels built with Clang, it means that boards that don't enable AEABI
like s3c2410_defconfig will stop failing to link in KernelCI when built
with Clang.

Link: https://github.com/ClangBuiltLinux/linux/issues/482
Link: https://groups.google.com/forum/#!msg/clang-built-linux/yydsAAux5hk/GxjqJSW-AQAJ
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8869742a85df..3539be870055 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1545,8 +1545,9 @@ config ARM_PATCH_IDIV
 	  code to do integer division.
 
 config AEABI
-	bool "Use the ARM EABI to compile the kernel" if !CPU_V7 && !CPU_V7M && !CPU_V6 && !CPU_V6K
-	default CPU_V7 || CPU_V7M || CPU_V6 || CPU_V6K
+	bool "Use the ARM EABI to compile the kernel" if !CPU_V7 && \
+		!CPU_V7M && !CPU_V6 && !CPU_V6K && !CC_IS_CLANG
+	default CPU_V7 || CPU_V7M || CPU_V6 || CPU_V6K || CC_IS_CLANG
 	help
 	  This option allows for the kernel to be compiled using the latest
 	  ARM ABI (aka EABI).  This is only useful if you are using a user
-- 
2.22.0.410.gd8fdbe21b5-goog

