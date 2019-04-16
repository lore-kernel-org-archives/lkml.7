Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0C7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE50720663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfDPU3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:29:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:53459 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730848AbfDPU24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:28:56 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MVv8f-1hOVTH1lqP-00RnRe; Tue, 16 Apr 2019 22:28:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 25/26] compat_ioctl: remove /dev/raw ioctl translation
Date:   Tue, 16 Apr 2019 22:28:10 +0200
Message-Id: <20190416202839.248216-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202839.248216-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202839.248216-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NKIzQHvuacGsem/0YDjZ3Izh6l5C5RHpSzcw7X9OoSF6amjB0YN
 Rv4RXuFB9buqWJ4GsMEJQE+YxpgX8c1r+5XmCA5sxNENCibx9F2/boVq9R9nytEvRR1DChd
 GAqsPIVH+O5yK1QJbxmNC8VnQX2NhlBwa/clejshWUS09LL/kjkc80ee/jP+H+thdSWpdWF
 f2tFbVe+J8k4tQwLJOtpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5kUueMKFZno=:58w6mRrXu4tJlh6xNrUKvO
 Y74U2UcO9xkjcJAX4FpJCMVGz+otAYlcQ9FwVvy5Qhbh7l5BWde6fM0Ak3Qew15v0ovrIITVH
 jH6I9J4p/bK+Vi3LXQqz+zBxTExYYpO0VQJ7U/rBJT1JW0vrU2yRJjH45WrAsq8rMytlSYUk9
 TIFVMwPxKwpDbFHV6YExRDoEfkQDlZvOjY+YVbaw34LT6BDpCej6zVH84xW6ocJkyMgqV6AfG
 FsGZZKLt/tQK64Q6f5XJOGhHQizJ8cVT7xK60wVUEbrgyfx+fku78IMwP4f39RgaqHl1IL4O3
 YUvKQattficKKnhsH0Pv6468eDY5KwIKUQdCgA1EBzcSYW5ztYq4v8V6GrYa03tZZVs2F8l27
 rVDt2PGh9xvzE94npPZJag1CAJWrLK6xty/QFoiAM1GvzbI9zfYVT41gFN1lEPl7ymbgQ/v9q
 e1uGxFnxiheSfq1krRUhNjL3aG3ITT0+J1wBcNQW4rJAun6onCo82iyuBpcOUWkNZ5tK90Zjl
 9uNPiwtCNa9AR0KqySXOEcWvJfQ+qxftfYeDPCQwHmWstgi2BJdIesCzA+FTMXPYWSn0YgdU1
 uZo4hwIyB77UNT3ncxwFjvXQ0bViRzhWjRF1zqKa7s9Ul+1VU4Mjkl1oQYYft1MiZzYX2+GvX
 FMFr681BwG/a85FS6b/mIl0zvYSDgTBrd+vX7QXdLn/QBsM3SULLHUjM5ySFxg6fPQ4WcaJeY
 yDPyARokE0O5S6NGzVBTvd9UMOUGyTb/qsssqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /dev/rawX implementation already handles these just fine, so
the entries in the table are not needed any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 6ad45550b4b1..63de00cc85df 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -27,7 +27,6 @@
 #include <linux/if_pppox.h>
 #include <linux/tty.h>
 #include <linux/vt_kern.h>
-#include <linux/raw.h>
 #include <linux/blkdev.h>
 #include <linux/serial.h>
 #include <linux/ctype.h>
@@ -363,9 +362,6 @@ COMPATIBLE_IOCTL(SG_GET_KEEP_ORPHAN)
 /* PPP stuff */
 COMPATIBLE_IOCTL(PPPIOCGUNIT)
 COMPATIBLE_IOCTL(PPPIOCGCHAN)
-/* Raw devices */
-COMPATIBLE_IOCTL(RAW_SETBIND)
-COMPATIBLE_IOCTL(RAW_GETBIND)
 /* Watchdog */
 COMPATIBLE_IOCTL(WDIOC_GETSUPPORT)
 COMPATIBLE_IOCTL(WDIOC_GETSTATUS)
-- 
2.20.0

