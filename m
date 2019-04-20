Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD145C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7826E21855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="qRYWagdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfDTKqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 06:46:20 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51346 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfDTKqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 06:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1555757177; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZFNdaIfJj47xCdubjYphhaOdGLseFCSEhtDMHA2MkFo=;
        b=qRYWagdbYStd7BnfbFN6tceTIudnCdyRo9MizWqVC0GBAWPjL9vnPlYbz6ymY2UleSHwre
        oJ8rNvj0QXVwd0I23GVUDBIY4btBAzbVfgwIF2BGEdIliQuUZUGCy2S8VyH+KKlzqDnZs6
        R+ETEyWJl9ozc6Pj8Vk26r6JGoyo7FU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] ASoC: simple-card: Read pin switches conf from devicetree
Date:   Sat, 20 Apr 2019 12:45:53 +0200
Message-Id: <20190420104553.5071-3-paul@crapouillou.net>
In-Reply-To: <20190420104553.5071-1-paul@crapouillou.net>
References: <20190420104553.5071-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the routing path between a widget (e.g. "Speaker") and the codec
goes through an external amplifier, having a pin switch for this widget
allows the amplifier to be disabled when the widget is not to be used
(e.g. when using headphones).

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/generic/simple-card.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 34de32efc4c4..d34adb1518e7 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -556,6 +556,10 @@ static int simple_parse_of(struct simple_priv *priv)
 	if (ret < 0)
 		return ret;
 
+	ret = asoc_simple_card_of_parse_pin_switches(card, PREFIX);
+	if (ret < 0)
+		return ret;
+
 	/* Single/Muti DAI link(s) & New style of DT node */
 	memset(&li, 0, sizeof(li));
 	for (li.cpu = 1; li.cpu >= 0; li.cpu--) {
-- 
2.21.0.593.g511ec345e18

