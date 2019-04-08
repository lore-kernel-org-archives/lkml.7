Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E40C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17B420857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfDHV2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:28:43 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54375 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfDHV2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:28:43 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mn2Fb-1gViE70viR-00k6NX; Mon, 08 Apr 2019 23:28:36 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] s390: syscall_wrapper: avoid clang warning
Date:   Mon,  8 Apr 2019 23:26:21 +0200
Message-Id: <20190408212648.2407234-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a7z6K92Aqxd+6jYl8kxTzV0/4l7UDWHqxrRdCWm4WIz1hRaB51E
 JCrx4Cn3T9QAALoQ1tdC5DCiQvUN4GM4cwmos2Nsk5Ji3yi4TknMztqTJFJimP0/pWcv7Nd
 l0OwAiPftnJ7oNUu2azun8bJ+WRIFer3ER/Pwdv6ycmqP0dI6AXp9TU6msH8KOoI0c85bcZ
 wI8q/jtMMSfpDWJsDVE1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xiKi11OGdTE=:XRlwXMab1lwX6qPWoGlUS4
 8PUxGXiRdSCedrtjZ0Fo33+KPKB9jshAx1gI2WuBFwdysBHulFDP14eOie3uM2n8HcRQrM+SE
 g5OyKVWNAETGbMk4EZBtm7n+LodH5/1ErIo2/s/pP+oOCZE6A+bDFE09utB0JK4mJa8khpfap
 jw9H2b36eEjYLTbAFcXRLmbnu35hdxq4t4Iex7ckBDPz7K4XJxXzNMEVae3LXtF6vY2f4/Z9K
 +E0cb9iMNlPNxJk+g+BGS8AS6YiVjhWHpB9VZKlhj0gZXmcOg1TNKT9k1z2NRBy6s2fYa5Q7q
 CZoiRZahqliFFfhWkOH/LK9+VhkFE0w5GVlzT2i07LERaHyTV1j2GfGLE/o4qa31HuEqb/Be1
 7veeHn6Tz/B3MaOnfVZ68H9/WYTw0eVkwF+anp+qM8w2u/JPbM58bjnKoICyx95MZEnq3ggU4
 LiEuPjtxPEZE4Fd0xx604XyPVKimGdIdgHT96ZhIH0kAscz7ZzYi8EYg9e70eTFMIw/0zr6qz
 6uG57r98TDP0G4hTmf7s7OKEgLYzKsx+UEkQ+v0nHh7PWtuT+7cY3qpZYKK/TUY8whFanCbk0
 J3/D3h2k5Uc4HkZ7eUjhSmjfSFJQQsdGRuY/qtGSdA2/D/XVxxvVJt17gB3SUbPmd+fhvJrSj
 QL1bFrktKha6I+I7hp4qNYxLoi5AAOR5czIfLLw3jZ073qpstw8pqpKH8BSgar4dU1Tp+LVqv
 9XDxyKakz51C/FAzyZ0/xAvisAghsY7ZNvfEoQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building system calls with clang results in a warning
about an alias from a global function to a static one:

../fs/namei.c:3847:1: warning: unused function '__se_sys_mkdirat' [-Wunused-function]
SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
^
../include/linux/syscalls.h:219:36: note: expanded from macro 'SYSCALL_DEFINE3'
 #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                   ^
../include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
        __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
        ^
../arch/s390/include/asm/syscall_wrapper.h:126:18: note: expanded from macro '__SYSCALL_DEFINEx'
        asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))          \
                        ^
<scratch space>:31:1: note: expanded from here
__se_sys_mkdirat
^

The only reference to the static __se_sys_mkdirat() here is the alias, but
this only gets evaluated later. Making this function global as well avoids
the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I considered opening a bug report for llvm here, but I suspect the
behavior is intentional, so I'm just fixing it here. Let me know if
you disagree.
---
 arch/s390/include/asm/syscall_wrapper.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/syscall_wrapper.h b/arch/s390/include/asm/syscall_wrapper.h
index 5596c5c625d2..3c3d6fe8e2f0 100644
--- a/arch/s390/include/asm/syscall_wrapper.h
+++ b/arch/s390/include/asm/syscall_wrapper.h
@@ -119,8 +119,8 @@
 		      "Type aliasing is used to sanitize syscall arguments");\
 	asmlinkage long __s390x_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(__se_sys##name))));		\
-	ALLOW_ERROR_INJECTION(__s390x_sys##name, ERRNO);				\
-	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
+	ALLOW_ERROR_INJECTION(__s390x_sys##name, ERRNO);			\
+	long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));			\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
 	__S390_SYS_STUBx(x, name, __VA_ARGS__)					\
 	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
-- 
2.20.0

