Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B3AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6816F20679
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfKLPSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:18:53 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:36145 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfKLPSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:18:52 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MvsMz-1heMlZ1bTr-00srMc; Tue, 12 Nov 2019 16:16:58 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v6 7/8] ALSA: move snd_pcm_ioctl_sync_ptr_compat into pcm_native.c
Date:   Tue, 12 Nov 2019 16:16:41 +0100
Message-Id: <20191112151642.680072-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191112151642.680072-1-arnd@arndb.de>
References: <20191112151642.680072-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dtqoaQwSKA1q63zq2NLtnzRRfdE4iOdCohvxz6SoA6GtAIprbQA
 QUkxbusXoMRs9YuevIRG06mGKr179ICD90ysX1I7kufOsgutVAajIKbMatzON5h+WEjI1mi
 2ZlsS9yiCa8U853bBW2FL03aImgfAFOIKIwh8HFKG/537MkEos/GL/Vz7eOBNNVrVCx8dK8
 SWX+rnoEZnmslK9br4B8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9b2k5ENw0xc=:nhmErBHh8bwn0ffdqcyE/g
 zu0F7nZ+WLIcXemXY8RTC8ibhVAw4HiH6LgfD7pYKW5Sm9R2bv92cE/O9lNH19Xt+/QYkFzd3
 megGMJCMdjjSZ3D1FENgq5mSlqK2jyFkOjhUmA/AAm1pMJvrWl+jprM7kIFA8AP2/ktoqh1/D
 5ZJeksLRVCGs1KnknXitwJGIM5bztr3P9xItJGbjRSOk9YoLanMpsRkmolX4Z588Bb7HZ1DcT
 WarsQmITagCDgzOWZ2y8eCyjBGGiDY4WB2IKkq+/kFUpaskyYuDfuYo8xmiF30kEksh+zyzxb
 EZnX9eDH1FnbSw9ExWmBpDbWapFHqthnEKarFlg2S0u5wcB1I462xFXBmm3NdQzglCMjBvlWQ
 b3Uxqaopy3OS4PoaK99Vw+JFdVwp0EMdWMx4dn/jA9hhWt3eoufg6WEN7tWxfzgT0TNvnH4HJ
 zjXE3t/aJDCJZy3KMC6TkfehISPQ/SaET2GOOnRXk3TG48VB5CDOZwqPF2ojLrMXJc7rSwcCH
 8ilTC9O+nkeAUCFPQwfISZdM6oDOSs8JLjL2NWORjuXtOAoPfJ190KC22T4JnBIHBMAtw5wmg
 wjOxkQU5zqYIgDjM59lH8vsyKUlr26KEiNNbVQokKkrBuORzRLpyVpMz3aKCVxURhdNHAgz8g
 P9HlrhAw0JMEM/DU260goiUcNlDWIew4caW9+A2YWW67SGDWb0vBeTzxX/0vMwpcdiOHKhkFT
 A4sJrPUMpvC0XFbqf/8vmPFORf+04bzYYs5OorAgTHjXO5EjdPkfcKIEVIekjmy4SGr+qfsFp
 oMEhuqdoJGBr8wcKqCjnYYtqSZCUefHUuboyG6TgpGiil5E153mRfRgvMDP7dPmUHRVPt7X3w
 DXo3l52tPUYKwqSWxyng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch, moving the compat handler for
snd_pcm_ioctl_sync_ptr_compat from pcm_compat.c to pcm_native.c.
No other changes are indented.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/core/pcm_compat.c |  98 --------------------------------------
 sound/core/pcm_native.c | 101 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 98 deletions(-)

diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 2671658442ea..6a2e5ea145e6 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -83,19 +83,6 @@ struct snd_pcm_sw_params32 {
 	unsigned char reserved[56];
 };
 
-/* recalcuate the boundary within 32bit */
-static snd_pcm_uframes_t recalculate_boundary(struct snd_pcm_runtime *runtime)
-{
-	snd_pcm_uframes_t boundary;
-
-	if (! runtime->buffer_size)
-		return 0;
-	boundary = runtime->buffer_size;
-	while (boundary * 2 <= 0x7fffffffUL - runtime->buffer_size)
-		boundary *= 2;
-	return boundary;
-}
-
 static int snd_pcm_ioctl_sw_params_compat(struct snd_pcm_substream *substream,
 					  struct snd_pcm_sw_params32 __user *src)
 {
@@ -388,91 +375,6 @@ static int snd_pcm_ioctl_xfern_compat(struct snd_pcm_substream *substream,
 	return err;
 }
 
-
-struct snd_pcm_mmap_status32 {
-	s32 state;
-	s32 pad1;
-	u32 hw_ptr;
-	struct compat_timespec tstamp;
-	s32 suspended_state;
-	struct compat_timespec audio_tstamp;
-} __attribute__((packed));
-
-struct snd_pcm_mmap_control32 {
-	u32 appl_ptr;
-	u32 avail_min;
-};
-
-struct snd_pcm_sync_ptr32 {
-	u32 flags;
-	union {
-		struct snd_pcm_mmap_status32 status;
-		unsigned char reserved[64];
-	} s;
-	union {
-		struct snd_pcm_mmap_control32 control;
-		unsigned char reserved[64];
-	} c;
-} __attribute__((packed));
-
-static int snd_pcm_ioctl_sync_ptr_compat(struct snd_pcm_substream *substream,
-					 struct snd_pcm_sync_ptr32 __user *src)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	volatile struct snd_pcm_mmap_status *status;
-	volatile struct snd_pcm_mmap_control *control;
-	u32 sflags;
-	struct snd_pcm_mmap_control scontrol;
-	struct snd_pcm_mmap_status sstatus;
-	snd_pcm_uframes_t boundary;
-	int err;
-
-	if (snd_BUG_ON(!runtime))
-		return -EINVAL;
-
-	if (get_user(sflags, &src->flags) ||
-	    get_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
-	    get_user(scontrol.avail_min, &src->c.control.avail_min))
-		return -EFAULT;
-	if (sflags & SNDRV_PCM_SYNC_PTR_HWSYNC) {
-		err = snd_pcm_hwsync(substream);
-		if (err < 0)
-			return err;
-	}
-	status = runtime->status;
-	control = runtime->control;
-	boundary = recalculate_boundary(runtime);
-	if (! boundary)
-		boundary = 0x7fffffff;
-	snd_pcm_stream_lock_irq(substream);
-	/* FIXME: we should consider the boundary for the sync from app */
-	if (!(sflags & SNDRV_PCM_SYNC_PTR_APPL))
-		control->appl_ptr = scontrol.appl_ptr;
-	else
-		scontrol.appl_ptr = control->appl_ptr % boundary;
-	if (!(sflags & SNDRV_PCM_SYNC_PTR_AVAIL_MIN))
-		control->avail_min = scontrol.avail_min;
-	else
-		scontrol.avail_min = control->avail_min;
-	sstatus.state = status->state;
-	sstatus.hw_ptr = status->hw_ptr % boundary;
-	sstatus.tstamp = status->tstamp;
-	sstatus.suspended_state = status->suspended_state;
-	sstatus.audio_tstamp = status->audio_tstamp;
-	snd_pcm_stream_unlock_irq(substream);
-	if (put_user(sstatus.state, &src->s.status.state) ||
-	    put_user(sstatus.hw_ptr, &src->s.status.hw_ptr) ||
-	    compat_put_timespec(&sstatus.tstamp, &src->s.status.tstamp) ||
-	    put_user(sstatus.suspended_state, &src->s.status.suspended_state) ||
-	    compat_put_timespec(&sstatus.audio_tstamp,
-		    &src->s.status.audio_tstamp) ||
-	    put_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
-	    put_user(scontrol.avail_min, &src->c.control.avail_min))
-		return -EFAULT;
-
-	return 0;
-}
-
 #ifdef CONFIG_X86_X32
 /* X32 ABI has 64bit timespec and 64bit alignment */
 struct snd_pcm_mmap_status_x32 {
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 2c8c9b91677a..cad90d9ce9da 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -4,6 +4,7 @@
  *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
  */
 
+#include <linux/compat.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/file.h>
@@ -2846,6 +2847,106 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
+struct snd_pcm_mmap_status32 {
+	s32 state;
+	s32 pad1;
+	u32 hw_ptr;
+	struct compat_timespec tstamp;
+	s32 suspended_state;
+	struct compat_timespec audio_tstamp;
+} __attribute__((packed));
+
+struct snd_pcm_mmap_control32 {
+	u32 appl_ptr;
+	u32 avail_min;
+};
+
+struct snd_pcm_sync_ptr32 {
+	u32 flags;
+	union {
+		struct snd_pcm_mmap_status32 status;
+		unsigned char reserved[64];
+	} s;
+	union {
+		struct snd_pcm_mmap_control32 control;
+		unsigned char reserved[64];
+	} c;
+} __attribute__((packed));
+
+/* recalcuate the boundary within 32bit */
+static snd_pcm_uframes_t recalculate_boundary(struct snd_pcm_runtime *runtime)
+{
+	snd_pcm_uframes_t boundary;
+
+	if (! runtime->buffer_size)
+		return 0;
+	boundary = runtime->buffer_size;
+	while (boundary * 2 <= 0x7fffffffUL - runtime->buffer_size)
+		boundary *= 2;
+	return boundary;
+}
+
+static int snd_pcm_ioctl_sync_ptr_compat(struct snd_pcm_substream *substream,
+					 struct snd_pcm_sync_ptr32 __user *src)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	volatile struct snd_pcm_mmap_status *status;
+	volatile struct snd_pcm_mmap_control *control;
+	u32 sflags;
+	struct snd_pcm_mmap_control scontrol;
+	struct snd_pcm_mmap_status sstatus;
+	snd_pcm_uframes_t boundary;
+	int err;
+
+	if (snd_BUG_ON(!runtime))
+		return -EINVAL;
+
+	if (get_user(sflags, &src->flags) ||
+	    get_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
+	    get_user(scontrol.avail_min, &src->c.control.avail_min))
+		return -EFAULT;
+	if (sflags & SNDRV_PCM_SYNC_PTR_HWSYNC) {
+		err = snd_pcm_hwsync(substream);
+		if (err < 0)
+			return err;
+	}
+	status = runtime->status;
+	control = runtime->control;
+	boundary = recalculate_boundary(runtime);
+	if (! boundary)
+		boundary = 0x7fffffff;
+	snd_pcm_stream_lock_irq(substream);
+	/* FIXME: we should consider the boundary for the sync from app */
+	if (!(sflags & SNDRV_PCM_SYNC_PTR_APPL))
+		control->appl_ptr = scontrol.appl_ptr;
+	else
+		scontrol.appl_ptr = control->appl_ptr % boundary;
+	if (!(sflags & SNDRV_PCM_SYNC_PTR_AVAIL_MIN))
+		control->avail_min = scontrol.avail_min;
+	else
+		scontrol.avail_min = control->avail_min;
+	sstatus.state = status->state;
+	sstatus.hw_ptr = status->hw_ptr % boundary;
+	sstatus.tstamp = status->tstamp;
+	sstatus.suspended_state = status->suspended_state;
+	sstatus.audio_tstamp = status->audio_tstamp;
+	snd_pcm_stream_unlock_irq(substream);
+	if (put_user(sstatus.state, &src->s.status.state) ||
+	    put_user(sstatus.hw_ptr, &src->s.status.hw_ptr) ||
+	    compat_put_timespec(&sstatus.tstamp, &src->s.status.tstamp) ||
+	    put_user(sstatus.suspended_state, &src->s.status.suspended_state) ||
+	    compat_put_timespec(&sstatus.audio_tstamp,
+				&src->s.status.audio_tstamp) ||
+	    put_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
+	    put_user(scontrol.avail_min, &src->c.control.avail_min))
+		return -EFAULT;
+
+	return 0;
+}
+#define __SNDRV_PCM_IOCTL_SYNC_PTR32 = _IOWR('A', 0x23, struct snd_pcm_sync_ptr32),
+#endif
+
 static int snd_pcm_tstamp(struct snd_pcm_substream *substream, int __user *_arg)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-- 
2.20.0

