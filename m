Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E75AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF5520679
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKLPSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:18:37 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:48109 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbfKLPSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:18:35 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MoNyA-1i6Fhy0Hd2-00oryL; Tue, 12 Nov 2019 16:16:58 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 6/8] ALSA: Avoid using timespec for struct snd_timer_tread
Date:   Tue, 12 Nov 2019 16:16:40 +0100
Message-Id: <20191112151642.680072-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191112151642.680072-1-arnd@arndb.de>
References: <20191112151642.680072-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8tyWGY2E1T7Je1mDQRXAm/1XcX+3F+kX/ls4nsz4wW4vAHm5gYl
 P42VGz0CneqNn5ggJFZQAbD08pMgGu7BgKZd03vt976a0Jomdux0ePiJdT02EfQVo0gCA0B
 UTlhE9vkJUtADiXwiE+O3IY4BkL1uCyUSRUYpP488Tu7EZ1j5SKIpaaLvQtOXcEeoOQwIZS
 NG1tEHesOONy74q3B/T8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HR4+05j5RwY=:QFU4VqXlQ5E+FHGHZa/K3r
 vIHskQd0+big1nEOudlzs9ZOhn2XHsr+AxOAKDCEnBrtpSV5sOPcFtOjX8+XeEmyZaOgHQrZt
 BzvqsEwJ0BUNTh+/1k4BZ4fWCA0YmndV0vCdIn8wWGeJ2sTVjyZVvdWcXzjSLWGWwV506rCFr
 6vu4G3kskwVMBqceyVp8KT4C0qrdjbYd8qri07q6jYXJwf4kYPaHWP/1dyD3GbizemWK+VpOg
 huF0W/PIckR+1ziFwr5yfZh7XbcbM/R/ODCZzBge32WZVpxoaJKB7698s8uE567U4PawX7Hpx
 pmiQH5lyT2OHKqGQPXrw3d8T2gUjSOsuvJOiQ1wTYgu0g3f2zzfw3a2sCkLKMOY8p/fefdUy7
 Gk3Kq7IABWAHA7uLcRVr/VDvj6+j+slmyUhGiWVCUBcXShc3ki6MiKzaDuLBuJLTaOlrgN5N8
 12Kh3mDK+FsRq6166DZEETOWoCqiz1TZAz39YzHDNA51V+sWVTqP6Awj6AQNZ/Wh/tfq78nrw
 hzaT8ALQv3csongl1X4kbriCTJQqynWxMhXndyBwdJMe4crTHfKXJWIKRleh+uHMh07KTPSvB
 mc1vs0YpswlnIqvUVSlhcsvEZvTW28qYjF4fdVg6/M0hdyfS+N4wAn8KA24vYac9b8UzdqKnT
 0vIug1dzwZBcx/0FpqqY/OJPB3g4Q9S9caSTVIha+Gelml3zU5AS94kMSkyzamB8/1+KkcE6C
 sYc19K7x4KLiyloiZeRHieP8moZnQph+LoA3aXOFgUzFQE0cuIZBdKunGk7pOR7j75u9SlMQz
 XqxmMgoEhHDVBQYAk+d1JXZfs8LHm8rErg+/VJEY2C7Zvu0+YN6/+pgXhjjg2KuuV04XdTVxn
 tealbwHNS0ltJT5O0QiA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

The struct snd_timer_tread will use 'timespec' type variables to record
timestamp, which is not year 2038 safe on 32bits system.

Since the struct snd_timer_tread is passed through read() rather than
ioctl(), and the read syscall has no command number that lets us pick
between the 32-bit or 64-bit version of this structure.

Thus we introduced one new command SNDRV_TIMER_IOCTL_TREAD64 and new
struct snd_timer_tread64 replacing timespec with s64 type to handle
64bit time_t. That means we will set tu->tread = TREAD_FORMAT_64BIT
when user space has a 64bit time_t, then we will copy to user with
struct snd_timer_tread64. Otherwise we will use 32bit time_t variables
when copying to user.

Moreover this patch replaces timespec type with timespec64 type and
related y2038 safe APIs.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/sound/asound.h |  15 +++-
 sound/core/timer.c          | 149 +++++++++++++++++++++++++++---------
 sound/core/timer_compat.c   |   5 +-
 3 files changed, 130 insertions(+), 39 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index cb830813da5d..8ce73fb629e8 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -780,7 +780,7 @@ struct snd_timer_status {
 
 #define SNDRV_TIMER_IOCTL_PVERSION	_IOR('T', 0x00, int)
 #define SNDRV_TIMER_IOCTL_NEXT_DEVICE	_IOWR('T', 0x01, struct snd_timer_id)
-#define SNDRV_TIMER_IOCTL_TREAD		_IOW('T', 0x02, int)
+#define SNDRV_TIMER_IOCTL_TREAD_OLD	_IOW('T', 0x02, int)
 #define SNDRV_TIMER_IOCTL_GINFO		_IOWR('T', 0x03, struct snd_timer_ginfo)
 #define SNDRV_TIMER_IOCTL_GPARAMS	_IOW('T', 0x04, struct snd_timer_gparams)
 #define SNDRV_TIMER_IOCTL_GSTATUS	_IOWR('T', 0x05, struct snd_timer_gstatus)
@@ -793,6 +793,15 @@ struct snd_timer_status {
 #define SNDRV_TIMER_IOCTL_STOP		_IO('T', 0xa1)
 #define SNDRV_TIMER_IOCTL_CONTINUE	_IO('T', 0xa2)
 #define SNDRV_TIMER_IOCTL_PAUSE		_IO('T', 0xa3)
+#define SNDRV_TIMER_IOCTL_TREAD64	_IOW('T', 0xa4, int)
+
+#if __BITS_PER_LONG == 64
+#define SNDRV_TIMER_IOCTL_TREAD SNDRV_TIMER_IOCTL_TREAD_OLD
+#else
+#define SNDRV_TIMER_IOCTL_TREAD ((sizeof(__kernel_long_t) >= sizeof(time_t)) ? \
+				 SNDRV_TIMER_IOCTL_TREAD_OLD : \
+				 SNDRV_TIMER_IOCTL_TREAD64)
+#endif
 
 struct snd_timer_read {
 	unsigned int resolution;
@@ -818,11 +827,15 @@ enum {
 	SNDRV_TIMER_EVENT_MRESUME = SNDRV_TIMER_EVENT_RESUME + 10,
 };
 
+#ifndef __KERNEL__
 struct snd_timer_tread {
 	int event;
+	__u8 pad1[sizeof(time_t) - sizeof(int)];
 	struct timespec tstamp;
 	unsigned int val;
+	__u8 pad2[sizeof(time_t) - sizeof(unsigned int)];
 };
+#endif
 
 /****************************************************************************
  *                                                                          *
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 921f4ae2f9bf..19a68cbbfbcb 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -44,6 +44,28 @@ MODULE_PARM_DESC(timer_tstamp_monotonic, "Use posix monotonic clock source for t
 MODULE_ALIAS_CHARDEV(CONFIG_SND_MAJOR, SNDRV_MINOR_TIMER);
 MODULE_ALIAS("devname:snd/timer");
 
+enum timer_tread_format {
+	TREAD_FORMAT_NONE = 0,
+	TREAD_FORMAT_TIME64,
+	TREAD_FORMAT_TIME32,
+};
+
+struct snd_timer_tread32 {
+	int event;
+	s32 tstamp_sec;
+	s32 tstamp_nsec;
+	unsigned int val;
+};
+
+struct snd_timer_tread64 {
+	int event;
+	u8 pad1[4];
+	s64 tstamp_sec;
+	s64 tstamp_nsec;
+	unsigned int val;
+	u8 pad2[4];
+};
+
 struct snd_timer_user {
 	struct snd_timer_instance *timeri;
 	int tread;		/* enhanced read with timestamps and events */
@@ -55,7 +77,7 @@ struct snd_timer_user {
 	int queue_size;
 	bool disconnected;
 	struct snd_timer_read *queue;
-	struct snd_timer_tread *tqueue;
+	struct snd_timer_tread64 *tqueue;
 	spinlock_t qlock;
 	unsigned long last_resolution;
 	unsigned int filter;
@@ -1326,7 +1348,7 @@ static void snd_timer_user_interrupt(struct snd_timer_instance *timeri,
 }
 
 static void snd_timer_user_append_to_tqueue(struct snd_timer_user *tu,
-					    struct snd_timer_tread *tread)
+					    struct snd_timer_tread64 *tread)
 {
 	if (tu->qused >= tu->queue_size) {
 		tu->overrun++;
@@ -1343,7 +1365,7 @@ static void snd_timer_user_ccallback(struct snd_timer_instance *timeri,
 				     unsigned long resolution)
 {
 	struct snd_timer_user *tu = timeri->callback_data;
-	struct snd_timer_tread r1;
+	struct snd_timer_tread64 r1;
 	unsigned long flags;
 
 	if (event >= SNDRV_TIMER_EVENT_START &&
@@ -1353,7 +1375,8 @@ static void snd_timer_user_ccallback(struct snd_timer_instance *timeri,
 		return;
 	memset(&r1, 0, sizeof(r1));
 	r1.event = event;
-	r1.tstamp = timespec64_to_timespec(*tstamp);
+	r1.tstamp_sec = tstamp->tv_sec;
+	r1.tstamp_nsec = tstamp->tv_nsec;
 	r1.val = resolution;
 	spin_lock_irqsave(&tu->qlock, flags);
 	snd_timer_user_append_to_tqueue(tu, &r1);
@@ -1375,7 +1398,7 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 				      unsigned long ticks)
 {
 	struct snd_timer_user *tu = timeri->callback_data;
-	struct snd_timer_tread *r, r1;
+	struct snd_timer_tread64 *r, r1;
 	struct timespec64 tstamp;
 	int prev, append = 0;
 
@@ -1396,7 +1419,8 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 	if ((tu->filter & (1 << SNDRV_TIMER_EVENT_RESOLUTION)) &&
 	    tu->last_resolution != resolution) {
 		r1.event = SNDRV_TIMER_EVENT_RESOLUTION;
-		r1.tstamp = timespec64_to_timespec(tstamp);
+		r1.tstamp_sec = tstamp.tv_sec;
+		r1.tstamp_nsec = tstamp.tv_nsec;
 		r1.val = resolution;
 		snd_timer_user_append_to_tqueue(tu, &r1);
 		tu->last_resolution = resolution;
@@ -1410,14 +1434,16 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 		prev = tu->qtail == 0 ? tu->queue_size - 1 : tu->qtail - 1;
 		r = &tu->tqueue[prev];
 		if (r->event == SNDRV_TIMER_EVENT_TICK) {
-			r->tstamp = timespec64_to_timespec(tstamp);
+			r->tstamp_sec = tstamp.tv_sec;
+			r->tstamp_nsec = tstamp.tv_nsec;
 			r->val += ticks;
 			append++;
 			goto __wake;
 		}
 	}
 	r1.event = SNDRV_TIMER_EVENT_TICK;
-	r1.tstamp = timespec64_to_timespec(tstamp);
+	r1.tstamp_sec = tstamp.tv_sec;
+	r1.tstamp_nsec = tstamp.tv_nsec;
 	r1.val = ticks;
 	snd_timer_user_append_to_tqueue(tu, &r1);
 	append++;
@@ -1432,7 +1458,7 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 static int realloc_user_queue(struct snd_timer_user *tu, int size)
 {
 	struct snd_timer_read *queue = NULL;
-	struct snd_timer_tread *tqueue = NULL;
+	struct snd_timer_tread64 *tqueue = NULL;
 
 	if (tu->tread) {
 		tqueue = kcalloc(size, sizeof(*tqueue), GFP_KERNEL);
@@ -1860,11 +1886,11 @@ static int snd_timer_user_params(struct file *file,
 	tu->qhead = tu->qtail = tu->qused = 0;
 	if (tu->timeri->flags & SNDRV_TIMER_IFLG_EARLY_EVENT) {
 		if (tu->tread) {
-			struct snd_timer_tread tread;
+			struct snd_timer_tread64 tread;
 			memset(&tread, 0, sizeof(tread));
 			tread.event = SNDRV_TIMER_EVENT_EARLY;
-			tread.tstamp.tv_sec = 0;
-			tread.tstamp.tv_nsec = 0;
+			tread.tstamp_sec = 0;
+			tread.tstamp_nsec = 0;
 			tread.val = 0;
 			snd_timer_user_append_to_tqueue(tu, &tread);
 		} else {
@@ -1994,6 +2020,36 @@ static int snd_timer_user_pause(struct file *file)
 	return 0;
 }
 
+static int snd_timer_user_tread(void __user *argp, struct snd_timer_user *tu,
+				unsigned int cmd, bool compat)
+{
+	int __user *p = argp;
+	int xarg, old_tread;
+
+	if (tu->timeri)	/* too late */
+		return -EBUSY;
+	if (get_user(xarg, p))
+		return -EFAULT;
+
+	old_tread = tu->tread;
+
+	if (!xarg)
+		tu->tread = TREAD_FORMAT_NONE;
+	else if (cmd == SNDRV_TIMER_IOCTL_TREAD64 ||
+		 (IS_ENABLED(CONFIG_64BITS) && !compat))
+		tu->tread = TREAD_FORMAT_TIME64;
+	else
+		tu->tread = TREAD_FORMAT_TIME32;
+
+	if (tu->tread != old_tread &&
+	    realloc_user_queue(tu, tu->queue_size) < 0) {
+		tu->tread = old_tread;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 enum {
 	SNDRV_TIMER_IOCTL_START_OLD = _IO('T', 0x20),
 	SNDRV_TIMER_IOCTL_STOP_OLD = _IO('T', 0x21),
@@ -2002,7 +2058,7 @@ enum {
 };
 
 static long __snd_timer_user_ioctl(struct file *file, unsigned int cmd,
-				 unsigned long arg)
+				 unsigned long arg, bool compat)
 {
 	struct snd_timer_user *tu;
 	void __user *argp = (void __user *)arg;
@@ -2014,23 +2070,9 @@ static long __snd_timer_user_ioctl(struct file *file, unsigned int cmd,
 		return put_user(SNDRV_TIMER_VERSION, p) ? -EFAULT : 0;
 	case SNDRV_TIMER_IOCTL_NEXT_DEVICE:
 		return snd_timer_user_next_device(argp);
-	case SNDRV_TIMER_IOCTL_TREAD:
-	{
-		int xarg, old_tread;
-
-		if (tu->timeri)	/* too late */
-			return -EBUSY;
-		if (get_user(xarg, p))
-			return -EFAULT;
-		old_tread = tu->tread;
-		tu->tread = xarg ? 1 : 0;
-		if (tu->tread != old_tread &&
-		    realloc_user_queue(tu, tu->queue_size) < 0) {
-			tu->tread = old_tread;
-			return -ENOMEM;
-		}
-		return 0;
-	}
+	case SNDRV_TIMER_IOCTL_TREAD_OLD:
+	case SNDRV_TIMER_IOCTL_TREAD64:
+		return snd_timer_user_tread(argp, tu, cmd, compat);
 	case SNDRV_TIMER_IOCTL_GINFO:
 		return snd_timer_user_ginfo(file, argp);
 	case SNDRV_TIMER_IOCTL_GPARAMS:
@@ -2070,7 +2112,7 @@ static long snd_timer_user_ioctl(struct file *file, unsigned int cmd,
 	long ret;
 
 	mutex_lock(&tu->ioctl_lock);
-	ret = __snd_timer_user_ioctl(file, cmd, arg);
+	ret = __snd_timer_user_ioctl(file, cmd, arg, false);
 	mutex_unlock(&tu->ioctl_lock);
 	return ret;
 }
@@ -2086,13 +2128,28 @@ static int snd_timer_user_fasync(int fd, struct file * file, int on)
 static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 				   size_t count, loff_t *offset)
 {
+	struct snd_timer_tread64 *tread;
+	struct snd_timer_tread32 tread32;
 	struct snd_timer_user *tu;
 	long result = 0, unit;
 	int qhead;
 	int err = 0;
 
 	tu = file->private_data;
-	unit = tu->tread ? sizeof(struct snd_timer_tread) : sizeof(struct snd_timer_read);
+	switch (tu->tread) {
+	case TREAD_FORMAT_TIME64:
+		unit = sizeof(struct snd_timer_tread64);
+		break;
+	case TREAD_FORMAT_TIME32:
+		unit = sizeof(struct snd_timer_tread32);
+		break;
+	case TREAD_FORMAT_NONE:
+		unit = sizeof(struct snd_timer_read);
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
 	mutex_lock(&tu->ioctl_lock);
 	spin_lock_irq(&tu->qlock);
 	while ((long)count - result >= unit) {
@@ -2131,14 +2188,34 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 		tu->qused--;
 		spin_unlock_irq(&tu->qlock);
 
-		if (tu->tread) {
-			if (copy_to_user(buffer, &tu->tqueue[qhead],
-					 sizeof(struct snd_timer_tread)))
+		tread = &tu->tqueue[qhead];
+
+		switch (tu->tread) {
+		case TREAD_FORMAT_TIME64:
+			if (copy_to_user(buffer, tread,
+					 sizeof(struct snd_timer_tread64)))
 				err = -EFAULT;
-		} else {
+			break;
+		case TREAD_FORMAT_TIME32:
+			memset(&tread32, 0, sizeof(tread32));
+			tread32 = (struct snd_timer_tread32) {
+				.event = tread->event,
+				.tstamp_sec = tread->tstamp_sec,
+				.tstamp_sec = tread->tstamp_nsec,
+				.val = tread->val,
+			};
+
+			if (copy_to_user(buffer, &tread32, sizeof(tread32)))
+				err = -EFAULT;
+			break;
+		case TREAD_FORMAT_NONE:
 			if (copy_to_user(buffer, &tu->queue[qhead],
 					 sizeof(struct snd_timer_read)))
 				err = -EFAULT;
+			break;
+		default:
+			err = -ENOTSUPP;
+			break;
 		}
 
 		spin_lock_irq(&tu->qlock);
diff --git a/sound/core/timer_compat.c b/sound/core/timer_compat.c
index 20eef5bc304b..0103d16f6f9f 100644
--- a/sound/core/timer_compat.c
+++ b/sound/core/timer_compat.c
@@ -83,7 +83,8 @@ static long __snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case SNDRV_TIMER_IOCTL_PVERSION:
-	case SNDRV_TIMER_IOCTL_TREAD:
+	case SNDRV_TIMER_IOCTL_TREAD_OLD:
+	case SNDRV_TIMER_IOCTL_TREAD64:
 	case SNDRV_TIMER_IOCTL_GINFO:
 	case SNDRV_TIMER_IOCTL_GSTATUS:
 	case SNDRV_TIMER_IOCTL_SELECT:
@@ -97,7 +98,7 @@ static long __snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd,
 	case SNDRV_TIMER_IOCTL_PAUSE:
 	case SNDRV_TIMER_IOCTL_PAUSE_OLD:
 	case SNDRV_TIMER_IOCTL_NEXT_DEVICE:
-		return __snd_timer_user_ioctl(file, cmd, (unsigned long)argp);
+		return __snd_timer_user_ioctl(file, cmd, (unsigned long)argp, true);
 	case SNDRV_TIMER_IOCTL_GPARAMS32:
 		return snd_timer_user_gparams_compat(file, argp);
 	case SNDRV_TIMER_IOCTL_INFO32:
-- 
2.20.0

