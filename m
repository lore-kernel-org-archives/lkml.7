Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF2AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB0F20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582282;
	bh=d0LZQVmkwKoC+KOo44e+swDldATl5u07QK342dpbSlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i/5Max1cAohgW+q81Bgilo7hPWpzIHYlDEaEOi1IZEFRX0SBH0zD4CF7yhjIHdD58
	 wbHs1TWv0kUi1vQ98hiHmI+CGEwvI3cEin2i0/QBU8wIB1wSxdQx/fcy10PPwI7Dey
	 lvVArvJ1gbc4dWCk6jOQr7zsru7Ef4RQy9cP6a64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbfCZGiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:38:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732440AbfCZGh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:37:58 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 363CF2075E;
        Tue, 26 Mar 2019 06:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582276;
        bh=d0LZQVmkwKoC+KOo44e+swDldATl5u07QK342dpbSlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=01IdKLwte9vIzAsZir5ZmCgBVuXr01WEZZLX9SGVyG21nWBuhWdLZS8OmZBr3ENIn
         +/BNvJodSjFUrfkWqe/yT/ffGgDMuHONpPYbkbtQ6jaKE5k5lc67msLA1kI/2Dbxbq
         cJoT+88/uEYa86FM1N1zrywJLSwVm5rfaULjeVBU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 44/45] ALSA: hda - Enforces runtime_resume after S3 and S4 for each codec
Date:   Tue, 26 Mar 2019 15:30:27 +0900
Message-Id: <20190326042705.005848439@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Wang <hui.wang@canonical.com>

commit b5a236c175b0d984552a5f7c9d35141024c2b261 upstream.

Recently we found the audio jack detection stop working after suspend
on many machines with Realtek codec. Sometimes the audio selection
dialogue didn't show up after users plugged headhphone/headset into
the headset jack, sometimes after uses plugged headphone/headset, then
click the sound icon on the upper-right corner of gnome-desktop, it
also showed the speaker rather than the headphone.

The root cause is that before suspend, the codec already call the
runtime_suspend since this codec is not used by any apps, then in
resume, it will not call runtime_resume for this codec. But for some
realtek codec (so far, alc236, alc255 and alc891) with the specific
BIOS, if it doesn't run runtime_resume after suspend, all codec
functions including jack detection stop working anymore.

This problem existed for a long time, but it was not exposed, that is
because when problem happens, if users play sound or open
sound-setting to check audio device, this will trigger calling to
runtime_resume (via snd_hda_power_up), then the codec starts working
again before users notice this problem.

Since we don't know how many codec and BIOS combinations have this
problem, to fix it, let the driver call runtime_resume for all codecs
in pm_resume, maybe for some codecs, this is not needed, but it is
harmless. After a codec is runtime resumed, if it is not used by any
apps, it will be runtime suspended soon and furthermore we don't run
suspend frequently, this change will not add much power consumption.

Fixes: cc72da7d4d06 ("ALSA: hda - Use standard runtime PM for codec power-save control")
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_codec.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2944,6 +2944,20 @@ static int hda_codec_runtime_resume(stru
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_PM_SLEEP
+static int hda_codec_force_resume(struct device *dev)
+{
+	int ret;
+
+	/* The get/put pair below enforces the runtime resume even if the
+	 * device hasn't been used at suspend time.  This trick is needed to
+	 * update the jack state change during the sleep.
+	 */
+	pm_runtime_get_noresume(dev);
+	ret = pm_runtime_force_resume(dev);
+	pm_runtime_put(dev);
+	return ret;
+}
+
 static int hda_codec_pm_suspend(struct device *dev)
 {
 	dev->power.power_state = PMSG_SUSPEND;
@@ -2953,7 +2967,7 @@ static int hda_codec_pm_suspend(struct d
 static int hda_codec_pm_resume(struct device *dev)
 {
 	dev->power.power_state = PMSG_RESUME;
-	return pm_runtime_force_resume(dev);
+	return hda_codec_force_resume(dev);
 }
 
 static int hda_codec_pm_freeze(struct device *dev)
@@ -2965,13 +2979,13 @@ static int hda_codec_pm_freeze(struct de
 static int hda_codec_pm_thaw(struct device *dev)
 {
 	dev->power.power_state = PMSG_THAW;
-	return pm_runtime_force_resume(dev);
+	return hda_codec_force_resume(dev);
 }
 
 static int hda_codec_pm_restore(struct device *dev)
 {
 	dev->power.power_state = PMSG_RESTORE;
-	return pm_runtime_force_resume(dev);
+	return hda_codec_force_resume(dev);
 }
 #endif /* CONFIG_PM_SLEEP */
 


