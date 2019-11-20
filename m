Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E0AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3172E218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfKTPYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:24:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47028 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfKTPYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:24:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B3D7C2910DB
Received: by earth.universe (Postfix, from userid 1000)
        id 1E69D3C0C71; Wed, 20 Nov 2019 16:24:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 0/6] ASoC: da7213: support for usage with simple-card
Date:   Wed, 20 Nov 2019 16:24:00 +0100
Message-Id: <20191120152406.2744-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This extends the da7213 driver to be used with simple-audio-card in
combination with a fixed clock. Here is a snippet of the downstream
board's DT, that is supposed to be supported by this patchset.

---------------------------------------------------------------------
/ {
	sound {
		compatible = "simple-audio-card";
		simple-audio-card,name = "audio-card";
		simple-audio-card,format = "i2s";
		simple-audio-card,bitclock-master = <&dailink_master>;
		simple-audio-card,frame-master = <&dailink_master>;

		simple-audio-card,widgets = "Speaker", "Ext Spk";
		simple-audio-card,audio-routing = "Ext Spk", "LINE";

		simple-audio-card,cpu {
			sound-dai = <&ssi1>;
		};

		dailink_master: simple-audio-card,codec {
			sound-dai = <&codec>;
		};
	};


	clk_ext_audio_codec: clock-codec {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency = <12288000>;
	};
};

&i2c1 {
	codec: audio-codec@1a {
		compatible = "dlg,da7212";
		reg = <0x1a>;
		#sound-dai-cells = <0>;
		VDDA-supply = <&reg_2v5_audio>;
		VDDSP-supply = <&reg_5v0_audio>;
		VDDMIC-supply = <&reg_3v3_audio>;
		VDDIO-supply = <&reg_3v3_audio>;
		clocks = <&clk_ext_audio_codec>;
		clock-names = "mclk";
	};
};
---------------------------------------------------------------------

Changes since PATCHv1:
 * https://lore.kernel.org/alsa-devel/20191108174843.11227-1-sebastian.reichel@collabora.com/
 * add patch adding da7212 compatible to DT bindings
 * update regulator patch, so that VDDA is enabled together with VDDIO
   while the device is enabled to avoid device reset
 * update clock patch, so that automatic PLL handling is not enabled
   when PLL is configured manually
 * update clock patch, so that automatic PLL is disabled when the device
   is suspended
 * update clock patch, so that automatic PLL is configured into bypass
   mode when possible

-- Sebastian

Sebastian Reichel (6):
  ASoC: da7213: Add da7212 DT compatible
  ASoC: da7213: Add regulator support
  ASoC: da7213: Provide selectable option
  ASoC: da7213: Move set_sysclk to codec level
  ASoC: da7213: Move set_pll to codec level
  ASoC: da7213: Add default clock handling

 .../devicetree/bindings/sound/da7213.txt      |   8 +-
 sound/soc/codecs/Kconfig                      |   3 +-
 sound/soc/codecs/da7213.c                     | 171 ++++++++++++++++--
 sound/soc/codecs/da7213.h                     |  11 ++
 4 files changed, 177 insertions(+), 16 deletions(-)

-- 
2.24.0

