Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF0BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1493020868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfDPU3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:29:43 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35025 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730441AbfDPU2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:28:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M5Q6l-1hFfrw2wbt-001OVd; Tue, 16 Apr 2019 22:27:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3 16/26] compat_ioctl: move rfcomm handlers into driver
Date:   Tue, 16 Apr 2019 22:25:37 +0200
Message-Id: <20190416202701.127745-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202701.127745-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202701.127745-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Qiho7U3i4gw3R6Dcoyve6xDkcUvHNjZ3HtfY6H3tUIWlqE+XgY/
 yyP4VMnOkoG3uF0UPP8hQk+KNTJTVI+rGSrQrYU6ZSjKL7ubiTRNdaxRc0jQuemCh8nmJ29
 eYy+ztJx1g93COGuAIayP7h4qiMT2zqIH4+fcAkKG8jzm3D0kOCugSqRWB5enjZ3Y8+lbOl
 C+JYvnFgFiMoeqBEcVoIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J1QwsCf9W3g=:8xtgrPo3j5z1afVqLylf0R
 z5/ueFoTfyJTI3soAAg5tNr3EuOXzQfIs3tFHMsLp55hP6qUrFDGiJqdouuLsstZ8XC4/v/ZG
 GiUznrySp4SvxSsLR6Sbi+3Wy/PJ8XXZ9ShNMVXs2VsMmdoHrbBQEwrkYV+3QQVwGgeVAfNBo
 4y4NtTlzAZfVZJ3cvwwjVBxAnm/VbirojoFAXou0is/hjYOjXvd/OxzEABzX4OhQ6K6u/htUO
 crYWOdYkZftKTV8RvuPGFYFDN8w2bR6Uwey/mEK+UhVslHemDgfl4Ki8xsqECpaSb/aBFxDud
 NvhIWtktp59vNDLUYfTjzAj1JbfZAMBVrLp9H4vheeotgoeE98FCaiO/QfOQdfHRNU8/zS41M
 fYATIqnaqrmaWGmNy0AclG6oHLK+bCLjB4mMxcJIjHx83FDmS34udDkUeFxCRgThM1ONFsej0
 DSFLjRSUZ9Cn2oFLjMIwmQN0KI4SiNdxkkQK9Aa+FQhdXihtnCpIcxDI9AG03x12Fr8AHzq3T
 HY8XvCdCd6n3G46x5gpq9dX9/wYkXBO3U21TzrwJO5NlBhYxWFiCl94Ni07OJhuwKhSZG3cou
 Jv/XlLsr4nCXPzFLPZAoCSAhUyG4QNGtmDiVSc2KGz7/kAuBu/p38JI0b1gbmU7awk+DCAa+D
 VZrDxoMlRedlREACNN5J/iVgJzvs45I1TaewrgPOFwjAdvlJ6EKx7anFjd82r490afkbuZDQ3
 6Bxosbg2aALPfaM11eLpunxt1xODTCoz3uDx8g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All these ioctl commands are compatible, so we can handle
them with a trivial wrapper in rfcomm/sock.c and remove
the listing in fs/compat_ioctl.c.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c           |  6 ------
 net/bluetooth/rfcomm/sock.c | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index aad7071eaee0..efe3df389150 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -42,7 +42,6 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_sock.h>
-#include <net/bluetooth/rfcomm.h>
 
 #ifdef CONFIG_BLOCK
 #include <linux/cdrom.h>
@@ -614,11 +613,6 @@ COMPATIBLE_IOCTL(HCIUARTGETPROTO)
 COMPATIBLE_IOCTL(HCIUARTGETDEVICE)
 COMPATIBLE_IOCTL(HCIUARTSETFLAGS)
 COMPATIBLE_IOCTL(HCIUARTGETFLAGS)
-COMPATIBLE_IOCTL(RFCOMMCREATEDEV)
-COMPATIBLE_IOCTL(RFCOMMRELEASEDEV)
-COMPATIBLE_IOCTL(RFCOMMGETDEVLIST)
-COMPATIBLE_IOCTL(RFCOMMGETDEVINFO)
-COMPATIBLE_IOCTL(RFCOMMSTEALDLC)
 /* Misc. */
 COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 90bb53aa4bee..b4eaf21360ef 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -24,7 +24,7 @@
 /*
  * RFCOMM sockets.
  */
-
+#include <linux/compat.h>
 #include <linux/export.h>
 #include <linux/debugfs.h>
 #include <linux/sched/signal.h>
@@ -909,6 +909,13 @@ static int rfcomm_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned lon
 	return err;
 }
 
+#ifdef CONFIG_COMPAT
+static int rfcomm_sock_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
+{
+	return rfcomm_sock_ioctl(sock, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static int rfcomm_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
@@ -1042,7 +1049,10 @@ static const struct proto_ops rfcomm_sock_ops = {
 	.gettstamp	= sock_gettstamp,
 	.poll		= bt_sock_poll,
 	.socketpair	= sock_no_socketpair,
-	.mmap		= sock_no_mmap
+	.mmap		= sock_no_mmap,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= rfcomm_sock_compat_ioctl,
+#endif
 };
 
 static const struct net_proto_family rfcomm_sock_family_ops = {
-- 
2.20.0

