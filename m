Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C52FC7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11513223BE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NZoqfZaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733076AbfGWKVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:21:40 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:16686 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfGWKVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:21:40 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6NAL83r014462;
        Tue, 23 Jul 2019 19:21:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6NAL83r014462
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563877268;
        bh=leBBnmZaRTGH097gPwPQUaUdmJKXHcG6CKmg6v6AlGQ=;
        h=From:To:Cc:Subject:Date:From;
        b=NZoqfZaKNjamoIrwCcuBndO2rk9EG8AZ+t8JvIqjyPUsbWD+MQ4TMY3DvzyD9bty9
         8l1Vh455grWjoOFBWOmmpVU0HRIrwHslpj4YwqhtSeilNSE+AXegcHDzzryu6NIXf7
         MLDPsx+iqzJxWTdf/9kIeJwmpYVqQDCm/Y/Cna1d0PfbM0TIjQca1YQlUwKaC8Jtq7
         lHvhz0TiuFHyhiGTIg9ZYeslN40EFJoQ0WqDT5XHZu/PVVUWa1h8/7raUunQ9+ATOF
         7kP2dZn0CkLYrb69JN7dLNhHN8mLz1hXFeg5HUVrj3a/oFpJe/Y3P61iVA1k7bARYf
         6iYUwp3nSTY+A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] h8300: move definition of  __kernel_size_t etc. to posix_types.h
Date:   Tue, 23 Jul 2019 19:21:06 +0900
Message-Id: <20190723102106.11375-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These types should be defined in posix_types.h, not in bitsperlong.h .

With these defines moved, h8300-specific bitsperlong.h is no longer
needed since Kbuild will automatically create a wrapper of
include/uapi/asm-generic/bitsperlong.h

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/h8300/include/uapi/asm/bitsperlong.h | 15 ---------------
 arch/h8300/include/uapi/asm/posix_types.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 15 deletions(-)
 delete mode 100644 arch/h8300/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/h8300/include/uapi/asm/posix_types.h

diff --git a/arch/h8300/include/uapi/asm/bitsperlong.h b/arch/h8300/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index a33e358f1c1b..000000000000
--- a/arch/h8300/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI__ASM_H8300_BITS_PER_LONG
-#define _UAPI__ASM_H8300_BITS_PER_LONG
-
-#include <asm-generic/bitsperlong.h>
-
-#if !defined(__ASSEMBLY__)
-/* h8300-unknown-linux required long */
-#define __kernel_size_t __kernel_size_t
-typedef unsigned long	__kernel_size_t;
-typedef long		__kernel_ssize_t;
-typedef long		__kernel_ptrdiff_t;
-#endif
-
-#endif /* _UAPI__ASM_H8300_BITS_PER_LONG */
diff --git a/arch/h8300/include/uapi/asm/posix_types.h b/arch/h8300/include/uapi/asm/posix_types.h
new file mode 100644
index 000000000000..3efc9dd59476
--- /dev/null
+++ b/arch/h8300/include/uapi/asm/posix_types.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_POSIX_TYPES_H
+#define _UAPI_ASM_POSIX_TYPES_H
+
+/* h8300-unknown-linux required long */
+#define __kernel_size_t __kernel_size_t
+typedef unsigned long	__kernel_size_t;
+typedef long		__kernel_ssize_t;
+typedef long		__kernel_ptrdiff_t;
+
+#include <asm-generic/posix_types.h>
+
+#endif /* _UAPI_ASM_POSIX_TYPES_H */
-- 
2.17.1

