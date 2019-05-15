Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873FDC04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AAC20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="X1lAu5ZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfEONTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:19:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43939 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbfEONTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:19:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so2642050wro.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2h106Z4/ATcPU1QRPJE9+ZrjCSAT+SxJpUGNW5+ypdI=;
        b=X1lAu5ZHCCzjYghnscD0OX/jA0eMlPFEIG8XZk5dovfhL4UaTlEOtCBhFZFxVzm/Tx
         pAuVx3DJBiDzhUUHz/kN5GlFuAml795hgYaBtvabvfgbbSrUquNiIytC02wU6fj3fGpV
         INbx6MKpj3ZgfAYTSaDK2uVDCHND1QaFcBdR+pzG5vz7wuf9++VSiy/sSnyHl2lnRX4K
         iD8w9VgD4eEWjD7rTwGUzq2ueadZtVALe0cg3iNfzNm+P/LBrM1AkLpMcCw3Fcdvgogo
         fQ92LKWlhxnHDQLEc8iLHSjHlbisyKDTjc72ScH+sPXvyRVEgeAlm70JJ+g8h/ZGY0eW
         KeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2h106Z4/ATcPU1QRPJE9+ZrjCSAT+SxJpUGNW5+ypdI=;
        b=hBn5mvPAwT3uWgkZ/L+PnEOgkTHDSiptQSB8Cd49AqH+J/B40xcpq2xphvSMaK6g/u
         JRWbhmiFkbJDUDCPuuRmyIxDqa7pm6bDw6QIdJ+mjV7oQ3exX9ihQq5nCvz6Nl6QBwnu
         wsvtjHbEceDlIe1VsV+mXN3n4Sx7c2H4H9w/wwtmOhayTAMaTYMVW4CsxWq0KTp98/AT
         02CgcOhDyeA1QmeS0s/n2zGcb4RfAkadKrkEBtc8ISAhyxbGmltYKQ2yGr57nS+avMoc
         alb6WB/9ynWVlmkQIP8p+Rv6NQBHnrla67FmNcu3M0qG0R12Otqer+pcVgYn6EFETvFa
         Rtqw==
X-Gm-Message-State: APjAAAVkGczKZ+v0cOS1sT4Pho3CpGMObtEc8VzrqR7yP8cFCOknPAgn
        T+AJwjHXku20NL1FeZH0L9NTHA==
X-Google-Smtp-Source: APXvYqz/lQB5wpF2+qRrJ4I1Hpnj5Nzq4JBpunwqfTjfsaJ/6TVlW1DUT56LRi4iginnZTHgAhAYZg==
X-Received: by 2002:adf:f5d1:: with SMTP id k17mr25107467wrp.281.1557926344035;
        Wed, 15 May 2019 06:19:04 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b206sm2789848wmd.28.2019.05.15.06.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:19:03 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 1/5] ASoC: meson: axg-card: set link name based on link node name
Date:   Wed, 15 May 2019 15:18:54 +0200
Message-Id: <20190515131858.32130-2-jbrunet@baylibre.com>
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

So far the link names of the axg sound card was derived from the cpu name
of the link. Since the dai link must be unique, it works as long as a
device does not provide more than one cpu dai. However, the 'tohdmitx'
does provide 2 dais used as cpu on codec-to-codec links

Instead of cpu name, use the node name of the dai link. DT already enforce
the uniqueness of this name

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-card.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index aa54d2c612c9..5c8deee8d512 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -80,10 +80,11 @@ static int axg_card_parse_dai(struct snd_soc_card *card,
 
 static int axg_card_set_link_name(struct snd_soc_card *card,
 				  struct snd_soc_dai_link *link,
+				  struct device_node *node,
 				  const char *prefix)
 {
 	char *name = devm_kasprintf(card->dev, GFP_KERNEL, "%s.%s",
-				    prefix, link->cpu_of_node->full_name);
+				    prefix, node->full_name);
 	if (!name)
 		return -ENOMEM;
 
@@ -474,7 +475,7 @@ static int axg_card_set_be_link(struct snd_soc_card *card,
 		codec++;
 	}
 
-	ret = axg_card_set_link_name(card, link, "be");
+	ret = axg_card_set_link_name(card, link, node, "be");
 	if (ret)
 		dev_err(card->dev, "error setting %pOFn link name\n", np);
 
@@ -483,6 +484,7 @@ static int axg_card_set_be_link(struct snd_soc_card *card,
 
 static int axg_card_set_fe_link(struct snd_soc_card *card,
 				struct snd_soc_dai_link *link,
+				struct device_node *node,
 				bool is_playback)
 {
 	link->dynamic = 1;
@@ -497,7 +499,7 @@ static int axg_card_set_fe_link(struct snd_soc_card *card,
 	else
 		link->dpcm_capture = 1;
 
-	return axg_card_set_link_name(card, link, "fe");
+	return axg_card_set_link_name(card, link, node, "fe");
 }
 
 static int axg_card_cpu_is_capture_fe(struct device_node *np)
@@ -527,9 +529,9 @@ static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 		return ret;
 
 	if (axg_card_cpu_is_playback_fe(dai_link->cpu_of_node))
-		ret = axg_card_set_fe_link(card, dai_link, true);
+		ret = axg_card_set_fe_link(card, dai_link, np, true);
 	else if (axg_card_cpu_is_capture_fe(dai_link->cpu_of_node))
-		ret = axg_card_set_fe_link(card, dai_link, false);
+		ret = axg_card_set_fe_link(card, dai_link, np, false);
 	else
 		ret = axg_card_set_be_link(card, dai_link, np);
 
-- 
2.20.1

