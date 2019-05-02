Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB80DC04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB30C2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Gn8SvsLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfEBMLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:11:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37556 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfEBMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:11:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id k23so3015967wrd.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oCtO7F4iCfswKyRGi7bOSLphK4gIn4iJZV2uNp5ivzs=;
        b=Gn8SvsLQMxKlYfYvb5wfkMqO5ckj8c3meyR1C3aEF7HNubkJ1NYdrJV78Fn4DIcTc2
         750uPQfLMl89SFZVsmnEJSvaPPNSwxsgI9dXKjMCp1D61Qha+89LL/J4SCUdIsk/J0dX
         sFXO4IQo2P0IQtqgww6Tm2hVB0yxjd55TI6Ed3Y9xvMGF5PWOSlwCZlFLC5IS7WPB+sO
         Y0fjL8vgivscCL6P0QoLWuwI5Wsl2E2ihgRT9AewjeuhAB3aMlikCoxqnbCC4x5upxwp
         DFnouu0WnTTIOg6TR60OvVdUtOQULErUwESdhxKc24p93FG6V2sFDU1c8uHzJNKS89oI
         ieBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oCtO7F4iCfswKyRGi7bOSLphK4gIn4iJZV2uNp5ivzs=;
        b=KCQMJwgkiYfzalILd9Jl0BTWWacD+bkKHasmdt9wu0jrepA9tBblKB7HGjOBK/F4lB
         2G+OD4bNlMyDkJ5+wGa0EGNuLzOZ88nlyIqH9ZGvJA9gpZCpcs70urS/Wlx1aoKm61/r
         1l+jIoHRKVFWx3PDH1FgoaavZuti3JaHBOIAXFjSBBDH0GBXI0H0p2XjaK/hdHR3VxMy
         5ufGZZiTzt8B8fRbauZ4yxWUz0zoAXgV5zHkjmb3jHZEkbesKVMkUHhgaGx0fSjmXj8H
         aSNShqNP9p4xJtz77DQ5U8fAh8C/B5lwPRUbEPZh752kCGuKEepr17HQGkUmcyBjrc6w
         jIXg==
X-Gm-Message-State: APjAAAWu9K2CcaHx35kQpy92Ti/yJaBm8/5Y1ATHdcnHhUFZarPiZwQP
        tlFgQTkWB8QWMPsELTjxcoWLuQ==
X-Google-Smtp-Source: APXvYqwiOYJrXyeXMjSrke5vRgXR13G0kZTQzgHmDuQOjoYmPdNvfpQ6nGVxnTDki5cdAAvppT14Iw==
X-Received: by 2002:adf:e984:: with SMTP id h4mr2580423wrm.32.1556799059924;
        Thu, 02 May 2019 05:10:59 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-8-187.w90-86.abo.wanadoo.fr. [90.86.125.187])
        by smtp.gmail.com with ESMTPSA id u9sm3648348wmd.14.2019.05.02.05.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 05:10:59 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com, perex@perex.cz,
        tiwai@suse.com, kaichieh.chuang@mediatek.com,
        shunli.wang@mediatek.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 5/5] ASoC: mediatek: mt8516: register ADDA DAI
Date:   Thu,  2 May 2019 14:10:41 +0200
Message-Id: <20190502121041.8045-6-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502121041.8045-1-fparent@baylibre.com>
References: <20190502121041.8045-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the ADDA DAI driver into the MT8516 PCM driver.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 sound/soc/mediatek/mt8516/mt8516-afe-pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/mediatek/mt8516/mt8516-afe-pcm.c b/sound/soc/mediatek/mt8516/mt8516-afe-pcm.c
index 84fbb5dbbd14..e1fd9290dd8f 100644
--- a/sound/soc/mediatek/mt8516/mt8516-afe-pcm.c
+++ b/sound/soc/mediatek/mt8516/mt8516-afe-pcm.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 
+#include "mt8516-afe-common.h"
 #include "mt8516-afe-regs.h"
 
 #include "../common/mtk-afe-platform-driver.h"
@@ -670,6 +671,7 @@ static int mt8516_dai_memif_register(struct mtk_base_afe *afe)
 typedef int (*dai_register_cb)(struct mtk_base_afe *);
 static const dai_register_cb dai_register_cbs[] = {
 	mt8516_dai_memif_register,
+	mt8516_dai_adda_register,
 };
 
 static int mt8516_afe_component_probe(struct snd_soc_component *component)
-- 
2.20.1

