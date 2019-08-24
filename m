Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29E1C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BDD20870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="anw28Gsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfHXU1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 16:27:17 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:12082 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbfHXU05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 16:26:57 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46G8sC3TJ3zTs;
        Sat, 24 Aug 2019 22:25:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566678319; bh=VdbgtZ09Jmhv6nJYzpWS3ntFIzMHLWp5KKJVlktY88w=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=anw28Gshlg7ioShZh4jMUTbNhZLisNCofQ7YU/mNq1U957DdsRYUy0eFjOFaT5i53
         5mP8AKvzz4Vl324o0DRvozaxEUsX3Aohg9XUhRjGDB9ewFakBsSD1Xw0+nz9dxeiza
         1RPw2S12ZiNB55qaCwIK8xqfcbSM3fiYYAKifSbPZx9PnpG6U1kWCvWEV3lB6JwbI3
         3yP8CTo02S2cKCt3uOKj0SzOugCwJPrYoyKtxs+MIibEG77Ra/mlfqqKza0ba+DJx7
         KMsgfp+ulEIu7vzox++YCmsKj6TYM93ykMNsPY8RZAaijYzhmqcINdd+1KQ1jr0YVl
         SS2AmLbJejucw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Sat, 24 Aug 2019 22:26:54 +0200
Message-Id: <44fa6b700421e80778f20ff9ead2b148cf6d2e92.1566677788.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
References: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 3/6] ASoC: atmel_ssc_dai: implement left-justified data
 mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chas Williams <3chas3@gmail.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh-dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for left-justified data mode for SSC-codec link.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

---
 v2: rebased

---
 sound/soc/atmel/atmel_ssc_dai.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 7dc6ec9b8c7a..48e9eef34c0f 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -564,6 +564,15 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 
 	switch (ssc_p->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 
+	case SND_SOC_DAIFMT_LEFT_J:
+		fs_osync = SSC_FSOS_POSITIVE;
+		fs_edge = SSC_START_RISING_RF;
+
+		rcmr =	  SSC_BF(RCMR_STTDLY, 0);
+		tcmr =	  SSC_BF(TCMR_STTDLY, 0);
+
+		break;
+
 	case SND_SOC_DAIFMT_I2S:
 		fs_osync = SSC_FSOS_NEGATIVE;
 		fs_edge = SSC_START_FALLING_RF;
-- 
2.20.1

