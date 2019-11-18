Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451FEC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 07:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1447F20726
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 07:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lasfj/iU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKRHgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 02:36:52 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:43838 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRHgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 02:36:50 -0500
Received: by mail-pj1-f67.google.com with SMTP id a10so1234322pju.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 23:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O2pEQ/gFrO9sbquSpD0RUFiXEZPVde4Gd/3NvXvj/F8=;
        b=lasfj/iUysHaMF/qDePjau4redMEkpAtBhX7DCWwsRWWjoMjocxy53+NEzYlRx6r+F
         eqQDOy6M4w/kJNlBDir5GV7B2JaigQk7H0QKVPSK7M2gIomrHOwulfnCqztEEL6G/k+F
         T7zpBu/Uw/7zNWTTExlJ4dC0NjILJUqniavbTldNu4ppTZ3oaPyO3RS7l5Y89icjrMnZ
         /4WyzvHplHa/ygdLd2SvixPvFo1NgnVt+pk/A2J6R40uU80Zbbce2AecXSatp6LWc5c9
         IGSnhiCXSLSiMCZlQN4f6XKPDoRRUE6jCcsxilTW/Fdw8qB5t66bpprKEK5tvlf3mB+U
         L/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O2pEQ/gFrO9sbquSpD0RUFiXEZPVde4Gd/3NvXvj/F8=;
        b=CJwMgsseIXSukl/tgFWbyE6I10/IsE3ow1eWeejYDWFHTO/yWEdxGsimShprb/TKwH
         hwCREus7dJUWLmokp0kAmZrr5P7aHyR+1wdsfc99EI9p6n4/Lnvy3EpobZZM8hC0RB8z
         LTZ888BVBIZ1OxXtk1In2JKcPJyjKlhugV4q6K3eMEYR1Z8KQ3/Hld9J8ujcxO9Qu7hp
         bwh5lzaOFhX9+XIRX0k2AaWh0sbzsMNjbOtMgpImFZApZxtc5JyoKTFr0luJ7klbe27E
         nQgk3ajzpCjelbUZhtjlgb5FrCPxB3ASXglKQXnAq3rN2sFzT/drje1paMmq6hs9BCy6
         GOvA==
X-Gm-Message-State: APjAAAUNGBVvRwdbQTY/ghTm9RGphEqWcPBNYTgyld2ScyB3Pn7Z1Xes
        Tz0IV6aOX/Sy+bkLwOl/WZUx3LK6hDQ=
X-Google-Smtp-Source: APXvYqzTxqKx8I3LrGzO+aP1mTgFtsOpNih9t3u1AhFiqfSjAM2j1hpXKU8cxdopEtymDDo+1JkzHA==
X-Received: by 2002:a17:90a:2470:: with SMTP id h103mr39127468pje.12.1574062609419;
        Sun, 17 Nov 2019 23:36:49 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id k13sm18597563pgl.69.2019.11.17.23.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 23:36:48 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ASoC: wm2200: add missed operations in remove and probe failure
Date:   Mon, 18 Nov 2019 15:36:33 +0800
Message-Id: <20191118073633.28237-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver misses calls to pm_runtime_disable and regulator_bulk_disable
in remove and a call to free_irq in probe failure.
Add the calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/codecs/wm2200.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index cf64e109c658..7b087d94141b 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -2410,6 +2410,8 @@ static int wm2200_i2c_probe(struct i2c_client *i2c,
 
 err_pm_runtime:
 	pm_runtime_disable(&i2c->dev);
+	if (i2c->irq)
+		free_irq(i2c->irq, wm2200);
 err_reset:
 	if (wm2200->pdata.reset)
 		gpio_set_value_cansleep(wm2200->pdata.reset, 0);
@@ -2426,12 +2428,15 @@ static int wm2200_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm2200_priv *wm2200 = i2c_get_clientdata(i2c);
 
+	pm_runtime_disable(&i2c->dev);
 	if (i2c->irq)
 		free_irq(i2c->irq, wm2200);
 	if (wm2200->pdata.reset)
 		gpio_set_value_cansleep(wm2200->pdata.reset, 0);
 	if (wm2200->pdata.ldo_ena)
 		gpio_set_value_cansleep(wm2200->pdata.ldo_ena, 0);
+	regulator_bulk_disable(ARRAY_SIZE(wm2200->core_supplies),
+			       wm2200->core_supplies);
 
 	return 0;
 }
-- 
2.24.0

