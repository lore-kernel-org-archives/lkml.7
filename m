Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828CFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5357F20663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfDPUVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:21:52 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:46449 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbfDPUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:21:47 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MK5BG-1hYhvb2HTK-00LYy0; Tue, 16 Apr 2019 22:21:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Subject: [PATCH v3 07/26] compat_ioctl: move rtc handling into rtc-dev.c
Date:   Tue, 16 Apr 2019 22:19:45 +0200
Message-Id: <20190416202013.4034148-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202013.4034148-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:B2ClSMSiEFlnaEEi3ndg7yav6kA3YQMp22nXP4yMYACDK4GCVb8
 so8/3NOd0R8UETnhaAWoNo8PJueRe4PlnmV/ESRHVb3ZnuTV5i0rkpbg5tGVq6jeY3MfCJo
 KONeeBv5yswcOlSgGCwuYRDAJLVMmi0N+iCoOX88gKvK6v6vqiPXb9upPHvJu3hptAjzTpl
 7S7kIEa+X35b9UoxeZu5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0MmAwt7Sbvk=:fEf2j0EDW7jMOmEKI61Onk
 /uMt4yFXfPUDC7H4WXsovokdtvCOqDjm6IRHEvf4NYW3a/7GaCwJDf/3Ol+Pt5UwAEvBSQe8t
 OEposH/RXVTu0ClMzs0XJCZvW8fzHX73ugPoirOpNOyaX4IXHCxhnLx3S1Llx30mPFm98bRL7
 t55yZp4xJnlRHsTKBp6RGd5SiAeBVuJX+QgITzgCiwUQRyNAkNl0BmqpEeN1Sx7q1EfKYkK0I
 0CbczoMSrnbTnX+CZLsHjg3rMpqfdevS143P1REMXfveYLfQYRc8XeyRWsEzOtnSlZSS13ilJ
 OGrUCB2767hNAr1W7Jy9fxX+WRSE0NLbUiaRCX8PV7js/RAQHYG8ibFCk8G7C2ianjgNu6w2z
 K64IkyPiss326rAkjXrkOEdqYjp0kx12/hNbKVPYTP7bXR9JvQ+LlUhddRT9z7Mn5B8RojJ59
 NbgzhqenuM+Kcw8PFMuo3A6A3JclLy1pde+oP0UF/wDyfEvr8jYsHi+lbVQa0hZ5MJF0LF+l1
 MRiTB4Zw3aDerVOrWdxaxYWSjG3fr1uwv8QmowYuhsWD0adelfl6/+jnuyXZ4b1fmvzTLWkE5
 jnqO/QnFYJgsDUGdxOhKQq21e2c9ByLOR9HITFiKHtyMXg3EzlnBByF6rSSZW/OUHHEfm7JCf
 8stZMR4cVAzwcEVek1O9IFmr7nIsOlfPRM0o5g1B8yyYeFUDZkTTWO6il8Jj7LDU9mBvJ8MQu
 Oab33A9/ZJL/xvy/JnrRQUqyOADHsS46zhjoDQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We no longer need the rtc compat handling to be in common code, now that
all drivers are either moved to the rtc-class framework, or (rarely)
exist in drivers/char for architectures without compat mode (m68k,
alpha and ia64, respectively).

I checked the list of ioctl commands in drivers, and the ones that are
not already handled are all compatible, again with the one exception of
m68k driver, which implements RTC_PLL_GET and RTC_PLL_SET, but has no
compat mode.

Since the ioctl commands are either compatible or differ in both structure
and command code between 32-bit and 64-bit, we can merge the compat
handler into the native one and just implement the two common compat
commands (RTC_IRQP_READ, RTC_IRQP_SET) there. The result is a slight
change in behavior, as a native 64-bit process will now also handle the
32-bit commands (RTC_IRQP_SET32/RTC_IRQP_SET).

The old conversion handler also deals with RTC_EPOCH_READ and
RTC_EPOCH_SET, which are not handled in rtc-dev.c but only in a single
device driver (rtc-vr41xx), so I'm adding the compat version in the same
place. I don't expect other drivers to need those commands in the future.

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: merge compat handler into ioctl function to avoid the
    compat_alloc_user_space() roundtrip, based on feedback
    from Al Viro.
---
 drivers/rtc/dev.c        | 13 ++++++++-
 drivers/rtc/rtc-vr41xx.c | 10 +++++++
 fs/compat_ioctl.c        | 61 ++--------------------------------------
 3 files changed, 25 insertions(+), 59 deletions(-)

diff --git a/drivers/rtc/dev.c b/drivers/rtc/dev.c
index 1d006ef4bb57..a63779ccc8aa 100644
--- a/drivers/rtc/dev.c
+++ b/drivers/rtc/dev.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/sched/signal.h>
@@ -359,10 +360,19 @@ static long rtc_dev_ioctl(struct file *file,
 		mutex_unlock(&rtc->ops_lock);
 		return rtc_update_irq_enable(rtc, 0);
 
+#ifdef CONFIG_64BIT
+#define RTC_IRQP_SET32		_IOW('p', 0x0c, __u32)
+#define RTC_IRQP_READ32		_IOR('p', 0x0b, __u32)
+	case RTC_IRQP_SET32:
+		err = rtc_irq_set_freq(rtc, arg);
+		break;
+	case RTC_IRQP_READ32:
+		err = put_user(rtc->irq_freq, (unsigned int __user *)uarg);
+		break;
+#endif
 	case RTC_IRQP_SET:
 		err = rtc_irq_set_freq(rtc, arg);
 		break;
-
 	case RTC_IRQP_READ:
 		err = put_user(rtc->irq_freq, (unsigned long __user *)uarg);
 		break;
@@ -434,6 +444,7 @@ static const struct file_operations rtc_dev_fops = {
 	.read		= rtc_dev_read,
 	.poll		= rtc_dev_poll,
 	.unlocked_ioctl	= rtc_dev_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= rtc_dev_open,
 	.release	= rtc_dev_release,
 	.fasync		= rtc_dev_fasync,
diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index e66d0f63cee2..62c16a3b2d5c 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/compat.h>
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/init.h>
@@ -79,6 +80,10 @@ static void __iomem *rtc2_base;
 #define rtc2_read(offset)		readw(rtc2_base + (offset))
 #define rtc2_write(offset, value)	writew((value), rtc2_base + (offset))
 
+/* 32-bit compat for ioctls that nobody else uses */
+#define RTC_EPOCH_READ32	_IOR('p', 0x0d, __u32)
+#define RTC_EPOCH_SET32		_IOW('p', 0x0e, __u32)
+
 static unsigned long epoch = 1970;	/* Jan 1 1970 00:00:00 */
 
 static DEFINE_SPINLOCK(rtc_lock);
@@ -192,6 +197,11 @@ static int vr41xx_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long
 	switch (cmd) {
 	case RTC_EPOCH_READ:
 		return put_user(epoch, (unsigned long __user *)arg);
+#ifdef CONFIG_64BIT
+	case RTC_EPOCH_READ32:
+		return put_user(epoch, (unsigned int __user *)arg);
+	case RTC_EPOCH_SET32:
+#endif
 	case RTC_EPOCH_SET:
 		/* Doesn't support before 1900 */
 		if (arg < 1900)
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index e6dbd956cf66..fee116e822d8 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -32,7 +32,6 @@
 #include <linux/vt_kern.h>
 #include <linux/raw.h>
 #include <linux/blkdev.h>
-#include <linux/rtc.h>
 #include <linux/pci.h>
 #include <linux/serial.h>
 #include <linux/ctype.h>
@@ -343,37 +342,6 @@ static int mt_ioctl_trans(struct file *file,
 #define HCIUARTSETFLAGS		_IOW('U', 203, int)
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
 
-#define RTC_IRQP_READ32		_IOR('p', 0x0b, compat_ulong_t)
-#define RTC_IRQP_SET32		_IOW('p', 0x0c, compat_ulong_t)
-#define RTC_EPOCH_READ32	_IOR('p', 0x0d, compat_ulong_t)
-#define RTC_EPOCH_SET32		_IOW('p', 0x0e, compat_ulong_t)
-
-static int rtc_ioctl(struct file *file,
-		unsigned cmd, void __user *argp)
-{
-	unsigned long __user *valp = compat_alloc_user_space(sizeof(*valp));
-	int ret;
-
-	if (valp == NULL)
-		return -EFAULT;
-	switch (cmd) {
-	case RTC_IRQP_READ32:
-	case RTC_EPOCH_READ32:
-		ret = do_ioctl(file, (cmd == RTC_IRQP_READ32) ?
-					RTC_IRQP_READ : RTC_EPOCH_READ,
-					(unsigned long)valp);
-		if (ret)
-			return ret;
-		return convert_in_user(valp, (unsigned int __user *)argp);
-	case RTC_IRQP_SET32:
-		return do_ioctl(file, RTC_IRQP_SET, (unsigned long)argp);
-	case RTC_EPOCH_SET32:
-		return do_ioctl(file, RTC_EPOCH_SET, (unsigned long)argp);
-	}
-
-	return -ENOIOCTLCMD;
-}
-
 /* on ia32 l_start is on a 32-bit boundary */
 #if defined(CONFIG_IA64) || defined(CONFIG_X86_64)
 struct space_resv_32 {
@@ -457,21 +425,6 @@ COMPATIBLE_IOCTL(SCSI_IOCTL_GET_PCI)
 /* Big V (don't complain on serial console) */
 IGNORE_IOCTL(VT_OPENQRY)
 IGNORE_IOCTL(VT_GETMODE)
-/* Little p (/dev/rtc, /dev/envctrl, etc.) */
-COMPATIBLE_IOCTL(RTC_AIE_ON)
-COMPATIBLE_IOCTL(RTC_AIE_OFF)
-COMPATIBLE_IOCTL(RTC_UIE_ON)
-COMPATIBLE_IOCTL(RTC_UIE_OFF)
-COMPATIBLE_IOCTL(RTC_PIE_ON)
-COMPATIBLE_IOCTL(RTC_PIE_OFF)
-COMPATIBLE_IOCTL(RTC_WIE_ON)
-COMPATIBLE_IOCTL(RTC_WIE_OFF)
-COMPATIBLE_IOCTL(RTC_ALM_SET)
-COMPATIBLE_IOCTL(RTC_ALM_READ)
-COMPATIBLE_IOCTL(RTC_RD_TIME)
-COMPATIBLE_IOCTL(RTC_SET_TIME)
-COMPATIBLE_IOCTL(RTC_WKALM_SET)
-COMPATIBLE_IOCTL(RTC_WKALM_RD)
 /*
  * These two are only for the sbus rtc driver, but
  * hwclock tries them on every rtc device first when
@@ -806,24 +759,16 @@ IGNORE_IOCTL(FBIOGCURSOR32)
 static long do_ioctl_trans(unsigned int cmd,
 		 unsigned long arg, struct file *file)
 {
-	void __user *argp = compat_ptr(arg);
-
 	switch (cmd) {
 #ifdef CONFIG_BLOCK
 	case SG_IO:
-		return sg_ioctl_trans(file, cmd, argp);
+		return sg_ioctl_trans(file, cmd, compat_ptr(arg));
 	case SG_GET_REQUEST_TABLE:
-		return sg_grt_trans(file, cmd, argp);
+		return sg_grt_trans(file, cmd, compat_ptr(arg));
 	case MTIOCGET32:
 	case MTIOCPOS32:
-		return mt_ioctl_trans(file, cmd, argp);
+		return mt_ioctl_trans(file, cmd, compat_ptr(arg));
 #endif
-	/* Not implemented in the native kernel */
-	case RTC_IRQP_READ32:
-	case RTC_IRQP_SET32:
-	case RTC_EPOCH_READ32:
-	case RTC_EPOCH_SET32:
-		return rtc_ioctl(file, cmd, argp);
 	}
 
 	/*
-- 
2.20.0

