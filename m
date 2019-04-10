Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A0FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD6E2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDJUNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:13:49 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45625 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfDJUNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:13:49 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N5VXu-1gpg003t0s-016zjP; Wed, 10 Apr 2019 22:13:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] s390: boot, purgatory: pass $(CLANG_FLAGS) where needed
Date:   Wed, 10 Apr 2019 22:12:41 +0200
Message-Id: <20190410201300.3528984-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190410201300.3528984-1-arnd@arndb.de>
References: <20190410201300.3528984-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4kHQTeoWEX/56QzZgzt6tTms3ph0CUQzW12FyBpIJ84Jni675FW
 mkF2HJNWcb3v4VnA4F4MbSMOq+NKxTPxXKT0vsTiAjes3gXvv+p8AQYf/Zj914inJsaBWow
 yREn8pFQ02wO0h47ZB1jQWXjQ4YpXpkJmiXvbdmO9MG44t7uPrGZy5XwomUCCXIAhfgw6dZ
 a1632lEmWnIptJ67ouu/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7aGoQfQ823Y=:jfhcrSH+xbvajbrWaPWoEY
 pXJIfaeXHxA9yJGCDGLzJ+826OU8w2sM4h6Ak9A3o+aTZa+t1l+vlr++jLbADMBmeVxAK5W/k
 biFpWKa6RyBLarlfct8txKj+tdFQfFx2OI4iFDD1Os0bEEHsM8tBCZQijaDel7++B79zXt5Et
 jxlB8Kfn87+CbQR0KVe2kabP/RflSAhOBSNhlSXN1CuChkSaa4dyt256WSBhreINVwRWMhF05
 J4fEhXDntkeNlNoNGUjtye9/IwBiIe3LkQzG2ZsfruiB2Q+lvQsiDaC478ETH1reFyFFBX2ZX
 x6mmWjThpacJxJmbqSiR6xXK8krFraKcJgZuCO2Zz/BE86X7r4YkZQnnhcvTN14X0YpBTz1Gg
 XmT+SwBtU6x2jEU75lA1TUvkBvit1Ahpimm/WgH37R99L/c6nj6BM3ED/cp3zgnx+3zQ6TXjd
 SAL8wy85c5o7vTl+9RdMYvkWeZqjOFIb6bTsGhpdzfHOsauBTH8M7pMK8UuRAqY+XoLQ7JN6D
 YW8JXdHoSx91sR+D40UodZ169kLNGYiOdFHm4AQmyfnGuSqwSiiMonavaaIwSBcD50b5h11tB
 2cRUoh+bfcyCkKyM/gtr6UCnPBgnqAXgAe24YP9cNQHLbHvaXmaDEiN5ptg42A6QdXkB29AbP
 F+mmCBkbCNOU9JIF2pkX8WrExBYjtGl3sfT4JlAsHMZ7+Ml5tWedAjS4IyHvk+Ac2lg0fN+jm
 JqWdkW1OX/jkAI9tuANctyTMBn05n4PP1v9Q4g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purgatory and boot Makefiles do not inherit the original cflags,
so clang falls back to the default target architecture when building it,
typically this would be x86 when cross-compiling.

Add $(CLANG_FLAGS) everywhere so we pass the correct --target=s390x-linux
option when cross-compiling.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/Makefile           | 5 +++--
 arch/s390/purgatory/Makefile | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 9c079a506325..443990791099 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -17,12 +17,13 @@ KBUILD_CFLAGS_MODULE += -fPIC
 KBUILD_AFLAGS	+= -m64
 KBUILD_CFLAGS	+= -m64
 aflags_dwarf	:= -Wa,-gdwarf-2
-KBUILD_AFLAGS_DECOMPRESSOR := -m64 -D__ASSEMBLY__
+KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
 KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
-KBUILD_CFLAGS_DECOMPRESSOR := -m64 -O2
+KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2
 KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
+KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning,pointer-sign)
 KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-option,-ffreestanding)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index ce6a3f75065b..ecd0b3847fef 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -22,6 +22,7 @@ KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
+KBUILD_CFLAGS += $(CLANG_FLAGS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
 
-- 
2.20.0

