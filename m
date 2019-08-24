Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DBCC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB54D22CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Qy14nzbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfHXU0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 16:26:54 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:47251 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfHXU0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 16:26:54 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46G8s64hS6zw;
        Sat, 24 Aug 2019 22:25:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566678316; bh=cjKOovDL+bRYnoSIR5KoHK4uHeLbz95Ofcl724n69I8=;
        h=Date:From:Subject:To:Cc:From;
        b=Qy14nzbf1OgvFwcEdGs/WQZj/XWXrU6g157AJRvrsXx3oKLN0xPeltoxNUESbPO2g
         k1k49Sh6r4oMEKGd+h61L1MvwwqHgs3k3NJZ3LnZBitxsYWQYDmFiSceXKVxXsEVjX
         N9PQ4aEkRZnO8wm+jC76ojyXEhtS5S1SqI/O5T/VLcnfSxf2Vf0ilhCrXeLdrgItuE
         dh72p4KWtN9zwr78X7KF9H6r52CaghFFIcazQEiWQP3LLlrIDXm+CZmLEAS5n1ZRau
         bwF7UMR5jztspvx9GW+YV6CyiIvIS6S/z4pAiDgAp0CTNoYCMnv5vd5IvdI098BL24
         KXvjzGDbP51dA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Sat, 24 Aug 2019 22:26:49 +0200
Message-Id: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 0/6] ] ASoC: atmel: extend SSC support
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

This series improves support for various configurations using SSC module
as implemented in Atmel SAMA5Dx SoCs. Patches are:

1. enable SSC in Kconfig for audio-graph-card support
2. DRY mode setting code
3. implement left-justified data mode
4-6. enable shared FSYNC source for slave mode

Patches against tiwai/sound/for-next tree. You can also pull from
   https://rere.qmqm.pl/git/linux
branch:
   atmel-ssc


Michał Mirosław (6):
  ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in Kconfig
  ASoC: atmel_ssc_dai: rework DAI format configuration
  ASoC: atmel_ssc_dai: implement left-justified data mode
  dt-bindings: misc: atmel-ssc: LRCLK from TF/RF pin option
  misc: atmel-ssc: get LRCLK pin selection from DT
  ASoC: atmel_ssc_dai: Enable shared FSYNC source in frame-slave mode

 .../devicetree/bindings/misc/atmel-ssc.txt    |   5 +
 drivers/misc/atmel-ssc.c                      |   9 +
 include/linux/atmel-ssc.h                     |   2 +
 sound/soc/atmel/Kconfig                       |  30 +-
 sound/soc/atmel/atmel_ssc_dai.c               | 305 ++++++------------
 5 files changed, 137 insertions(+), 214 deletions(-)

-- 
2.20.1

