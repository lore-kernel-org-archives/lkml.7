Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83B3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AF120693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfDPNMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:12:53 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:36975 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfDPNMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:12:52 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MDyoU-1h6W081KSK-009x0E; Tue, 16 Apr 2019 15:12:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: imx: fix fiq dependencies
Date:   Tue, 16 Apr 2019 15:12:23 +0200
Message-Id: <20190416131242.1232143-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lo7UpILhnUjahKQUzMx0hhOZaj8tlRqnUxInMnO4970rBZihFAd
 Q6+qcs5UL6fqyp38A5oD5MoWREFXriz25NtTWSn9o36XmxUvbVBJd2SgIuyOxhOWUxdX2DP
 cp0cS4OCK+ARYNPXyBW7chp6PbVGTpLugO4uu/Kq6B1zpWbaTa6EF+CtzMxBZe9CDqI338Z
 v+LVzlWrAINohJAcg85uA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W7rEIcSTWOs=:tV2qJnFWm4UexhcqSh3KJX
 NBaEOlR9+H+7g0BC5yzESIW5OPA+E986MFpN2HQlwELuwsntUJAzv7w4NOgKjrVnu+dbO4tra
 2xri4956DU37qJoxybc32+M2bU/aX68aLTPlhPmdm4gQJZCb6lAypA6tmi6riM/5Lvk4vkH2G
 IYS4tYV8MtTP/noNbkbYy0rKwVNLiYIg8FeRhQUrihtY+tZbrq/RdtozHJReWeIyd72sHEEoe
 jsh6PkmUPkDMTbgMD1WZ2aHODRtIu/Cdk4xny6qeKfexMdvVe6C21yYSuQJ3aeFXoDdyNYEvH
 Ijs1FMCuABxGbQ4l1V6sSAgwoclijevqwTZrnwcthae4DRIY0+XO9kpYJL0KFwLuPcJwQIvpJ
 pkjFJDlSU0uUbfHNHSVJi96qg/cKW8gzzkACd8SP7pzl0kGxAOEo82VoGlwbtm95iyFHR50ea
 CgJZPvvBHAUC3+8WM+pkght3/DjZwbW7Ryo/ZIM7JAdu6PiTBWh9XqXcTyYpKJkpoQPCCWjOJ
 sQErxqL91TBdoy7NqhkfFGJsr1Syt5vI91R12jFslUJbThIxoG3btOSk2MGx4NTIh5ERq5CVb
 6kQrZJFMkR6NxWk8sT9bgdzYA8FLXvdR++eALMuggRh+PWOP+19VgF0DA3cLmNK057mpueAX0
 /Ua7ksicjfE2+hqNnlH1sgONSiVhUOPtF6nzdEmv6nPVGAgfesTJdAjcv4i8gRBFKvpDWUYob
 bpDg2ZSJHjW4SPmzc0NxbFdeiSMD0bP67igstQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During randconfig builds, I occasionally run into an invalid configuration
of the freescale FIQ sound support:

WARNING: unmet direct dependencies detected for SND_SOC_IMX_PCM_FIQ
  Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_IMX_SOC [=m]
  Selected by [y]:
  - SND_SOC_FSL_SPDIF [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_IMX_SOC [=m]!=n && (MXC_TZIC [=n] || MXC_AVIC [=y])

sound/soc/fsl/imx-ssi.o: In function `imx_ssi_remove':
imx-ssi.c:(.text+0x28): undefined reference to `imx_pcm_fiq_exit'
sound/soc/fsl/imx-ssi.o: In function `imx_ssi_probe':
imx-ssi.c:(.text+0xa64): undefined reference to `imx_pcm_fiq_init'

The Kconfig warning is a result of the symbol being defined inside of
the "if SND_IMX_SOC" block, and is otherwise harmless. The link error
is more tricky and happens with SND_SOC_IMX_SSI=y, which may or may not
imply FIQ support. However, if SND_SOC_FSL_SSI is set to =m at the same
time, that selects SND_SOC_IMX_PCM_FIQ as a loadable module dependency,
which then causes a link failure from imx-ssi.

The solution here is to make SND_SOC_IMX_PCM_FIQ built-in whenever
one of its potential users is built-in.

Fixes: ff40260f79dc ("ASoC: fsl: refine DMA/FIQ dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/fsl/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 7b1d9970be8b..1f65cf555ebe 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -182,16 +182,17 @@ config SND_MPC52xx_SOC_EFIKA
 
 endif # SND_POWERPC_SOC
 
+config SND_SOC_IMX_PCM_FIQ
+	tristate
+	default y if SND_SOC_IMX_SSI=y && (SND_SOC_FSL_SSI=m || SND_SOC_FSL_SPDIF=m) && (MXC_TZIC || MXC_AVIC)
+	select FIQ
+
 if SND_IMX_SOC
 
 config SND_SOC_IMX_SSI
 	tristate
 	select SND_SOC_FSL_UTILS
 
-config SND_SOC_IMX_PCM_FIQ
-	tristate
-	select FIQ
-
 comment "SoC Audio support for Freescale i.MX boards:"
 
 config SND_MXC_SOC_WM1133_EV1
-- 
2.20.0

