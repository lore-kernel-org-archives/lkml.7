Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4758C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5372080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkB6qwlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfGISmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:42:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35016 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfGISmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:42:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so10533640plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YK8HnDW92D+ZcMeXZwEcU33SpTDrdHnDF8vDLTjwf5s=;
        b=kkB6qwlK4xX9daXzHcc9L1T4Mj6a6SO0VEC7YbpN2qEwk4FwZzherF440LW3iui/mu
         +kvX9cDmbK1vGjcozntltdcAVEjFRLjTc9XBKFRe1g2OCrklnm7Tvjp8Ncui4OsyOfGM
         +QqRYrmKTK/1esiT4f/+eVsQx5PoOj5zN+LgHQZ46SFk0W8MQRLd7R+HKaSFWYGnQ722
         XqleeeB3+8k5oSkgBONyzr7wRKwcphnvvgA++3vYtbbA20mDhQ9+J4AuGDLUYthlmlbX
         Ts48nyFv+28GaPMs5J9m24qpLGdsGlmwT2f8AYaLpwm4qCL8t8qruG7yQYD2FWJMwFc4
         Rk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YK8HnDW92D+ZcMeXZwEcU33SpTDrdHnDF8vDLTjwf5s=;
        b=FBzac6pZoI3c0XZDmmJi4v62/bl0Tz24YBdJzkko4dTkXZPCtEuyAgWvrb64Ao5phV
         Cv6Ox8jxfo3G0q6e9ZvgjqqBmMCcr2sd/uHEvHlJ8EsVCQSYRN4kPg2v2v222ICxDCyl
         /icaN71xKDdmDns2y6gKGgTRayVFCtD0rNNMr31U/gaxW/tDCax2dezbWlMHofWSGkTz
         kOtqU1J9Ih+UwXQyblXfJ4tbfJJ2wXqu83KcA2yYg3MvJ3e9r+Ew2cpRHqyC1T+/MMJm
         kBUAn2QZUHq5RWUc/Ngtgkzg9cPRZMvypshaXjK5+5JYfsd0EHeR6un2Lahg/oHHU5fj
         imIg==
X-Gm-Message-State: APjAAAVxaJcvPsAypwg2/Li76LFIuobwgjSarOF22WdHq2ws9p9JdaHA
        scH9ZlCXU8HVOdu+GKvd57g=
X-Google-Smtp-Source: APXvYqxpoGHClqBhZvSk6c0AeV7usiTYaC08tEej11WUV8nOUh0tPg53DkAkDAcCGle8Vk2SkZT8JA==
X-Received: by 2002:a17:902:f095:: with SMTP id go21mr34549642plb.58.1562697763289;
        Tue, 09 Jul 2019 11:42:43 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id l44sm3051428pje.29.2019.07.09.11.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 11:42:42 -0700 (PDT)
Date:   Wed, 10 Jul 2019 00:12:37 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sound: soc: bcm: cygnus-pcm: Unneeded variable: "ret".
Message-ID: <20190709184236.GA7873@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below issues reported by coccicheck

sound/soc/bcm/cygnus-pcm.c:642:5-8: Unneeded variable: "ret". Return "0"
on line 650
sound/soc/bcm/cygnus-pcm.c:671:5-8: Unneeded variable: "ret". Return "0"
on line 696

We cannot change return type of these functions as they are callback
functions of snd_pcm_ops

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/soc/bcm/cygnus-pcm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/bcm/cygnus-pcm.c b/sound/soc/bcm/cygnus-pcm.c
index 123ecf5..8966b02 100644
--- a/sound/soc/bcm/cygnus-pcm.c
+++ b/sound/soc/bcm/cygnus-pcm.c
@@ -639,7 +639,6 @@ static int cygnus_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct cygnus_aio_port *aio;
-	int ret = 0;
 
 	aio = cygnus_dai_get_dma_data(substream);
 	dev_dbg(rtd->cpu_dai->dev, "%s  port %d\n", __func__, aio->portnum);
@@ -647,7 +646,7 @@ static int cygnus_pcm_hw_params(struct snd_pcm_substream *substream,
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 	runtime->dma_bytes = params_buffer_bytes(params);
 
-	return ret;
+	return 0;
 }
 
 static int cygnus_pcm_hw_free(struct snd_pcm_substream *substream)
@@ -668,7 +667,6 @@ static int cygnus_pcm_prepare(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct cygnus_aio_port *aio;
 	unsigned long bufsize, periodsize;
-	int ret = 0;
 	bool is_play;
 	u32 start;
 	struct ringbuf_regs *p_rbuf = NULL;
@@ -693,7 +691,7 @@ static int cygnus_pcm_prepare(struct snd_pcm_substream *substream)
 	ringbuf_set_initial(aio->cygaud->audio, p_rbuf, is_play, start,
 				periodsize, bufsize);
 
-	return ret;
+	return 0;
 }
 
 static snd_pcm_uframes_t cygnus_pcm_pointer(struct snd_pcm_substream *substream)
-- 
2.7.4

