Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29418C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F1C20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kfICYAvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfC1Lxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:53:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38707 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1Lxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:53:51 -0400
Received: by mail-io1-f65.google.com with SMTP id v4so16961237ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 04:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Om6eCMnV+MwlW6LsmhTlLpiZQQPbbSu3ga//i5iYsak=;
        b=kfICYAvFxvkCZPgsm+gCI9WV5RonAaD8hbMRHinoTYJKQirZWXCM38FucpGGvGalOr
         2OBt15BFF4KhNsQ/WQLJweAaEl+PfNNWSSPJefTeGnWnGBfUXTmIW0xq6csiAipJx4Bz
         PYHKeyN61fkfIaFaOJBkrMRyXt+xHR8/MICHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Om6eCMnV+MwlW6LsmhTlLpiZQQPbbSu3ga//i5iYsak=;
        b=V5+wzkRiUvL3T60msJ1UHHfhhTK4+JV+PhxY3WGvLdmFDQQ7IKCIadr/3BzZsNBhit
         46ZGN23QnKzfcnNFURioYymeojOlJw7/7h8hG27FcM6Q5rJGtdFzfOFpUr2+F3y9B/RW
         J/OJKVEw8uuV8krWdpmYAG3JOkOe7I0kwhFex1JhfdAOggYQpmwTr9yKjgqxZE39QWAs
         ytMWvXIk23zFjADj+VUT2QK/UNAig3u0f7aGQAMtqbxD5MHVMYQThorCcJzM84EU+56p
         0CCFUCTW2YiDXEtSs2ljXA+hJP1mZgxqT0++pgxjquKXCrMdatrA5tePOxH7in98jk82
         3QxQ==
X-Gm-Message-State: APjAAAXO3smry0ibp19CK+0TMJMogaQ4rZBBwn+FK4udFP9O9w6k4s18
        gXiUstXX+CRZ2YXYO3gU4UF7mB2D8Gn3VQ0izkzSRA==
X-Google-Smtp-Source: APXvYqzRtR4wMYU/m+HkA4JJT53Yc94WUa9EEkpZSSemsT+egefzl0YGploPOFa/IbUw4YB72J/HWZIeboUy+Sf9Sv0=
X-Received: by 2002:a6b:d80a:: with SMTP id y10mr27759329iob.114.1553774030414;
 Thu, 28 Mar 2019 04:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
 <20190303173527.31055-3-jagan@amarulasolutions.com> <20190304154320.uledvwz5jhzt22o3@flea>
 <CAMty3ZDWkLWgWhGWBjhXOsmAXzuGKGADAEhzB6gcL+jd7FRazQ@mail.gmail.com>
 <20190307153935.uxh2hsmahw5l7h4q@flea> <CAMty3ZDyk60R0YCsBV6toz84CFjD0D6uWyLVhmp8PC+Mj8GJpQ@mail.gmail.com>
 <20190311140923.vvtubx7wndos2rfr@flea> <CAMty3ZCABQ8Sa9+E_nznzMEYpvVm+KrnXDuEgt9qwue9t5Zs8g@mail.gmail.com>
 <20190319105648.54i6pd4l74uvp4px@flea>
In-Reply-To: <20190319105648.54i6pd4l74uvp4px@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 28 Mar 2019 17:23:39 +0530
Message-ID: <CAMty3ZAp9tXD2dMKEdOYy6zftqobHNOs6U4fSUeAOfmSiO909A@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 4:26 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Mar 11, 2019 at 08:28:22PM +0530, Jagan Teki wrote:
> > On Mon, Mar 11, 2019 at 7:39 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Thu, Mar 07, 2019 at 09:24:02PM +0530, Jagan Teki wrote:
> > > > On Thu, Mar 7, 2019 at 9:09 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > On Thu, Mar 07, 2019 at 05:49:07PM +0530, Jagan Teki wrote:
> > > > > > On Mon, Mar 4, 2019 at 9:13 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > >
> > > > > > > On Sun, Mar 03, 2019 at 11:05:24PM +0530, Jagan Teki wrote:
> > > > > > > > TCON DRQ for non-burst DSI mode can computed based on horizontal
> > > > > > > > front porch value, but the current driver trying to include sync
> > > > > > > > timings along with front porch resulting wrong drq.
> > > > > > > >
> > > > > > > > This patch is trying to update the drq by subtracting hsync_start
> > > > > > > > with hdisplay, which is horizontal front porch.
> > > > > > > >
> > > > > > > > Current code:
> > > > > > > > ------------
> > > > > > > > mode->hsync_end - mode->hdisplay => horizontal front porch + sync
> > > > > > > >
> > > > > > > > With this patch:
> > > > > > > > ----------------
> > > > > > > > mode->hsync_start - mode->hdisplay => horizontal front porch
> > > > > > > >
> > > > > > > > BSP code form BPI-M64-bsp is computing TCON DRQ set bits
> > > > > > > > for non-burts as (from linux-sunxi/
> > > > > > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > > > > > >
> > > > > > > > => panel->lcd_ht -    panel->lcd_x - panel->lcd_hbp
> > > > > > > > => (timmings->hor_front_porch + panel->lcd_hbp + panel->lcd_x)
> > > > > > >                                   ^ + sync length +
> > > > > > > >    - panel->lcd_x - panel->hbp
> > > > > > > > => timmings->hor_front_porch
> > > > > > >                                ^ + sync
> > > > > > > > => mode->hsync_start - mode->hdisplay
> > > > > > >
> > > > > > > s/hsync_start/hsync_end/
> > > > > >
> > > > > > No, it should be front porch so it is hsync_start. This change is
> > > > > > trying to update DRQ set to use front porch and above evaluation from
> > > > > > BSP, result the same front front porch
> > > > > >
> > > > > > Current driver has hsync_end - hdisplay which is not front porch
> > > > > > timing (it is adding extra sync timing).
> > > > >
> > > > > It would be if you considered that the back porch actually was the
> > > > > back porch plus the sync length. I have found no such evidence, quite
> > > > > the opposite actually, everything seems to point at the fact that
> > > > > unlike the TCON, the DSI block uses the back porch as only the back
> > > > > porch.
> > > >
> > > > Sorry, I'm not clear about back porch here.
> > > >
> > > > The current code has mode->hsync_end - mode->hdisplay which is Front
> > > > porch + sync time do you think it's not?
> > >
> > > It is.
> > >
> > > > DRQ set time is pure front porch value (according BSP) as I didn't
> > > > see any information about DRQ set bits in manual or anywhere.
> > >
> > > This is what I'm telling you. If you consider the back porch as only
> > > the back porch, then the result of that BSP calculation you mentionned
> > > earlier is the front porch and the sync length.
> > >
> > > You imply that the back porch should actually be treated as the back
> > > porch and the sync length in your calculation. What makes you say so?
> >
> > I'm consider the computations accordingly to drm_modes.h and which
> > matches similar like BSP code.
> >
> > mode->hsync_end - mode->hdisplay = front porch + sync
> >
> > but the actual computation is
> > mode->hsync_start - mode->hdisplay =>  front porch
> >
> > Which is similar to what BSP is using.
> >
> > => panel->lcd_ht -    panel->lcd_x - panel->lcd_hbp
> > => (timmings->hor_front_porch + panel->lcd_hbp + panel->lcd_x)
> >    - panel->lcd_x - panel->hbp
> > => timmings->hor_front_porch
> > => mode->hsync_start - mode->hdisplay
>
> You're missing the point. What I'm asking for is why you think that
> panel->lcd_ht == (timmings->hor_front_porch + panel->lcd_hbp +
> panel->lcd_x) and not timmings->hor_front_porch + panel->lcd_hbp +
> sync_width + panel->lcd_x

No ie not true we can't include sync_width, please see here [1]

timmings->hor_front_porch= panel_info->lcd_ht-panel_info->lcd_hbp -
panel_info->lcd_x;
panel_info->lcd_ht = timmings->hor_front_porch + panel_info->lcd_hbp +
panel_info->lcd_x;

and the result of this lcd_ht is exactly matched with Mainline timings
or any supported panel in A64.

[1] https://github.com/longsleep/linux-pine64/blob/pine64-hacks-1.2/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L1839
