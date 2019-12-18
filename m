Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022D2C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AB320717
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfLRQpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:45:50 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:40151 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfLRQpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:45:50 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N3bnP-1hhqcJ2ccd-010bkI; Wed, 18 Dec 2019 17:45:32 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] y2038: sh: remove timeval/timespec usage from headers
Date:   Wed, 18 Dec 2019 17:45:11 +0100
Message-Id: <20191218164527.542823-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DMQ5Nstz2iNQ6VhbEOPaGqLSp/BDXB+L9DaoDSta8r7mGWTx02S
 2d41/T0uymdNKG4hRkAwkDdKuOBvucXRcqSZOtR4jIu2kcUqo9JGMjJluVVq+kOGnWEaSoc
 8so6L6HO3bN1p7SJKhWIlIWXRYaeXMPqI6sZUxGIIdiK6MCN7M7/e+ODxRKz6SQV/UZPRGV
 jOukBrIMaAGCYLshwkvXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0OdFC6eI7iI=:qSLeRvQMk2UrLmt0GS/QaR
 uMLiejva+UUVVQ+nVTJlgrprgYL3i2op9LSNd1rZl422yeDqrO+TIxXgqRU9Gf2b1nUOp9UVI
 FFfgR9Az0FzzKh/8Qt2FhOua9jIf9v4fwQvoaRn3VV9rbssiYrUZZ6rbxsd3Mfse7ybv8CbDn
 MXcZrrK1vG2/oxMr310BU5pIZt+Rq1XIAazKgUwX4ul6W2JFoHC4CxsqD/QwOnkH20HgJ23Bc
 6Djmh5pDTgqpu8NTqh5Y79IyHqw714dy6NJYKW+WA2vtro5jds+CA6fKlq+EULK5UO86cz1gP
 uokZhOt8zuda6gdYMmSLpmcrhrIkDpdD9SWWroOdOsafgqma1z7uaFUwAVwoscuEjXqzg2et9
 XkQQPRfQ8HfKGHYmPRpI0tGEBCBC7X4pGppX9ij7kwl5NyRcq4XHrpOSnfTW2P049z9F4oTcN
 DhCBgHDPuoPksNywDGGMfBX9XtkXt8tKlq8qeLJdMX3P5Orvh3fKt0gjAYkhFrc9Rth9dwQ+B
 L+attDwvtQsgryxWBi5NstpsRI7Ds7Enspy2igEPicq3yj2ytqW2WwzMXEycZ7vSwsU3uNoJA
 6ZL9IbxUHXbgVAwsKsUBYr9Al/KT2R4Tdw6jh4jJiU9/m97NpJnBvFbjCMWRJVyO+JornQkR9
 G9Ahw3MYYK2qrEPwQOv+/iRBRcbkNp7nFLvz3M7ljthhSYQBasJSBM3YfXLtoABMoPlO3Qtb1
 mKAVwxYYz/a+TMd35h6MqHd005NEDP3gs4jqNBOgzODOCV02UEY0Yh3ddjnlP05IS5pfAoizz
 Z6IXwS8PJvxCOAkLj7XNzlpnu2Sindq08PgjDXDDhXh1g7mpRGgNVVCM45jsdmFoC71tXvtgx
 7rwwN6hGNO9MeSi97SNQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header file escaped my earlier cleanups for removing
the in-kernel usage of timeval and timespec structs.

Replace them with the corresponding __kernel_old_* types.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/include/uapi/asm/sockios.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/uapi/asm/sockios.h b/arch/sh/include/uapi/asm/sockios.h
index ef18a668456d..3da561453260 100644
--- a/arch/sh/include/uapi/asm/sockios.h
+++ b/arch/sh/include/uapi/asm/sockios.h
@@ -10,7 +10,7 @@
 #define SIOCSPGRP	_IOW('s', 8, pid_t)
 #define SIOCGPGRP	_IOR('s', 9, pid_t)
 
-#define SIOCGSTAMP_OLD	_IOR('s', 100, struct timeval) /* Get stamp (timeval) */
-#define SIOCGSTAMPNS_OLD _IOR('s', 101, struct timespec) /* Get stamp (timespec) */
+#define SIOCGSTAMP_OLD	_IOR('s', 100, struct __kernel_old_timeval) /* Get stamp (timeval) */
+#define SIOCGSTAMPNS_OLD _IOR('s', 101, struct __kernel_old_timespec) /* Get stamp (timespec) */
 
 #endif /* __ASM_SH_SOCKIOS_H */
-- 
2.20.0

