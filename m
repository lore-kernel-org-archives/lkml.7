Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FD2C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBE320651
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IaT2UBQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfEAO3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 10:29:52 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9719 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfEAO3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:29:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc9ad400000>; Wed, 01 May 2019 07:29:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 May 2019 07:29:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 01 May 2019 07:29:51 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 May
 2019 14:29:50 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 1 May 2019 14:29:50 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.148]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cc9ad5d0003>; Wed, 01 May 2019 07:29:50 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] ASoC: max98090: Fix restore of DAPM Muxes
Date:   Wed, 1 May 2019 15:29:38 +0100
Message-ID: <1556720978-13233-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556720960; bh=xzT+9ba+DceKVlRkNgzKqIKE7WlhmlwTc7GlIb8E9ro=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=IaT2UBQzynNCN/2eXAVNDVLxSkZSDCAzS0LclJG1c3uS6XbayGWgg7i1NAGp7RZMF
         PEEvqulVMyj29lGIme6Oxtgfoq0dEDr90f94ooyYI486Py/IdmcAS1wliKT5wuUAZj
         1jva8sARGHkQqAYL61yFpXxKs0Z2uDxW3QLm8sslA0kNo61Q3wABU/1eKw7+OFK2+c
         I+GfliL5FUFPU5DwhBb/1WlFaYWFy7njqV9XNFUYGJHkhaal3prKpFKyrNsDN+I8x8
         k3gT7XPbrwG/46mL4qobH9/wdExfoo1Hn0vxIcJplCsyX+3EyeZxAft7IGkNPh0pcY
         wiRkdWGYy1PQA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max98090 driver defines 3 DAPM muxes; one for the right line output
(LINMOD Mux), one for the left headphone mixer source (MIXHPLSEL Mux)
and one for the right headphone mixer source (MIXHPRSEL Mux). The same
bit is used for the mux as well as the DAPM enable, and although the mux
can be correctly configured, after playback has completed, the mux will
be reset during the disable phase. This is preventing the state of these
muxes from being saved and restored correctly on system reboot. Fix this
by marking these muxes as SND_SOC_NOPM.

Note this has been verified this on the Tegra124 Nyan Big which features
the MAX98090 codec.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
If this is the correct fix for this issue, can we tag this for stable?
Or I can re-send with the stable tag. However, wanted to send out for
review first.

 sound/soc/codecs/max98090.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 30c242c38d99..7619ea31ab50 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1194,14 +1194,14 @@ static const struct snd_soc_dapm_widget max98090_dapm_widgets[] = {
 		&max98090_right_rcv_mixer_controls[0],
 		ARRAY_SIZE(max98090_right_rcv_mixer_controls)),
 
-	SND_SOC_DAPM_MUX("LINMOD Mux", M98090_REG_LOUTR_MIXER,
-		M98090_LINMOD_SHIFT, 0, &max98090_linmod_mux),
+	SND_SOC_DAPM_MUX("LINMOD Mux", SND_SOC_NOPM, 0, 0,
+		&max98090_linmod_mux),
 
-	SND_SOC_DAPM_MUX("MIXHPLSEL Mux", M98090_REG_HP_CONTROL,
-		M98090_MIXHPLSEL_SHIFT, 0, &max98090_mixhplsel_mux),
+	SND_SOC_DAPM_MUX("MIXHPLSEL Mux", SND_SOC_NOPM, 0, 0,
+		&max98090_mixhplsel_mux),
 
-	SND_SOC_DAPM_MUX("MIXHPRSEL Mux", M98090_REG_HP_CONTROL,
-		M98090_MIXHPRSEL_SHIFT, 0, &max98090_mixhprsel_mux),
+	SND_SOC_DAPM_MUX("MIXHPRSEL Mux", SND_SOC_NOPM, 0, 0,
+		&max98090_mixhprsel_mux),
 
 	SND_SOC_DAPM_PGA("HP Left Out", M98090_REG_OUTPUT_ENABLE,
 		M98090_HPLEN_SHIFT, 0, NULL, 0),
-- 
2.7.4

