Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513D0C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C55520693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfG3UDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:03:40 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:48349 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfG3UDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:03:39 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Md6V3-1iSR7y0CLz-00aHcj; Tue, 30 Jul 2019 22:03:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 27/29] compat_ioctl: remove /dev/raw ioctl translation
Date:   Tue, 30 Jul 2019 22:01:32 +0200
Message-Id: <20190730200145.1081541-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730200145.1081541-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
 <20190730200145.1081541-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:W4sRNCmwCse+igQstofYbNjuY5tIEp4ixys4++ENhar1qkn8J4E
 As5oNaflN+7FC3Gd6vk+Rp0xB0KIaCBVZGKuE1EXgkSncFodiJ/cHTXzeNyoVwHI3sdfmKh
 BxFERihlEl8gh3GJoI2yjgIkVXqxHxPBJUXfNZ6+bPGY4d9zwJwvbu7VPvX8OZ2FqqQWpxi
 em3+zAolpmkXabnpvblbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:grdhaW8stRg=:4WiG3W5aYSIYYfW7xWa6H0
 vGwey/6NtgcXHYGepmBSIqxYjfQxlRlOJF39y3EngeivyfeVmT6ZmH5W8LVQpHZxwI9Nfykpu
 4ncAzWXuuLPt7Th27VELsWVQAtfhL/bY+54ji4hnbtDaUBfIGvCqUkgVwPwWd+jz3DGSbW8Ou
 obhRBla3MSnaSUn/sa57a1GwnyK5nf44SQzXjQFNDtuHiyWb9pXJnZUzb25jWrHQYTn7K7A8t
 nTJpHxvYIdJ9M4KH61G11oFEKfWxyQ9cQYYtbJjIsKzL9+ua5zHxrQwn5Scr93RzE+xwABGVy
 JqVJeIaopS1lsKZZLXUlVdpd/RFNVRcqP6BLyWVJptN14kYoMSVw3z66TTD3nYVGXh+oSyekj
 rrMxQFDBGAanGmUsD/roPqOwImW78LdXiVMPXA7aOXeLZF6C11uCWFoKOOVaJ4CnRkj3YO6Iq
 TWs8MxOMaZBTjWne+aWBozUDgWqNZbvOv9WT8uVDkfpiB8+oVYQeTaMCo8yIeLiIdi9HoFMtC
 MtE5slB22mqW2nqXM74GKYxZPTR5sIxO9lduuyFu3YJBXH2f7IryM08MVdmwgR6X8NBQcd7yo
 kzzgntjTwIKKU95USU6qSKzy3XYqK55j20FZXivyCnNYlLaLq3IqTWVnU5R0XDOMYRBorKEQw
 Ua0+qZR9V6YGf6fjtqdZqSeKhXVJIDKxr5cqtEpw0qH+5tnQz6GJsMlagDOKQGK0q37QSb6SI
 AF850Dqb4f3Pro85qwqdj/EPPSoPssWQr7B0wA==
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
index 37f45644528a..6070481f2b6a 100644
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
@@ -422,9 +421,6 @@ COMPATIBLE_IOCTL(PPPIOCDISCONN)
 COMPATIBLE_IOCTL(PPPIOCATTCHAN)
 COMPATIBLE_IOCTL(PPPIOCGCHAN)
 COMPATIBLE_IOCTL(PPPIOCGL2TPSTATS)
-/* Raw devices */
-COMPATIBLE_IOCTL(RAW_SETBIND)
-COMPATIBLE_IOCTL(RAW_GETBIND)
 /* Watchdog */
 COMPATIBLE_IOCTL(WDIOC_GETSUPPORT)
 COMPATIBLE_IOCTL(WDIOC_GETSTATUS)
-- 
2.20.0

