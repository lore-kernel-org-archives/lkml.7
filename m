Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98CBC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B987216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q9qEe6nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfGIECO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:02:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46759 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfGIECO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:02:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so7780798plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 21:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eRS78OWHqkPassIhCrQBp7dftHSLHAwV/FZqf0gRdDE=;
        b=Q9qEe6nlNveqMLgdp9dy7hMTu8Qj4wowQPPPFvIveM8eDDunlIwyhQK1cwwGoBKh0I
         xVXUKnt7PSm9xaepMoQCga54ppDTviuo247P6zwRS8Hz2M5txQrsH/K/XP+f2uvU/PNa
         /qDkBdtmuKwQRG/duwbvCriisvI01pbz0j0tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eRS78OWHqkPassIhCrQBp7dftHSLHAwV/FZqf0gRdDE=;
        b=WZFEP/tn3Rx+BxZVMlOA0hskmfhOiCYtFYo23S4PNJeTJK23zyG6RjfwbRdQxoJ3sb
         pJhJv5gVWzQZCsvuLvw7bgjGNjRGUWI4Zfdo9l3M+tlWHPHV4qf++PHoPy3h2bVJPgbF
         sYrJHU6JcjHblkZiVBD/ap2WyMBhz7hklXZu0kklhTGPUYC6BfpJGHO5LdwqiJfas3kA
         YxQbvBi6oh+HzGSfN5/bjF6Wh0AN8WkYkWiyb93e7p2lBzXAOiEF2Y/sx8TbAsUeyTsv
         fmGLQSyX1i6mxOxvdrd8617UTrxTQ4WuhFFP53BvQdwUVdOsL6Wc8wMvOZ1xkN2lg+/r
         ITDA==
X-Gm-Message-State: APjAAAWgnEBvp4NLK0plUgh4Jwe4YNouRwcriGBtUQXO3e3s94z5EQDk
        Ff6Qs4Fj679O3e+xl0DnZ9lXVw==
X-Google-Smtp-Source: APXvYqw1POX5vUNQfCeCAYBFdnr8Hff0wsdebHhnjXjJxe04kvt3a7FE1kpZ1AlgHQbJC8nJcqu/3w==
X-Received: by 2002:a17:902:2884:: with SMTP id f4mr28745735plb.286.1562644933885;
        Mon, 08 Jul 2019 21:02:13 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:82b8:d8c4:6cb6:57f5])
        by smtp.gmail.com with ESMTPSA id k5sm861841pjl.32.2019.07.08.21.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 21:02:12 -0700 (PDT)
From:   Alex Levin <levinale@chromium.org>
To:     alsa-devel@alsa-project.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alex Levin <levinale@chromium.org>,
        linux-kernel@vger.kernel.org, benzh@chromium.org,
        cujomalainey@chromium.org
Subject: [PATCH] ASoC: Intel: Atom: read timestamp moved to period_elapsed
Date:   Mon,  8 Jul 2019 21:01:47 -0700
Message-Id: <20190709040147.111927-1-levinale@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sst_platform_pcm_pointer is called from both snd_pcm_period_elapsed and
from snd_pcm_ioctl. Calling read timestamp results in recalculating
pcm_delay and buffer_ptr (sst_calc_tstamp) which consumes buffers in a
faster rate than intended.
In a tested BSW system with chtrt5650, for a rate of 48000, the
measured rate was sometimes 10 times more than that.
After moving the timestamp read to period elapsed, buffer consumption is
as expected.

Signed-off-by: Alex Levin <levinale@chromium.org>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 23 +++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 0e8b1c5eec88..196af0b30b41 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -265,16 +265,28 @@ static void sst_period_elapsed(void *arg)
 {
 	struct snd_pcm_substream *substream = arg;
 	struct sst_runtime_stream *stream;
-	int status;
+	struct snd_soc_pcm_runtime *rtd;
+	int status, ret_val;
 
 	if (!substream || !substream->runtime)
 		return;
 	stream = substream->runtime->private_data;
 	if (!stream)
 		return;
+
+	rtd = substream->private_data;
+	if (!rtd)
+		return;
+
 	status = sst_get_stream_status(stream);
 	if (status != SST_PLATFORM_RUNNING)
 		return;
+
+	ret_val = stream->ops->stream_read_tstamp(sst->dev, &stream->stream_info);
+	if (ret_val) {
+		dev_err(rtd->dev, "stream_read_tstamp err code = %d\n", ret_val);
+		return;
+	}
 	snd_pcm_period_elapsed(substream);
 }
 
@@ -658,20 +670,15 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
 			(struct snd_pcm_substream *substream)
 {
 	struct sst_runtime_stream *stream;
-	int ret_val, status;
+	int status;
 	struct pcm_stream_info *str_info;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 
 	stream = substream->runtime->private_data;
 	status = sst_get_stream_status(stream);
 	if (status == SST_PLATFORM_INIT)
 		return 0;
+
 	str_info = &stream->stream_info;
-	ret_val = stream->ops->stream_read_tstamp(sst->dev, str_info);
-	if (ret_val) {
-		dev_err(rtd->dev, "sst: error code = %d\n", ret_val);
-		return ret_val;
-	}
 	substream->runtime->delay = str_info->pcm_delay;
 	return str_info->buffer_ptr;
 }
-- 
2.22.0.410.gd8fdbe21b5-goog

