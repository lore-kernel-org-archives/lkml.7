Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A79C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5064520663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbfDPU2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:28:47 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730442AbfDPU2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:28:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MlNgx-1gZyGk3BEr-00llxR; Tue, 16 Apr 2019 22:27:55 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3 17/26] compat_ioctl: move hci_sock handlers into driver
Date:   Tue, 16 Apr 2019 22:25:38 +0200
Message-Id: <20190416202701.127745-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202701.127745-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202701.127745-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wVrrxHykN4m2wuv4wYPBq2QrDsrHr9makxgNyqWbgjd+bJpateF
 2WUZMhf20F9hdOvX/sNasRpmVnG2PfnLG6yidhtLbo8vRU1lerMkZq96jvaIfsjcqSjb+1P
 bQN6Y8Fr6S8vIJxT2FRCR8xfnPokm5YOLAa598BvzLR6ojgJ3wAj08WCRO6QO8kA5Wy/cq8
 e9T5GQWp3jJ6mKXF+MRMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KwnzaPtod3Q=:/jbjy/rdACzfKB/hEu3lc7
 g5wAhER3Di/By6pnDEPrwGhMjilM3HgmBA6Xn8rzEr5A3xRVRRa70f0UtyYo4h68Z/7Dirj6H
 2VLGR29iJLoM9yeubBbcwkx5pLP+rg84ZoFRJNtwOg4tZVUZyI3rTQkEzsRZVhICJ1COi0Cp/
 eCFM+//PMCuAm7e7JhhO5u/VLM1mGu+cuH3V27dsoIcvPfwTa/LT8rxcfB7W8I0W7Ni7VWQY5
 xcVIpqb3PopkvORvH8FCKJNR9IjpZqnGe2X8qbxGjtLRNpIZ/Lc6eKXjM06jWtfzplup4N8kP
 iP2KpvAfcTaiDOZ1Hl/sI/qqpEBASc1Gz2KFWlPruUswAW63gqdhJqeXfMXcEJxKnytIaEgLe
 ftzIVNT73mUNJt35tX8AWuZSUxbWGOiRJLtWXMaEbrcZg3s00tI0x4N/FcAFhZ8qzULO6jvdW
 vLeMzU4eLWeUOVJRNlC3hxnXRmzi4nqhdaTxKcqGsJ6btAc0fkXwW/Buspj5QnRipWpxf6DKm
 HUIQjI6cWGzoce1PNSvJGTtyf6VFM2owCN3ROxBExHCoUBpeU/wzW5Q/cEIVkwkNKv+UUxwQk
 scNmZOxp8u8LLCV17r5LBZQxssa/tLaxKj8z3ZxtHnHKlPcjj6khrvA5dWmhyaxMBzCArzeLC
 sxu+NbMZ8s/UNjQd8vC96mUmHz15/g4J81oYTdzQ8c51M7jAaASWZ4lSGgVrAwwJwJbHkm9lj
 8IJYoQ1CpcDjrKvopUbxuSlc//BVPkmiZ6du3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All these ioctl commands are compatible, so we can handle
them with a trivial wrapper in hci_sock.c and remove
the listing in fs/compat_ioctl.c.

A few of the commands pass integer arguments instead of
pointers, so for correctness skip the compat_ptr() conversion
here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c        | 24 ------------------------
 net/bluetooth/hci_sock.c | 21 ++++++++++++++++++++-
 2 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index efe3df389150..9024cae05eda 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -40,9 +40,6 @@
 
 #include "internal.h"
 
-#include <net/bluetooth/bluetooth.h>
-#include <net/bluetooth/hci_sock.h>
-
 #ifdef CONFIG_BLOCK
 #include <linux/cdrom.h>
 #include <linux/fd.h>
@@ -587,27 +584,6 @@ COMPATIBLE_IOCTL(RNDADDENTROPY)
 COMPATIBLE_IOCTL(RNDZAPENTCNT)
 COMPATIBLE_IOCTL(RNDCLEARPOOL)
 /* Bluetooth */
-COMPATIBLE_IOCTL(HCIDEVUP)
-COMPATIBLE_IOCTL(HCIDEVDOWN)
-COMPATIBLE_IOCTL(HCIDEVRESET)
-COMPATIBLE_IOCTL(HCIDEVRESTAT)
-COMPATIBLE_IOCTL(HCIGETDEVLIST)
-COMPATIBLE_IOCTL(HCIGETDEVINFO)
-COMPATIBLE_IOCTL(HCIGETCONNLIST)
-COMPATIBLE_IOCTL(HCIGETCONNINFO)
-COMPATIBLE_IOCTL(HCIGETAUTHINFO)
-COMPATIBLE_IOCTL(HCISETRAW)
-COMPATIBLE_IOCTL(HCISETSCAN)
-COMPATIBLE_IOCTL(HCISETAUTH)
-COMPATIBLE_IOCTL(HCISETENCRYPT)
-COMPATIBLE_IOCTL(HCISETPTYPE)
-COMPATIBLE_IOCTL(HCISETLINKPOL)
-COMPATIBLE_IOCTL(HCISETLINKMODE)
-COMPATIBLE_IOCTL(HCISETACLMTU)
-COMPATIBLE_IOCTL(HCISETSCOMTU)
-COMPATIBLE_IOCTL(HCIBLOCKADDR)
-COMPATIBLE_IOCTL(HCIUNBLOCKADDR)
-COMPATIBLE_IOCTL(HCIINQUIRY)
 COMPATIBLE_IOCTL(HCIUARTSETPROTO)
 COMPATIBLE_IOCTL(HCIUARTGETPROTO)
 COMPATIBLE_IOCTL(HCIUARTGETDEVICE)
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index d32077b28433..5d0ed28c0d3a 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -23,7 +23,7 @@
 */
 
 /* Bluetooth HCI sockets. */
-
+#include <linux/compat.h>
 #include <linux/export.h>
 #include <linux/utsname.h>
 #include <linux/sched.h>
@@ -1054,6 +1054,22 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 	return err;
 }
 
+#ifdef CONFIG_COMPAT
+static int hci_sock_compat_ioctl(struct socket *sock, unsigned int cmd,
+				 unsigned long arg)
+{
+	switch (cmd) {
+	case HCIDEVUP:
+	case HCIDEVDOWN:
+	case HCIDEVRESET:
+	case HCIDEVRESTAT:
+		return hci_sock_ioctl(sock, cmd, arg);
+	}
+
+	return hci_sock_ioctl(sock, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			 int addr_len)
 {
@@ -1974,6 +1990,9 @@ static const struct proto_ops hci_sock_ops = {
 	.sendmsg	= hci_sock_sendmsg,
 	.recvmsg	= hci_sock_recvmsg,
 	.ioctl		= hci_sock_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= hci_sock_compat_ioctl,
+#endif
 	.poll		= datagram_poll,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
-- 
2.20.0

