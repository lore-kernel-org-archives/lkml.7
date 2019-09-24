Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE94C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EF5217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niHE/crm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389858AbfIXPdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:33:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39396 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbfIXPdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:33:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17so1148486plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bPgGMeHX52Zgve81Fb6Zz6kKe0AroWoZpYr70OMqndQ=;
        b=niHE/crmYUFDmG2qHk6Z6QdYguIBLD9lHVWxW4LF7yKqKYbRitFfr+0vKA63CJ0hAN
         bJPlZqyqCPJw734HH3FogzEY6fk3Txx01LalDLW3r6iUp22jo/lt3QtI2hXsWeKXVtYx
         ItFzcpG+DKelvqsowc7kHnH1AWK56a36oI+bO/fZm4LxdksbTUbFwOUW/VXbEXrkTHJ9
         hoEhUu4KhYygR+6FUS11vhGcWZLQmln2c+GoeorihGal1f5B4WHE0hS+KoaZFKwMvlKf
         42ajOM23xKdWRlihesYjluu02R0FaDnf+y7hCWVI1W219RFWjP/IQ9ysVnDYtAP8Pd0l
         oZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bPgGMeHX52Zgve81Fb6Zz6kKe0AroWoZpYr70OMqndQ=;
        b=iUxHCvHWIgRj1t+XWW/qVHTMGrhY4+Wfa2AWU8mFFTbgPb5qxWpEwhobeL8mVC6OhQ
         gc8Yph5dnHyiiFLhioPIbvBBBznWT2MQ6pA1USfXlLBrzaEFT8hbIMsoEYZOSQ55AAbG
         oR4BZGs7m1B42m0AdEHHyUWGjaKNAPnCBG3hR0iC4NAwtjo3nAJA7gCGBvfggKoRVyRn
         ijKWFeplCqAdxkwS3sgaslFoA6AUblO3iGEPPBvXRmBw8gFYhQ0qZNEAi3HLkJ5YdqdL
         ZdyZgGzYkDm7v5SAr1sq9aapY/2ANs7f+/N99lf/6j16br0BkAJinbymDrzZD5EUqMF3
         sBGA==
X-Gm-Message-State: APjAAAWalSClx9yPydgYQVfyZR8IRTcvmdpWSTd04YYelwyOqE9YyfLC
        AFrYopHlqIDfge1BKRwe15U=
X-Google-Smtp-Source: APXvYqwYd6NWFBfPfig6VqCOebE6z1UI9i+Zo+Nhn/fhKAa2mnu5o8QTRu3d8DsXmMPM+DWf9kunnA==
X-Received: by 2002:a17:902:242:: with SMTP id 60mr3856083plc.86.1569339209842;
        Tue, 24 Sep 2019 08:33:29 -0700 (PDT)
Received: from linux.eic.com ([103.249.233.35])
        by smtp.gmail.com with ESMTPSA id e192sm2621566pfh.83.2019.09.24.08.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 08:33:29 -0700 (PDT)
Date:   Tue, 24 Sep 2019 21:03:17 +0530
From:   Chetan Kankotiya <chetankankotiya@gmail.com>
To:     plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: sdm845: remove unnecessary goto
Message-ID: <20190924153317.GA23893@linux.eic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no specific handling in the error path of
sdm845_tdm_snd_hw_params, remove the unnecessary goto and label.
As there is no specific handling in error path return with error code
directly.

Signed-off-by: Chetan Kankotiya <chetankankotiya@gmail.com>
---
 sound/soc/qcom/sdm845.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 28f3cef696e6..e9d6588e61ee 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -61,7 +61,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 		if (ret < 0) {
 			dev_err(rtd->dev, "%s: failed to set tdm slot, err:%d\n",
 					__func__, ret);
-			goto end;
+			return ret;
 		}
 
 		ret = snd_soc_dai_set_channel_map(cpu_dai, 0, NULL,
@@ -69,7 +69,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 		if (ret < 0) {
 			dev_err(rtd->dev, "%s: failed to set channel map, err:%d\n",
 					__func__, ret);
-			goto end;
+			return ret;
 		}
 	} else {
 		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0xf, 0,
@@ -77,7 +77,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 		if (ret < 0) {
 			dev_err(rtd->dev, "%s: failed to set tdm slot, err:%d\n",
 					__func__, ret);
-			goto end;
+			return ret;
 		}
 
 		ret = snd_soc_dai_set_channel_map(cpu_dai, channels,
@@ -85,7 +85,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 		if (ret < 0) {
 			dev_err(rtd->dev, "%s: failed to set channel map, err:%d\n",
 					__func__, ret);
-			goto end;
+			return ret;
 		}
 	}
 
@@ -117,8 +117,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-end:
-	return ret;
+	return 0;
 }
 
 static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
-- 
2.20.1

