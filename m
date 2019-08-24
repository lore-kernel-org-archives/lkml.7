Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CE3C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B3520870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="GadtC0t8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfHXU1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 16:27:03 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:12082 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbfHXU1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 16:27:00 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46G8sG3RHFzhv;
        Sat, 24 Aug 2019 22:25:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566678322; bh=VMADLsNAb53KqJMxEINzewk+gjFvVaLwVHUb8Ct9D+Y=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=GadtC0t8GZJA/lhACGRFEtRl8Z69pZTr7VwbIJv7I5uAhvVM7V/Ea7mtmClXGF+WH
         X21adHNbfwNw0YI+mHhPDWXdhDkZERVvSjuc/InEx1JEyK08hE6AuII3LfnpRMvieR
         Ym54Z211qnXPqi9zWGF3QWHHWdOyGEv+4VMYXvp445EXOFsRwhk2uyQuyAhHwpAf0j
         fs9jsMo7IrTHip65QLCfhxrWi3yG7oVxt+wse75vpEhY3Z/i64Xn6ucteb1cLGmOEA
         wusM19TMVgygdapkBgu0woqjRFbG/AwK2VOxV5OzJgahPjjRhKv67+TZG9LaQbl2RX
         OHGJAkxUIW0eQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Sat, 24 Aug 2019 22:26:57 +0200
Message-Id: <b56ebac96ad232e2d9871067b13654eb9223f28f.1566677788.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
References: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 6/6] ASoC: atmel_ssc_dai: Enable shared FSYNC source in
 frame-slave mode
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

SSC driver allows only synchronous TX and RX. In slave mode for BCLK
it uses only one of TK or RK pin, but for LRCLK it configured separate
inputs from TF and RF pins. Allow configuration with common FS signal.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

---
 v2: use alternate DT binding
     split DT and drivers/misc changes

---
 sound/soc/atmel/atmel_ssc_dai.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 48e9eef34c0f..035d4da58f2b 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -605,14 +605,32 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	if (!atmel_ssc_cfs(ssc_p)) {
+	if (atmel_ssc_cfs(ssc_p)) {
+		/*
+		 * SSC provides LRCLK
+		 *
+		 * Both TF and RF are generated, so use them directly.
+		 */
+		rcmr |=	  SSC_BF(RCMR_START, fs_edge);
+		tcmr |=	  SSC_BF(TCMR_START, fs_edge);
+	} else {
 		fslen = fslen_ext = 0;
 		rcmr_period = tcmr_period = 0;
 		fs_osync = SSC_FSOS_NONE;
-	}
 
-	rcmr |=	  SSC_BF(RCMR_START, fs_edge);
-	tcmr |=	  SSC_BF(TCMR_START, fs_edge);
+		if (ssc->lrclk_from_tf_pin) {
+			rcmr |=	  SSC_BF(RCMR_START, SSC_START_TX_RX);
+			tcmr |=	  SSC_BF(TCMR_START, fs_edge);
+		} else if (ssc->lrclk_from_rf_pin) {
+			/* assume RF is to be used when RK is used as BCLK input */
+			/* Note: won't work correctly on SAMA5D2 due to errata */
+			rcmr |=	  SSC_BF(RCMR_START, fs_edge);
+			tcmr |=	  SSC_BF(TCMR_START, SSC_START_TX_RX);
+		} else {
+			rcmr |=	  SSC_BF(RCMR_START, fs_edge);
+			tcmr |=	  SSC_BF(TCMR_START, fs_edge);
+		}
+	}
 
 	if (atmel_ssc_cbs(ssc_p)) {
 		/*
-- 
2.20.1

