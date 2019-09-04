Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A276C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C5221670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RUqHkSmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfIDJgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:36:25 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:32962 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfIDJgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:36:24 -0400
Received: by mail-vs1-f68.google.com with SMTP id s18so6275181vsa.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 02:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+o+ErCjuT5qX6PyUMFETCMRQPrMpr1ayP1BJFKFPXQY=;
        b=RUqHkSmy9lAe6HlMGvJ2AeO7vvfTM/8ipY2yHVIo0GAAHyrGu1dtp2hncgfldaDL19
         0HgFoiRdCBjS33NXxSzdy9Igs4pUaLthBfVUFDpkYJTVRuQjYcc3oPcrvfUkCnx2TpO7
         Hyv+CTguGHsymOnLw2Vy2oDEPaCwxDbVwVANA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+o+ErCjuT5qX6PyUMFETCMRQPrMpr1ayP1BJFKFPXQY=;
        b=FzdQTM1ClrA9tows3k65Y8NfvQb0PprnapvP7y3gTiuiRzLRsltTf4ZbFLdnnwBm2a
         Btuxp612jNKfr0pjK+Bmh5W25vNshfk27ZutRR7DAoTv/7skl3mBD761hU293SN6io12
         Q3b2B3Wh3ob3fUGGHNwOozMfIyV5nAzMCO9PMA7W+lfqm6OS1Fk95jnm6RsD+pGLraMh
         PtIOos/GMgK6JeXRk59ADN28pwROBJij2s65OgXhxZkK8Kmn1aIu0QXor7nF76YtVhFt
         ZoRQuGmocQkP2bm4c2XRAFre1FyI0ahETGWja8NBd1rTn3jC/sBEZ3TQKBcbJ7OfSYli
         L/6Q==
X-Gm-Message-State: APjAAAXD3nBSVuLTt4dMf9BdCNGZ3kTTUSXB5GasrTj0VOC/7wADBl+t
        B2W30Y5tfpFRpRGbTPpLAKrQL/pvj8ZvgAtMm6Q41A==
X-Google-Smtp-Source: APXvYqz7zQLlv7fkn9VJhICKcEdJo5UbgsU5W16+fLJAaZnX0P6LdvN3fnQs0PNd8MeWH4ar/6qO0Hc/ewmG8+HR4UE=
X-Received: by 2002:a67:ab0b:: with SMTP id u11mr5576460vse.163.1567589782809;
 Wed, 04 Sep 2019 02:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190903055103.134764-1-cychiang@chromium.org>
 <e1c3483c-baa6-c726-e547-fadf40d259f4@baylibre.com> <d8a80ba5-dd2b-f84d-bbfc-9dd5ccbc26e9@baylibre.com>
 <19353031.SdOy5F5fmg@jernej-laptop> <HE1PR06MB40112AD52DAF0E837F23B441ACB90@HE1PR06MB4011.eurprd06.prod.outlook.com>
In-Reply-To: <HE1PR06MB40112AD52DAF0E837F23B441ACB90@HE1PR06MB4011.eurprd06.prod.outlook.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Wed, 4 Sep 2019 17:35:56 +0800
Message-ID: <CAFv8NwJptZfdqOqtpw4ZrCDwAYT1Rz_Z1wTAybMF_M6Uj4NF2A@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge/dw_hdmi: add audio sample channel status setting
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "tzungbi@chromium.org" <tzungbi@chromium.org>,
        "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "kuankuan.y@gmail.com" <kuankuan.y@gmail.com>,
        "jeffy.chen@rock-chips.com" <jeffy.chen@rock-chips.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "cain.cai@rock-chips.com" <cain.cai@rock-chips.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "eddie.cai@rock-chips.com" <eddie.cai@rock-chips.com>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "dgreid@chromium.org" <dgreid@chromium.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 4:33 AM Jonas Karlman <jonas@kwiboo.se> wrote:
>
> On 2019-09-03 20:08, Jernej =C5=A0krabec wrote:
> > Hi!
> >
> > Dne torek, 03. september 2019 ob 20:00:33 CEST je Neil Armstrong napisa=
l(a):
> >> Hi,
> >>
> >> Le 03/09/2019 =C3=A0 11:53, Neil Armstrong a =C3=A9crit :
> >>> Hi,
> >>>
> >>> On 03/09/2019 07:51, Cheng-Yi Chiang wrote:
> >>>> From: Yakir Yang <ykk@rock-chips.com>
> >>>>
> >>>> When transmitting IEC60985 linear PCM audio, we configure the
> >>>> Audio Sample Channel Status information of all the channel
> >>>> status bits in the IEC60958 frame.
> >>>> Refer to 60958-3 page 10 for frequency, original frequency, and
> >>>> wordlength setting.
> >>>>
> >>>> This fix the issue that audio does not come out on some monitors
> >>>> (e.g. LG 22CV241)
> >>>>
> >>>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> >>>> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> >>>> ---
> >>>>
> >>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 59 ++++++++++++++++++++=
+++
> >>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h | 20 ++++++++
> >>>>  2 files changed, 79 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >>>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> >>>> bd65d0479683..34d46e25d610 100644
> >>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >>>> @@ -582,6 +582,63 @@ static unsigned int hdmi_compute_n(unsigned int
> >>>> freq, unsigned long pixel_clk)>>
> >>>>    return n;
> >>>>
> >>>>  }
> >>>>
> >>>> +static void hdmi_set_schnl(struct dw_hdmi *hdmi)
> >>>> +{
> >>>> +  u8 aud_schnl_samplerate;
> >>>> +  u8 aud_schnl_8;
> >>>> +
> >>>> +  /* These registers are on RK3288 using version 2.0a. */
> >>>> +  if (hdmi->version !=3D 0x200a)
> >>>> +          return;
> >>> Are these limited to the 2.0a version *in* RK3288, or 2.0a version on=
 all
> >>> SoCs ?
> >> After investigations, Amlogic sets these registers on their 2.0a versi=
on
> >> aswell, and Jernej (added in Cc) reported me Allwinner sets them on th=
eir
> >> < 2.0a and > 2.0a IPs versions.
> >>
> >> Can you check on the Rockchip IP versions in RK3399 ?
> >>
> >> For reference, the HDMI 1.4a IP version allwinner setups is:
> >> https://github.com/Allwinner-Homlet/H3-BSP4.4-linux/blob/master/driver=
s/vide
> >> o/fbdev/sunxi/disp2/hdmi/hdmi_bsp_sun8iw7.c#L531-L539 (registers a
> >> "scrambled" but a custom bit can reset to the original mapping, 0x1066=
 ...
> >> 0x106f)
> > For easier reading, here is similar, but annotated version: http://ix.i=
o/1Ub6
> > Check function bsp_hdmi_audio().
> >
> > Unless there is a special reason, you can just remove that check.
>
> Agree, this check should not be needed, AUDSCHNLS7 used to be configured =
in my old
> multi-channel patches that have seen lot of testing on Amlogic, Allwinner=
 and Rockchip SoCs.
>

As stated in previous mail, I will modify the check for version >=3D1.4
since I know that 1.3 does not have such register, at least on iMX6.

> >
> > Best regards,
> > Jernej
> >
> >> Neil
> >>
> >>>> +
> >>>> +  switch (hdmi->sample_rate) {
> >>>> +  case 32000:
> >>>> +          aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_32K;
> >>>> +          break;
> >>>> +  case 44100:
> >>>> +          aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_44K1;
> >>>> +          break;
> >>>> +  case 48000:
> >>>> +          aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_48K;
> >>>> +          break;
> >>>> +  case 88200:
> >>>> +          aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_88K2;
> >>>> +          break;
> >>>> +  case 96000:
> >>>> +          aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_96K;
> >>>> +          break;
> >>>> +  case 176400:
> >>>> +          aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_176K4=
;
> >>>> +          break;
> >>>> +  case 192000:
> >>>> +          aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_192K;
> >>>> +          break;
> >>>> +  case 768000:
> >>>> +          aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_768K;
> >>>> +          break;
> >>>> +  default:
> >>>> +          dev_warn(hdmi->dev, "Unsupported audio sample rate (%u)\n=
",
> >>>> +                   hdmi->sample_rate);
> >>>> +          return;
> >>>> +  }
> >>>> +
> >>>> +  /* set channel status register */
> >>>> +  hdmi_modb(hdmi, aud_schnl_samplerate, HDMI_FC_AUDSCHNLS7_SMPRATE_=
MASK,
> >>>> +            HDMI_FC_AUDSCHNLS7);
> >>>> +
> >>>> +  /*
> >>>> +   * Set original frequency to be the same as frequency.
> >>>> +   * Use one-complement value as stated in IEC60958-3 page 13.
> >>>> +   */
> >>>> +  aud_schnl_8 =3D (~aud_schnl_samplerate) <<
> >>>> +                  HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_OFFSET;
> >>>> +
> >>>> +  /* This means word length is 16 bit. Refer to IEC60958-3 page 12.=
 */
> >>>> +  aud_schnl_8 |=3D 2 << HDMI_FC_AUDSCHNLS8_WORDLEGNTH_OFFSET;
>
> This looks wrong, user can use 16 and 24 bit wide audio streams.
>

Thanks for spotting this issue.
I will fix it in v2 (following how http://ix.io/1Ub6 set it for 16 and 24 b=
it)

> >>>> +
> >>>> +  hdmi_writeb(hdmi, aud_schnl_8, HDMI_FC_AUDSCHNLS8);
> >>>> +}
> >>>> +
> >>>>
> >>>>  static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
> >>>>
> >>>>    unsigned long pixel_clk, unsigned int sample_rate)
> >>>>
> >>>>  {
> >>>>
> >>>> @@ -620,6 +677,8 @@ static void hdmi_set_clk_regenerator(struct dw_h=
dmi
> >>>> *hdmi,>>
> >>>>    hdmi->audio_cts =3D cts;
> >>>>    hdmi_set_cts_n(hdmi, cts, hdmi->audio_enable ? n : 0);
> >>>>    spin_unlock_irq(&hdmi->audio_lock);
> >>>>
> >>>> +
> >>>> +  hdmi_set_schnl(hdmi);
>
> I will suggest this function is called from or merged with dw_hdmi_set_sa=
mple_rate().
> Similar to how AUDSCONF and AUDICONF0 is configured from dw_hdmi_set_chan=
nel_count().
>

I see. I think it will make sense to add a function
set_channel_status() for dw-hdmi-i2s-audio.c to call,
since this function is more than just setting rate.
Will fix in v2.

Thanks!

> Regards,
> Jonas
>
> >>>>
> >>>>  }
> >>>>
> >>>>  static void hdmi_init_clk_regenerator(struct dw_hdmi *hdmi)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> >>>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h index
> >>>> 6988f12d89d9..619ebc1c8354 100644
> >>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> >>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> >>>> @@ -158,6 +158,17 @@
> >>>>
> >>>>  #define HDMI_FC_SPDDEVICEINF                    0x1062
> >>>>  #define HDMI_FC_AUDSCONF                        0x1063
> >>>>  #define HDMI_FC_AUDSSTAT                        0x1064
> >>>>
> >>>> +#define HDMI_FC_AUDSV                           0x1065
> >>>> +#define HDMI_FC_AUDSU                           0x1066
> >>>> +#define HDMI_FC_AUDSCHNLS0                      0x1067
> >>>> +#define HDMI_FC_AUDSCHNLS1                      0x1068
> >>>> +#define HDMI_FC_AUDSCHNLS2                      0x1069
> >>>> +#define HDMI_FC_AUDSCHNLS3                      0x106a
> >>>> +#define HDMI_FC_AUDSCHNLS4                      0x106b
> >>>> +#define HDMI_FC_AUDSCHNLS5                      0x106c
> >>>> +#define HDMI_FC_AUDSCHNLS6                      0x106d
> >>>> +#define HDMI_FC_AUDSCHNLS7                      0x106e
> >>>> +#define HDMI_FC_AUDSCHNLS8                      0x106f
> >>>>
> >>>>  #define HDMI_FC_DATACH0FILL                     0x1070
> >>>>  #define HDMI_FC_DATACH1FILL                     0x1071
> >>>>  #define HDMI_FC_DATACH2FILL                     0x1072
> >>>>
> >>>> @@ -706,6 +717,15 @@ enum {
> >>>>
> >>>>  /* HDMI_FC_AUDSCHNLS7 field values */
> >>>>
> >>>>    HDMI_FC_AUDSCHNLS7_ACCURACY_OFFSET =3D 4,
> >>>>    HDMI_FC_AUDSCHNLS7_ACCURACY_MASK =3D 0x30,
> >>>>
> >>>> +  HDMI_FC_AUDSCHNLS7_SMPRATE_MASK =3D 0x0f,
> >>>> +  HDMI_FC_AUDSCHNLS7_SMPRATE_192K =3D 0xe,
> >>>> +  HDMI_FC_AUDSCHNLS7_SMPRATE_176K4 =3D 0xc,
> >>>> +  HDMI_FC_AUDSCHNLS7_SMPRATE_96K =3D 0xa,
> >>>> +  HDMI_FC_AUDSCHNLS7_SMPRATE_768K =3D 0x9,
> >>>> +  HDMI_FC_AUDSCHNLS7_SMPRATE_88K2 =3D 0x8,
> >>>> +  HDMI_FC_AUDSCHNLS7_SMPRATE_32K =3D 0x3,
> >>>> +  HDMI_FC_AUDSCHNLS7_SMPRATE_48K =3D 0x2,
> >>>> +  HDMI_FC_AUDSCHNLS7_SMPRATE_44K1 =3D 0x0,
> >>>>
> >>>>  /* HDMI_FC_AUDSCHNLS8 field values */
> >>>>
> >>>>    HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_MASK =3D 0xf0,
