Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AF2C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6B622C7D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB3SzSLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfGZDQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 23:16:05 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:38379 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfGZDQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 23:16:05 -0400
Received: by mail-pl1-f182.google.com with SMTP id az7so24162141plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 20:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/B4PDbbLi5E1r0p6qSNmBst0wo4BQnbZB0T82FXT7w4=;
        b=HB3SzSLNZgP3rRGFcwcbsiXgyEDMK0pjMowqn/aL2/C5yGPqlXdlqD3OXsxIcrU4kd
         FISzszaeLKh2R8uKJcneWq4qArASzFVMAo/aXOeb9ExFWUqszLM8R2AQFtySKUyNoxN4
         vU4Zhr9wMhgATsWvOUDQamBR35fWNQTOaG5GwIiCANhydbdnt9oAeAoakUpSwb2MV4Nm
         w4VNCWxEnr1tlzVPGvmwm4DGgUVFh9PM1PsGJ5sLP7IUAkLwB/VUBGlxO6zmlG7aV37Y
         eusmHwAnjH2iXKA8puzmoKk7v5SWHoHuk0rPDit34lSPzljPVxbLmsSQj5TpJ2vNwjMA
         YCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/B4PDbbLi5E1r0p6qSNmBst0wo4BQnbZB0T82FXT7w4=;
        b=DVSm7GlsiNtkWc0pr7Vo8jlkSgaroS1xvV3Y6mNdy+QEfmLilGS3q8zx8Hz3nDlj9q
         M/UHuhup2nKYOj8Yrd02nD5RCQqw8pZ1KMDOeTvjyEA1Fa1Dd3xp16hHYYqxW5NYoHnH
         OZAX1VgAMF2DtnkL6win2soxQSXfXeOKJsut5N1LnuMuvpcwz48HFvG9cyyq/TsdugN3
         TKLH+eKO5MV/4ca3cG5zaX2N3ZOOtt1RG7LkbiogyHBmpwfAC2B5/jzqohPy/jL3O4Gh
         O+Rr3zGAha4/kBOzk0bpSm6+9pWoDxoGWs8puwi3ECUY9e6NHWbdtJD5MrfH3wGJuvGb
         Pddg==
X-Gm-Message-State: APjAAAU7RqRpACzjMOXyq+zPFg/gk/PPB3ZxlY4xsMQMERsvPM8pkuSk
        WeOBOeqImYnIPr734wRLTy0HnJaz6MM=
X-Google-Smtp-Source: APXvYqzwRGeUo5iz5wOc36RldeVhxs5QFaLYCb79nuUFWoGgDB8PW6STs4idXE/XG86zJAMSBOuWnw==
X-Received: by 2002:a17:902:23:: with SMTP id 32mr7120299pla.34.1564110963790;
        Thu, 25 Jul 2019 20:16:03 -0700 (PDT)
Received: from satendra-MM061.ib-wrb304n.setup.in ([103.82.150.240])
        by smtp.gmail.com with ESMTPSA id v63sm52999506pfv.174.2019.07.25.20.16.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 20:16:02 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Satendra Singh Thakur <sst2005@gmail.com>
Subject: [PATCH] [ASoC][soc-dapm] : memory leak in the func snd_soc_dapm_new_dai
Date:   Fri, 26 Jul 2019 08:45:42 +0530
Message-Id: <20190726031542.19820-1-sst2005@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the func snd_soc_dapm_new_dai, if the inner func
snd_soc_dapm_alloc_kcontrol fails, there will be memory leak.
The label param_fail wont free memory which is allocated by
the func devm_kcalloc. Hence new label is created for this purpose.

Signed-off-by: Satendra Singh Thakur <sst2005@gmail.com>
---
 sound/soc/soc-dapm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f013b24c050a..f62d41ee6d68 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4095,7 +4095,7 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 						w_param_text, &private_value);
 		if (!template.kcontrol_news) {
 			ret = -ENOMEM;
-			goto param_fail;
+			goto outfree_w_param;
 		}
 	} else {
 		w_param_text = NULL;
@@ -4114,6 +4114,7 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 
 outfree_kcontrol_news:
 	devm_kfree(card->dev, (void *)template.kcontrol_news);
+outfree_w_param:
 	snd_soc_dapm_free_kcontrol(card, &private_value,
 				   rtd->dai_link->num_params, w_param_text);
 param_fail:
-- 
2.17.1

