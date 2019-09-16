Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294CBC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E524820644
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvIG+jDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbfIPNRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:17:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45997 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732956AbfIPNRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:17:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id c21so4406189qtj.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 06:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AfsCDT99MT8mtEXYRpUBfavmRU7fsMrXI5BMAHxEVzI=;
        b=PvIG+jDBXVedgUPD3XcKjHXh5GDKqOp6YQ5ufoyVceXIoVGwopQ/YmWFL4OVJUNOw+
         rg3JjZRxzKrimH/q3tVCDMKSdjV7ROqFcnQjv++HQZIGeb04XDwCnfTCIG5Imu9G5KV8
         gLF4oc144DNkzKnQw/qZIYxWXGPKmWcCONm8fBjm7z+VxV6Od01gaoEALMr7xypDoMgs
         wpuuuQE/8fFPWLwLag45b+0eFdLITFhpYc2ztug3j/N0eNOcGEYQbiWOAWl+RVmZ6vaU
         OvNdfUtA3+I4Ob61xRGZrab2yZo4X5zqT3xf3vKvNRSHVhsC1r93oRlTtxCC9SSZvKyi
         E0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AfsCDT99MT8mtEXYRpUBfavmRU7fsMrXI5BMAHxEVzI=;
        b=qwrzL/DsrXA2g5hY/p0OfPzr0kk2OfJrfBQaXNoJuIh2uIHoOZTKt7MCH7c8Drr9do
         HSvW9yR61COtJ+fiHZ/BrPJ2dYeDvfG9dB0JcP2F+ytce80L7plm206bJuZzALE4dCSb
         7M/ovtuQG69VIU2qkYncujry/JmYLRdC/Mx0KEyhNR+F3TUlnTnK4X8myUdUqoq5Far6
         iOwOe34WtMoAej+/ubNqIoSgu1FdDAtklBzSzqeJArxYIvc7hpCDGdHjw1jAnl3/o8eR
         E3vx7UOl+F/DpWc+LclhR1hd+ZR56zm7Hv1LOc/g2Z5scvq7qrYxVBN0UIibyLHRdHVY
         y2Kg==
X-Gm-Message-State: APjAAAWM5kLb3iNP10ZKfpGwXDHI2QjLSDnK0IkeP8udLpb8+BRL4RI9
        am32IEjo5cc6E97ry6d+b5xrnvhJDWwCJ1WtJhyI4w==
X-Google-Smtp-Source: APXvYqx5f0B8c8vyFPb+oOLmnL41S+UwF4v1C7z9cTUD+w7lpIU7SP9FhUtOAvECDvDTB+VwcUKflfHRj/EyZJAuYrk=
X-Received: by 2002:a0c:b359:: with SMTP id a25mr14290448qvf.242.1568639820337;
 Mon, 16 Sep 2019 06:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190909101254.24191-1-benjamin.gaignard@st.com>
In-Reply-To: <20190909101254.24191-1-benjamin.gaignard@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 16 Sep 2019 15:16:49 +0200
Message-ID: <CA+M3ks7XUt5co5HHBv1LPNB8CAPqDnrn4wr-oQeKOHnGj4Pyjg@mail.gmail.com>
Subject: Re: [PATCH] drm: sti: fix W=1 warnings
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 9 sept. 2019 =C3=A0 12:29, Benjamin Gaignard
<benjamin.gaignard@st.com> a =C3=A9crit :
>
> Fix warnings when W=3D1.
> No code changes, only clean up in sti internal structures and functions
> descriptions.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

For my own reference, applied on drm-misc-next

> ---
>  drivers/gpu/drm/sti/sti_cursor.c |  2 +-
>  drivers/gpu/drm/sti/sti_dvo.c    |  2 +-
>  drivers/gpu/drm/sti/sti_gdp.c    |  2 +-
>  drivers/gpu/drm/sti/sti_hda.c    |  2 +-
>  drivers/gpu/drm/sti/sti_hdmi.c   |  4 ++--
>  drivers/gpu/drm/sti/sti_tvout.c  | 10 +++++-----
>  drivers/gpu/drm/sti/sti_vtg.c    |  2 +-
>  7 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_c=
ursor.c
> index 0bf7c332cf0b..ea64c1dcaf63 100644
> --- a/drivers/gpu/drm/sti/sti_cursor.c
> +++ b/drivers/gpu/drm/sti/sti_cursor.c
> @@ -47,7 +47,7 @@ struct dma_pixmap {
>         void *base;
>  };
>
> -/**
> +/*
>   * STI Cursor structure
>   *
>   * @sti_plane:    sti_plane structure
> diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.=
c
> index 9e6d5d8b7030..c33d0aaee82b 100644
> --- a/drivers/gpu/drm/sti/sti_dvo.c
> +++ b/drivers/gpu/drm/sti/sti_dvo.c
> @@ -65,7 +65,7 @@ static struct dvo_config rgb_24bit_de_cfg =3D {
>         .awg_fwgen_fct =3D sti_awg_generate_code_data_enable_mode,
>  };
>
> -/**
> +/*
>   * STI digital video output structure
>   *
>   * @dev: driver device
> diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.=
c
> index 8e926cd6a1c8..11595c748844 100644
> --- a/drivers/gpu/drm/sti/sti_gdp.c
> +++ b/drivers/gpu/drm/sti/sti_gdp.c
> @@ -103,7 +103,7 @@ struct sti_gdp_node_list {
>         dma_addr_t btm_field_paddr;
>  };
>
> -/**
> +/*
>   * STI GDP structure
>   *
>   * @sti_plane:          sti_plane structure
> diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.=
c
> index 94e404f13234..3512a94a0fca 100644
> --- a/drivers/gpu/drm/sti/sti_hda.c
> +++ b/drivers/gpu/drm/sti/sti_hda.c
> @@ -230,7 +230,7 @@ static const struct sti_hda_video_config hda_supporte=
d_modes[] =3D {
>          AWGi_720x480p_60, NN_720x480p_60, VID_ED}
>  };
>
> -/**
> +/*
>   * STI hd analog structure
>   *
>   * @dev: driver device
> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdm=
i.c
> index f03d617edc4c..87e34f7a6cfe 100644
> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> @@ -333,7 +333,6 @@ static void hdmi_infoframe_reset(struct sti_hdmi *hdm=
i,
>   * Helper to concatenate infoframe in 32 bits word
>   *
>   * @ptr: pointer on the hdmi internal structure
> - * @data: infoframe to write
>   * @size: size to write
>   */
>  static inline unsigned int hdmi_infoframe_subpack(const u8 *ptr, size_t =
size)
> @@ -543,13 +542,14 @@ static int hdmi_vendor_infoframe_config(struct sti_=
hdmi *hdmi)
>         return 0;
>  }
>
> +#define HDMI_TIMEOUT_SWRESET  100   /*milliseconds */
> +
>  /**
>   * Software reset of the hdmi subsystem
>   *
>   * @hdmi: pointer on the hdmi internal structure
>   *
>   */
> -#define HDMI_TIMEOUT_SWRESET  100   /*milliseconds */
>  static void hdmi_swreset(struct sti_hdmi *hdmi)
>  {
>         u32 val;
> diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_tv=
out.c
> index e1b3c8cb7287..b1fc77b150da 100644
> --- a/drivers/gpu/drm/sti/sti_tvout.c
> +++ b/drivers/gpu/drm/sti/sti_tvout.c
> @@ -157,9 +157,9 @@ static void tvout_write(struct sti_tvout *tvout, u32 =
val, int offset)
>   *
>   * @tvout: tvout structure
>   * @reg: register to set
> - * @cr_r:
> - * @y_g:
> - * @cb_b:
> + * @cr_r: red chroma or red order
> + * @y_g: y or green order
> + * @cb_b: blue chroma or blue order
>   */
>  static void tvout_vip_set_color_order(struct sti_tvout *tvout, int reg,
>                                       u32 cr_r, u32 y_g, u32 cb_b)
> @@ -214,7 +214,7 @@ static void tvout_vip_set_rnd(struct sti_tvout *tvout=
, int reg, u32 rnd)
>   * @tvout: tvout structure
>   * @reg: register to set
>   * @main_path: main or auxiliary path
> - * @sel_input: selected_input (main/aux + conv)
> + * @video_out: selected_input (main/aux + conv)
>   */
>  static void tvout_vip_set_sel_input(struct sti_tvout *tvout,
>                                     int reg,
> @@ -251,7 +251,7 @@ static void tvout_vip_set_sel_input(struct sti_tvout =
*tvout,
>   *
>   * @tvout: tvout structure
>   * @reg: register to set
> - * @in_vid_signed: used video input format
> + * @in_vid_fmt: used video input format
>   */
>  static void tvout_vip_set_in_vid_fmt(struct sti_tvout *tvout,
>                 int reg, u32 in_vid_fmt)
> diff --git a/drivers/gpu/drm/sti/sti_vtg.c b/drivers/gpu/drm/sti/sti_vtg.=
c
> index ef4009f11396..0b17ac8a3faa 100644
> --- a/drivers/gpu/drm/sti/sti_vtg.c
> +++ b/drivers/gpu/drm/sti/sti_vtg.c
> @@ -121,7 +121,7 @@ struct sti_vtg_sync_params {
>         u32 vsync_off_bot;
>  };
>
> -/**
> +/*
>   * STI VTG structure
>   *
>   * @regs: register mapping
> --
> 2.15.0
>
