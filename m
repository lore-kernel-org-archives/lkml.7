Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9B7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79D520856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553581999;
	bh=c5SGd1d6ETVjNf12ZRnjEJPJ/Wi993hhDzL+jlmNdZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=peKLuKvokihSBLTPzcesKtGDvOoLSPrSORIFcjj/EACBNP7VM4pUFTAKtDRtcGstq
	 0mp5zv4Lg9pzK9dryCTJV5ZDjkrl4qeghkX4wrK9CJEVFjtvfSx7I2pK934HFT6Pbw
	 kcJ2WGV2GhuEYxiTRCSYT/H0CKvnYiI3imBC6UMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbfCZGdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731611AbfCZGdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:33:16 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2CFA20856;
        Tue, 26 Mar 2019 06:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581994;
        bh=c5SGd1d6ETVjNf12ZRnjEJPJ/Wi993hhDzL+jlmNdZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqE6sha+9fwvZUvRQp37EalFxRhykolnCswbU74Gran+uRfH+OnmxeEToXmyOZJf5
         HReB4NU2iW5jCd5KrUeFVf9z7L+AHlHeh1tXiQCwidTYhNTuDXhVuBcUkUUolKk7tT
         sKXRtwUpHjYcPXTcxuoJyHIdDa7rrzin22JN9dPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH 4.14 14/41] ALSA: x86: Fix runtime PM for hdmi-lpe-audio
Date:   Tue, 26 Mar 2019 15:29:51 +0900
Message-Id: <20190326042650.745590731@linuxfoundation.org>
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 8dfb839cfe737a17def8e5f88ee13c295230364a upstream.

Commit 46e831abe864 ("drm/i915/lpe: Mark LPE audio runtime pm as
"no callbacks"") broke runtime PM with lpe audio. We can no longer
runtime suspend the GPU since the sysfs  power/control for the
lpe-audio device no longer exists and the device is considered
always active. We can fix this by not marking the device as
active.

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Fixes: 46e831abe864 ("drm/i915/lpe: Mark LPE audio runtime pm as "no callbacks"")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181024154825.18185-1-ville.syrjala@linux.intel.com
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Acked-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/x86/intel_hdmi_audio.c |    1 -
 1 file changed, 1 deletion(-)

--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1887,7 +1887,6 @@ static int hdmi_lpe_audio_probe(struct p
 
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
 
 	dev_dbg(&pdev->dev, "%s: handle pending notification\n", __func__);
 	for_each_port(card_ctx, port) {


