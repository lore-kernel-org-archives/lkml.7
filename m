Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6145EC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E5520675
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+8759gG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfESR5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:57:25 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38948 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfESR5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:57:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id e24so19942539edq.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2KDJMNJfIv5qLkX9gjcuIru5PdS9zm2I9aje75Yv/6w=;
        b=l+8759gGZy5S/jxlabgPPs2V+a/SRM9cdSQ0+67gyx5DqfYk/5qoGhbTTHeO+8/kt1
         vAga7RE/6uB7F6XPw1TefZgf+ucaQEcCOgkaBina5W5iFyhc26yYaa7UZL1LO8r1sApo
         7Fhqa3UuuFLVKn2j4VMOtnn1zO6z7KVCsfhg+6vH9/fyEbe6ntyEqCuWcXz9WoLkRdiI
         YPXcl30wRvNkI556ukv4n3zPklKb6nyhgyY6tW87V7iaR4qeCPxHh2Ztdxv5pKp7KTuD
         6X7BpL+Pzw3I1efXxXSYLs9ZtXrOMIYiaO9UMiRN6PiTaIxeM3djj7cQwnbPjeuaSRtT
         rDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2KDJMNJfIv5qLkX9gjcuIru5PdS9zm2I9aje75Yv/6w=;
        b=Qs2mZUwoSP5RD2vfX35GZe//RM8BRiF9twAsXUn1/hDy+tFjIA29wJYy2b/m0H+u+J
         /F0HEHU0g9Eozu/m0AvfdG9vsz2JB9b/ZpZbnSIDNXMX/OlCppUHJE5Hx+licm1xt+ag
         GM1cej5lKL1g5khNU60MsIare54t6rR0/a5ChoHoqmZSk7DFLYGAlzzgSn2NwdvyYhG8
         ZQZl4pZTL0qShlPu3GEdp4TzC6j/stbvxLAa8JNeguLYvWfM9e5GhXcUelPrXatgjkzK
         N36fqinECU59B0h2x+IztuKKP1yHPi0jGRgE/llExYzaGfVRQbmLxq+HwNGBsakp6+uP
         cEyg==
X-Gm-Message-State: APjAAAXzmrU/3Cw52mNiGjVjteMDiL5ToqKcdH97nvMCdOz+cjl+5RBU
        7gLRLg8AdSplXoN2qn/l7KE=
X-Google-Smtp-Source: APXvYqzEvNUVnANyNFltuSglkuQsB1moXN98HHJaC97f/0xeIx8YKGzQqYpDqwYWt1s50urnsGQjHw==
X-Received: by 2002:a17:906:3955:: with SMTP id g21mr54442419eje.61.1558288643498;
        Sun, 19 May 2019 10:57:23 -0700 (PDT)
Received: from elitebook-localhost (84-106-70-146.cable.dynamic.v4.ziggo.nl. [84.106.70.146])
        by smtp.gmail.com with ESMTPSA id z10sm4921920edl.35.2019.05.19.10.57.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 May 2019 10:57:22 -0700 (PDT)
From:   nariman <narimantos@gmail.com>
To:     broonie@kernel.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Damian van Soelen <dj.vsoelen@gmail.com>,
        Nariman Etemadi <narimantos@gmail.com>
Subject: [PATCH] ASoC: Intel: cht_bsw_rt5645.c: Remove buffer and snprintf calls
Date:   Sun, 19 May 2019 19:57:04 +0200
Message-Id: <20190519175706.3998-2-narimantos@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190519175706.3998-1-narimantos@gmail.com>
References: <20190519175706.3998-1-narimantos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damian van Soelen <dj.vsoelen@gmail.com>

The snprintf calls filling cht_rt5645_cpu_dai_name / cht_rt5645_codec_aif_name
always fill them with the same string ("ssp0-port" resp "rt5645-aif2") so
instead of keeping these buffers around and making the cpu_dai_name /
codec_aif_name point to this, simply update the foo_dai_name and foo_aif_name pointers to
directly point to a string constant containing the desired string.

Signed-off-by: Damian van Soelen <dj.vsoelen@gmail.com>
Signed-off-by: Nariman Etemadi <narimantos@gmail.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 26 ++++---------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index cbc2d458483f..b15459e56665 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -506,8 +506,6 @@ static struct cht_acpi_card snd_soc_cards[] = {
 };
 
 static char cht_rt5645_codec_name[SND_ACPI_I2C_ID_LEN];
-static char cht_rt5645_codec_aif_name[12]; /*  = "rt5645-aif[1|2]" */
-static char cht_rt5645_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
 
 static bool is_valleyview(void)
 {
@@ -641,28 +639,12 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	log_quirks(&pdev->dev);
 
 	if ((cht_rt5645_quirk & CHT_RT5645_SSP2_AIF2) ||
-		(cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2)) {
-
-		/* fixup codec aif name */
-		snprintf(cht_rt5645_codec_aif_name,
-			sizeof(cht_rt5645_codec_aif_name),
-			"%s", "rt5645-aif2");
-
-		cht_dailink[dai_index].codec_dai_name =
-			cht_rt5645_codec_aif_name;
-	}
+		(cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2))
+			cht_dailink[dai_index].codec_dai_name = "rt5645-aif2";
 
 	if ((cht_rt5645_quirk & CHT_RT5645_SSP0_AIF1) ||
-		(cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2)) {
-
-		/* fixup cpu dai name name */
-		snprintf(cht_rt5645_cpu_dai_name,
-			sizeof(cht_rt5645_cpu_dai_name),
-			"%s", "ssp0-port");
-
-		cht_dailink[dai_index].cpu_dai_name =
-			cht_rt5645_cpu_dai_name;
-	}
+		(cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2))
+			cht_dailink[dai_index].cpu_dai_name = "ssp0-port";
 
 	/* override plaform name, if required */
 	platform_name = mach->mach_params.platform;
-- 
2.20.1

