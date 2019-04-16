Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC45C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039A520880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbfDPU16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:27:58 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:42899 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDPU16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:27:58 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MN5W7-1hXLF301gL-00J3uz; Tue, 16 Apr 2019 22:27:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Karsten Keil <isdn@linux-pingi.de>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Subject: [PATCH v3 15/26] compat_ioctl: move isdn/capi ioctl translation into driver
Date:   Tue, 16 Apr 2019 22:25:36 +0200
Message-Id: <20190416202701.127745-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202701.127745-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202701.127745-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1bxM3e87OBzkJ6OS+1ph95JDJYqy+l2IJieZER7kPSnMsUHHrCu
 avKu5ym+rekQQZIXiHGTDQt5mW+p2+0Ac/77OuC3gAik20i7aNmKCy8tzK0uqPfot4u/jki
 tPc2vHZpilSKBeW9R0rMzYLEGtADy5mZDjjBQ3p7dnUdY8BxvZXy9Ncrggj+AiY/FAuX/09
 ijb3t/gkG9/l/S38Hx+2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6IgTMv+EaAY=:Sby968aWJG/anO758O8t4n
 snkQQzG5HE+Gusu7iAQuFceZwkcjE8AR//RVJEkCLRjcT+sFK3h/e+1Wg8Mwdcuq9vEe4jB+n
 /oB+1dzuEgAzJjPydE4H49R2mKCpy/pWAUZ+PxgnL8GZyIDsB06Mmx9ccIHGfdB0lx9hSSs34
 zUB33bfjsY2IgfiHoAE3GLTH6ygdKfxISjc9hDw9gUPJDhjhdXEYxFnkIAkx1AMr9DHajdgMB
 oTBnk6O45gqPuabz15hrFlmhJe0kdfzIn4BPbNvGVyMa8HhfG5/LU+epwAO6++Z1ArIM8o9e3
 3EjIoiIPMzJVno0qEFlg1WD3OkaootzhSI7er/TkUSKRtT7NiDzw+0w6ZWUiqAhws3ABy6Z9x
 MxacVIjQeWRIwPlc2eEbLHQvjOxfqRC4QPZCIDC5hsB4qBETGeEFZm8DHQvN7CB0RcOJAP+m5
 jzu7Mp3scd+rW2fy71FDZaQ31LzxUE5tbnTg8+mvWsDf0xMrbyk4Vr2F7RrX92vxz9T/UuPQd
 qvQccR+EJHteB9SlLoTxSzUd/pOOYcjOMTcrpm2UYeWtEa+gzEubC4UoYYMCRMAOY/GOBZ+gD
 RJPTDGtg5AvpX2AMIOSke3ZvCkW3fuiOIWQYYEmjFF68Q0o7h1PskI1ELyPqBxGDd258mec2T
 65teQIztruHaReaEqlf83LqUd6xtWmjvGx01+MnqsroeerNpYOZS7KRkvYb63AwdM3cin7wDL
 BjNQfhHXj27dbZj43qs1CZN85JyvE55uvnE1/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither the old isdn4linux interface nor the newer mISDN stack
ever had working 32-bit compat mode as far as I can tell.

However, the CAPI stack has some ioctl commands that are
correctly listed in fs/compat_ioctl.c.

We can trivially move all of those into the corresponding
file that implement the native handlers by adding a compat_ioctl
redirect to that.

I did notice that treating CAPI_MANUFACTURER_CMD() as compatible
is broken, so I'm also adding a handler for that, realizing that
in all likelyhood, nobody is ever going to call it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/isdn/capi/capi.c | 31 +++++++++++++++++++++++++++++++
 fs/compat_ioctl.c        | 17 -----------------
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index e1da70a9530c..744cfdeb9ecf 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -942,6 +942,34 @@ capi_unlocked_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return ret;
 }
 
+#ifdef CONFIG_COMPAT
+static long
+capi_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int ret;
+
+	if (cmd == CAPI_MANUFACTURER_CMD) {
+		struct {
+			unsigned long cmd;
+			compat_uptr_t data;
+		} mcmd32;
+
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (copy_from_user(&mcmd32, compat_ptr(arg), sizeof(mcmd32)))
+			return -EFAULT;
+
+		mutex_lock(&capi_mutex);
+		ret = capi20_manufacturer(mcmd32.cmd, compat_ptr(mcmd32.data));
+		mutex_unlock(&capi_mutex);
+
+		return ret;
+	}
+
+	return capi_unlocked_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static int capi_open(struct inode *inode, struct file *file)
 {
 	struct capidev *cdev;
@@ -988,6 +1016,9 @@ static const struct file_operations capi_fops =
 	.write		= capi_write,
 	.poll		= capi_poll,
 	.unlocked_ioctl	= capi_unlocked_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= capi_compat_ioctl,
+#endif
 	.open		= capi_open,
 	.release	= capi_release,
 };
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index a0f230650de2..aad7071eaee0 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -44,9 +44,6 @@
 #include <net/bluetooth/hci_sock.h>
 #include <net/bluetooth/rfcomm.h>
 
-#include <linux/capi.h>
-#include <linux/gigaset_dev.h>
-
 #ifdef CONFIG_BLOCK
 #include <linux/cdrom.h>
 #include <linux/fd.h>
@@ -622,20 +619,6 @@ COMPATIBLE_IOCTL(RFCOMMRELEASEDEV)
 COMPATIBLE_IOCTL(RFCOMMGETDEVLIST)
 COMPATIBLE_IOCTL(RFCOMMGETDEVINFO)
 COMPATIBLE_IOCTL(RFCOMMSTEALDLC)
-/* CAPI */
-COMPATIBLE_IOCTL(CAPI_REGISTER)
-COMPATIBLE_IOCTL(CAPI_GET_MANUFACTURER)
-COMPATIBLE_IOCTL(CAPI_GET_VERSION)
-COMPATIBLE_IOCTL(CAPI_GET_SERIAL)
-COMPATIBLE_IOCTL(CAPI_GET_PROFILE)
-COMPATIBLE_IOCTL(CAPI_MANUFACTURER_CMD)
-COMPATIBLE_IOCTL(CAPI_GET_ERRCODE)
-COMPATIBLE_IOCTL(CAPI_INSTALLED)
-COMPATIBLE_IOCTL(CAPI_GET_FLAGS)
-COMPATIBLE_IOCTL(CAPI_SET_FLAGS)
-COMPATIBLE_IOCTL(CAPI_CLR_FLAGS)
-COMPATIBLE_IOCTL(CAPI_NCCI_OPENCOUNT)
-COMPATIBLE_IOCTL(CAPI_NCCI_GETUNIT)
 /* Misc. */
 COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
-- 
2.20.0

