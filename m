Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656ADC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E38B21743
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599855;
	bh=GFDOw1vLokEPjrw2hC5T0pdoppLVaZ7rZOTfoI8Wvqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PvgCXpo7M9o8Cv9zvlsSCwvv6zSeTzqhe8GylFFBCeR/1m/868+YqA05RaKH+O7PD
	 a8+yU18D4bMarlTNKzQTBNOTt7MU7VyKFRwvjarqhoHJCNtotMCS6tpyLwh2+ZzgJl
	 1j1x0oPlUMgPkHmIuKJLWe58701Ffd2FiDC2um/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389885AbfGHPay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389867AbfGHPav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:30:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3117520665;
        Mon,  8 Jul 2019 15:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599850;
        bh=GFDOw1vLokEPjrw2hC5T0pdoppLVaZ7rZOTfoI8Wvqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jC6pVTCrajhDh0s54GS0qnGSnCSEAi/3BabpgxX46/E60ioxNLY1h/1j2c1TECpM4
         0fo3dNknjQP5E3dE+XyP3K93S8web9KsFAvc8mbphFPrHDN9QHd9Cc0Ycrt2v12vvr
         D9ZB9sH7KuYalkrU7sfbt1202IRU4Q+wAy32pa1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 10/96] ASoC: ak4458: add return value for ak4458_probe
Date:   Mon,  8 Jul 2019 17:12:42 +0200
Message-Id: <20190708150526.894632053@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
References: <20190708150526.234572443@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a8dee20d792432740509237943700fbcfc230bad ]

AK4458 is probed successfully even if AK4458 is not present - this
is caused by probe function returning no error on i2c access failure.
Return an error on probe if i2c access has failed.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/ak4458.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index eab7c76cfcd9..4c5c3ec92609 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -536,9 +536,10 @@ static void ak4458_power_on(struct ak4458_priv *ak4458)
 	}
 }
 
-static void ak4458_init(struct snd_soc_component *component)
+static int ak4458_init(struct snd_soc_component *component)
 {
 	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	/* External Mute ON */
 	if (ak4458->mute_gpiod)
@@ -546,21 +547,21 @@ static void ak4458_init(struct snd_soc_component *component)
 
 	ak4458_power_on(ak4458);
 
-	snd_soc_component_update_bits(component, AK4458_00_CONTROL1,
+	ret = snd_soc_component_update_bits(component, AK4458_00_CONTROL1,
 			    0x80, 0x80);   /* ACKS bit = 1; 10000000 */
+	if (ret < 0)
+		return ret;
 
-	ak4458_rstn_control(component, 1);
+	return ak4458_rstn_control(component, 1);
 }
 
 static int ak4458_probe(struct snd_soc_component *component)
 {
 	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
 
-	ak4458_init(component);
-
 	ak4458->fs = 48000;
 
-	return 0;
+	return ak4458_init(component);
 }
 
 static void ak4458_remove(struct snd_soc_component *component)
-- 
2.20.1



