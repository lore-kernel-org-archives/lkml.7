Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7472C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A019020823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbfCDUbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:31:44 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:57981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDUbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:31:40 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MqbI0-1hMorl3vvM-00mXxV; Mon, 04 Mar 2019 21:31:26 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ASoC: ti: fix davinci_mcasp_probe dependencies
Date:   Mon,  4 Mar 2019 21:30:50 +0100
Message-Id: <20190304203114.1894822-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4WHISUG8ocxAAwYPAmZ+zHkTsPViuEM8zA/h9WNrN67zQWO6mKi
 vczHmqhoMu7KVOHcdco2Hn20CHdsa1p/M4jTbVKGVZYPB3KgFP3VsElBpuO5ecQqIuLaZDu
 LgbopVZ7+rnSpXbF5nF7bJnKXHOW67J6HjNUy+0Vvj3lkEToYjCkE2vCbnWTy26uesIrsiu
 Wm3EMudsRZLHhRZLSbs1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q5iJxDzL/lY=:/nX2YjWdXcK6H3+UfEaatQ
 AW0M1Sl3iqJMSuByNIInJH+fhCmfQzNWc2FyiyWaNSUMsD/qja7h526MKV1G0spYGa9JChtDQ
 2WoLZtGNem2SuVQn0bVd+jLNP0tnGhI3k5wyGxo3Zf9Oit9sIXhKRrsF3yzo9p+pujooHGtUA
 Q5eYocmgBB1dKjXQlJ+xsjlPPgTxyU2CruxSpEC2D945WMAzMtfd7Tedsu4asFqHhC+n+sNoI
 4zR2MPovedGZg5fyhkFQm9aAY5BcTn6Ytt0pm0WKMpfPTGpRRp6rofRzhVexjz+ugRlggbSLc
 xw4VsXuhBKf/zv221wpqqdm2mLJfpB3U+g52/gWyK8D6K3Xd6ZrxRx0R7Afbl9L0mVNzv3o9L
 VKDdARcBse2ax9SsmyFSPzTNgKIpiHdqgVeTBW0zBEcUkj0A9civCvmzcUswAlsBWKRJuAtMN
 VtNHceQU3SKIUfZkPbTKyNcWSKgclOPjxU/E1dfc3PVeaOgHL9wTV9Av1VsXlSutIIqYKdXut
 pbHbisVjVjQXj4NUPRLIoX21ye6IjeK3aE+B/uJ2fNlTTKjpECrS8NYubgwpjhcUoKz/iVYrJ
 Oq2oJ7Ibnm2g27PzdZzF8CZqH3P69YeNm6W5wNUJNIyPyyzu20WGMUbNxuZI1Ui5/DbGcX9WE
 jLflRoM5WVflBvwHRl8Dg24YpCUeSUK56KQycu4gIZWmbQid/0WPQXe2YvnwKVVn3rHhh7YWR
 cvq6tBKRGIpbqBLIC9jtIsjrgftkDg5ZG2CGAg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SND_SOC_DAVINCI_MCASP driver can use either edma or sdma as
a back-end, and it takes the presence of the respective dma engine
drivers in the configuration as an indication to which ones should be
built. However, this is flawed in multiple ways:

- With CONFIG_TI_EDMA=m and CONFIG_SND_SOC_DAVINCI_MCASP=y,
  is enabled as =m, and we get a link error:
  sound/soc/ti/davinci-mcasp.o: In function `davinci_mcasp_probe':
  davinci-mcasp.c:(.text+0x930): undefined reference to `edma_pcm_platform_register'

- When CONFIG_SND_SOC_DAVINCI_MCASP=m has already been selected by
  another driver, the same link error appears even if CONFIG_TI_EDMA
  is disabled

There are possibly other issues here, but it seems that the only reasonable
solution is to always build both SND_SOC_TI_EDMA_PCM and
SND_SOC_TI_SDMA_PCM as a dependency here. Both are fairly small and
do not have any other compile-time dependencies, so the cost is
very small, and makes the configuration stage much more consistent.

Fixes: f2055e145f29 ("ASoC: ti: Merge davinci and omap directories")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/ti/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index 4bf3c15d4e51..ee7c202c69b7 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -21,8 +21,8 @@ config SND_SOC_DAVINCI_ASP
 
 config SND_SOC_DAVINCI_MCASP
 	tristate "Multichannel Audio Serial Port (McASP) support"
-	select SND_SOC_TI_EDMA_PCM if TI_EDMA
-	select SND_SOC_TI_SDMA_PCM if DMA_OMAP
+	select SND_SOC_TI_EDMA_PCM
+	select SND_SOC_TI_SDMA_PCM
 	help
 	  Say Y or M here if you want to have support for McASP IP found in
 	  various Texas Instruments SoCs like:
-- 
2.20.0

