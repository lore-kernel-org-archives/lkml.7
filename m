Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649DAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3106F2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582747;
	bh=CH6dk7fVzt5fi0KC1bqhmiQ266xLVgNZh9bY3aRNTQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QsBBmcB5L7qajrDD4K41RaVpn9Lf7LPySGCNiR1Pa/OlQcuJXRHY4L7rn8BfEJRKr
	 cXOFKf6uIfkF9NBzolEBPVhciDr7NAd2jdAx+ycZ0UcMhCaTA7KalICC6/ZhFlYRDV
	 FP6l8kodoDPPBxurI2lMuSSdqF8wVqWDliXeXS4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbfCZGeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731361AbfCZGeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:34:07 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FEB92070B;
        Tue, 26 Mar 2019 06:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582045;
        bh=CH6dk7fVzt5fi0KC1bqhmiQ266xLVgNZh9bY3aRNTQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVBS/XHqPCjpk4X38SS+fBbqje2KXQZswMeTou+03OKpkWTZ+NTVYuSeoeUsn5Ic2
         aYlmLQ1D0YY1KXNCUVYI6UFW86RRgXVVcTskc7LqgZ+wALkvoFmmIfSgyUyP8hxDw3
         Z2Nu54q5OtlMTO5UnW6XhXrM04XuCmv50e6CgLd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 29/41] ALSA: hda - Record the current power state before suspend/resume calls
Date:   Tue, 26 Mar 2019 15:30:06 +0900
Message-Id: <20190326042651.503009188@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 98081ca62cbac31fb0f7efaf90b2e7384ce22257 upstream.

Currently we deal with single codec and suspend codec callbacks for
all S3, S4 and runtime PM handling.  But it turned out that we want
distinguish the call patterns sometimes, e.g. for applying some init
sequence only at probing and restoring from hibernate.

This patch slightly modifies the common PM callbacks for HD-audio
codec and stores the currently processed PM event in power_state of
the codec's device.power field, which is currently unused.  The codec
callback can take a look at this event value and judges which purpose
it's being called.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_codec.c |   43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2900,6 +2900,7 @@ static void hda_call_codec_resume(struct
 		hda_jackpoll_work(&codec->jackpoll_work.work);
 	else
 		snd_hda_jack_report_sync(codec);
+	codec->core.dev.power.power_state = PMSG_ON;
 	atomic_dec(&codec->core.in_pm);
 }
 
@@ -2932,10 +2933,48 @@ static int hda_codec_runtime_resume(stru
 }
 #endif /* CONFIG_PM */
 
+#ifdef CONFIG_PM_SLEEP
+static int hda_codec_pm_suspend(struct device *dev)
+{
+	dev->power.power_state = PMSG_SUSPEND;
+	return pm_runtime_force_suspend(dev);
+}
+
+static int hda_codec_pm_resume(struct device *dev)
+{
+	dev->power.power_state = PMSG_RESUME;
+	return pm_runtime_force_resume(dev);
+}
+
+static int hda_codec_pm_freeze(struct device *dev)
+{
+	dev->power.power_state = PMSG_FREEZE;
+	return pm_runtime_force_suspend(dev);
+}
+
+static int hda_codec_pm_thaw(struct device *dev)
+{
+	dev->power.power_state = PMSG_THAW;
+	return pm_runtime_force_resume(dev);
+}
+
+static int hda_codec_pm_restore(struct device *dev)
+{
+	dev->power.power_state = PMSG_RESTORE;
+	return pm_runtime_force_resume(dev);
+}
+#endif /* CONFIG_PM_SLEEP */
+
 /* referred in hda_bind.c */
 const struct dev_pm_ops hda_codec_driver_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+#ifdef CONFIG_PM_SLEEP
+	.suspend = hda_codec_pm_suspend,
+	.resume = hda_codec_pm_resume,
+	.freeze = hda_codec_pm_freeze,
+	.thaw = hda_codec_pm_thaw,
+	.poweroff = hda_codec_pm_suspend,
+	.restore = hda_codec_pm_restore,
+#endif /* CONFIG_PM_SLEEP */
 	SET_RUNTIME_PM_OPS(hda_codec_runtime_suspend, hda_codec_runtime_resume,
 			   NULL)
 };


