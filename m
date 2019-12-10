Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890DCC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C6E2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="uh3mhyY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfLJMvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:51:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44065 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfLJMvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:51:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so19940983wrm.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 04:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=OLrkMP1SU9o9YBr7j7LFNOgjptF6dJnR5stNA5yE+Q8=;
        b=uh3mhyY9uLO+mp2uiWazSJDcsnD5XfkpEOOcw1HNtcmytJFF5tu1V1nPwA6UbdH+2h
         /yxK3KCWNiZGyuFUODO1SVEoY4YmwIbJJJDLzCTFvsoc4Y3lx6RG55Wv0RhOI+Ld68F1
         MmTZZ84eonn/IAbK3vNCAYisSE4+wUk1qgGm4WGHokRJ5AV0cywIJGLKWA1egaIQv5Nf
         KdXxvktEn0ICLFcYXa263fjycY3/1jjakB53NOo+xMp66+udx5bOKyfOFp6cMX/sXGQ7
         GN+E2np2vMaWS1W5L9vO0alDheKQrwusY8FOV/qYloYWj78QTllHyxx5E02P8FWc8+bb
         uxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=OLrkMP1SU9o9YBr7j7LFNOgjptF6dJnR5stNA5yE+Q8=;
        b=NC2HIH9jK2XyeVxpTcXKgXlJYRbhTPmqn20A33znKv9lY+pEvTU+gCoVSym+6YpgcO
         KsliOajdL92CzC4ILddHEfx5Ne6+NzEKF/M46F3oKhy5UFS8kKMJ1xRfzNv/q5x3Q0Uv
         tQpfuW1hFlQrR1mqFkKZXZLLtH209wyNBubiH0lmbLmo1AaRDxjZiHADXwanE1rg6SLe
         nZEg9yDRxKogONS/tl797/Q/z/rOXncEW1K+wc6PdIqL4zgJlafpWQxP6V0/7LqKkoGO
         3/mSYqGuN3JfdKg1RI7yJV93pkNyhJpDSL0Qpu3buhre0ZVjZ76gVG3eNup3MsLirJhq
         0DOQ==
X-Gm-Message-State: APjAAAUf1fhqifF4ZePNvAPX8REpycQXD8NVud4+qZzXYtkT3hK+C4eh
        MeHEf45BBqFiwTGs6rwrB7XqDw==
X-Google-Smtp-Source: APXvYqxUkysahHkOiervGkOZJnvReIh3BHdOH5U6VcuWUyHem/WdlgN/yXqsOWyR+BN1yZhWfyRLnQ==
X-Received: by 2002:a05:6000:cb:: with SMTP id q11mr3039832wrx.14.1575982312182;
        Tue, 10 Dec 2019 04:51:52 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id d186sm3013991wmf.7.2019.12.10.04.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 04:51:51 -0800 (PST)
Message-ID: <5def94e7.1c69fb81.2751f.190a@mx.google.com>
Date:   Tue, 10 Dec 2019 04:51:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v5.5-rc1-46-g3778790e1d13
X-Kernelci-Tree: broonie-sound
X-Kernelci-Branch: for-next
X-Kernelci-Lab-Name: lab-collabora
Subject: broonie-sound/for-next bisection: boot on rk3399-gru-kevin
To:     Olivier Moysan <olivier.moysan@st.com>, mgalka@collabora.com,
        Mark Brown <broonie@kernel.org>, enric.balletbo@collabora.com,
        khilman@baylibre.com, tomeu.vizoso@collabora.com,
        broonie@kernel.org, guillaume.tucker@collabora.com
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Brian Austin <brian.austin@cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

broonie-sound/for-next bisection: boot on rk3399-gru-kevin

Summary:
  Start:      3778790e1d13 Merge branch 'asoc-5.6' into asoc-next
  Details:    https://kernelci.org/boot/id/5deef68acb72c66093960f08
  Plain log:  https://storage.kernelci.org//broonie-sound/for-next/v5.5-rc1=
-46-g3778790e1d13/arm64/defconfig/gcc-8/lab-collabora/boot-rk3399-gru-kevin=
.txt
  HTML log:   https://storage.kernelci.org//broonie-sound/for-next/v5.5-rc1=
-46-g3778790e1d13/arm64/defconfig/gcc-8/lab-collabora/boot-rk3399-gru-kevin=
.html
  Result:     abe3b6727b65 ASoC: cs42l51: add dac mux widget in codec routes

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       broonie-sound
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound=
.git
  Branch:     for-next
  Target:     rk3399-gru-kevin
  CPU arch:   arm64
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit abe3b6727b653307c27870a2d4ecbf9de4e914a5
Author: Olivier Moysan <olivier.moysan@st.com>
Date:   Tue Dec 3 15:16:27 2019 +0100

    ASoC: cs42l51: add dac mux widget in codec routes
    =

    Add "DAC mux" DAPM widget in CS42l51 audio codec routes,
    to support DAC mux control and to remove error trace
    "DAC Mux has no paths" at widget creation.
    Note: ADC path of DAC mux is not routed in this patch.
    =

    Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
    Link: https://lore.kernel.org/r/20191203141627.29471-1-olivier.moysan@s=
t.com
    Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 55408c8fcb4e..e47758e4fb36 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -214,12 +214,10 @@ static const struct snd_soc_dapm_widget cs42l51_dapm_=
widgets[] =3D {
 	SND_SOC_DAPM_ADC_E("Right ADC", "Right HiFi Capture",
 		CS42L51_POWER_CTL1, 2, 1,
 		cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
-	SND_SOC_DAPM_DAC_E("Left DAC", "Left HiFi Playback",
-		CS42L51_POWER_CTL1, 5, 1,
-		cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
-	SND_SOC_DAPM_DAC_E("Right DAC", "Right HiFi Playback",
-		CS42L51_POWER_CTL1, 6, 1,
-		cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
+	SND_SOC_DAPM_DAC_E("Left DAC", NULL, CS42L51_POWER_CTL1, 5, 1,
+			   cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
+	SND_SOC_DAPM_DAC_E("Right DAC", NULL, CS42L51_POWER_CTL1, 6, 1,
+			   cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
 =

 	/* analog/mic */
 	SND_SOC_DAPM_INPUT("AIN1L"),
@@ -255,6 +253,12 @@ static const struct snd_soc_dapm_route cs42l51_routes[=
] =3D {
 	{"HPL", NULL, "Left DAC"},
 	{"HPR", NULL, "Right DAC"},
 =

+	{"Right DAC", NULL, "DAC Mux"},
+	{"Left DAC", NULL, "DAC Mux"},
+
+	{"DAC Mux", "Direct PCM", "Playback"},
+	{"DAC Mux", "DSP PCM", "Playback"},
+
 	{"Left ADC", NULL, "Left PGA"},
 	{"Right ADC", NULL, "Right PGA"},
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [e42617b825f8073569da76dc4510bfa019b1c35a] Linux 5.5-rc1
git bisect good e42617b825f8073569da76dc4510bfa019b1c35a
# bad: [3778790e1d1329223601c63602286ad1d73c480f] Merge branch 'asoc-5.6' i=
nto asoc-next
git bisect bad 3778790e1d1329223601c63602286ad1d73c480f
# bad: [3e62579436c6a7fc35de7318e6c5f495b8d0046c] ASoC: SOF: core: modify t=
he signature for snd_sof_create_page_table
git bisect bad 3e62579436c6a7fc35de7318e6c5f495b8d0046c
# good: [62d5ae4cafb7ffeeec6ba2dd1814cafeeea7dd8f] ASoC: max98090: save and=
 restore SHDN when changing sensitive registers
git bisect good 62d5ae4cafb7ffeeec6ba2dd1814cafeeea7dd8f
# bad: [bc9a665581b3c6c82c9220a47f6573b49ce2df0b] ASoC: fix soc-core.c kern=
el-doc warning
git bisect bad bc9a665581b3c6c82c9220a47f6573b49ce2df0b
# bad: [abe3b6727b653307c27870a2d4ecbf9de4e914a5] ASoC: cs42l51: add dac mu=
x widget in codec routes
git bisect bad abe3b6727b653307c27870a2d4ecbf9de4e914a5
# good: [49df1e3925824cf44e590daac635974270185841] ASoC: rsnd: Calculate DA=
LIGN inversion at run-time
git bisect good 49df1e3925824cf44e590daac635974270185841
# first bad commit: [abe3b6727b653307c27870a2d4ecbf9de4e914a5] ASoC: cs42l5=
1: add dac mux widget in codec routes
---------------------------------------------------------------------------=
----
