Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B549BC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786A6205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGzWIbKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbfHORNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:13:37 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42914 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730932AbfHORNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:13:37 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so2391498qkm.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k01EdK39fXAsy433GSANuRrBTV+5yuWxEMUTAVxIQUk=;
        b=vGzWIbKluro4GsouXwOpDks7+UxNjjDqwWhiKSsqlzP8jzrTXDYWfCbQeq7BCMu8WA
         e2Ttkq2xoR3YOoSzvJ5L64HV+1Af63s/uMI9EI/qiK8f6wo2l5//wAEqZoJ9fM0k5415
         0MCl6uP/GobxxuDNBnjSNDmgctwKRKzEi+4upPZJxmgaw5ZXURT1gkiS/23Ns7DUNj4G
         78VGpJt0IKFMXD1UayB0RFlSErAsPlng2VAdOlMZgnIZmIHBr+oVwFdg5+tvDZ7FVLbX
         vdw+pM8UB1qokK0zwUX4yj4hISB+1PTtB+nAbt9n+Zen3xuS3vDlpVFpiD/irLGgD8l/
         a0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k01EdK39fXAsy433GSANuRrBTV+5yuWxEMUTAVxIQUk=;
        b=j9GgBjhK5gjr/36mZz0dd5Xyz/90Aw5pzefYFBpe/wgiOm8I0nW8C808HHbdosuW89
         BA51aPxaS8NCplAglhCeOVAmdl+NzJXpKxr+jhTZN2LKoReyxbYk+ycxSw7WvbUv1vx9
         9Of0+Ao1rjDgXVkdmctEqBQ0r7zKq+ScYSSm/yoV80eqV0sPTVHEoqEmmoYg1orWf350
         ILx2vW5oosroMB3AMEoCHk0jkzPf9RxbczaztDr/kk/mzA9WtSWt8OiR7NIrqa45r/MQ
         ZNFp2Hb8ZYM6foupJP1R1gfQKMb6XLCaA7vmIKbPxuxdDu9NU3yV0+/iFamyeawcqjsu
         Eshg==
X-Gm-Message-State: APjAAAUfJDD3/badByxA2JMr/4RLu2cjS/vFp2wocuAkEq6RiWnhVSeW
        m5F2y8pnUbdF2ZvA4S6vHWg=
X-Google-Smtp-Source: APXvYqwud3JQQVpp9Zix1svSLQ4bKesHtvFJNW99NMeM3u3A3fvmpgtJLzatV7SmPym2P9GgpORdpw==
X-Received: by 2002:a37:484a:: with SMTP id v71mr5033584qka.29.1565889215618;
        Thu, 15 Aug 2019 10:13:35 -0700 (PDT)
Received: from localhost.localdomain ([191.177.180.86])
        by smtp.googlemail.com with ESMTPSA id j66sm1646474qkf.86.2019.08.15.10.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:13:35 -0700 (PDT)
From:   Daniel Stuart <daniel.stuart14@gmail.com>
Cc:     cezary.rojewski@intel.com,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Daniel Stuart <daniel.stuart@pucpr.edu.br>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: intel: cht_bsw_max98090_ti: Add all Chromebooks that need pmc_plt_clk_0 quirk
Date:   Thu, 15 Aug 2019 14:12:55 -0300
Message-Id: <20190815171300.30126-1-daniel.stuart14@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every single baytrail chromebook sets PMC to 0, as can be seeing
below by searching through coreboot source code:
	$ grep -rl "PMC_PLT_CLK\[0\]" .
	./rambi/variants/glimmer/devicetree.cb
	./rambi/variants/clapper/devicetree.cb
	./rambi/variants/swanky/devicetree.cb
	./rambi/variants/enguarde/devicetree.cb
	./rambi/variants/winky/devicetree.cb
	./rambi/variants/kip/devicetree.cb
	./rambi/variants/squawks/devicetree.cb
	./rambi/variants/orco/devicetree.cb
	./rambi/variants/ninja/devicetree.cb
	./rambi/variants/heli/devicetree.cb
	./rambi/variants/sumo/devicetree.cb
	./rambi/variants/banjo/devicetree.cb
	./rambi/variants/candy/devicetree.cb
	./rambi/variants/gnawty/devicetree.cb
	./rambi/variants/rambi/devicetree.cb
	./rambi/variants/quawks/devicetree.cb

Plus, Cyan (only non-baytrail chromebook with max98090) also needs
this patch for audio to work.

Thus, this commit adds all the missing devices to bsw_max98090 quirk
table, implemented by commit a182ecd3809c ("ASoC: intel:
cht_bsw_max98090_ti: Add quirk for boards using pmc_plt_clk_0").

Signed-off-by: Daniel Stuart <daniel.stuart14@gmail.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 98 ++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 33eb72545be6..83b978e7b4c4 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -399,6 +399,20 @@ static struct snd_soc_card snd_soc_card_cht = {
 };
 
 static const struct dmi_system_id cht_max98090_quirk_table[] = {
+	{
+		/* Banjo model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Banjo"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Candy model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Candy"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
 	{
 		/* Clapper model Chromebook */
 		.matches = {
@@ -406,6 +420,27 @@ static const struct dmi_system_id cht_max98090_quirk_table[] = {
 		},
 		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
 	},
+	{
+		/* Cyan model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Cyan"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Enguarde model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Enguarde"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Glimmer model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Glimmer"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
 	{
 		/* Gnawty model Chromebook (Acer Chromebook CB3-111) */
 		.matches = {
@@ -413,6 +448,62 @@ static const struct dmi_system_id cht_max98090_quirk_table[] = {
 		},
 		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
 	},
+	{
+		/* Heli model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Heli"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Kip model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Kip"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Ninja model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Ninja"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Orco model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Orco"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Quawks model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Quawks"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Rambi model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Rambi"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Squawks model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Squawks"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
+		/* Sumo model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Sumo"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
 	{
 		/* Swanky model Chromebook (Toshiba Chromebook 2) */
 		.matches = {
@@ -420,6 +511,13 @@ static const struct dmi_system_id cht_max98090_quirk_table[] = {
 		},
 		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
 	},
+	{
+		/* Winky model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Winky"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
 	{}
 };
 
-- 
2.17.1

