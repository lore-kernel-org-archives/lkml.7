Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D047CC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A6E21479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="pD8+PQaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfDTKqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 06:46:21 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51326 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfDTKqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 06:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1555757176; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+37NYGOkFUpJZTWiZmXk4xAeier065JR0ubSruTb7RA=;
        b=pD8+PQaRlnKrQFsISssYM1W80w48E1PIO3RieCKubLZBlS6Rt4PV3Arg/DUJHhho5Fy8H5
        NKpijMpi+eab38T2+0Jk8GhxYI3DVtzWR2cBoAF6MqwuxoZp+h8t5cdG51aRuwk4R5nb35
        KnsBE7BiXNhUniOm47pa+meKeZ4Og2c=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/3] ASoC: simple-card-utils: add asoc_simple_card_of_parse_pin_switches()
Date:   Sat, 20 Apr 2019 12:45:52 +0200
Message-Id: <20190420104553.5071-2-paul@crapouillou.net>
In-Reply-To: <20190420104553.5071-1-paul@crapouillou.net>
References: <20190420104553.5071-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is a helper that permits to create pin switch controls for
a list of widgets whose names are listed in the PREFIX "pin-switches"
devicetree property.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 include/sound/simple_card_utils.h     |  2 +
 sound/soc/generic/simple-card-utils.c | 57 +++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 7afe45389972..8a56c1713952 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -124,6 +124,8 @@ int asoc_simple_card_of_parse_routing(struct snd_soc_card *card,
 				      char *prefix);
 int asoc_simple_card_of_parse_widgets(struct snd_soc_card *card,
 				      char *prefix);
+int asoc_simple_card_of_parse_pin_switches(struct snd_soc_card *card,
+					   char *prefix);
 
 int asoc_simple_card_init_jack(struct snd_soc_card *card,
 			       struct asoc_simple_jack *sjack,
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 5c1424f03620..431002e3e63f 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -469,6 +469,63 @@ int asoc_simple_card_of_parse_widgets(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_of_parse_widgets);
 
+int asoc_simple_card_of_parse_pin_switches(struct snd_soc_card *card,
+					   char *prefix)
+{
+	const unsigned int nb_controls_max = 16;
+	const char **strings, *control_name;
+	struct snd_kcontrol_new *controls;
+	struct device *dev = card->dev;
+	unsigned int i, nb_controls;
+	char prop[128];
+	int ret;
+
+	if (!prefix)
+		prefix = "";
+
+	snprintf(prop, sizeof(prop), "%s%s", prefix, "pin-switches");
+
+	if (!of_property_read_bool(dev->of_node, prop))
+		return 0;
+
+	strings = devm_kcalloc(dev, nb_controls_max,
+			       sizeof(*strings), GFP_KERNEL);
+	if (!strings)
+		return -ENOMEM;
+
+	ret = of_property_read_string_array(dev->of_node, prop,
+					    strings, nb_controls_max);
+	if (ret < 0)
+		return ret;
+
+	nb_controls = (unsigned int)ret;
+
+	controls = devm_kcalloc(dev, nb_controls,
+				sizeof(*controls), GFP_KERNEL);
+	if (!controls)
+		return -ENOMEM;
+
+	for (i = 0; i < nb_controls; i++) {
+		control_name = devm_kasprintf(dev, GFP_KERNEL,
+					      "%s Switch", strings[i]);
+		if (!control_name)
+			return -ENOMEM;
+
+		controls[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+		controls[i].name = control_name;
+		controls[i].info = snd_soc_dapm_info_pin_switch;
+		controls[i].get = snd_soc_dapm_get_pin_switch;
+		controls[i].put = snd_soc_dapm_put_pin_switch;
+		controls[i].private_value = (unsigned long)strings[i];
+	}
+
+	card->controls = controls;
+	card->num_controls = nb_controls;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_card_of_parse_pin_switches);
+
 int asoc_simple_card_init_jack(struct snd_soc_card *card,
 			       struct asoc_simple_jack *sjack,
 			       int is_hp, char *prefix)
-- 
2.21.0.593.g511ec345e18

