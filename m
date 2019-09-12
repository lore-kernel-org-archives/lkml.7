Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4179C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 07:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9681120830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 07:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="b5zTIocn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfILHmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 03:42:37 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:37658 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfILHmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 03:42:37 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x8C7edBo002482;
        Thu, 12 Sep 2019 16:40:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x8C7edBo002482
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568274040;
        bh=tYNGmUKDdlHdaYWdH5IidgIolcOzTVD5cgXor3vQ83I=;
        h=From:To:Cc:Subject:Date:From;
        b=b5zTIocnN33/DdUDcjaMeyjFzoTtbxCd5868rKO0xNO0s4hj4TNzpDUOblkZcIN5s
         blwV1MedYVuH8L4E6jhrG9tGRK5B6XcHeO9hj0vbKerkxkYHo2Ide3IG4M/1a7c4bX
         1PaFV6ym3Hz6Rf1JatWU/532qvHQvpov555Eto+SN0h143gBLKQRZ81xTz1moDF4q8
         PIRr9nPjvDy9VjennU0QLC/d+55xbxsG5lX6PE7UvoAwocoen+R8QD/u8uMmFMIzBi
         yEL4RALzlrR3T6bfH2CDH66vDOel/m3mCNo/vLZ6dB9qFtFdxrTaTKOewUmDQU56i6
         cURS0DcBm/zvw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Firoz Khan <firoz.khan@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: improve prom_init_check rule
Date:   Thu, 12 Sep 2019 16:40:37 +0900
Message-Id: <20190912074037.13813-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This slightly improves the prom_init_check rule.

[1] Avoid needless check

Currently, prom_init_check.sh is invoked every time you run 'make'
even if you have changed nothing in prom_init.c. With this commit,
the script is re-run only when prom_init.o is recompiled.

[2] Beautify the build log

Currently, the O= build shows the absolute path to the script:

  CALL    /abs/path/to/source/of/linux/arch/powerpc/kernel/prom_init_check.sh

With this commit, it is always a relative path to the timestamp file:

  PROMCHK arch/powerpc/kernel/prom_init_check

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/powerpc/kernel/.gitignore |  1 +
 arch/powerpc/kernel/Makefile   | 14 ++++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/.gitignore b/arch/powerpc/kernel/.gitignore
index c5f676c3c224..67ebd3003c05 100644
--- a/arch/powerpc/kernel/.gitignore
+++ b/arch/powerpc/kernel/.gitignore
@@ -1 +1,2 @@
+prom_init_check
 vmlinux.lds
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 56dfa7a2a6f2..07bf5a45f176 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -184,15 +184,13 @@ extra-$(CONFIG_ALTIVEC)		+= vector.o
 extra-$(CONFIG_PPC64)		+= entry_64.o
 extra-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)	+= prom_init.o
 
-ifdef CONFIG_PPC_OF_BOOT_TRAMPOLINE
-$(obj)/built-in.a:		prom_init_check
+extra-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)	+= prom_init_check
 
-quiet_cmd_prom_init_check = CALL    $<
-      cmd_prom_init_check = $(CONFIG_SHELL) $< "$(NM)" "$(obj)/prom_init.o"
+quiet_cmd_prom_init_check = PROMCHK $@
+      cmd_prom_init_check = $(CONFIG_SHELL) $< "$(NM)" $(obj)/prom_init.o; touch $@
 
-PHONY += prom_init_check
-prom_init_check: $(src)/prom_init_check.sh $(obj)/prom_init.o
-	$(call cmd,prom_init_check)
-endif
+$(obj)/prom_init_check: $(src)/prom_init_check.sh $(obj)/prom_init.o FORCE
+	$(call if_changed,prom_init_check)
+targets += prom_init_check
 
 clean-files := vmlinux.lds
-- 
2.17.1

