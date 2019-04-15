Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E3C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE4620651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfDOIgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:36:36 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:43489 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOIgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:36:35 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N3KkM-1gqCkt3REg-010P4b; Mon, 15 Apr 2019 10:36:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] s390: boot, purgatory: pass $(CLANG_FLAGS) where needed
Date:   Mon, 15 Apr 2019 10:35:52 +0200
Message-Id: <20190415083605.2560074-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190415083605.2560074-1-arnd@arndb.de>
References: <20190415083605.2560074-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DUi2IPPFGOns/G1VORQzsxkHqRzczPaTbKYAoZ7o/OXakm44zXP
 eaKkpkShSuEc7LVI69cqoE14avZgLTxGjwNUdvWZL0aK0BAJ/qv2kJosD3AVSO70/ESBwRB
 k8o+f3shUA/4DzJBj1gWTQgYO80Cfb6H5eOxdE2k1zEv7/WrPGJJJxgTVHMZrPn6EBu99PF
 ohQvRstqXApuk3gQc8DwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kAK0dNPU2So=:nuqkLmpBl3l/g/k3g7SmAx
 Pn9BWauQrxYbqCgfdqKjV8Wpaydz35/4Bm1qRyczvwDYQO7YnwmtLQgicp2oY9dWOFecrI3Ie
 BmexKQPttU3pE5R9HRglG12IdaOjB5HjY2yZFFc0f+7tjUbMiObayc8EOtdtI8OZKTXqYx3gd
 YDR43qwQ1Xoio0oEzJ+A47qaGxOxL+rJ5TLrW3JFRlDb4tqgumQ8ZtNUyhdGhq7g6Dzj9KSAg
 YdwtBuOCPXe4mtP2ew/e/gBUf856BaAJrwLKdY2degBLzsSnajKZK5o6VT1k/eQgXyrz41Z6+
 Puqn0+q372nB/9hhvwzDYfo+PjMg7Al+WZzXmXWuC+gZzesrss1eDla3OwFCy/yjOb6WFUHys
 UrhhWDmtYRqKAg0GDMCWuFXLWQDlfXIpbJIhgzy6FdE1ySGGVq+rfJegxY19D3qGq7QPlVWpC
 SUC0zthRjzU01EOaFBVaAjYcVdcrpO+oMk1sG8rq04h6Xy2421uFonPj4z30j0yB36nXJF+6f
 nVecKDmiueLWOhozaVP1/47Io50EX7EcbzqqId03ectcY5yn3cgzpJw+ap0mvkIx9icGpbW2R
 ofXnjct91o9Lgc1Nnga6hKymIaGg6wqA0p3CO+6wfDTJEFH37pzpcf/8JQKbjAFdJCFR8TbKn
 9Tz4Nh0e61kduoAmTbnpR3kVIaH0ZIQp4CXF8WdY23avUSCrxQQQB++vZe+8MDUAeOfqGANV5
 yH/NKK4113sI+MteHmNc2C73HHd6AW61QquKsA==
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
 arch/s390/Makefile           | 4 ++--
 arch/s390/purgatory/Makefile | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 9c079a506325..9a228786e34f 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -17,9 +17,9 @@ KBUILD_CFLAGS_MODULE += -fPIC
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

