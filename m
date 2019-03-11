Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC70C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5505321872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfCKPjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:39:48 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:44379 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfCKPjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:39:47 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MnqbU-1giwm43Jla-00pJck; Mon, 11 Mar 2019 16:39:02 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] y2038: fix socket.h header inclusion
Date:   Mon, 11 Mar 2019 16:38:17 +0100
Message-Id: <20190311153857.563743-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hbJOlGFctjSe4uIASWSdvohq94Ci+jZkFRBdQPJ/OWMJENbMYXn
 p6diVLksQqT/wvIECJWQdSwuaOMZWQ0QLFzjm5MOU1cbl3c6MYiCGGsCzyNWZhVkYC5yLtW
 j7YY9/8HEBXDzh06CyrsYWzY4rcFhasLmbxOMaLQpnhqIbb35YmXVq/TcxIo+lwnbjS7SLX
 dnU81YbsyenBlRqPf2TBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B3/mxksVWSY=:xFc7KSzQwv5Vqct67DwByb
 Y3V37JImFVImcC6lns6wFika45ZzzLtkS4UBSIGYozSLVEaegao9d+Lri62jpMdqbvzbEg/hN
 a1Jkcud6zOGJvFz//q330eqeusWDQUIUuBbknFvyaRuMrJerMdvHxozvBh95Ew1ckmBmjP9dq
 WjqyHMh87EoY8X6fo3iQXs2v9jzBynk7L0b5CgpJuK5kyPkDox/BAtkJONXrV1HVFifM8/Atv
 918HtQL0odUeaUK2W4cn1ugP4K0ozbnGoZlBOjP1JKnOgujEnaXkQNPr1CV/uCKH0Njpppl7M
 VF/g7jAysP6M8yZ+cD86ylBPmClnwqdyPGBzvpdgHrZYWlAw2MulW7xZ50462QVbhFd6l++UK
 nQEm8IMZVCSC8GZkGSZH4hbQy+1Eox6MNOuYs05+XbpCqeD+amY6FZkvlPpOq8FAl/Vrb+U8J
 PcHl0SHrlVmpL3Br9dVDhMzgwWhvo1HTTD28Fb2xtb3HNWSzoahJ6dozChNwBbKyDCxJxra0z
 eKfH6Y5tDP1tOk6uWTa65+V0c+6qlRBiEnJ5yOsTSGENByCaToy+H1cBBveNn3FA1IMsFNMqO
 RDyITVHC2Md4U/CccXrqXzB79w1JVo9xGX1SbC4RyxIBhljt3EqZHLZdzF58i96PLf1Gl23I6
 43FXfE5KyL6BM1/sdHTbVdiRxmn/q2d2vFvFC1hCncdExKo2jRCoLYvU2VcxX/XKcEIvDsKgn
 z3QzZdIagN6UJkMY4ckBxcahLZ1E5+7FhPABuw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Referencing the __kernel_long_t type caused some user space applications
to stop compiling when they had not already included linux/posix_types.h,
e.g.

s/multicast.c -o ext/sockets/multicast.lo
In file included from /builddir/build/BUILD/php-7.3.3/main/php.h:468,
                 from /builddir/build/BUILD/php-7.3.3/ext/sockets/sockets.c:27:
/builddir/build/BUILD/php-7.3.3/ext/sockets/sockets.c: In function 'zm_startup_sockets':
/builddir/build/BUILD/php-7.3.3/ext/sockets/sockets.c:776:40: error: '__kernel_long_t' undeclared (first use in this function)
  776 |  REGISTER_LONG_CONSTANT("SO_SNDTIMEO", SO_SNDTIMEO, CONST_CS | CONST_PERSISTENT);

It is safe to include that header here, since it only contains kernel
internal types that do not conflict with other user space types.

It's still possible that some related build failures remain, but those
are likely to be for code that is not already y2038 safe.

Reported-by: Laura Abbott <labbott@redhat.com>
Fixes: a9beb86ae6e5 ("sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/uapi/asm/socket.h  | 2 +-
 arch/mips/include/uapi/asm/socket.h   | 2 +-
 arch/parisc/include/uapi/asm/socket.h | 2 +-
 arch/sparc/include/uapi/asm/socket.h  | 2 +-
 include/uapi/asm-generic/socket.h     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 0d0fddb7e738..976e89b116e5 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -2,8 +2,8 @@
 #ifndef _UAPI_ASM_SOCKET_H
 #define _UAPI_ASM_SOCKET_H
 
+#include <linux/posix_types.h>
 #include <asm/sockios.h>
-#include <asm/bitsperlong.h>
 
 /* For setsockopt(2) */
 /*
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index eb9f33f8a8b3..d41765cfbc6e 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -10,8 +10,8 @@
 #ifndef _UAPI_ASM_SOCKET_H
 #define _UAPI_ASM_SOCKET_H
 
+#include <linux/posix_types.h>
 #include <asm/sockios.h>
-#include <asm/bitsperlong.h>
 
 /*
  * For setsockopt(2)
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 16e428f03526..66c5dd245ac7 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -2,8 +2,8 @@
 #ifndef _UAPI_ASM_SOCKET_H
 #define _UAPI_ASM_SOCKET_H
 
+#include <linux/posix_types.h>
 #include <asm/sockios.h>
-#include <asm/bitsperlong.h>
 
 /* For setsockopt(2) */
 #define SOL_SOCKET	0xffff
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 88fe4f978aca..9265a9eece15 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -2,8 +2,8 @@
 #ifndef _ASM_SOCKET_H
 #define _ASM_SOCKET_H
 
+#include <linux/posix_types.h>
 #include <asm/sockios.h>
-#include <asm/bitsperlong.h>
 
 /* For setsockopt(2) */
 #define SOL_SOCKET	0xffff
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index c8b430cb6dc4..8c1391c89171 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -2,8 +2,8 @@
 #ifndef __ASM_GENERIC_SOCKET_H
 #define __ASM_GENERIC_SOCKET_H
 
+#include <linux/posix_types.h>
 #include <asm/sockios.h>
-#include <asm/bitsperlong.h>
 
 /* For setsockopt(2) */
 #define SOL_SOCKET	1
-- 
2.20.0

