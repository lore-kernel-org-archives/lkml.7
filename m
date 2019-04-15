Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F26C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AA420651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDOIgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:36:20 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34167 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOIgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:36:19 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1McGtA-1gi0OB1pBU-00cfR1; Mon, 15 Apr 2019 10:36:07 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] s390: only build for new CPUs with clang
Date:   Mon, 15 Apr 2019 10:35:51 +0200
Message-Id: <20190415083605.2560074-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ANLYJGcdNV8vevCapllzHEWWD+paDLqJkYiMmjf5j9ByOZklrGP
 wiKwVmW7/lWl1DnuEsUCQX/Zk+RHyHM7SsPJ+yTZR/rmLqrh2bGrxMQVc5r4HrIunUGP+48
 D59woTWiupkMjsa7nlfhrliyFgwYDHjjIogCGi7Sr5GjbdFWwsOiggx3twzd0riR+27cPb7
 1iCPyVkQpsKYMi7bp8bsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rJf33xNb6Y0=:IwVQhop63ZKnlSl1ajajbH
 inOFm87UF/ymvnVrN1VHVZtqmzTDdM4X7NtiKxufyMCU6KB6BGfBI+5qGlnPV+t8t2qbK87DE
 EgdRe0a1J8QpVFlFDkLCOT5YIJ7e8CWXHsekWPTLC5dYoOinYGjZzYWdM3JrslT2+UjB3M2Yp
 zF9nK17QOtsruvCMG7z/f8jsBBkmlocWd6x/EfwpwNzcMlHkKmOh6mbc7a5NoZYEmgEu3caGj
 mIMpYhUq4OuVFqQzQjuMIJhTz78QRlgAouppNp5iHKd1VIVl8p9Nks2QytWBVKk6P/3trpwaE
 7Rfh4KNi7uSxi6q3iGgK3LBLL6sVgHtyX2soRNQhHsbBXVM5cncDbEi5G51ogq3EFtwuE38KU
 cxmp4vjButXPVf3nQ1DKDN3LdTc67inH1iTByb53vduVCOcIvb9Z+FQ74FW4eP5nzNjw8aUOu
 Szg4NnBgRV5RmMnmPsts0oeDeHs3ZqS/tD95F0l8C+VzaQXnv7ayCD96Dh42nkAX/MeMd8Mea
 pk8GXGpw0L4IDTpVf5jM+jzZulLyZq4rBei9Vv3qUkUITJu7mvuoqJV6wkYZJA9oMMrD7mM2Q
 sO/QApPEo+hUnNegy0VkVv/I5s+gqjsh/j3SG731TxT75kEzmeNOTDFUGrU+32LOaTffE2CbN
 PddJJSs1aCdgwOanseM3twYJkDakMLzgV1MjXXSUOIyEXIkJ1xRjtu1DS5ZFOVO+cnaVEXCKo
 PINTE1so3coHFuHu42SDO4zBotHHxjg3VTSqAw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

llvm does does not understand -march=z9-109 and older target
specifiers, so disable the respective Kconfig settings and
the logic to make the boot code work on old systems when
building with clang.

Part of the early boot code is normally compiled with -march=z900
for maximum compatibility. This also has to get changed with
clang to the oldest supported ISA, which is -march=z10 here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/Kconfig       |  6 ++++++
 arch/s390/boot/Makefile | 18 ++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8cd860cba4d1..1a2eec61196d 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -240,6 +240,7 @@ choice
 
 config MARCH_Z900
 	bool "IBM zSeries model z800 and z900"
+	depends on !CC_IS_CLANG
 	select HAVE_MARCH_Z900_FEATURES
 	help
 	  Select this to enable optimizations for model z800/z900 (2064 and
@@ -248,6 +249,7 @@ config MARCH_Z900
 
 config MARCH_Z990
 	bool "IBM zSeries model z890 and z990"
+	depends on !CC_IS_CLANG
 	select HAVE_MARCH_Z990_FEATURES
 	help
 	  Select this to enable optimizations for model z890/z990 (2084 and
@@ -256,6 +258,7 @@ config MARCH_Z990
 
 config MARCH_Z9_109
 	bool "IBM System z9"
+	depends on !CC_IS_CLANG
 	select HAVE_MARCH_Z9_109_FEATURES
 	help
 	  Select this to enable optimizations for IBM System z9 (2094 and
@@ -347,12 +350,15 @@ config TUNE_DEFAULT
 
 config TUNE_Z900
 	bool "IBM zSeries model z800 and z900"
+	depends on !CC_IS_CLANG
 
 config TUNE_Z990
 	bool "IBM zSeries model z890 and z990"
+	depends on !CC_IS_CLANG
 
 config TUNE_Z9_109
 	bool "IBM System z9"
+	depends on !CC_IS_CLANG
 
 config TUNE_Z10
 	bool "IBM System z10"
diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index c844eaf24ed7..c6a6b6dd3d52 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -12,18 +12,24 @@ KBUILD_AFLAGS := $(KBUILD_AFLAGS_DECOMPRESSOR)
 KBUILD_CFLAGS := $(KBUILD_CFLAGS_DECOMPRESSOR)
 
 #
-# Use -march=z900 for als.c to be able to print an error
+# Use minimum architecture for als.c to be able to print an error
 # message if the kernel is started on a machine which is too old
 #
-ifneq ($(CC_FLAGS_MARCH),-march=z900)
+ifndef CONFIG_CC_IS_CLANG
+CC_FLAGS_MARCH_MINIMUM := -march=z900
+else
+CC_FLAGS_MARCH_MINIMUM := -march=z10
+endif
+
+ifneq ($(CC_FLAGS_MARCH),$(CC_FLAGS_MARCH_MINIMUM))
 AFLAGS_REMOVE_head.o		+= $(CC_FLAGS_MARCH)
-AFLAGS_head.o			+= -march=z900
+AFLAGS_head.o			+= $(CC_FLAGS_MARCH_MINIMUM)
 AFLAGS_REMOVE_mem.o		+= $(CC_FLAGS_MARCH)
-AFLAGS_mem.o			+= -march=z900
+AFLAGS_mem.o			+= $(CC_FLAGS_MARCH_MINIMUM)
 CFLAGS_REMOVE_als.o		+= $(CC_FLAGS_MARCH)
-CFLAGS_als.o			+= -march=z900
+CFLAGS_als.o			+= $(CC_FLAGS_MARCH_MINIMUM)
 CFLAGS_REMOVE_sclp_early_core.o	+= $(CC_FLAGS_MARCH)
-CFLAGS_sclp_early_core.o	+= -march=z900
+CFLAGS_sclp_early_core.o	+= $(CC_FLAGS_MARCH_MINIMUM)
 endif
 
 CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
-- 
2.20.0

