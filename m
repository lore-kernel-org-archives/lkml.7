Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAB9C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605FC207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="swo9NRqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfDBJIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:08:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52499 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729924AbfDBJIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:08:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44YNfy3Vv9z9v0Zs;
        Tue,  2 Apr 2019 11:08:42 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=swo9NRqG; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Li86sRJR3c32; Tue,  2 Apr 2019 11:08:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44YNfy22QMz9v0ZY;
        Tue,  2 Apr 2019 11:08:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1554196122; bh=rWaMv7jLMRcybMw+rH4c15xjnJ5LQFZqC8X6T/gYj8o=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=swo9NRqG5EU5D7oa6/L6CNl12ZwO5S9usIc8hhR7hD6w/GscJey8Ke3k6J1UlS5sk
         b+PSecS+LLqVw3WVycaPPBvZP9q93gMj5f6iSsji2YzH28G/qYnvcyOUNGaslY7uy2
         ISLpIE1QUFco2Wy2/rP92UfAYcIwBX/KPYxGaFVo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6165E8B8C4;
        Tue,  2 Apr 2019 11:08:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wTqIwhouLvzb; Tue,  2 Apr 2019 11:08:43 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2988C8B8C3;
        Tue,  2 Apr 2019 11:08:43 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0AA17661D9; Tue,  2 Apr 2019 09:08:43 +0000 (UTC)
Message-Id: <f42400db206bcc94f99b38c7d7b2967bb7591bd2.1554195798.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554195798.git.christophe.leroy@c-s.fr>
References: <cover.1554195798.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 8/9] Gives arches opportunity to use generically defined boot
 cmdline manipulation
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org
Date:   Tue,  2 Apr 2019 09:08:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most arches have similar boot command line manipulation options.
This patchs adds the definition in init/Kconfig, gated by
CONFIG_HAVE_CMDLINE that the arches can select to use them.

In order to use this, a few arches will have to change their
CONFIG options:
- riscv has to replace CMDLINE_FALLBACK by CMDLINE_FROM_BOOTLOADER
- arches using CONFIG_CMDLINE_OVERRIDE or CONFIG_CMDLINE_OVERWRITE
have to replace them by CONFIG_CMDLINE_FORCE

Arches also have to define CONFIG_DEFAULT_CMDLINE

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 init/Kconfig | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 4592bf7997c0..83537603412c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -80,6 +80,62 @@ config INIT_ENV_ARG_LIMIT
 	  Maximum of each of the number of arguments and environment
 	  variables passed to init from the kernel command line.
 
+config HAVE_CMDLINE
+	bool
+
+config CMDLINE_BOOL
+	bool "Default bootloader kernel arguments"
+	depends on HAVE_CMDLINE
+	help
+	  On some platforms, there is currently no way for the boot loader to
+	  pass arguments to the kernel. For these platforms, you can supply
+	  some command-line options at build time by entering them here.  In
+	  most cases you will need to specify the root device here.
+
+config CMDLINE
+	string "Initial kernel command string"
+	depends on CMDLINE_BOOL
+	default DEFAULT_CMDLINE
+	help
+	  On some platforms, there is currently no way for the boot loader to
+	  pass arguments to the kernel. For these platforms, you can supply
+	  some command-line options at build time by entering them here.  In
+	  most cases you will need to specify the root device here.
+
+choice
+	prompt "Kernel command line type" if CMDLINE != ""
+	default CMDLINE_FROM_BOOTLOADER
+	help
+	  Selects the way you want to use the default kernel arguments.
+
+config CMDLINE_FROM_BOOTLOADER
+	bool "Use bootloader kernel arguments if available"
+	help
+	  Uses the command-line options passed by the boot loader. If
+	  the boot loader doesn't provide any, the default kernel command
+	  string provided in CMDLINE will be used.
+
+config CMDLINE_EXTEND
+	bool "Extend bootloader kernel arguments"
+	help
+	  The default kernel command string will be appended to the
+	  command-line arguments provided during boot.
+
+config CMDLINE_PREPEND
+	bool "Prepend bootloader kernel arguments"
+	help
+	  The default kernel command string will be prepend to the
+	  command-line arguments provided during boot.
+
+config CMDLINE_FORCE
+	bool "Always use the default kernel command string"
+	help
+	  Always use the default kernel command string, even if the boot
+	  loader passes other arguments to the kernel.
+	  This is useful if you cannot or don't want to change the
+	  command-line options your boot loader passes to the kernel.
+endchoice
+
 config COMPILE_TEST
 	bool "Compile also drivers which will not load"
 	depends on !UML
-- 
2.13.3

