Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4A6C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3515220665
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY0SKwLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfGISZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:25:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45191 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGISZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:25:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so9853807pgp.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=F53dI+T31MQO7QsmvZEQqUD+Bsf7Au5f6Ym6GihKyBU=;
        b=dY0SKwLV9k80CMp0A2x+iTnnhV5A92BoDgH5N8dKXZsQJo/haO6q4csQICb21yuckh
         UoHQx1dad/dqKIH5no1Q0PzDgicSMi7Y5RCJHrokKzaFn1A0jUIaCZEyYPEx/1O50Qqj
         EaVisjg4hQjAn7fvBEoThlflmA8uYcC+eluRgi0rKci9zKgK9q9hW49KSneUgU1uZFTX
         qUfI+GJsUpt2ojpAt1tD1dNxRyHN3xUFdvEW9T1s38tIAtBJ2Leab/lwjLq9eZWs75TB
         yMg2KLtL3F4aaIrioY7PRjrarbnUbrJMOcIs4N1wN6MtlaB47ttLlWxH++h7D2shfR+O
         b55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=F53dI+T31MQO7QsmvZEQqUD+Bsf7Au5f6Ym6GihKyBU=;
        b=TGmZRpKBrjXJJmFwttiXVCunPHSkuxzlgr6zIs/Kouz4gMx5tPDpAjNsbZWVylKBsZ
         KDZQcNKNN8o/UZnprSCSo2oYcghk/9BBUeLDR80o2WKrog55p2kOBOt/9Tzp3gTZBE1/
         04Hm1hQ1A2+Jbh3WXraPE3xzc/NHNWv/OKzCukqH8TeXW2fqcg7arUW98m7CAA/NJiJz
         TSwSDQEPeOmqTMTexoXmttXNqWdoYSByiOlzYQ3oBOF8pQRfw7op0paJvrALF4LF/t/P
         3s/f/ATOLxtk24d9sjOOiC7r1sd89M3m4j17qC45sAUmSOydQYAEYTSut/UmidATgmoH
         lnvg==
X-Gm-Message-State: APjAAAXToIklEQeWkWIPyA0o6Q4XCIkzCXyw/dE02xHcbImY0Bc0ik7w
        07IuA1Ay+Dq9gDpp2L4ucKI=
X-Google-Smtp-Source: APXvYqxPF2ZglfLFUEIjNK+xpEPSth8BelId/59gN0t4fpsSCcw0Ul22LI6xyEHQdp/Z7aYDfK8lIw==
X-Received: by 2002:a65:5888:: with SMTP id d8mr31623341pgu.124.1562696750983;
        Tue, 09 Jul 2019 11:25:50 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id x13sm13084575pfn.6.2019.07.09.11.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 11:25:50 -0700 (PDT)
Date:   Tue, 9 Jul 2019 23:55:43 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Shunli Wang <shunli.wang@mediatek.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: soc: codecs: mt6358: change return type of
 mt6358_codec_init_reg
Message-ID: <20190709182543.GA6611@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mt6358_codec_init_reg function always returns 0 , change return type
from int to void.

fixes below issue reported by coccicheck
sound/soc/codecs/mt6358.c:2260:5-8: Unneeded variable: "ret". Return "0"
on line 2289

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/soc/codecs/mt6358.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/mt6358.c b/sound/soc/codecs/mt6358.c
index 50b3fc5..c17250a 100644
--- a/sound/soc/codecs/mt6358.c
+++ b/sound/soc/codecs/mt6358.c
@@ -2255,10 +2255,8 @@ static struct snd_soc_dai_driver mt6358_dai_driver[] = {
 	},
 };
 
-static int mt6358_codec_init_reg(struct mt6358_priv *priv)
+static void mt6358_codec_init_reg(struct mt6358_priv *priv)
 {
-	int ret = 0;
-
 	/* Disable HeadphoneL/HeadphoneR short circuit protection */
 	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON0,
 			   RG_AUDHPLSCDISABLE_VAUDP15_MASK_SFT,
@@ -2285,8 +2283,6 @@ static int mt6358_codec_init_reg(struct mt6358_priv *priv)
 	/* set gpio */
 	playback_gpio_reset(priv);
 	capture_gpio_reset(priv);
-
-	return ret;
 }
 
 static int mt6358_codec_probe(struct snd_soc_component *cmpnt)
-- 
2.7.4

