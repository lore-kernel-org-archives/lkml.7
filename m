Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCB5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44342077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfDJUNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:13:15 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:36257 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDJUNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:13:14 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MlNYj-1gTSBm1LDx-00lmDM; Wed, 10 Apr 2019 22:13:03 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] s390: only build for new CPUs with clang
Date:   Wed, 10 Apr 2019 22:12:40 +0200
Message-Id: <20190410201300.3528984-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YFRyT6qgQvR+qhv9mS8yRRrUceXDy65GVtgAlXxGmTGhW0mDZ+G
 sI/5jMlMr9MwxKef2jS8TKnJ35YjTPZiEl5+ul6LZtq5sYpgcpjtrdmOGN+kYg5Yf5+YfpG
 +w2AA30VLJNmhdTbBnuHrUJ4K5zwSGeU5ZShR3lWtHUZJuPOjblN5alLhDr6d0JDiD1uz6b
 GgBiBUG+OU4uh4bsgH7Bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jjrGWuM0PD8=:IlJsEhIuRgSxnbYHMlwwo0
 nd30BGZEK74vNeQuI/ufq5rl1AIJohJA4P2XKvdQ3If1ZZRxy+o83hx+oe5yPPy4aO6I4HT5J
 TGjN/S6DQzQuoWZK9DdfL5p2+E8l/LloGpxH3pWhOLun0GQKmDswrA6fTPkatx7SIsDRC+sri
 /aUWngk3I9cxPYzZ7PAvhAZbYJf0zEIafKTbNGt9gZ1gYVjix660Q/9z6nzd01e3oP/mLnSEb
 FoApA+gTSBOjl//k6tyKnhb2JVzOVoNYZk+gkxqiKVxxdheSRvz2h55H4hzc5FZM8UwYqPCVK
 330bxP+a9vKOTmY7+Df4z4v0zmczImwk2XZwFblLh4G9NGhPq+ryz6MTdUylJn+Nicy4h482c
 +T2ZX7WHUB2rZkU4sr7vn7EkMSEUdlcpiup3DT9U+JYoxCrJ4ntQC7nEYt36Krf3bXrbXy2T+
 uGG8tCPkZ/GYb6W5hIQUl9KSl8turbEFevbh0G+F36XL9bD7ZYBBbQvyOooTHDPCpjcCMn6wG
 wxR0bd00C4O+jSm25UF5c2eu0joELQOK5wi1738vh2cjK9OZFvkYwDnL5tWPsFl4Ov3Ta33ow
 nUOkGf+CGuD/jRhS0EH8XyI1/MuAH+Ma4x/769f746b12wdDgdXkDEVBOi5PsJw4j/T/mQXiD
 jBRpEgRna3UtJwAcORKoCglo8oeBzTL5WUm3BA3dmdHhJgSpDijFbilRaVYj2TvTLEFStPWF4
 O43oURSkRqt2BUOyJnElK/3e58ow1BEOZXPEwQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

llvm does does not understand -march=z9-109 and older target
specifiers, so disable the respective Kconfig settings and
the logic to make the boot code work on old systems when
building with clang.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/Kconfig       | 6 ++++++
 arch/s390/boot/Makefile | 2 ++
 2 files changed, 8 insertions(+)

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
index c844eaf24ed7..953a74d04990 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -11,6 +11,7 @@ KASAN_SANITIZE := n
 KBUILD_AFLAGS := $(KBUILD_AFLAGS_DECOMPRESSOR)
 KBUILD_CFLAGS := $(KBUILD_CFLAGS_DECOMPRESSOR)
 
+ifndef CONFIG_CC_IS_CLANG
 #
 # Use -march=z900 for als.c to be able to print an error
 # message if the kernel is started on a machine which is too old
@@ -25,6 +26,7 @@ CFLAGS_als.o			+= -march=z900
 CFLAGS_REMOVE_sclp_early_core.o	+= $(CC_FLAGS_MARCH)
 CFLAGS_sclp_early_core.o	+= -march=z900
 endif
+endif
 
 CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
 
-- 
2.20.0

