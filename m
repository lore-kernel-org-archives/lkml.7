Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FE3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F2D20663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfDPU3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:29:35 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:56793 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPU3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:29:33 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mq2za-1gTd8d3NQY-00n9Zp; Tue, 16 Apr 2019 22:28:41 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
        linux-um@lists.infradead.org, alsa-devel@alsa-project.org
Subject: [PATCH v3 20/26] compat_ioctl: remove translation for sound ioctls
Date:   Tue, 16 Apr 2019 22:28:05 +0200
Message-Id: <20190416202839.248216-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202013.4034148-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mKAJ4vltBmPlWCiZYnDCwW+VEhJjQIdp5ngMRC1rR2fUmOP2Is1
 cAYiX0n7sO4FNhTFtckvCgE51si4xId5Nfj3e1jFT0VcKg7RDaEfC9cvln7ttfafiKQeSv/
 +74X2mOQrGvAsZBdytf2wmN/69K8cMwTN7wKZfgNqz+NaqWaVnZ6eL7+YaqNatwIlNsP/EE
 wW+NvSHRdeyBYVBWifIwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y5gValG+h3E=:0LwxiVbVDVtnsVvvQlF0Qi
 rHTRNF5SHWjXm6ewuNkkAMRxgu+AGka0nCXVRLMaY/glcXbziX1H2B0ryknWtoYKIYatW948d
 0lVbP8BXbC1BvU4kxhCPxMrl4OAg18Xs7hmkCa7LnMj10OK7zANfKvm27Pbq2GD/hmlQXN+oF
 65mUxNi854hZ/vnkmxgBbLhawhHDusfwApW2QQUZB5xDyIj5FrkRQ7NKdQi1y99GJUgfMflix
 wkZCS+3i7h9sorr6FDvnbKtvLE0u5kE0V+fvQ0t1azpiUS0Lt++LrJR69fHbD6wUiB2BTg6Ww
 EoITVejfZmgeEnWDP/LOmnILgNBzI6QKgpGKTRHZJLDF5+gAo/wqylekxS0Gb41IdDXYA1OTR
 vifA7Qlj9q/fmdmgozLWHqhApJ8O0JHQzei5McmGa3CrfavZllTxqvB0mYvwyFy6DPMXL+iUh
 PfKGhOUCgjTUGQaehC3REtFaXzu7ke+JDIUAqlndiKF4MzeMLL61L9tv9KVrkRJH9rD8JNsqw
 wCZV/lR8jqJlTTbwYOuB+Qa8yCUc72WcUYY6wmPy91vX75apf+BtJqsdPHVGDYhgj/QAm4AZs
 PljI+556/W1CU2JqUYGVFE2oje9s/QaVhpZyeUZtlxLypWdaf81aLeBngHb35NQ4itXwzXJmb
 FQNhR1xxmsyuhOPhUXXtE1xXho30eR6BLmwkni4TGdlVhr/IbsK/KbolP4KAZB/0r549lzYA0
 fIrDuVyC8fOaoGLK345yqp0XMu8yzhLsiVTbsA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SNDCTL_* and SOUND_* commands are the old OSS user interface.

I checked all the sound ioctl commands listed in fs/compat_ioctl.c
to see if we still need the translation handlers. Here is what I
found:

- sound/oss/ is (almost) gone from the kernel, this is what actually
  needed all the translations
- The ALSA emulation for OSS correctly handles all compat_ioctl
  commands already.
- sound/oss/dmasound/ is the last holdout of the original OSS code,
  this is only used on arch/m68k, which has no 64-bit mode and
  hence needs no compat handlers
- arch/um/drivers/hostaudio_kern.c may run in 64-bit mode with
  32-bit x86 user space underneath it. This rare corner case is
  the only one that still needs the compat handlers.

By adding a simple redirect of .compat_ioctl to .unlocked_ioctl in the
UML driver, we can remove all the COMPATIBLE_IOCTL() annotations without
a change in functionality. For completeness, I'm adding the same thing
to the dmasound file, knowing that it makes no difference.

The compat_ioctl list contains one comment about SNDCTL_DSP_MAPINBUF and
SNDCTL_DSP_MAPOUTBUF, which actually would need a translation handler
if implemented. However, the native implementation just returns -EINVAL,
so we don't care.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/um/drivers/hostaudio_kern.c   |   1 +
 fs/compat_ioctl.c                  | 158 -----------------------------
 sound/core/oss/pcm_oss.c           |   4 +
 sound/oss/dmasound/dmasound_core.c |   2 +
 4 files changed, 7 insertions(+), 158 deletions(-)

diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
index 7f9dbdbc4eb7..1bf139c3727a 100644
--- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -298,6 +298,7 @@ static const struct file_operations hostaudio_fops = {
 	.write          = hostaudio_write,
 	.poll           = hostaudio_poll,
 	.unlocked_ioctl	= hostaudio_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.mmap           = NULL,
 	.open           = hostaudio_open,
 	.release        = hostaudio_release,
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 5d13336e9eaa..625536aa6b03 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -51,8 +51,6 @@
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
 
-#include <linux/soundcard.h>
-
 #include <linux/hiddev.h>
 
 
@@ -399,162 +397,6 @@ COMPATIBLE_IOCTL(SG_GET_KEEP_ORPHAN)
 /* PPP stuff */
 COMPATIBLE_IOCTL(PPPIOCGUNIT)
 COMPATIBLE_IOCTL(PPPIOCGCHAN)
-/* Big A */
-/* sparc only */
-/* Big Q for sound/OSS */
-COMPATIBLE_IOCTL(SNDCTL_SEQ_RESET)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_SYNC)
-COMPATIBLE_IOCTL(SNDCTL_SYNTH_INFO)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_CTRLRATE)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_GETOUTCOUNT)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_GETINCOUNT)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_PERCMODE)
-COMPATIBLE_IOCTL(SNDCTL_FM_LOAD_INSTR)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_TESTMIDI)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_RESETSAMPLES)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_NRSYNTHS)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_NRMIDIS)
-COMPATIBLE_IOCTL(SNDCTL_MIDI_INFO)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_THRESHOLD)
-COMPATIBLE_IOCTL(SNDCTL_SYNTH_MEMAVL)
-COMPATIBLE_IOCTL(SNDCTL_FM_4OP_ENABLE)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_PANIC)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_OUTOFBAND)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_GETTIME)
-COMPATIBLE_IOCTL(SNDCTL_SYNTH_ID)
-COMPATIBLE_IOCTL(SNDCTL_SYNTH_CONTROL)
-COMPATIBLE_IOCTL(SNDCTL_SYNTH_REMOVESAMPLE)
-/* Big T for sound/OSS */
-COMPATIBLE_IOCTL(SNDCTL_TMR_TIMEBASE)
-COMPATIBLE_IOCTL(SNDCTL_TMR_START)
-COMPATIBLE_IOCTL(SNDCTL_TMR_STOP)
-COMPATIBLE_IOCTL(SNDCTL_TMR_CONTINUE)
-COMPATIBLE_IOCTL(SNDCTL_TMR_TEMPO)
-COMPATIBLE_IOCTL(SNDCTL_TMR_SOURCE)
-COMPATIBLE_IOCTL(SNDCTL_TMR_METRONOME)
-COMPATIBLE_IOCTL(SNDCTL_TMR_SELECT)
-/* Little m for sound/OSS */
-COMPATIBLE_IOCTL(SNDCTL_MIDI_PRETIME)
-COMPATIBLE_IOCTL(SNDCTL_MIDI_MPUMODE)
-COMPATIBLE_IOCTL(SNDCTL_MIDI_MPUCMD)
-/* Big P for sound/OSS */
-COMPATIBLE_IOCTL(SNDCTL_DSP_RESET)
-COMPATIBLE_IOCTL(SNDCTL_DSP_SYNC)
-COMPATIBLE_IOCTL(SNDCTL_DSP_SPEED)
-COMPATIBLE_IOCTL(SNDCTL_DSP_STEREO)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETBLKSIZE)
-COMPATIBLE_IOCTL(SNDCTL_DSP_CHANNELS)
-COMPATIBLE_IOCTL(SOUND_PCM_WRITE_FILTER)
-COMPATIBLE_IOCTL(SNDCTL_DSP_POST)
-COMPATIBLE_IOCTL(SNDCTL_DSP_SUBDIVIDE)
-COMPATIBLE_IOCTL(SNDCTL_DSP_SETFRAGMENT)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETFMTS)
-COMPATIBLE_IOCTL(SNDCTL_DSP_SETFMT)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETOSPACE)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETISPACE)
-COMPATIBLE_IOCTL(SNDCTL_DSP_NONBLOCK)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETCAPS)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETTRIGGER)
-COMPATIBLE_IOCTL(SNDCTL_DSP_SETTRIGGER)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETIPTR)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETOPTR)
-/* SNDCTL_DSP_MAPINBUF,  XXX needs translation */
-/* SNDCTL_DSP_MAPOUTBUF,  XXX needs translation */
-COMPATIBLE_IOCTL(SNDCTL_DSP_SETSYNCRO)
-COMPATIBLE_IOCTL(SNDCTL_DSP_SETDUPLEX)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETODELAY)
-COMPATIBLE_IOCTL(SNDCTL_DSP_PROFILE)
-COMPATIBLE_IOCTL(SOUND_PCM_READ_RATE)
-COMPATIBLE_IOCTL(SOUND_PCM_READ_CHANNELS)
-COMPATIBLE_IOCTL(SOUND_PCM_READ_BITS)
-COMPATIBLE_IOCTL(SOUND_PCM_READ_FILTER)
-/* Big C for sound/OSS */
-COMPATIBLE_IOCTL(SNDCTL_COPR_RESET)
-COMPATIBLE_IOCTL(SNDCTL_COPR_LOAD)
-COMPATIBLE_IOCTL(SNDCTL_COPR_RDATA)
-COMPATIBLE_IOCTL(SNDCTL_COPR_RCODE)
-COMPATIBLE_IOCTL(SNDCTL_COPR_WDATA)
-COMPATIBLE_IOCTL(SNDCTL_COPR_WCODE)
-COMPATIBLE_IOCTL(SNDCTL_COPR_RUN)
-COMPATIBLE_IOCTL(SNDCTL_COPR_HALT)
-COMPATIBLE_IOCTL(SNDCTL_COPR_SENDMSG)
-COMPATIBLE_IOCTL(SNDCTL_COPR_RCVMSG)
-/* Big M for sound/OSS */
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_VOLUME)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_BASS)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_TREBLE)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_SYNTH)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_PCM)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_SPEAKER)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_LINE)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_MIC)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_CD)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_IMIX)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_ALTPCM)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_RECLEV)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_IGAIN)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_OGAIN)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_LINE1)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_LINE2)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_LINE3)
-COMPATIBLE_IOCTL(MIXER_READ(SOUND_MIXER_DIGITAL1))
-COMPATIBLE_IOCTL(MIXER_READ(SOUND_MIXER_DIGITAL2))
-COMPATIBLE_IOCTL(MIXER_READ(SOUND_MIXER_DIGITAL3))
-COMPATIBLE_IOCTL(MIXER_READ(SOUND_MIXER_PHONEIN))
-COMPATIBLE_IOCTL(MIXER_READ(SOUND_MIXER_PHONEOUT))
-COMPATIBLE_IOCTL(MIXER_READ(SOUND_MIXER_VIDEO))
-COMPATIBLE_IOCTL(MIXER_READ(SOUND_MIXER_RADIO))
-COMPATIBLE_IOCTL(MIXER_READ(SOUND_MIXER_MONITOR))
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_MUTE)
-/* SOUND_MIXER_READ_ENHANCE,  same value as READ_MUTE */
-/* SOUND_MIXER_READ_LOUD,  same value as READ_MUTE */
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_RECSRC)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_DEVMASK)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_RECMASK)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_STEREODEVS)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_CAPS)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_VOLUME)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_BASS)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_TREBLE)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_SYNTH)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_PCM)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_SPEAKER)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_LINE)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_MIC)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_CD)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_IMIX)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_ALTPCM)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_RECLEV)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_IGAIN)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_OGAIN)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_LINE1)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_LINE2)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_LINE3)
-COMPATIBLE_IOCTL(MIXER_WRITE(SOUND_MIXER_DIGITAL1))
-COMPATIBLE_IOCTL(MIXER_WRITE(SOUND_MIXER_DIGITAL2))
-COMPATIBLE_IOCTL(MIXER_WRITE(SOUND_MIXER_DIGITAL3))
-COMPATIBLE_IOCTL(MIXER_WRITE(SOUND_MIXER_PHONEIN))
-COMPATIBLE_IOCTL(MIXER_WRITE(SOUND_MIXER_PHONEOUT))
-COMPATIBLE_IOCTL(MIXER_WRITE(SOUND_MIXER_VIDEO))
-COMPATIBLE_IOCTL(MIXER_WRITE(SOUND_MIXER_RADIO))
-COMPATIBLE_IOCTL(MIXER_WRITE(SOUND_MIXER_MONITOR))
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_MUTE)
-/* SOUND_MIXER_WRITE_ENHANCE,  same value as WRITE_MUTE */
-/* SOUND_MIXER_WRITE_LOUD,  same value as WRITE_MUTE */
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_RECSRC)
-COMPATIBLE_IOCTL(SOUND_MIXER_INFO)
-COMPATIBLE_IOCTL(SOUND_OLD_MIXER_INFO)
-COMPATIBLE_IOCTL(SOUND_MIXER_ACCESS)
-COMPATIBLE_IOCTL(SOUND_MIXER_AGC)
-COMPATIBLE_IOCTL(SOUND_MIXER_3DSE)
-COMPATIBLE_IOCTL(SOUND_MIXER_PRIVATE1)
-COMPATIBLE_IOCTL(SOUND_MIXER_PRIVATE2)
-COMPATIBLE_IOCTL(SOUND_MIXER_PRIVATE3)
-COMPATIBLE_IOCTL(SOUND_MIXER_PRIVATE4)
-COMPATIBLE_IOCTL(SOUND_MIXER_PRIVATE5)
-COMPATIBLE_IOCTL(SOUND_MIXER_GETLEVELS)
-COMPATIBLE_IOCTL(SOUND_MIXER_SETLEVELS)
-COMPATIBLE_IOCTL(OSS_GETVERSION)
 /* Raw devices */
 COMPATIBLE_IOCTL(RAW_SETBIND)
 COMPATIBLE_IOCTL(RAW_GETBIND)
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index f6ae68017608..f85ea328fd27 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2732,6 +2732,10 @@ static long snd_pcm_oss_ioctl(struct file *file, unsigned int cmd, unsigned long
 static long snd_pcm_oss_ioctl_compat(struct file *file, unsigned int cmd,
 				     unsigned long arg)
 {
+	/*
+	 * Everything is compatbile except SNDCTL_DSP_MAPINBUF/SNDCTL_DSP_MAPOUTBUF,
+	 * which are not implemented for the native case either
+	 */
 	return snd_pcm_oss_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
 }
 #else
diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
index fc9bcd47d6a4..f802ea331e24 100644
--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -384,6 +384,7 @@ static const struct file_operations mixer_fops =
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.unlocked_ioctl	= mixer_unlocked_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= mixer_open,
 	.release	= mixer_release,
 };
@@ -1167,6 +1168,7 @@ static const struct file_operations sq_fops =
 	.write		= sq_write,
 	.poll		= sq_poll,
 	.unlocked_ioctl	= sq_unlocked_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= sq_open,
 	.release	= sq_release,
 };
-- 
2.20.0

