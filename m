Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFF9C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B46205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="blN2Wv4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfFZNgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:36:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42117 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfFZNgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:36:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so2762932wrl.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 06:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gnbXfzzoDtydJ87Q5fD6teACNHZuePi08QBtGx5OaUc=;
        b=blN2Wv4WVam0hiUqSylbBjtVDmRMsW53HOX2psNbZKAxgOV2/z/PkOMtPkvN/ugaMZ
         Sg4t47aCwoKzFiHw5nHazKAzbtIIT1w5Cg3nv+jk5gdLshoApig4CdNMpdMnYHjq9tnk
         CedAXDygrR2Ry2XQZjRO9kNtKX+IT1NbJk0z0dwj9Lpr0DgIjdw6g0Z9+faU+mkx7mrF
         CTbKNYE6FmB6gqFUzdzYfA74pNkEU/94kdqZgl9dh8fj7D+Yhwb2d2/+4XhXJeLiYfEa
         RHU/dazcHlX1nB+mtKcX232onWixjioT9LUKx+Rkgfh1Q3bg1P6IAwWw0fNvYbujtGBk
         gw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gnbXfzzoDtydJ87Q5fD6teACNHZuePi08QBtGx5OaUc=;
        b=AVigiNn+o5mJEt+/FN5W8WguzmIFFeHl5Ig21zNPpKL5LDcJuQMLFjDy3Zv0DAYwpb
         LEXL28gKAQeyxzKdpSR7dB2x8JP+LloRlzScFSgTOYQ4gzFCuMNJAY+3DHORHDzdFK9V
         4+C91EfAV1aUXdPTDkcXxSG+a2O0gmxRGDyBN5deGHPcLnh8o0l1tgxi9Cj+7DGwJiTx
         XnxgpALEGuNPhN1BaI/t13vJCkZnyyzIOrrIrtbq63SI3blB26IFhZFO1bZ43CbOydBS
         2bHMWHUmFwWvGXrDP6/Prx+D841b9EY6pMLRS3GfekxpGvG1KT+Xyt2EOKFj0uh3qJA6
         z/hQ==
X-Gm-Message-State: APjAAAXAc67ZFG99l6hGAtTJW66QSiavXDyRuZ3kagGyrWJX29h8MoC/
        NfhTlXeyfRySs6VMRs0Endu63RoqffSvBg==
X-Google-Smtp-Source: APXvYqw4hWzpgN2aSWbX3Ju7Pa2dKjxwWsjZwurpIK/EUEgT1P05NHGu8zYfqRbAxNX4dVIeZVs39A==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr2478127wrw.138.1561556195567;
        Wed, 26 Jun 2019 06:36:35 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w185sm2877880wma.39.2019.06.26.06.36.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 06:36:35 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 1/2] ASoC: soc-core: defer card registration if codec component is missing
Date:   Wed, 26 Jun 2019 15:36:16 +0200
Message-Id: <20190626133617.25959-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626133617.25959-1-jbrunet@baylibre.com>
References: <20190626133617.25959-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like cpus and platforms, defer sound card initialization if the codec
component is missing when initializing the dai_link

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 358f1fbf9a30..002ddbf4e5a3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1064,12 +1064,20 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 				link->name);
 			return -EINVAL;
 		}
+
 		/* Codec DAI name must be specified */
 		if (!codec->dai_name) {
 			dev_err(card->dev, "ASoC: codec_dai_name not set for %s\n",
 				link->name);
 			return -EINVAL;
 		}
+
+		/*
+		 * Defer card registartion if codec component is not added to
+		 * component list.
+		 */
+		if (!soc_find_component(codec))
+			return -EPROBE_DEFER;
 	}
 
 	/*
-- 
2.21.0

