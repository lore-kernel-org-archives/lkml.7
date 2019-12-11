Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885A9C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5596721556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfLKVUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:20:49 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:39115 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKVUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:20:49 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M890H-1ib0fc2usl-005IZj; Wed, 11 Dec 2019 22:20:31 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v7 2/9] ALSA: Avoid using timespec for struct snd_timer_status
Date:   Wed, 11 Dec 2019 22:20:18 +0100
Message-Id: <20191211212025.1981822-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211212025.1981822-1-arnd@arndb.de>
References: <20191211212025.1981822-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dASm1+fwPi9ktSUgKFgQ12hr3ORHPeVSyLCtmtG5M1WYGKRGD5G
 fnF6XiWNl9XCouAIcLL/JXK+Dt8dORlDH81A4dP6cj/wfAl1p5TvSSr5SZZhWpepWZUv6Hr
 nuKLUHXdRbpzVryz4OZjTDYbx1IuyJuHdZurA3JT5JR+ap9p7tvB+A7iuhi/OPGdm39s+V+
 888KUlbr+gujNN4XGf3WA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vqpdI6wKNCo=:lr1IHH0cnyMDeh5L6vk/M0
 Y3SKwG5IuwCqULkfu2kIVmtd899IpEj4yaAERepZEgLCAwN9Cd3S5IkyOk5+W/zVFUGGwM/sw
 /UcjvJuCOezswCqh6zlScD1+ga3Tp0YIwcYS6kM6mGn6xUGuFtDhIaGv64y4nPMAEFJufO6Uz
 5K1logXRsK4IFNYJXWFlHdGyX2h7v+BDb4xd7UtUIb5OYzrWLPc5LqT1u82CjSlsxU1rwwiEi
 JyeB9Y1IWJxSo5JK/AwvNuy86DOaTC6ZNdRwgiw1FrFw44cgNxRnpmMSYN8AcqLfvxtX8oVVl
 hNukMNMw/WG9PQtuY2XM8tYx0/Pw3YRRcnHlygBvdyp5VSSQzHDJzknxI+oS2suyFywhZxnyF
 iaGIQ5mqQae6/pnAFpkwMECY5YsfrrZEhjceervLn0rhlchU95ohvC25F8ofFujftW8v2pB3J
 nYFlhODa/FaG2aFbIUsYyHUGu1riAvHbrEucgmbZ3oocO0wX2w9lizJboWWSnQiz2ZTnIPDTZ
 o5x0oohZoZSGIWZRlHgcRxbkLA4CtaE+yLa9ExnRJUwaZArHBHeHArX7XZSwZ61qhvt0uqtLq
 Ks6SgqmhBf4lhJhuO5EVxGgJLAjusYg2q/vCgUz2Z+H5J4JVecn0Rx9HSL4Q0J3LcAw8B1Pu3
 CMmsr1SC1tnOaQkJRcPKpYxsNx85lur4Inhqviz5Ux/1xbWnciJvn6rRLal0skaHCktOz7+Xl
 AZGk8yrulhLZc2vtTK6IThD9+9TdbXMBy6VfIyw6InSTwtPmSI9lg6mKrHVp11oFefiipnlak
 nypz1BPscfP0yGfYnzWD+IET/W6urvSfKMXeaw/M9sWPCS1lYWfeHLeA9YMaybPB+w8VPwsQR
 nk9ORUBG8pJDSonSUCvg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

struct snd_timer_status uses 'timespec' type variables to record
timestamp, which will be changed to an incompatible layout with
updated user space using 64-bit time_t.

To handle both the old and the new layout on 32-bit architectures,
this patch introduces 'struct snd_timer_status32' and 'struct snd_timer_status64'
to handle 32bit time_t and 64bit time_t in native mode and compat mode,
which replaces timespec with s64 type.

When glibc changes time_t to 64-bit, any recompiled program will issue
ioctl commands that the kernel does not understand without this patch.

In the public uapi header, snd_timer_status is now guarded by
an #ifndef __KERNEL__ to avoid referencing 'struct timespec'.
The timespec definition will be removed from the kernel to prevent
new y2038 bugs and to avoid the conflict with an incompatible libc
type of the same name.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/sound/asound.h |  2 ++
 sound/core/timer.c          | 62 +++++++++++++++++++++++++++++++++----
 sound/core/timer_compat.c   | 57 ++++------------------------------
 3 files changed, 64 insertions(+), 57 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index df1153cea0b7..930854f67fd3 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -761,6 +761,7 @@ struct snd_timer_params {
 	unsigned char reserved[60];	/* reserved */
 };
 
+#ifndef __KERNEL__
 struct snd_timer_status {
 	struct timespec tstamp;		/* Timestamp - last update */
 	unsigned int resolution;	/* current period resolution in ns */
@@ -769,6 +770,7 @@ struct snd_timer_status {
 	unsigned int queue;		/* used queue size */
 	unsigned char reserved[64];	/* reserved */
 };
+#endif
 
 #define SNDRV_TIMER_IOCTL_PVERSION	_IOR('T', 0x00, int)
 #define SNDRV_TIMER_IOCTL_NEXT_DEVICE	_IOWR('T', 0x01, struct snd_timer_id)
diff --git a/sound/core/timer.c b/sound/core/timer.c
index d808d5554c7a..d2f69039f941 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -65,6 +65,30 @@ struct snd_timer_user {
 	struct mutex ioctl_lock;
 };
 
+struct snd_timer_status32 {
+	s32 tstamp_sec;			/* Timestamp - last update */
+	s32 tstamp_nsec;
+	unsigned int resolution;	/* current period resolution in ns */
+	unsigned int lost;		/* counter of master tick lost */
+	unsigned int overrun;		/* count of read queue overruns */
+	unsigned int queue;		/* used queue size */
+	unsigned char reserved[64];	/* reserved */
+};
+
+#define SNDRV_TIMER_IOCTL_STATUS32	_IOR('T', 0x14, struct snd_timer_status32)
+
+struct snd_timer_status64 {
+	s64 tstamp_sec;			/* Timestamp - last update */
+	s64 tstamp_nsec;
+	unsigned int resolution;	/* current period resolution in ns */
+	unsigned int lost;		/* counter of master tick lost */
+	unsigned int overrun;		/* count of read queue overruns */
+	unsigned int queue;		/* used queue size */
+	unsigned char reserved[64];	/* reserved */
+};
+
+#define SNDRV_TIMER_IOCTL_STATUS64	_IOR('T', 0x14, struct snd_timer_status64)
+
 /* list of timers */
 static LIST_HEAD(snd_timer_list);
 
@@ -1875,17 +1899,41 @@ static int snd_timer_user_params(struct file *file,
 	return err;
 }
 
-static int snd_timer_user_status(struct file *file,
-				 struct snd_timer_status __user *_status)
+static int snd_timer_user_status32(struct file *file,
+				   struct snd_timer_status32 __user *_status)
+ {
+	struct snd_timer_user *tu;
+	struct snd_timer_status32 status;
+
+	tu = file->private_data;
+	if (!tu->timeri)
+		return -EBADFD;
+	memset(&status, 0, sizeof(status));
+	status.tstamp_sec = tu->tstamp.tv_sec;
+	status.tstamp_nsec = tu->tstamp.tv_nsec;
+	status.resolution = snd_timer_resolution(tu->timeri);
+	status.lost = tu->timeri->lost;
+	status.overrun = tu->overrun;
+	spin_lock_irq(&tu->qlock);
+	status.queue = tu->qused;
+	spin_unlock_irq(&tu->qlock);
+	if (copy_to_user(_status, &status, sizeof(status)))
+		return -EFAULT;
+	return 0;
+}
+
+static int snd_timer_user_status64(struct file *file,
+				   struct snd_timer_status64 __user *_status)
 {
 	struct snd_timer_user *tu;
-	struct snd_timer_status status;
+	struct snd_timer_status64 status;
 
 	tu = file->private_data;
 	if (!tu->timeri)
 		return -EBADFD;
 	memset(&status, 0, sizeof(status));
-	status.tstamp = timespec64_to_timespec(tu->tstamp);
+	status.tstamp_sec = tu->tstamp.tv_sec;
+	status.tstamp_nsec = tu->tstamp.tv_nsec;
 	status.resolution = snd_timer_resolution(tu->timeri);
 	status.lost = tu->timeri->lost;
 	status.overrun = tu->overrun;
@@ -2009,8 +2057,10 @@ static long __snd_timer_user_ioctl(struct file *file, unsigned int cmd,
 		return snd_timer_user_info(file, argp);
 	case SNDRV_TIMER_IOCTL_PARAMS:
 		return snd_timer_user_params(file, argp);
-	case SNDRV_TIMER_IOCTL_STATUS:
-		return snd_timer_user_status(file, argp);
+	case SNDRV_TIMER_IOCTL_STATUS32:
+		return snd_timer_user_status32(file, argp);
+	case SNDRV_TIMER_IOCTL_STATUS64:
+		return snd_timer_user_status64(file, argp);
 	case SNDRV_TIMER_IOCTL_START:
 	case SNDRV_TIMER_IOCTL_START_OLD:
 		return snd_timer_user_start(file);
diff --git a/sound/core/timer_compat.c b/sound/core/timer_compat.c
index bb6be484dfd3..20eef5bc304b 100644
--- a/sound/core/timer_compat.c
+++ b/sound/core/timer_compat.c
@@ -69,54 +69,11 @@ static int snd_timer_user_info_compat(struct file *file,
 	return 0;
 }
 
-struct snd_timer_status32 {
-	struct compat_timespec tstamp;
-	u32 resolution;
-	u32 lost;
-	u32 overrun;
-	u32 queue;
-	unsigned char reserved[64];
-};
-
-static int snd_timer_user_status_compat(struct file *file,
-					struct snd_timer_status32 __user *_status)
-{
-	struct snd_timer_user *tu;
-	struct snd_timer_status32 status;
-	
-	tu = file->private_data;
-	if (!tu->timeri)
-		return -EBADFD;
-	memset(&status, 0, sizeof(status));
-	status.tstamp.tv_sec = tu->tstamp.tv_sec;
-	status.tstamp.tv_nsec = tu->tstamp.tv_nsec;
-	status.resolution = snd_timer_resolution(tu->timeri);
-	status.lost = tu->timeri->lost;
-	status.overrun = tu->overrun;
-	spin_lock_irq(&tu->qlock);
-	status.queue = tu->qused;
-	spin_unlock_irq(&tu->qlock);
-	if (copy_to_user(_status, &status, sizeof(status)))
-		return -EFAULT;
-	return 0;
-}
-
-#ifdef CONFIG_X86_X32
-/* X32 ABI has the same struct as x86-64 */
-#define snd_timer_user_status_x32(file, s) \
-	snd_timer_user_status(file, s)
-#endif /* CONFIG_X86_X32 */
-
-/*
- */
-
 enum {
 	SNDRV_TIMER_IOCTL_GPARAMS32 = _IOW('T', 0x04, struct snd_timer_gparams32),
 	SNDRV_TIMER_IOCTL_INFO32 = _IOR('T', 0x11, struct snd_timer_info32),
-	SNDRV_TIMER_IOCTL_STATUS32 = _IOW('T', 0x14, struct snd_timer_status32),
-#ifdef CONFIG_X86_X32
-	SNDRV_TIMER_IOCTL_STATUS_X32 = _IOW('T', 0x14, struct snd_timer_status),
-#endif /* CONFIG_X86_X32 */
+	SNDRV_TIMER_IOCTL_STATUS_COMPAT32 = _IOW('T', 0x14, struct snd_timer_status32),
+	SNDRV_TIMER_IOCTL_STATUS_COMPAT64 = _IOW('T', 0x14, struct snd_timer_status64),
 };
 
 static long __snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd,
@@ -145,12 +102,10 @@ static long __snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd,
 		return snd_timer_user_gparams_compat(file, argp);
 	case SNDRV_TIMER_IOCTL_INFO32:
 		return snd_timer_user_info_compat(file, argp);
-	case SNDRV_TIMER_IOCTL_STATUS32:
-		return snd_timer_user_status_compat(file, argp);
-#ifdef CONFIG_X86_X32
-	case SNDRV_TIMER_IOCTL_STATUS_X32:
-		return snd_timer_user_status_x32(file, argp);
-#endif /* CONFIG_X86_X32 */
+	case SNDRV_TIMER_IOCTL_STATUS_COMPAT32:
+		return snd_timer_user_status32(file, argp);
+	case SNDRV_TIMER_IOCTL_STATUS_COMPAT64:
+		return snd_timer_user_status64(file, argp);
 	}
 	return -ENOIOCTLCMD;
 }
-- 
2.20.0

