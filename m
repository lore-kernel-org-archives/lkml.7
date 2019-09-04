Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B25C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EB32339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U+b4Fp2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfIDJON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:14:13 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37493 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbfIDJON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:14:13 -0400
Received: by mail-vs1-f65.google.com with SMTP id q9so7185982vsl.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 02:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MN0b6OvKnXZr8uGhWjmCrGTXb1h5H1L7qagdNg+S1sg=;
        b=U+b4Fp2al576XCFXnzNH1lWT0u9Rlzbc5/BCXDYtfPEfL1w+DTyq4kDUJXYVvy2RMv
         5IUy877oizgwz2GMU72ADTgzpmexHkRBrQ9l0hZ3GsdV/Fpue2ESv+qkSnf9pJXNV8u3
         MJ1eRzLaZcdq5uLHh0A+1OJ77a4mqchZ12yKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MN0b6OvKnXZr8uGhWjmCrGTXb1h5H1L7qagdNg+S1sg=;
        b=Bb+Q0XIB8dZpVQ1JC2TOlIFtlUbnI1n7tz0MDHMBGKyHKBiZLjLGnHaPQzhfCzJRLe
         vCxsc3uOivETCSKFwfGGbDpBw/ie0npUhO587hBa4yYQyuHy68gL0bTq5YtuHkkA+uzB
         EzGA3UOoXJg89d/aC6L/MbRsUlFnMAOFrV3IMiebL9qCcwDtgHzmT0E3QhEFJdFdGeL9
         wbJA3fK1GiNSpRqvdl2Tj229dahWcJ1g0IzQKrSdGTv5JQv70kDXRun/pPvNV/Bep5nx
         qrj3vFazWL8zr8yqYiSHTVsfLwGUVWidkqayY7CF2dtoQAVKJqkLB+BzZOO6R+oE7af8
         kGYg==
X-Gm-Message-State: APjAAAUb2CHTNUyOe6LiFVooeuDwgMg6lF22af56m1m9fNjWll3HjgsA
        iF9Dee7nm1hOiTq2Ow7aGDxBw6j2j3+MnU+uh9rAlQ==
X-Google-Smtp-Source: APXvYqykSGETqss+CbHmnsZe1fTUP4pEHpX6xPKY5VZ2TjYX0n59XRPduBG0rpnAbraIcYajXzkHkvwwXMNo38IzQGQ=
X-Received: by 2002:a05:6102:7d5:: with SMTP id y21mr21284524vsg.9.1567588451598;
 Wed, 04 Sep 2019 02:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190903055103.134764-1-cychiang@chromium.org>
 <e1c3483c-baa6-c726-e547-fadf40d259f4@baylibre.com> <d8a80ba5-dd2b-f84d-bbfc-9dd5ccbc26e9@baylibre.com>
In-Reply-To: <d8a80ba5-dd2b-f84d-bbfc-9dd5ccbc26e9@baylibre.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Wed, 4 Sep 2019 17:13:45 +0800
Message-ID: <CAFv8NwJz9gbdjqcNNxBzvzoOWGu4MeFjp=OKcfH=wCPksQc8Zw@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge/dw_hdmi: add audio sample channel status setting
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, tzungbi@chromium.org,
        Xing Zheng <zhengxing@rock-chips.com>,
        kuninori.morimoto.gx@renesas.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>, kuankuan.y@gmail.com,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>, cain.cai@rock-chips.com,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?B?6JSh5p6r?= <eddie.cai@rock-chips.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dylan Reid <dgreid@chromium.org>, sam@ravnborg.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 2:00 AM Neil Armstrong <narmstrong@baylibre.com> wro=
te:
>
> Hi,
>
> Le 03/09/2019 =C3=A0 11:53, Neil Armstrong a =C3=A9crit :
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
> >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 59 ++++++++++++++++++++++=
+
> >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h | 20 ++++++++
> >>  2 files changed, 79 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi.c
> >> index bd65d0479683..34d46e25d610 100644
> >> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> @@ -582,6 +582,63 @@ static unsigned int hdmi_compute_n(unsigned int f=
req, unsigned long pixel_clk)
> >>      return n;
> >>  }
> >>
> >> +static void hdmi_set_schnl(struct dw_hdmi *hdmi)
> >> +{
> >> +    u8 aud_schnl_samplerate;
> >> +    u8 aud_schnl_8;
> >> +
> >> +    /* These registers are on RK3288 using version 2.0a. */
> >> +    if (hdmi->version !=3D 0x200a)
> >> +            return;
> >
> > Are these limited to the 2.0a version *in* RK3288, or 2.0a version on a=
ll
> > SoCs ?
>
> After investigations, Amlogic sets these registers on their 2.0a version
> aswell, and Jernej (added in Cc) reported me Allwinner sets them on their
> < 2.0a and > 2.0a IPs versions.
>
> Can you check on the Rockchip IP versions in RK3399 ?
>
Sorry, the RK3399 board I am using is using DP, not HDMI.
But I found that on rockchip's tree at

https://github.com/rockchip-linux/kernel/commit/924f480383c982da9908fb96d6b=
bb580b25545a5#diff-f74b4cfb23436a137a9338a5af3fbb3dR172

There is such register setting, so I think RK3399 should have the same regi=
ster.


> For reference, the HDMI 1.4a IP version allwinner setups is:
> https://github.com/Allwinner-Homlet/H3-BSP4.4-linux/blob/master/drivers/v=
ideo/fbdev/sunxi/disp2/hdmi/hdmi_bsp_sun8iw7.c#L531-L539
> (registers a "scrambled" but a custom bit can reset to the original mappi=
ng,
> 0x1066 ... 0x106f)

I see.. so 1.4 has this register.
I can modify the check to be >=3D 1.4 then.
Will fix in v2.

Thanks!

>
> Neil
>
> >
> >> +
> >> +    switch (hdmi->sample_rate) {
> >> +    case 32000:
> >> +            aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_32K;
> >> +            break;
> >> +    case 44100:
> >> +            aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_44K1;
> >> +            break;
> >> +    case 48000:
> >> +            aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_48K;
> >> +            break;
> >> +    case 88200:
> >> +            aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_88K2;
> >> +            break;
> >> +    case 96000:
> >> +            aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_96K;
> >> +            break;
> >> +    case 176400:
> >> +            aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_176K4=
;
> >> +            break;
> >> +    case 192000:
> >> +            aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_192K;
> >> +            break;
> >> +    case 768000:
> >> +            aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_768K;
> >> +            break;
> >> +    default:
> >> +            dev_warn(hdmi->dev, "Unsupported audio sample rate (%u)\n=
",
> >> +                     hdmi->sample_rate);
> >> +            return;
> >> +    }
> >> +
> >> +    /* set channel status register */
> >> +    hdmi_modb(hdmi, aud_schnl_samplerate, HDMI_FC_AUDSCHNLS7_SMPRATE_=
MASK,
> >> +              HDMI_FC_AUDSCHNLS7);
> >> +
> >> +    /*
> >> +     * Set original frequency to be the same as frequency.
> >> +     * Use one-complement value as stated in IEC60958-3 page 13.
> >> +     */
> >> +    aud_schnl_8 =3D (~aud_schnl_samplerate) <<
> >> +                    HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_OFFSET;
> >> +
> >> +    /* This means word length is 16 bit. Refer to IEC60958-3 page 12.=
 */
> >> +    aud_schnl_8 |=3D 2 << HDMI_FC_AUDSCHNLS8_WORDLEGNTH_OFFSET;
> >> +
> >> +    hdmi_writeb(hdmi, aud_schnl_8, HDMI_FC_AUDSCHNLS8);
> >> +}
> >> +
> >>  static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
> >>      unsigned long pixel_clk, unsigned int sample_rate)
> >>  {
> >> @@ -620,6 +677,8 @@ static void hdmi_set_clk_regenerator(struct dw_hdm=
i *hdmi,
> >>      hdmi->audio_cts =3D cts;
> >>      hdmi_set_cts_n(hdmi, cts, hdmi->audio_enable ? n : 0);
> >>      spin_unlock_irq(&hdmi->audio_lock);
> >> +
> >> +    hdmi_set_schnl(hdmi);
> >>  }
> >>
> >>  static void hdmi_init_clk_regenerator(struct dw_hdmi *hdmi)
> >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi.h
> >> index 6988f12d89d9..619ebc1c8354 100644
> >> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> >> @@ -158,6 +158,17 @@
> >>  #define HDMI_FC_SPDDEVICEINF                    0x1062
> >>  #define HDMI_FC_AUDSCONF                        0x1063
> >>  #define HDMI_FC_AUDSSTAT                        0x1064
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
> >>  #define HDMI_FC_DATACH0FILL                     0x1070
> >>  #define HDMI_FC_DATACH1FILL                     0x1071
> >>  #define HDMI_FC_DATACH2FILL                     0x1072
> >> @@ -706,6 +717,15 @@ enum {
> >>  /* HDMI_FC_AUDSCHNLS7 field values */
> >>      HDMI_FC_AUDSCHNLS7_ACCURACY_OFFSET =3D 4,
> >>      HDMI_FC_AUDSCHNLS7_ACCURACY_MASK =3D 0x30,
> >> +    HDMI_FC_AUDSCHNLS7_SMPRATE_MASK =3D 0x0f,
> >> +    HDMI_FC_AUDSCHNLS7_SMPRATE_192K =3D 0xe,
> >> +    HDMI_FC_AUDSCHNLS7_SMPRATE_176K4 =3D 0xc,
> >> +    HDMI_FC_AUDSCHNLS7_SMPRATE_96K =3D 0xa,
> >> +    HDMI_FC_AUDSCHNLS7_SMPRATE_768K =3D 0x9,
> >> +    HDMI_FC_AUDSCHNLS7_SMPRATE_88K2 =3D 0x8,
> >> +    HDMI_FC_AUDSCHNLS7_SMPRATE_32K =3D 0x3,
> >> +    HDMI_FC_AUDSCHNLS7_SMPRATE_48K =3D 0x2,
> >> +    HDMI_FC_AUDSCHNLS7_SMPRATE_44K1 =3D 0x0,
> >>
> >>  /* HDMI_FC_AUDSCHNLS8 field values */
> >>      HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_MASK =3D 0xf0,
> >>
> >
