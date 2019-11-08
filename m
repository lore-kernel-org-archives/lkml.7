Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680A3FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456DB206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfKHRs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:48:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37778 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKHRs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:48:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 78DD929128D
Received: by jupiter.universe (Postfix, from userid 1000)
        id EA32148009C; Fri,  8 Nov 2019 18:48:53 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 0/5] ASoC: da7213: support for usage with simple-card
Date:   Fri,  8 Nov 2019 18:48:38 +0100
Message-Id: <20191108174843.11227-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.24.0.rc1
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

-- Sebastian

Sebastian Reichel (5):
  ASoC: da7213: Add regulator support
  ASoC: Add DA7213 audio codec as selectable option
  ASoC: da7213: move set_sysclk to codec level
  ASoC: da7213: move set_pll to codec level
  ASoC: da7213: add default clock handling

 .../devicetree/bindings/sound/da7213.txt      |   4 +
 sound/soc/codecs/Kconfig                      |   3 +-
 sound/soc/codecs/da7213.c                     | 128 ++++++++++++++++--
 sound/soc/codecs/da7213.h                     |   3 +
 4 files changed, 125 insertions(+), 13 deletions(-)

-- 
2.24.0.rc1

