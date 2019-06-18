Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2423DC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044282080A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfFRJrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:47:51 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:34129 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfFRJrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:47:51 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MvazO-1iVYJd1CNC-00sfaV; Tue, 18 Jun 2019 11:47:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Alexander Popov <alex.popov@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] structleak: disable BYREF_ALL in combination with KASAN_STACK
Date:   Tue, 18 Jun 2019 11:47:13 +0200
Message-Id: <20190618094731.3677294-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:peaZfmlkgECAGz9riypsIjV4ic/JP7FXX72Osd9/Mq+xyvBdsCS
 QBR6nMT1ohGbRCit/XsDuRwE9m62UtxQb8P0hVuaqx/phcvYootks744nTD7mnuahBKuDRd
 nlFPtsir0LRT4s7DskzMEeyJxjArgwMxWUyRsgRPXJRek+d2c5rWM1qoz78m39pnj+BpCM6
 +yskDQBig2i7wcwA6yOBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mt0pBl9Irk8=:bYl9+u5Pgnw4rI3NpDMYHT
 i53Q/NuCg7Ndw7pN9sP3ZPFD5oeob8tWcVRjg+sNsM7RJ5b9tSeQixOT4O5MYt/D3k3OxKKFR
 CsMMgCj6iveTYDoMsmni/ibnZEv82LWgLycDF/VppP+KZDUEtaLbGUL1zO2KSr9QbWPN8aFc+
 lRLUI9FmI141/v+985lLmm3oOfEgVbmyl/+U0etuXukfVHrJ2YAISq96Nax93pejvbGmN/R6E
 gMxHU1tztk8Bz8A9z+LMq1SuiZ+fCaWyUv7cz//JBCwF0A7R3amDs1oofWWmGIhZ2woS7knzk
 s2PUnpiym4S4dWsQXv4Nm1q7zRzXDtGcHuwqhdfls7EcfffVnoBSejJk958zKoe9Usl3xWCK1
 /VC9gy9fE8Lu+nU5LxlteBelIwC5h1mcq3slnIylUnNW+FfZ01OCbNerLhuiMZrsRfuOG3j9R
 oySFqVKdqDDE77EVHlxUtZAKaY7H5C/Y74EzN7nfv/c3E2mHSdN7IZHpEbZztPDEqa72lY1Ko
 8jW/nWO+ZzsizP7A//X5ToG2yMsjuCd3Bx4XEbTmCGpgAREI2JI637qz53t4QPAkoNsjSDSKs
 GVIY8zbeF2JUvFkqt5Xx1omS8tFFZKlzcdalZOoMjwUo0ntoXLnDbOtPirWOLhizc1pqZri7Z
 ZnGvPtxhuCnVqCQk9ESm64GpMnDxt0gfXVzKqAu1fYwaMqXdZQAOAw2Jq18zIJuTgzkyl+5Vm
 qNG0l247NeNjdJmxBsYCKJm7kUZFWaEYg7MCEg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The combination of KASAN_STACK and GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
leads to much larger kernel stack usage, as seen from the warnings
about functions that now exceed the 2048 byte limit:

drivers/media/i2c/tvp5150.c:253:1: error: the frame size of 3936 bytes is larger than 2048 bytes
fs/ocfs2/dlm/dlmrecovery.c:737:1: error: the frame size of 2088 bytes is larger than 2048 bytes
fs/ocfs2/aops.c:1892:1: error: the frame size of 2088 bytes is larger than 2048 bytes
fs/ocfs2/namei.c:1677:1: error: the frame size of 2584 bytes is larger than 2048 bytes
fs/ocfs2/super.c:1186:1: error: the frame size of 2640 bytes is larger than 2048 bytes
fs/ocfs2/xattr.c:3678:1: error: the frame size of 2176 bytes is larger than 2048 bytes
net/bridge/br_netlink.c:1505:1: error: the frame size of 2448 bytes is larger than 2048 bytes
net/ieee802154/nl802154.c:548:1: error: the frame size of 2232 bytes is larger than 2048 bytes
net/wireless/nl80211.c:1726:1: error: the frame size of 2224 bytes is larger than 2048 bytes
net/wireless/nl80211.c:6472:1: error: the frame size of 2112 bytes is larger than 2048 bytes
net/wireless/nl80211.c:2357:1: error: the frame size of 4584 bytes is larger than 2048 bytes
net/wireless/nl80211.c:5108:1: error: the frame size of 2760 bytes is larger than 2048 bytes
drivers/media/tuners/r820t.c:1327:1: error: the frame size of 2816 bytes is larger than 2048 bytes

The warnings are distracting, and risking a kernel stack overflow is
generally not beneficial to performance, so it may be best to disallow
that particular combination. This can be done by turning off either
one. I picked the dependency in GCC_PLUGIN_STRUCTLEAK_BYREF_ALL, as
this option is designed to make uninitialized stack usage less harmful
when enabled on its own, but it also prevents KASAN from detecting those
cases in which it was in fact needed.

KASAN_STACK is currently implied by KASAN on gcc, but could be made a
user selectable option if we want to allow combining (non-stack) KASAN
wtih GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.

Note that it woult be possible to specifically address the files that
print the warning, but presumably the overall stack usage is still
significantly higher than in other configurations, so this would not
address the full problem.

I could not test this with CONFIG_INIT_STACK_ALL, which may or may not
suffer from a similar problem.

Fixes: 81a56f6dcd20 ("gcc-plugins: structleak: Generalize to all variable types")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/Kconfig.hardening | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index c6cb2d9b2905..e742d1006a4b 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -73,6 +73,7 @@ choice
 	config GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
 		bool "zero-init anything passed by reference (very strong)"
 		depends on GCC_PLUGINS
+		depends on !(KASAN && KASAN_STACK=1)
 		select GCC_PLUGIN_STRUCTLEAK
 		help
 		  Zero-initialize any stack variables that may be passed
@@ -80,6 +81,10 @@ choice
 		  initialized. This is intended to eliminate all classes
 		  of uninitialized stack variable exploits and information
 		  exposures.
+		  As a side-effect, this keeps a lot of variables on the
+		  stack that can otherwise be optimized out, so combining
+		  this with CONFIG_KASAN_STACK can lead to a stack overflow
+		  and is disallowed.
 
 	config INIT_STACK_ALL
 		bool "0xAA-init everything on the stack (strongest)"
-- 
2.20.0

