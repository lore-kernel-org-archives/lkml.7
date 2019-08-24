Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CADC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4AA20870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="kV9Oso3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfHXU05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 16:26:57 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:62629 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfHXU0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 16:26:55 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46G8s91604zGl;
        Sat, 24 Aug 2019 22:25:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566678317; bh=bI4z6h+GTprYkJG4UIeziaeNCROEh3xOu5vMoCUwBkc=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=kV9Oso3/S7TQywbIKVaxb9X+muAQ/SPO73jIs0Vf8pfH0YJ8qKetq8TQw0wt3F5Yc
         EFQ1cVLJujArhDaMGce+XLp/EO8kbUa+jH9EdpqeT1UTA3w9yZhkontd88bW/Y4qAP
         fKdrgW7cc/rYdqhxV2FJgkjHnhMB5sRFC6TBV9IXALS4YEmrvVWWdHwgATCU1DnDhn
         +jeGIkW91SqGkpTJb1VP7fPxb8msf27AfCLQruKYWn5bwiAA4p1szQMgw0QccJaQh5
         cLu3zJaBVKi/Kq+LqBAWbkZUd9gKb7rV89d2PhCz4ywvm8/JASyxGtfAcBKkgQagFn
         9xsjFe4s3wHeQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Sat, 24 Aug 2019 22:26:52 +0200
Message-Id: <233d5461f4448df151755de7b69a0cd3ad310d5c.1566677788.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
References: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 1/6] ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in
 Kconfig
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

Allow SSC to be used on platforms described using audio-graph-card
in Device Tree.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

---
 v2: extended to PDC mode
     reworked and fixed Kconfig option dependencies

---
 sound/soc/atmel/Kconfig | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 06c1d5ce642c..f118c229ed82 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -12,25 +12,31 @@ if SND_ATMEL_SOC
 config SND_ATMEL_SOC_PDC
 	tristate
 	depends on HAS_DMA
-	default m if SND_ATMEL_SOC_SSC_PDC=m && SND_ATMEL_SOC_SSC=m
-	default y if SND_ATMEL_SOC_SSC_PDC=y || (SND_ATMEL_SOC_SSC_PDC=m && SND_ATMEL_SOC_SSC=y)
-
-config SND_ATMEL_SOC_SSC_PDC
-	tristate
 
 config SND_ATMEL_SOC_DMA
 	tristate
 	select SND_SOC_GENERIC_DMAENGINE_PCM
-	default m if SND_ATMEL_SOC_SSC_DMA=m && SND_ATMEL_SOC_SSC=m
-	default y if SND_ATMEL_SOC_SSC_DMA=y || (SND_ATMEL_SOC_SSC_DMA=m && SND_ATMEL_SOC_SSC=y)
-
-config SND_ATMEL_SOC_SSC_DMA
-	tristate
 
 config SND_ATMEL_SOC_SSC
 	tristate
-	default y if SND_ATMEL_SOC_SSC_DMA=y || SND_ATMEL_SOC_SSC_PDC=y
-	default m if SND_ATMEL_SOC_SSC_DMA=m || SND_ATMEL_SOC_SSC_PDC=m
+
+config SND_ATMEL_SOC_SSC_PDC
+	tristate "SoC PCM DAI support for AT91 SSC controller using PDC"
+	depends on ATMEL_SSC
+	select SND_ATMEL_SOC_PDC
+	select SND_ATMEL_SOC_SSC
+	help
+	  Say Y or M if you want to add support for Atmel SSC interface
+	  in PDC mode configured using audio-graph-card in device-tree.
+
+config SND_ATMEL_SOC_SSC_DMA
+	tristate "SoC PCM DAI support for AT91 SSC controller using DMA"
+	depends on ATMEL_SSC
+	select SND_ATMEL_SOC_DMA
+	select SND_ATMEL_SOC_SSC
+	help
+	  Say Y or M if you want to add support for Atmel SSC interface
+	  in DMA mode configured using audio-graph-card in device-tree.
 
 config SND_AT91_SOC_SAM9G20_WM8731
 	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
-- 
2.20.1

