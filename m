Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22004C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE46C2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0R237QW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfDLDKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:10:32 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:34369 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfDLDKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 23:10:32 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x3C39naP014385;
        Fri, 12 Apr 2019 12:09:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x3C39naP014385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555038590;
        bh=NJm8Jp/5FVCr70RF8H8c2eqxkBnhjeEvPOF/F2ziYIs=;
        h=From:To:Cc:Subject:Date:From;
        b=0R237QW3qlz0hzPx+DCYfGkj48+UHpD76nqGGzksufp9IUJZyJynVXdK3bxBYo5VB
         eAy214th1nuey5qaS4xqsDmA5Q/z+sYn5BTPJxZcMpjqRXL6/gpZa2VC3qIZn0QKiB
         IcHaJSZSTUJiBlgCXvLLp1wxB5sc59Q5Y3jUtQaUzZWQxMhlN0ygp9uG3GbQVkfoSb
         VVSWmP9Yt6x9D0HI7S9ViiWc74990wj3Jm+VgWynjQrIjlVc0rt5c1HLuOS3k7ZsGs
         lsk5u/5hg+xieujYt1K0LdCibPwkPUx0q39QT87VyLfevyQCPByAbXU+Jd/uozIBYH
         JhKrQnOwy4fmA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH] memory: ti-emif-sram: move driver-specific asm-offset.h to drivers/memory/
Date:   Fri, 12 Apr 2019 12:09:41 +0900
Message-Id: <20190412030941.11373-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<generated/ti-emif-asm-offsets.h> is only generated and included
by drivers/memory/, so it does not need to reside in the globally
visible include/generated/.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I will apply this to linux-kbuild since this depends on
another patch there.


 drivers/memory/.gitignore        | 1 +
 drivers/memory/Makefile          | 5 +++--
 drivers/memory/ti-emif-sram-pm.S | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)
 create mode 100644 drivers/memory/.gitignore

diff --git a/drivers/memory/.gitignore b/drivers/memory/.gitignore
new file mode 100644
index 000000000000..cbca8b028437
--- /dev/null
+++ b/drivers/memory/.gitignore
@@ -0,0 +1 @@
+ti-emif-asm-offsets.h
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 91ae4eb0e913..2eb0a5b44bb9 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -28,9 +28,10 @@ ti-emif-sram-objs		:= ti-emif-pm.o ti-emif-sram-pm.o
 
 AFLAGS_ti-emif-sram-pm.o	:=-Wa,-march=armv7-a
 
-drivers/memory/ti-emif-sram-pm.o: include/generated/ti-emif-asm-offsets.h
+$(obj)/ti-emif-sram-pm.o: $(obj)/ti-emif-asm-offsets.h
 
-include/generated/ti-emif-asm-offsets.h: drivers/memory/emif-asm-offsets.s FORCE
+$(obj)/ti-emif-asm-offsets.h: $(obj)/emif-asm-offsets.s FORCE
 	$(call filechk,offsets,__TI_EMIF_ASM_OFFSETS_H__)
 
 targets += emif-asm-offsets.s
+clean-files += ti-emif-asm-offsets.h
diff --git a/drivers/memory/ti-emif-sram-pm.S b/drivers/memory/ti-emif-sram-pm.S
index a5369181e5c2..615cd6247739 100644
--- a/drivers/memory/ti-emif-sram-pm.S
+++ b/drivers/memory/ti-emif-sram-pm.S
@@ -14,12 +14,12 @@
  * GNU General Public License for more details.
  */
 
-#include <generated/ti-emif-asm-offsets.h>
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/memory.h>
 
 #include "emif.h"
+#include "ti-emif-asm-offsets.h"
 
 #define EMIF_POWER_MGMT_WAIT_SELF_REFRESH_8192_CYCLES	0x00a0
 #define EMIF_POWER_MGMT_SR_TIMER_MASK			0x00f0
-- 
2.17.1

