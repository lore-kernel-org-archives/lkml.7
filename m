Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490BFC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131C221852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="at/Rzl+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfIQN6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:58:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44387 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfIQN6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:58:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id 21so3082644otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f9Ic2nh0M3eSfguu2IBsLH1I2cap5zIzcYSHxECOH6g=;
        b=at/Rzl+NdRusFIQ8yF3troxz7j2whbeKM80wozcNr+jELmelX6Th+zVmVgj58lN2vE
         pVHUBCTZfN+m8IoZndVKmYTgBAPqMbGg2CjCTIGu/k7ePJRw/uDX0qqCBvW/deSUvVB9
         bcWRmnKB6bvMEkGj47IIA3EVwqeO1aqccscV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f9Ic2nh0M3eSfguu2IBsLH1I2cap5zIzcYSHxECOH6g=;
        b=T4tys1tW62IEtzq7ucei4MRABkB3g2IsGN6cVK/up10tv+QQLGmFbADjSep4P69gLb
         LSW807i5EFodJ+epWqXQ+PgyVnWC7dLa4FhFL/bCxqW7AivUUcDrY33jyeLzWRBET/Jb
         C6aCB8lbk1DKu/ZLw78tPFdKO4kzqPkBwGfY4cmvGiWbOXY2m810WQ3EEL4qxter1A+k
         sYRluQGdUj19JSpxNBNCrz3lyotmpehJeA5VmY7/mLvuolY2c1v16RKLeoKoHeWJtAbu
         i/dsLjMM5SqaSrS0D2z9TNia0PygtDrfkOtl6SWoJNkzgkt5Lh06wRprv1B+VKhBiETi
         kmOA==
X-Gm-Message-State: APjAAAVwOLfb4AbM7hsKM1vRSq3JWBuuxKrriMz0N6iJFV793eM6QC/u
        YToDSLOUM1QfvpZuIcZUmkCGnJ7m991NZ2VlPowEcQ==
X-Google-Smtp-Source: APXvYqxCJjVhJf1aoT5CFBxCOwCvUT3YcigB4EbWbU98Pfd53VVh6pQXWT2Guhq0WjhT33gUR/v/0QJKO2SL7beOYx0=
X-Received: by 2002:a05:6830:10d8:: with SMTP id z24mr2946326oto.281.1568728727367;
 Tue, 17 Sep 2019 06:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190909101254.24191-1-benjamin.gaignard@st.com>
 <CA+M3ks7XUt5co5HHBv1LPNB8CAPqDnrn4wr-oQeKOHnGj4Pyjg@mail.gmail.com>
 <20190917124635.GP3958@phenom.ffwll.local> <CA+M3ks4y5jLM_NsSUfPO1KR5r8=xB23=nd43jwjLhixBYV0pbg@mail.gmail.com>
In-Reply-To: <CA+M3ks4y5jLM_NsSUfPO1KR5r8=xB23=nd43jwjLhixBYV0pbg@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 17 Sep 2019 15:58:35 +0200
Message-ID: <CAKMK7uFL0iWYF-PK51a3ca3pSjRYoC-+zTRtWCTXVC8aPd4jbw@mail.gmail.com>
Subject: Re: [PATCH] drm: sti: fix W=1 warnings
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Maxime Ripard <mripard@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 3:40 PM Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
>
> Le mar. 17 sept. 2019 =C3=A0 14:46, Daniel Vetter <daniel@ffwll.ch> a =C3=
=A9crit :
> >
> > On Mon, Sep 16, 2019 at 03:16:49PM +0200, Benjamin Gaignard wrote:
> > > Le lun. 9 sept. 2019 =C3=A0 12:29, Benjamin Gaignard
> > > <benjamin.gaignard@st.com> a =C3=A9crit :
> > > >
> > > > Fix warnings when W=3D1.
> > > > No code changes, only clean up in sti internal structures and funct=
ions
> > > > descriptions.
> > > >
> > > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > >
> > > For my own reference, applied on drm-misc-next
> >
> > Dude seriously no:
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > Link: https://patchwork.freedesktop.org/patch/msgid/20190909101254.2419=
1-1-benjamin.gaignard@st.com
> >
> > Self-review ain't ok in drm-misc, you need someone to
> > ack/double-check/have a look. And given that you had to fabricate your
> > self-review yourself somehow (the tools really don't do that for you) t=
his
> > doesn't look like an accident.
> >
> > Adding other maintainers.
> > -Daniel
> >
>
> All my apologies, I have taken a shortcut for this STI patch...
> I will ask to Philippe or Yannick to formally review STI related
> patches on mailing and not only on internal one.

Note we don't require full formal review, that's just overkill. But a
quick ack shouldn't bee too much for any driver with more than 1
person working on it.

Also pls no internal review, because review is about learning and
sharing knowledge, and code correctness only secondary. If you do that
behind closed doors you forgoe most of the benefits.
-Daniel

>
> Benjamin
>
> > >
> > > > ---
> > > >  drivers/gpu/drm/sti/sti_cursor.c |  2 +-
> > > >  drivers/gpu/drm/sti/sti_dvo.c    |  2 +-
> > > >  drivers/gpu/drm/sti/sti_gdp.c    |  2 +-
> > > >  drivers/gpu/drm/sti/sti_hda.c    |  2 +-
> > > >  drivers/gpu/drm/sti/sti_hdmi.c   |  4 ++--
> > > >  drivers/gpu/drm/sti/sti_tvout.c  | 10 +++++-----
> > > >  drivers/gpu/drm/sti/sti_vtg.c    |  2 +-
> > > >  7 files changed, 12 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti=
/sti_cursor.c
> > > > index 0bf7c332cf0b..ea64c1dcaf63 100644
> > > > --- a/drivers/gpu/drm/sti/sti_cursor.c
> > > > +++ b/drivers/gpu/drm/sti/sti_cursor.c
> > > > @@ -47,7 +47,7 @@ struct dma_pixmap {
> > > >         void *base;
> > > >  };
> > > >
> > > > -/**
> > > > +/*
> > > >   * STI Cursor structure
> > > >   *
> > > >   * @sti_plane:    sti_plane structure
> > > > diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/st=
i_dvo.c
> > > > index 9e6d5d8b7030..c33d0aaee82b 100644
> > > > --- a/drivers/gpu/drm/sti/sti_dvo.c
> > > > +++ b/drivers/gpu/drm/sti/sti_dvo.c
> > > > @@ -65,7 +65,7 @@ static struct dvo_config rgb_24bit_de_cfg =3D {
> > > >         .awg_fwgen_fct =3D sti_awg_generate_code_data_enable_mode,
> > > >  };
> > > >
> > > > -/**
> > > > +/*
> > > >   * STI digital video output structure
> > > >   *
> > > >   * @dev: driver device
> > > > diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/st=
i_gdp.c
> > > > index 8e926cd6a1c8..11595c748844 100644
> > > > --- a/drivers/gpu/drm/sti/sti_gdp.c
> > > > +++ b/drivers/gpu/drm/sti/sti_gdp.c
> > > > @@ -103,7 +103,7 @@ struct sti_gdp_node_list {
> > > >         dma_addr_t btm_field_paddr;
> > > >  };
> > > >
> > > > -/**
> > > > +/*
> > > >   * STI GDP structure
> > > >   *
> > > >   * @sti_plane:          sti_plane structure
> > > > diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/st=
i_hda.c
> > > > index 94e404f13234..3512a94a0fca 100644
> > > > --- a/drivers/gpu/drm/sti/sti_hda.c
> > > > +++ b/drivers/gpu/drm/sti/sti_hda.c
> > > > @@ -230,7 +230,7 @@ static const struct sti_hda_video_config hda_su=
pported_modes[] =3D {
> > > >          AWGi_720x480p_60, NN_720x480p_60, VID_ED}
> > > >  };
> > > >
> > > > -/**
> > > > +/*
> > > >   * STI hd analog structure
> > > >   *
> > > >   * @dev: driver device
> > > > diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/s=
ti_hdmi.c
> > > > index f03d617edc4c..87e34f7a6cfe 100644
> > > > --- a/drivers/gpu/drm/sti/sti_hdmi.c
> > > > +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> > > > @@ -333,7 +333,6 @@ static void hdmi_infoframe_reset(struct sti_hdm=
i *hdmi,
> > > >   * Helper to concatenate infoframe in 32 bits word
> > > >   *
> > > >   * @ptr: pointer on the hdmi internal structure
> > > > - * @data: infoframe to write
> > > >   * @size: size to write
> > > >   */
> > > >  static inline unsigned int hdmi_infoframe_subpack(const u8 *ptr, s=
ize_t size)
> > > > @@ -543,13 +542,14 @@ static int hdmi_vendor_infoframe_config(struc=
t sti_hdmi *hdmi)
> > > >         return 0;
> > > >  }
> > > >
> > > > +#define HDMI_TIMEOUT_SWRESET  100   /*milliseconds */
> > > > +
> > > >  /**
> > > >   * Software reset of the hdmi subsystem
> > > >   *
> > > >   * @hdmi: pointer on the hdmi internal structure
> > > >   *
> > > >   */
> > > > -#define HDMI_TIMEOUT_SWRESET  100   /*milliseconds */
> > > >  static void hdmi_swreset(struct sti_hdmi *hdmi)
> > > >  {
> > > >         u32 val;
> > > > diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/=
sti_tvout.c
> > > > index e1b3c8cb7287..b1fc77b150da 100644
> > > > --- a/drivers/gpu/drm/sti/sti_tvout.c
> > > > +++ b/drivers/gpu/drm/sti/sti_tvout.c
> > > > @@ -157,9 +157,9 @@ static void tvout_write(struct sti_tvout *tvout=
, u32 val, int offset)
> > > >   *
> > > >   * @tvout: tvout structure
> > > >   * @reg: register to set
> > > > - * @cr_r:
> > > > - * @y_g:
> > > > - * @cb_b:
> > > > + * @cr_r: red chroma or red order
> > > > + * @y_g: y or green order
> > > > + * @cb_b: blue chroma or blue order
> > > >   */
> > > >  static void tvout_vip_set_color_order(struct sti_tvout *tvout, int=
 reg,
> > > >                                       u32 cr_r, u32 y_g, u32 cb_b)
> > > > @@ -214,7 +214,7 @@ static void tvout_vip_set_rnd(struct sti_tvout =
*tvout, int reg, u32 rnd)
> > > >   * @tvout: tvout structure
> > > >   * @reg: register to set
> > > >   * @main_path: main or auxiliary path
> > > > - * @sel_input: selected_input (main/aux + conv)
> > > > + * @video_out: selected_input (main/aux + conv)
> > > >   */
> > > >  static void tvout_vip_set_sel_input(struct sti_tvout *tvout,
> > > >                                     int reg,
> > > > @@ -251,7 +251,7 @@ static void tvout_vip_set_sel_input(struct sti_=
tvout *tvout,
> > > >   *
> > > >   * @tvout: tvout structure
> > > >   * @reg: register to set
> > > > - * @in_vid_signed: used video input format
> > > > + * @in_vid_fmt: used video input format
> > > >   */
> > > >  static void tvout_vip_set_in_vid_fmt(struct sti_tvout *tvout,
> > > >                 int reg, u32 in_vid_fmt)
> > > > diff --git a/drivers/gpu/drm/sti/sti_vtg.c b/drivers/gpu/drm/sti/st=
i_vtg.c
> > > > index ef4009f11396..0b17ac8a3faa 100644
> > > > --- a/drivers/gpu/drm/sti/sti_vtg.c
> > > > +++ b/drivers/gpu/drm/sti/sti_vtg.c
> > > > @@ -121,7 +121,7 @@ struct sti_vtg_sync_params {
> > > >         u32 vsync_off_bot;
> > > >  };
> > > >
> > > > -/**
> > > > +/*
> > > >   * STI VTG structure
> > > >   *
> > > >   * @regs: register mapping
> > > > --
> > > > 2.15.0
> > > >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
