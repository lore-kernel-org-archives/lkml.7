Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2807C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFA720663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfDPU2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:28:20 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:45069 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730446AbfDPU2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:28:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mr9O4-1gSXBy2fjy-00oDbO; Tue, 16 Apr 2019 22:27:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v3 14/26] compat_ioctl: move ATYFB_CLK handling to atyfb driver
Date:   Tue, 16 Apr 2019 22:25:35 +0200
Message-Id: <20190416202701.127745-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202701.127745-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202701.127745-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:C0I4iM7ah9sSs/Ga3OL/mLvU4BOuiuy7Hr1XtoBw48wtNdkZ4hG
 VCNkRnN6RAAoin8yeOfVagnup4xtdIwMoHD/ZyPmVfbBu+CW2aeKsfoSLhCmNh4xJh1xlG8
 gAIXYBRAlpS9adxjA1wEA9/lr54iifHYcRnWLKNcH6O+ExkN8Rh86cO9JWbRQQ2ZyunAZ9t
 jN1tujqqGMMIrsLqNff/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qa2ZV3CAEPE=:LnDTKzBXimzs226naIEirp
 DNpnQFXg0OCDzWadb705mrhnMwGUT60bdYU54RTLns2m4gVojBFcoFB2NfBGKljQEbu+v2u6b
 uUkHWwgPKy68miCaLLieghA+ZCKzInxMHLVJ5ncPTsacSkcpWNbr+gfwOFbMLUi6EZR2ZmrNv
 t92nRlHOtk1Vvd67aJM4+fEwO+YzuL6ihp0KQ3V6lqne945LuOOIwEXstQu49SXgUF0f1z0OB
 V7lrAlmE5RfjXln3SV/xVxOmzZk9ajL80d9UfRQJZ8/qT9gMF4tPdVrDgtuB7dOcsX5W1R63X
 c0dHo88D/BzP+DwWngSI5x5v/Gt+308ZRp9OBrcjByzXHuvOuUCyqHhkw7BXg7o5t1GJIs+0k
 3zAXuE8ezSsKUt+5JvYta5w80vBuvOsNun01yhnrhhrkaq0gcNyvir72+tVgsytmV5wW+bLi+
 RlE660ty7LgG2zwYZvkCPa6xydG8D8pI2DsdiUFUnH2C6cY7w8ueZ726Nu5/KJsDQKncotR5a
 nl8SHkARgb2AWwR04zR+49uUrYPnr0i++WyMQAj5/VXaXeT6kgFLxmRlKTvcQW7HotqS9DWWI
 nhay/HU/+3ywUkD6Enpj4eojJ067Bl2Gl0HfCVuzaSvKGI0rysTSZ6tNujr57XVh35nIFZ6xk
 YGw+T0y1oQ4gXu/qYjIaTxd42ZKfOFt3gE5YeNmxrLzdKJhPmOsQKAB+E9VPnKAIigaj68V+9
 GMNE71R48LoRtEv0YWScJ1VEWTEQAEQLW4m37g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are two obscure ioctl commands, in a driver that only
has compatible commands, so just let the driver handle this
itself.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/aty/atyfb_base.c | 12 +++++++++++-
 fs/compat_ioctl.c                    |  2 --
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index b6fe103df145..1bc4b6672fdc 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -48,7 +48,7 @@
 
 ******************************************************************************/
 
-
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
@@ -235,6 +235,13 @@ static int atyfb_pan_display(struct fb_var_screeninfo *var,
 			     struct fb_info *info);
 static int atyfb_blank(int blank, struct fb_info *info);
 static int atyfb_ioctl(struct fb_info *info, u_int cmd, u_long arg);
+#ifdef CONFIG_COMPAT
+static int atyfb_compat_ioctl(struct fb_info *info, u_int cmd, u_long arg)
+{
+	return atyfb_ioctl(info, cmd, (u_long)compat_ptr(arg));
+}
+#endif
+
 #ifdef __sparc__
 static int atyfb_mmap(struct fb_info *info, struct vm_area_struct *vma);
 #endif
@@ -290,6 +297,9 @@ static struct fb_ops atyfb_ops = {
 	.fb_pan_display	= atyfb_pan_display,
 	.fb_blank	= atyfb_blank,
 	.fb_ioctl	= atyfb_ioctl,
+#ifdef CONFIG_COMPAT
+	.fb_compat_ioctl = atyfb_compat_ioctl,
+#endif
 	.fb_fillrect	= atyfb_fillrect,
 	.fb_copyarea	= atyfb_copyarea,
 	.fb_imageblit	= atyfb_imageblit,
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 6eb7a3f51702..a0f230650de2 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -637,8 +637,6 @@ COMPATIBLE_IOCTL(CAPI_CLR_FLAGS)
 COMPATIBLE_IOCTL(CAPI_NCCI_OPENCOUNT)
 COMPATIBLE_IOCTL(CAPI_NCCI_GETUNIT)
 /* Misc. */
-COMPATIBLE_IOCTL(0x41545900)		/* ATYIO_CLKR */
-COMPATIBLE_IOCTL(0x41545901)		/* ATYIO_CLKW */
 COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
-- 
2.20.0

