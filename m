Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5C2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D462622CED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfICSIi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:08:38 -0400
Received: from mailoutvs29.siol.net ([185.57.226.220]:41345 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727352AbfICSIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:08:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A94315219C4;
        Tue,  3 Sep 2019 20:08:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id P2mZ8gzE8-O5; Tue,  3 Sep 2019 20:08:33 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id E59FD521C1B;
        Tue,  3 Sep 2019 20:08:32 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 5FE0D5219C4;
        Tue,  3 Sep 2019 20:08:28 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jonas Karlman <jonas@kwiboo.se>, alsa-devel@alsa-project.org,
        tzungbi@chromium.org, zhengxing@rock-chips.com,
        kuninori.morimoto.gx@renesas.com, a.hajda@samsung.com,
        airlied@linux.ie, kuankuan.y@gmail.com, jeffy.chen@rock-chips.com,
        dianders@chromium.org, cain.cai@rock-chips.com,
        linux-rockchip@lists.infradead.org, eddie.cai@rock-chips.com,
        Laurent.pinchart@ideasonboard.com, daniel@ffwll.ch,
        Yakir Yang <ykk@rock-chips.com>, enric.balletbo@collabora.com,
        dgreid@chromium.org, sam@ravnborg.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm: bridge/dw_hdmi: add audio sample channel status setting
Date:   Tue, 03 Sep 2019 20:08:28 +0200
Message-ID: <19353031.SdOy5F5fmg@jernej-laptop>
In-Reply-To: <d8a80ba5-dd2b-f84d-bbfc-9dd5ccbc26e9@baylibre.com>
References: <20190903055103.134764-1-cychiang@chromium.org> <e1c3483c-baa6-c726-e547-fadf40d259f4@baylibre.com> <d8a80ba5-dd2b-f84d-bbfc-9dd5ccbc26e9@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne torek, 03. september 2019 ob 20:00:33 CEST je Neil Armstrong napisal(a):
> Hi,
> 
> Le 03/09/2019 à 11:53, Neil Armstrong a écrit :
> > Hi,
> > 
> > On 03/09/2019 07:51, Cheng-Yi Chiang wrote:
> >> From: Yakir Yang <ykk@rock-chips.com>
> >> 
> >> When transmitting IEC60985 linear PCM audio, we configure the
> >> Audio Sample Channel Status information of all the channel
> >> status bits in the IEC60958 frame.
> >> Refer to 60958-3 page 10 for frequency, original frequency, and
> >> wordlength setting.
> >> 
> >> This fix the issue that audio does not come out on some monitors
> >> (e.g. LG 22CV241)
> >> 
> >> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> >> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> >> ---
> >> 
> >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 59 +++++++++++++++++++++++
> >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h | 20 ++++++++
> >>  2 files changed, 79 insertions(+)
> >> 
> >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> >> bd65d0479683..34d46e25d610 100644
> >> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> @@ -582,6 +582,63 @@ static unsigned int hdmi_compute_n(unsigned int
> >> freq, unsigned long pixel_clk)>> 
> >>  	return n;
> >>  
> >>  }
> >> 
> >> +static void hdmi_set_schnl(struct dw_hdmi *hdmi)
> >> +{
> >> +	u8 aud_schnl_samplerate;
> >> +	u8 aud_schnl_8;
> >> +
> >> +	/* These registers are on RK3288 using version 2.0a. */
> >> +	if (hdmi->version != 0x200a)
> >> +		return;
> > 
> > Are these limited to the 2.0a version *in* RK3288, or 2.0a version on all
> > SoCs ?
> 
> After investigations, Amlogic sets these registers on their 2.0a version
> aswell, and Jernej (added in Cc) reported me Allwinner sets them on their
> < 2.0a and > 2.0a IPs versions.
> 
> Can you check on the Rockchip IP versions in RK3399 ?
> 
> For reference, the HDMI 1.4a IP version allwinner setups is:
> https://github.com/Allwinner-Homlet/H3-BSP4.4-linux/blob/master/drivers/vide
> o/fbdev/sunxi/disp2/hdmi/hdmi_bsp_sun8iw7.c#L531-L539 (registers a
> "scrambled" but a custom bit can reset to the original mapping, 0x1066 ...
> 0x106f)

For easier reading, here is similar, but annotated version: http://ix.io/1Ub6
Check function bsp_hdmi_audio().

Unless there is a special reason, you can just remove that check.

Best regards,
Jernej

> 
> Neil
> 
> >> +
> >> +	switch (hdmi->sample_rate) {
> >> +	case 32000:
> >> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_32K;
> >> +		break;
> >> +	case 44100:
> >> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_44K1;
> >> +		break;
> >> +	case 48000:
> >> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_48K;
> >> +		break;
> >> +	case 88200:
> >> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_88K2;
> >> +		break;
> >> +	case 96000:
> >> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_96K;
> >> +		break;
> >> +	case 176400:
> >> +		aud_schnl_samplerate = 
HDMI_FC_AUDSCHNLS7_SMPRATE_176K4;
> >> +		break;
> >> +	case 192000:
> >> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_192K;
> >> +		break;
> >> +	case 768000:
> >> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_768K;
> >> +		break;
> >> +	default:
> >> +		dev_warn(hdmi->dev, "Unsupported audio sample rate (%u)
\n",
> >> +			 hdmi->sample_rate);
> >> +		return;
> >> +	}
> >> +
> >> +	/* set channel status register */
> >> +	hdmi_modb(hdmi, aud_schnl_samplerate, 
HDMI_FC_AUDSCHNLS7_SMPRATE_MASK,
> >> +		  HDMI_FC_AUDSCHNLS7);
> >> +
> >> +	/*
> >> +	 * Set original frequency to be the same as frequency.
> >> +	 * Use one-complement value as stated in IEC60958-3 page 13.
> >> +	 */
> >> +	aud_schnl_8 = (~aud_schnl_samplerate) <<
> >> +			HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_OFFSET;
> >> +
> >> +	/* This means word length is 16 bit. Refer to IEC60958-3 page 12. 
*/
> >> +	aud_schnl_8 |= 2 << HDMI_FC_AUDSCHNLS8_WORDLEGNTH_OFFSET;
> >> +
> >> +	hdmi_writeb(hdmi, aud_schnl_8, HDMI_FC_AUDSCHNLS8);
> >> +}
> >> +
> >> 
> >>  static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
> >>  
> >>  	unsigned long pixel_clk, unsigned int sample_rate)
> >>  
> >>  {
> >> 
> >> @@ -620,6 +677,8 @@ static void hdmi_set_clk_regenerator(struct dw_hdmi
> >> *hdmi,>> 
> >>  	hdmi->audio_cts = cts;
> >>  	hdmi_set_cts_n(hdmi, cts, hdmi->audio_enable ? n : 0);
> >>  	spin_unlock_irq(&hdmi->audio_lock);
> >> 
> >> +
> >> +	hdmi_set_schnl(hdmi);
> >> 
> >>  }
> >>  
> >>  static void hdmi_init_clk_regenerator(struct dw_hdmi *hdmi)
> >> 
> >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> >> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h index
> >> 6988f12d89d9..619ebc1c8354 100644
> >> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> >> @@ -158,6 +158,17 @@
> >> 
> >>  #define HDMI_FC_SPDDEVICEINF                    0x1062
> >>  #define HDMI_FC_AUDSCONF                        0x1063
> >>  #define HDMI_FC_AUDSSTAT                        0x1064
> >> 
> >> +#define HDMI_FC_AUDSV                           0x1065
> >> +#define HDMI_FC_AUDSU                           0x1066
> >> +#define HDMI_FC_AUDSCHNLS0                      0x1067
> >> +#define HDMI_FC_AUDSCHNLS1                      0x1068
> >> +#define HDMI_FC_AUDSCHNLS2                      0x1069
> >> +#define HDMI_FC_AUDSCHNLS3                      0x106a
> >> +#define HDMI_FC_AUDSCHNLS4                      0x106b
> >> +#define HDMI_FC_AUDSCHNLS5                      0x106c
> >> +#define HDMI_FC_AUDSCHNLS6                      0x106d
> >> +#define HDMI_FC_AUDSCHNLS7                      0x106e
> >> +#define HDMI_FC_AUDSCHNLS8                      0x106f
> >> 
> >>  #define HDMI_FC_DATACH0FILL                     0x1070
> >>  #define HDMI_FC_DATACH1FILL                     0x1071
> >>  #define HDMI_FC_DATACH2FILL                     0x1072
> >> 
> >> @@ -706,6 +717,15 @@ enum {
> >> 
> >>  /* HDMI_FC_AUDSCHNLS7 field values */
> >>  
> >>  	HDMI_FC_AUDSCHNLS7_ACCURACY_OFFSET = 4,
> >>  	HDMI_FC_AUDSCHNLS7_ACCURACY_MASK = 0x30,
> >> 
> >> +	HDMI_FC_AUDSCHNLS7_SMPRATE_MASK = 0x0f,
> >> +	HDMI_FC_AUDSCHNLS7_SMPRATE_192K = 0xe,
> >> +	HDMI_FC_AUDSCHNLS7_SMPRATE_176K4 = 0xc,
> >> +	HDMI_FC_AUDSCHNLS7_SMPRATE_96K = 0xa,
> >> +	HDMI_FC_AUDSCHNLS7_SMPRATE_768K = 0x9,
> >> +	HDMI_FC_AUDSCHNLS7_SMPRATE_88K2 = 0x8,
> >> +	HDMI_FC_AUDSCHNLS7_SMPRATE_32K = 0x3,
> >> +	HDMI_FC_AUDSCHNLS7_SMPRATE_48K = 0x2,
> >> +	HDMI_FC_AUDSCHNLS7_SMPRATE_44K1 = 0x0,
> >> 
> >>  /* HDMI_FC_AUDSCHNLS8 field values */
> >>  
> >>  	HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_MASK = 0xf0,




