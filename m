Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047C0C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E6520840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfCGPRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:17:13 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:48435 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCGPRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:17:12 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MWz4j-1hYf5t0yZF-00XHZY; Thu, 07 Mar 2019 16:16:56 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH 1/3] ASoC: ti: remove compat dma probing
Date:   Thu,  7 Mar 2019 16:16:08 +0100
Message-Id: <20190307151646.1016966-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IDAzRVFsZyLsEwWH6SxwekAejlCMqtnGRLZja5hBLGl3fy91UZa
 Ku1wtdkzNmOj25OsZ8M/wQN/zRq0wthhXe0g9UMSDa4g33G3UWXsBzIlq0IBc91aLOFOKNZ
 8w1Py5tly5egyXEWbxD8e+FsXmgD4PIlTDlliZ+CP8Z11bllYWGCFYEO0l0e267Vkh0Iula
 pxDdYoP2fqc2xt7rXmEsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M6MD7ZxYHGE=:bFMuDkQiJcwoYAAjJf9rlq
 LEcGnWy5knLhAvmsgWQiNVCRg2P/EXmHVtOW++5MhJEbz+RETAgrKuVhI9zrIy1c5H8JXuNYq
 jsDtUCByH6pGE+6D4FGuXuI8+z8LZ9J83fG7I99CTLTbqjD25O5u28hDK0WhVshzjfMM4ls3A
 FBRW6by33cCfNh67/mT+pn92rsJEC7nuHd4P/Yc7YnE01B+yvaqpogc4dw5v6qgl87mAI3/mt
 KTRgZ/81bUVb2xgEBlRfmG3eiqp+oJzEkjnML9WQgrt6CanIBLIBOMvNPYQJuOkgp8fZoTyj/
 InbFGuYuoXSzYn318WngfaDDUeBAtTJOqWQtynotg8ROQfleDOxKf25E7ds6DU4wT2l4+SM3c
 sNCjEM+G49yq1IdRSHhAGK7qt48Ch/milKzFWu/h7XrsMYQBELR7WpQDIaC+gfAJ5lOBzFj5p
 UwS00++2v+BOFXQJLnZY8MeatlSe41AK4H9jZjZ0g95OpPEC9lTecBAo5fxV+LBYDDSbnGvfH
 rao68/PzhZF4WVaztUU+qje2QLwK5HwJH5631XDqO9nZTkxhoKwukC/HZfEUpMMUqXX1pljgK
 0GAopM2XXTWbRQpgjv2/XCYCmlM5wI12VVYD9hsIGEqMd/RoA+901vmdIpJyK5ondAyaRFtmq
 Dcee8EvDTxDIPF/e8eoRsPY5LaMO9E/hTpvu9B1rrhsPuoc3ipZkQJ09WCn0p+TYwpLB6pviE
 vlkXD1bkP3TIcaJK7vos7jJOWedAJxLvJv3Hsg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After running into a link error:

sound/soc/ti/edma-pcm.o:(.rodata+0x18): undefined reference to `edma_filter_fn'

I checked all users of this, and they have new-style 'dma_slave_map' tables,
so none of them should still need it. Removing the associated lines
simplifies the code and avoids the build-time dependency on the
respective dmaengine drivers.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: remove header inclusions as well

I added the two dmaengine patches to the series this time, but
we probably want to have those merged separately through the
dmaengine tree, while this one should get merged as a bugfix
through ASoC.
---
 sound/soc/ti/edma-pcm.c | 5 +----
 sound/soc/ti/sdma-pcm.c | 9 +++------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/ti/edma-pcm.c b/sound/soc/ti/edma-pcm.c
index 59e588abe54b..fdffb801b185 100644
--- a/sound/soc/ti/edma-pcm.c
+++ b/sound/soc/ti/edma-pcm.c
@@ -23,7 +23,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
-#include <linux/edma.h>
 
 #include "edma-pcm.h"
 
@@ -43,14 +42,12 @@ static const struct snd_pcm_hardware edma_pcm_hardware = {
 static const struct snd_dmaengine_pcm_config edma_dmaengine_pcm_config = {
 	.pcm_hardware = &edma_pcm_hardware,
 	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
-	.compat_filter_fn = edma_filter_fn,
 	.prealloc_buffer_size = 128 * 1024,
 };
 
 int edma_pcm_platform_register(struct device *dev)
 {
-	return devm_snd_dmaengine_pcm_register(dev, &edma_dmaengine_pcm_config,
-					SND_DMAENGINE_PCM_FLAG_COMPAT);
+	return devm_snd_dmaengine_pcm_register(dev, &edma_dmaengine_pcm_config, 0);
 }
 EXPORT_SYMBOL_GPL(edma_pcm_platform_register);
 
diff --git a/sound/soc/ti/sdma-pcm.c b/sound/soc/ti/sdma-pcm.c
index 21a9c2499d48..a236350beb10 100644
--- a/sound/soc/ti/sdma-pcm.c
+++ b/sound/soc/ti/sdma-pcm.c
@@ -11,7 +11,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
-#include <linux/omap-dmaengine.h>
 
 #include "sdma-pcm.h"
 
@@ -31,7 +30,6 @@ static const struct snd_pcm_hardware sdma_pcm_hardware = {
 static const struct snd_dmaengine_pcm_config sdma_dmaengine_pcm_config = {
 	.pcm_hardware = &sdma_pcm_hardware,
 	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
-	.compat_filter_fn = omap_dma_filter_fn,
 	.prealloc_buffer_size = 128 * 1024,
 };
 
@@ -39,13 +37,12 @@ int sdma_pcm_platform_register(struct device *dev,
 			       char *txdmachan, char *rxdmachan)
 {
 	struct snd_dmaengine_pcm_config *config;
-	unsigned int flags = SND_DMAENGINE_PCM_FLAG_COMPAT;
+	unsigned int flags = 0;
 
 	/* Standard names for the directions: 'tx' and 'rx' */
 	if (!txdmachan && !rxdmachan)
 		return devm_snd_dmaengine_pcm_register(dev,
-						&sdma_dmaengine_pcm_config,
-						flags);
+						&sdma_dmaengine_pcm_config, 0);
 
 	config = devm_kzalloc(dev, sizeof(*config), GFP_KERNEL);
 	if (!config)
@@ -65,7 +62,7 @@ int sdma_pcm_platform_register(struct device *dev,
 	config->chan_names[0] = txdmachan;
 	config->chan_names[1] = rxdmachan;
 
-	return devm_snd_dmaengine_pcm_register(dev, config, flags);
+	return devm_snd_dmaengine_pcm_register(dev, config, 0);
 }
 EXPORT_SYMBOL_GPL(sdma_pcm_platform_register);
 
-- 
2.20.0

