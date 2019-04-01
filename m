Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7C920830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140319;
	bh=NHXF0X/COFBsN7JaQUKmZb3uAn4dk1o2Hj51cSwqjjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IDDeeTF/hPFV9mfNzQqO831+sORBDw8RfUPupweZv68RMPd9wOlUT0KTySOFx4L9m
	 djqyw70MNeFC++S1zGNYkPSXKRaZ9fL4Bl9m9FSlWa9hfBLFKcBz+wJnb59bZd3Aks
	 ia1xQ7gBL4B7uHOXWSuwUggWppkvszWw14SGwMoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbfDARih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387937AbfDARif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:38:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C791020830;
        Mon,  1 Apr 2019 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140314;
        bh=NHXF0X/COFBsN7JaQUKmZb3uAn4dk1o2Hj51cSwqjjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Byn6lyvN28NX5qI3M3W63awc/A1DQoXfBHkptbpFbUBcBq0sdzjKZd8sCUv6T1KiP
         ZaCHDLBdXdFaOH8gVd1Xx4vRced/RBj5rLFX8R5YsDwpBrD29mjh4Lv6/HaDtc+8CE
         mRvvsNHnib39TSJ8HGfa2lZZTCoNDHQ7pbUnniJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d4503ae45b65c5bc1194@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 37/50] ALSA: pcm: Fix possible OOB access in PCM oss plugins
Date:   Mon,  1 Apr 2019 19:03:20 +0200
Message-Id: <20190401170045.180589483@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit ca0214ee2802dd47239a4e39fb21c5b00ef61b22 upstream.

The PCM OSS emulation converts and transfers the data on the fly via
"plugins".  The data is converted over the dynamically allocated
buffer for each plugin, and recently syzkaller caught OOB in this
flow.

Although the bisection by syzbot pointed out to the commit
65766ee0bf7f ("ALSA: oss: Use kvzalloc() for local buffer
allocations"), this is merely a commit to replace vmalloc() with
kvmalloc(), hence it can't be the cause.  The further debug action
revealed that this happens in the case where a slave PCM doesn't
support only the stereo channels while the OSS stream is set up for a
mono channel.  Below is a brief explanation:

At each OSS parameter change, the driver sets up the PCM hw_params
again in snd_pcm_oss_change_params_lock().  This is also the place
where plugins are created and local buffers are allocated.  The
problem is that the plugins are created before the final hw_params is
determined.  Namely, two snd_pcm_hw_param_near() calls for setting the
period size and periods may influence on the final result of channels,
rates, etc, too, while the current code has already created plugins
beforehand with the premature values.  So, the plugin believes that
channels=1, while the actual I/O is with channels=2, which makes the
driver reading/writing over the allocated buffer size.

The fix is simply to move the plugin allocation code after the final
hw_params call.

Reported-by: syzbot+d4503ae45b65c5bc1194@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/pcm_oss.c |   43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -951,6 +951,28 @@ static int snd_pcm_oss_change_params_loc
 	oss_frame_size = snd_pcm_format_physical_width(params_format(params)) *
 			 params_channels(params) / 8;
 
+	err = snd_pcm_oss_period_size(substream, params, sparams);
+	if (err < 0)
+		goto failure;
+
+	n = snd_pcm_plug_slave_size(substream, runtime->oss.period_bytes / oss_frame_size);
+	err = snd_pcm_hw_param_near(substream, sparams, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, n, NULL);
+	if (err < 0)
+		goto failure;
+
+	err = snd_pcm_hw_param_near(substream, sparams, SNDRV_PCM_HW_PARAM_PERIODS,
+				     runtime->oss.periods, NULL);
+	if (err < 0)
+		goto failure;
+
+	snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DROP, NULL);
+
+	err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_HW_PARAMS, sparams);
+	if (err < 0) {
+		pcm_dbg(substream->pcm, "HW_PARAMS failed: %i\n", err);
+		goto failure;
+	}
+
 #ifdef CONFIG_SND_PCM_OSS_PLUGINS
 	snd_pcm_oss_plugin_clear(substream);
 	if (!direct) {
@@ -985,27 +1007,6 @@ static int snd_pcm_oss_change_params_loc
 	}
 #endif
 
-	err = snd_pcm_oss_period_size(substream, params, sparams);
-	if (err < 0)
-		goto failure;
-
-	n = snd_pcm_plug_slave_size(substream, runtime->oss.period_bytes / oss_frame_size);
-	err = snd_pcm_hw_param_near(substream, sparams, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, n, NULL);
-	if (err < 0)
-		goto failure;
-
-	err = snd_pcm_hw_param_near(substream, sparams, SNDRV_PCM_HW_PARAM_PERIODS,
-				     runtime->oss.periods, NULL);
-	if (err < 0)
-		goto failure;
-
-	snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DROP, NULL);
-
-	if ((err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_HW_PARAMS, sparams)) < 0) {
-		pcm_dbg(substream->pcm, "HW_PARAMS failed: %i\n", err);
-		goto failure;
-	}
-
 	if (runtime->oss.trigger) {
 		sw_params->start_threshold = 1;
 	} else {


