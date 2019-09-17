Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953E3C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E000206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="j7cs36nX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfIQMql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:46:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32858 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfIQMql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:46:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id c4so3237014edl.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 05:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MWc4ebZf4LWit2V6qbngzDl/b8CZm1E51lckC0limas=;
        b=j7cs36nX9popbpxWwyXWezsi1VQOvcdeufG9Gax/aEuCl2h+LWBFWnpqlNsCEyp8m/
         A29uy8V1qrc2BQWKnM4IeAXO2ZT67kvhp8LA7V9dzSBT2kYlZzDTEisjH/TJBHCzmhgX
         AzjlWqyz6Wh/UTiuVV7YlLvlnznLU2Q8Q8OYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MWc4ebZf4LWit2V6qbngzDl/b8CZm1E51lckC0limas=;
        b=ROR0HnYWmO+QtV1MSg2HIVe3bJLE03NxICDBgfKjK7EsUvoWddvXbjxAgHcAdGnedj
         jJNMLE+9gRY5iZUG37qihUs1MbqLyvX1Ch6BlGSjMpqfEJtrNYCTkq9ABvUysuuoZxzA
         fAsQPoItnpXlbj+Yq1OvMTSxB36e2IEptFb/avyMJgnFicRAzN82C8T4Gt97KZbdwRiP
         az+ZVnnO0xW/rLe3jXp1Ba9eX+L8TaH/dDJ1Sy3/fIRUagQeuxfMEK2Es0bnGll7tAMH
         0CSomjR7vJ7k0MGanmkuVQWURJiML+T4pRA8kho4xcdrsppQwGMZC7XKnD1Zgg9fKeHI
         /gQA==
X-Gm-Message-State: APjAAAU072X64LndmG5+HBpJPP5qM6nsKLmYpNJFEI0BLRMludknK095
        UvDLweWtcSrwwutT+Do46o9SBw==
X-Google-Smtp-Source: APXvYqy5zuFU9N4CokRUmdSL+8Eyd/hIZQcHTwX6zn4AHO8aIWpBlh6L2q45xnPUISOdxW8QkYGnIA==
X-Received: by 2002:aa7:cdd6:: with SMTP id h22mr2526239edw.132.1568724398667;
        Tue, 17 Sep 2019 05:46:38 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id e20sm264593eja.75.2019.09.17.05.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 05:46:37 -0700 (PDT)
Date:   Tue, 17 Sep 2019 14:46:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Dave Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Maxime Ripard <mripard@kernel.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: sti: fix W=1 warnings
Message-ID: <20190917124635.GP3958@phenom.ffwll.local>
Mail-Followup-To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Dave Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Maxime Ripard <mripard@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190909101254.24191-1-benjamin.gaignard@st.com>
 <CA+M3ks7XUt5co5HHBv1LPNB8CAPqDnrn4wr-oQeKOHnGj4Pyjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks7XUt5co5HHBv1LPNB8CAPqDnrn4wr-oQeKOHnGj4Pyjg@mail.gmail.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 03:16:49PM +0200, Benjamin Gaignard wrote:
> Le lun. 9 sept. 2019 à 12:29, Benjamin Gaignard
> <benjamin.gaignard@st.com> a écrit :
> >
> > Fix warnings when W=1.
> > No code changes, only clean up in sti internal structures and functions
> > descriptions.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> 
> For my own reference, applied on drm-misc-next

Dude seriously no:

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190909101254.24191-1-benjamin.gaignard@st.com

Self-review ain't ok in drm-misc, you need someone to
ack/double-check/have a look. And given that you had to fabricate your
self-review yourself somehow (the tools really don't do that for you) this
doesn't look like an accident.

Adding other maintainers.
-Daniel

> 
> > ---
> >  drivers/gpu/drm/sti/sti_cursor.c |  2 +-
> >  drivers/gpu/drm/sti/sti_dvo.c    |  2 +-
> >  drivers/gpu/drm/sti/sti_gdp.c    |  2 +-
> >  drivers/gpu/drm/sti/sti_hda.c    |  2 +-
> >  drivers/gpu/drm/sti/sti_hdmi.c   |  4 ++--
> >  drivers/gpu/drm/sti/sti_tvout.c  | 10 +++++-----
> >  drivers/gpu/drm/sti/sti_vtg.c    |  2 +-
> >  7 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
> > index 0bf7c332cf0b..ea64c1dcaf63 100644
> > --- a/drivers/gpu/drm/sti/sti_cursor.c
> > +++ b/drivers/gpu/drm/sti/sti_cursor.c
> > @@ -47,7 +47,7 @@ struct dma_pixmap {
> >         void *base;
> >  };
> >
> > -/**
> > +/*
> >   * STI Cursor structure
> >   *
> >   * @sti_plane:    sti_plane structure
> > diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
> > index 9e6d5d8b7030..c33d0aaee82b 100644
> > --- a/drivers/gpu/drm/sti/sti_dvo.c
> > +++ b/drivers/gpu/drm/sti/sti_dvo.c
> > @@ -65,7 +65,7 @@ static struct dvo_config rgb_24bit_de_cfg = {
> >         .awg_fwgen_fct = sti_awg_generate_code_data_enable_mode,
> >  };
> >
> > -/**
> > +/*
> >   * STI digital video output structure
> >   *
> >   * @dev: driver device
> > diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
> > index 8e926cd6a1c8..11595c748844 100644
> > --- a/drivers/gpu/drm/sti/sti_gdp.c
> > +++ b/drivers/gpu/drm/sti/sti_gdp.c
> > @@ -103,7 +103,7 @@ struct sti_gdp_node_list {
> >         dma_addr_t btm_field_paddr;
> >  };
> >
> > -/**
> > +/*
> >   * STI GDP structure
> >   *
> >   * @sti_plane:          sti_plane structure
> > diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
> > index 94e404f13234..3512a94a0fca 100644
> > --- a/drivers/gpu/drm/sti/sti_hda.c
> > +++ b/drivers/gpu/drm/sti/sti_hda.c
> > @@ -230,7 +230,7 @@ static const struct sti_hda_video_config hda_supported_modes[] = {
> >          AWGi_720x480p_60, NN_720x480p_60, VID_ED}
> >  };
> >
> > -/**
> > +/*
> >   * STI hd analog structure
> >   *
> >   * @dev: driver device
> > diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
> > index f03d617edc4c..87e34f7a6cfe 100644
> > --- a/drivers/gpu/drm/sti/sti_hdmi.c
> > +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> > @@ -333,7 +333,6 @@ static void hdmi_infoframe_reset(struct sti_hdmi *hdmi,
> >   * Helper to concatenate infoframe in 32 bits word
> >   *
> >   * @ptr: pointer on the hdmi internal structure
> > - * @data: infoframe to write
> >   * @size: size to write
> >   */
> >  static inline unsigned int hdmi_infoframe_subpack(const u8 *ptr, size_t size)
> > @@ -543,13 +542,14 @@ static int hdmi_vendor_infoframe_config(struct sti_hdmi *hdmi)
> >         return 0;
> >  }
> >
> > +#define HDMI_TIMEOUT_SWRESET  100   /*milliseconds */
> > +
> >  /**
> >   * Software reset of the hdmi subsystem
> >   *
> >   * @hdmi: pointer on the hdmi internal structure
> >   *
> >   */
> > -#define HDMI_TIMEOUT_SWRESET  100   /*milliseconds */
> >  static void hdmi_swreset(struct sti_hdmi *hdmi)
> >  {
> >         u32 val;
> > diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_tvout.c
> > index e1b3c8cb7287..b1fc77b150da 100644
> > --- a/drivers/gpu/drm/sti/sti_tvout.c
> > +++ b/drivers/gpu/drm/sti/sti_tvout.c
> > @@ -157,9 +157,9 @@ static void tvout_write(struct sti_tvout *tvout, u32 val, int offset)
> >   *
> >   * @tvout: tvout structure
> >   * @reg: register to set
> > - * @cr_r:
> > - * @y_g:
> > - * @cb_b:
> > + * @cr_r: red chroma or red order
> > + * @y_g: y or green order
> > + * @cb_b: blue chroma or blue order
> >   */
> >  static void tvout_vip_set_color_order(struct sti_tvout *tvout, int reg,
> >                                       u32 cr_r, u32 y_g, u32 cb_b)
> > @@ -214,7 +214,7 @@ static void tvout_vip_set_rnd(struct sti_tvout *tvout, int reg, u32 rnd)
> >   * @tvout: tvout structure
> >   * @reg: register to set
> >   * @main_path: main or auxiliary path
> > - * @sel_input: selected_input (main/aux + conv)
> > + * @video_out: selected_input (main/aux + conv)
> >   */
> >  static void tvout_vip_set_sel_input(struct sti_tvout *tvout,
> >                                     int reg,
> > @@ -251,7 +251,7 @@ static void tvout_vip_set_sel_input(struct sti_tvout *tvout,
> >   *
> >   * @tvout: tvout structure
> >   * @reg: register to set
> > - * @in_vid_signed: used video input format
> > + * @in_vid_fmt: used video input format
> >   */
> >  static void tvout_vip_set_in_vid_fmt(struct sti_tvout *tvout,
> >                 int reg, u32 in_vid_fmt)
> > diff --git a/drivers/gpu/drm/sti/sti_vtg.c b/drivers/gpu/drm/sti/sti_vtg.c
> > index ef4009f11396..0b17ac8a3faa 100644
> > --- a/drivers/gpu/drm/sti/sti_vtg.c
> > +++ b/drivers/gpu/drm/sti/sti_vtg.c
> > @@ -121,7 +121,7 @@ struct sti_vtg_sync_params {
> >         u32 vsync_off_bot;
> >  };
> >
> > -/**
> > +/*
> >   * STI VTG structure
> >   *
> >   * @regs: register mapping
> > --
> > 2.15.0
> >

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
