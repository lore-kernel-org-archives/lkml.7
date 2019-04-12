Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048F4C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BE22082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/EzBrKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfDLGk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:40:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36257 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfDLGk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:40:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id ck15so4621010plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 23:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=y+bMKdHi3SWeYs4dZvhMtk+AUKH/ZBVC2n8ty7LnNMw=;
        b=S/EzBrKjJJKgsluKYBFxQPiOpxxW782zUguX1a5Zvg0lojmCS9Tfce6kjL47U0FH8k
         zRO4WK5f7Bn/3J2Glth5uD5LRQemRVU5B19z9+s2U8GdF9xtmbp0WlF2KUBWVopieMkp
         0t2yz1wMI6jyS/x1Ol+9doChihWKwI+PS9Tdl3sBGlsFXtA2GDjkmL1l9XHue6WF/LQX
         EMd04VChvZbzYs2hUr6KQYaZyZXLgNcoIUuZvgsmTokc/kpKNjSYXCzzRKKJEVIomSpM
         EOIfD1x65D9iyLpoRqu9bvMPxZ0q388GXgFFRyHnll5H2NAgJFuexZGHYy2aeNHZdPlI
         9ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y+bMKdHi3SWeYs4dZvhMtk+AUKH/ZBVC2n8ty7LnNMw=;
        b=N0sgDf5Zm6inOMDFNxII2mstCF9wcemy2xtMkro7dYqSG+9y7yL1r2rS0yg1a0SiKZ
         Y8/b3qJwMsQmhkZ7nqIX9uB+E3kh+sVRVbhkce3t5PLIIFmB7oEYIR5l/eemWJlggC9C
         djVJIA1T1mnSltY6+iyPFrjxTgHxfNOkDhPjk5NCfjv35bii/xyqR8KNVQmzadgmVBx1
         XhOucQSr5tvMzbdou86KJHMRRZzAwp9mc1iiKr96Gc39TnHXHfodQfSAUsIxvlR+Eksu
         umvusIKIlMjsHHAyJlBBekojJFVDmXTO4BkqUqUX7LSNOkwTHZ1DFu1qTL7SXjvGxtGO
         wUOw==
X-Gm-Message-State: APjAAAW3iYXVgxp/wesELY6kj3IN9yPwoRhV+gCuIqLoqU2kAFEb98X3
        jhCKDU3Aibley/BB6YN6MgW7llMaPc4=
X-Google-Smtp-Source: APXvYqz7yEcQCcV2YqsuxzHQvEks2ZE/l/OOZgMrg0Wz6mqHYeR2PgroLF9cUQOlbXrypOEq4yA/5g==
X-Received: by 2002:a17:902:b089:: with SMTP id p9mr30161989plr.185.1555051226410;
        Thu, 11 Apr 2019 23:40:26 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h65sm100553081pfd.108.2019.04.11.23.40.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Apr 2019 23:40:25 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        baolin.wang@linaro.org, orsonzhai@gmail.com, zhang.lyra@gmail.com
Subject: [PATCH] ASoC: sprd: Add reserved DMA memory support
Date:   Fri, 12 Apr 2019 14:40:17 +0800
Message-Id: <ee4a22c3491628abf94c8d356dccd67984604811.1555049554.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Spreadtrum audio platform driver, it need allocate a larger DMA buffer
dynamically to copy audio data between userspace and kernel space, but that
will increase the risk of memory allocation failure especially the system
is under heavy load situation.

To make sure the audio can work in this scenario, we usually reserve one
region of memory to be used as a shared pool of DMA buffers for the
platform component. So add of_reserved_mem_device_init_by_idx() function
to initialize the shared pool of DMA buffers to be used by the platform
component.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 sound/soc/sprd/sprd-pcm-dma.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sprd/sprd-pcm-dma.c b/sound/soc/sprd/sprd-pcm-dma.c
index 9be6d4b..d38ebbb 100644
--- a/sound/soc/sprd/sprd-pcm-dma.c
+++ b/sound/soc/sprd/sprd-pcm-dma.c
@@ -6,6 +6,7 @@
 #include <linux/dma/sprd-dma.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -530,8 +531,14 @@ static void sprd_pcm_free(struct snd_pcm *pcm)
 
 static int sprd_soc_platform_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
+	ret = of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
+	if (ret)
+		dev_warn(&pdev->dev,
+			 "no reserved DMA memory for audio platform device\n");
+
 	ret = devm_snd_soc_register_component(&pdev->dev, &sprd_soc_component,
 					      NULL, 0);
 	if (ret)
-- 
1.7.9.5

