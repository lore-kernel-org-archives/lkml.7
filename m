Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F852C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E627420873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yMl0eoA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfEONTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:19:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34371 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfEONTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:19:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id j187so4699808wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bgxe1GRX/w2wrtefgULdeMfRiILdFJq82pUWP1dCMsw=;
        b=yMl0eoA65BOO2y5I3UtLa9IGCL5g/V97Lh8F7pAYnMofU0OqB+DIOWkgA2URKybltp
         H7qbZR+c/pQ5kg8Jh64jQWDo3qjvnPG5gXyHa1RJQEKTLZfVemrF0Ar/ngXN5HpkQa6X
         5KOSaON+QtfoQeSlXGJyzu0XWA3OzS1TPtloWRjxcSGfHYcOeaOhjxuJxfjypNfj0Qdb
         ycBdmXHDROw1d4BPZCaRserlLAhGbSb+L1o3j1Ky7n9KyiOytriN3Pj+KsBu2u03vCX4
         0Lyf6UnNjgpbUvuHwezCqrLu9sFkfWKa0YzOGa1HjNyARC0N3+KMc6ai62nlzhSuD9uR
         Pbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgxe1GRX/w2wrtefgULdeMfRiILdFJq82pUWP1dCMsw=;
        b=QAwP3Cek30TNb+AKaqCdP5ZiIOzdJ+6Tj0wWmmjAiEvtIhiHW4Ml8eVIbdO3KeFCeh
         rRExDVElPPDbAz198y7wfxfToDDAVY05eV4grn61JAWDUiv2HCVKyOCbyNHs/cLatGPp
         7e0Ru8isTI+3FSI1T7qJ1BEBuOYgnAti+PCnFe1RcMhX7YkbvoLxN0LTnDVAeKEJPh8w
         Xrz2JymrZqs2PhMuWUp14VNS1/ThH+V/+6yqXh4gnVjOrFhNOxOYAfBZ0AiYRHTme8D4
         Bza7UMgFsrCqpUOSUkWdhrApNuFp/C4XVhlQ5bXNa7ewlEn8DP+4YiG1y9Aex7m4pJcg
         Tr9A==
X-Gm-Message-State: APjAAAWxPiE0FNnTAlgt0WRkHBAiIim8qX3YOPAgCX+H4wU+F/NtBMh6
        xPzJXRpnA/DnhTHjkn4EaoqfeOyza3s=
X-Google-Smtp-Source: APXvYqxC3WiRwd3tKaX9tLKESnKaHtepk6/HtpPVFWaY2/GLrIXfw8TZB9PS3JtGTCSqZMvaoTXs/Q==
X-Received: by 2002:a7b:c549:: with SMTP id j9mr722446wmk.122.1557926347157;
        Wed, 15 May 2019 06:19:07 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b206sm2789848wmd.28.2019.05.15.06.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:19:06 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 4/5] ASoC: meson: axg-card: add basic codec-to-codec link support
Date:   Wed, 15 May 2019 15:18:57 +0200
Message-Id: <20190515131858.32130-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190515131858.32130-1-jbrunet@baylibre.com>
References: <20190515131858.32130-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for codec-to-codec link in the axg sound card.
The cpu side of these links is expected to properly set the hw_params
and format of the link.

ATM, only the tohdmitx glue is supported but others (like the
internal DAC glue) should follow.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-card.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 5c8deee8d512..db0a7fc18928 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -29,6 +29,18 @@ struct axg_dai_link_tdm_data {
 	struct axg_dai_link_tdm_mask *codec_masks;
 };
 
+/*
+ * Base params for the codec to codec links
+ * Those will be over-written by the CPU side of the link
+ */
+static const struct snd_soc_pcm_stream codec_params = {
+	.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	.rate_min = 5525,
+	.rate_max = 192000,
+	.channels_min = 1,
+	.channels_max = 8,
+};
+
 #define PREFIX "amlogic,"
 
 static int axg_card_reallocate_links(struct axg_card *priv,
@@ -517,6 +529,11 @@ static int axg_card_cpu_is_tdm_iface(struct device_node *np)
 	return of_device_is_compatible(np, PREFIX "axg-tdm-iface");
 }
 
+static int axg_card_cpu_is_codec(struct device_node *np)
+{
+	return of_device_is_compatible(np, PREFIX "g12a-tohdmitx");
+}
+
 static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 			     int *index)
 {
@@ -540,6 +557,8 @@ static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 
 	if (axg_card_cpu_is_tdm_iface(dai_link->cpu_of_node))
 		ret = axg_card_parse_tdm(card, np, index);
+	else if (axg_card_cpu_is_codec(dai_link->cpu_of_node))
+		dai_link->params = &codec_params;
 
 	return ret;
 }
-- 
2.20.1

