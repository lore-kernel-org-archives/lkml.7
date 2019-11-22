Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B619C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339B72071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAjnLsTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKVRoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:44:01 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:40743 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:44:00 -0500
Received: by mail-il1-f194.google.com with SMTP id v17so3839663ilg.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 09:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h56fbOK3LHFOKb7PeCUiHytHW+/rGe2pqRatOmUTizE=;
        b=BAjnLsTnSFBrVpp7SbyUz3Wk9Is7kL28zcQMGo2DO7JYFVPuoJBIHxIG1/OubuirXN
         Mu71/CxnBI1G0V+RFU9nkxqlM2Tai34cHtWlnP/GgBN8qmEOTPbOfAqz586TaKblpcsN
         XqBFi33fpuTJB+gHo82418deD2vILz1OKzqMRIBcjdKtt8T55P8Hc8T5F5OTkAivenPq
         5852UBtaEqRqJXOhqu4eTtlPMzFEK08llX6LHvDiUCF2dsMATTIOMPuCxqRUupwRb/5+
         dyzqwFOzXIVUJBbH1sJFcD4/RYl/zp72F0dGnF+XxsjpjIt5uTI4QyGUj9iMUGvZuB2V
         /Hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h56fbOK3LHFOKb7PeCUiHytHW+/rGe2pqRatOmUTizE=;
        b=nieDOMHsznqFVrNx4AmC53sAOBN6foiMDM9DEk/ea1BHbeS4THKcnekz+dfbeImi3h
         tf/ktIGqTsEQO0GOzUurHAzrLx2fUIh2ezaR0WwWwnXKsTE+pvQesUda+vTFdsrBTZGz
         MaOmK+Y6il13v43tFQWVEYXqskJ68qmh33PgiOihDpW+FZvHjAnMQkVLkIotbo4KIo07
         DAVTkHQKKe4ETfJw/iENRkVr1OaYda95wSSidNcLhMtuFErztvUHvqfW3S0JUILxJsiM
         bH5iihVJGaU5e7H0Vn6Lfn3x6gk5pB/x5WP05V8/AqcbdvDue9ha3Cx7jWMGNx65ZpS1
         VVKw==
X-Gm-Message-State: APjAAAU99TXtRql/mWt+Nt0tdAHTjxNQm99g9NYarUByBiCnyeBgqI5v
        TW8AcxkBLRpaFuvh5pS3706XlUylgdT5y+EZ00A=
X-Google-Smtp-Source: APXvYqxzFpQ6pRsKd5kK7vHYgkg7tAi4FAri6/7IjJHemZSmhcn2nnbMvZcqGvxWpgXjKAsyLm4J4dz/lukT/Cw6jng=
X-Received: by 2002:a92:3b0c:: with SMTP id i12mr16763619ila.190.1574444639533;
 Fri, 22 Nov 2019 09:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20191004190938.15353-1-navid.emamdoost@gmail.com>
 <CAEkB2EQGCcwBO4iZBiHthUAJUeprw2Q09932GATd6XVyXqukzw@mail.gmail.com> <20191122072239.dhbhi2uawoqsclwy@pengutronix.de>
In-Reply-To: <20191122072239.dhbhi2uawoqsclwy@pengutronix.de>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Fri, 22 Nov 2019 11:43:48 -0600
Message-ID: <CAEkB2EQAgmZwGSRyo2XC-1+Ls2MDdm-fxLY5P1SRAjyhNeUiXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/imx: fix memory leak in imx_pd_bind
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Navid Emamdoost <emamd001@umn.edu>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the update.

On Fri, Nov 22, 2019 at 1:22 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi Navid,
>
> On 19-11-21 12:31, Navid Emamdoost wrote:
> > On Fri, Oct 4, 2019 at 2:09 PM Navid Emamdoost
> > <navid.emamdoost@gmail.com> wrote:
> > >
> > > In imx_pd_bind, the duplicated memory for imxpd->edid via kmemdup should
> > > be released in drm_of_find_panel_or_bridge or imx_pd_register fail.
> > >
> > > Fixes: ebc944613567 ("drm: convert drivers to use drm_of_find_panel_or_bridge")
> > > Fixes: 19022aaae677 ("staging: drm/imx: Add parallel display support")
> > > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > > ---
> >
> > Would you please review this patch?
> >
> > Thanks,
>
> I currently work on the drm/imx driver(s) to avoid errors like [1].
> Hopefully I have a working version till next week. There I fixed this
> issue by using the devm_kmemdup() and dropped the explicit kfree()
> within unbind().
>
> [1] https://www.spinics.net/lists/dri-devel/msg189388.html
>
> Regards,
>   Marco
>
> >
> > >  drivers/gpu/drm/imx/parallel-display.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
> > > index e7ce17503ae1..9522d2cb0ad5 100644
> > > --- a/drivers/gpu/drm/imx/parallel-display.c
> > > +++ b/drivers/gpu/drm/imx/parallel-display.c
> > > @@ -227,14 +227,18 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
> > >
> > >         /* port@1 is the output port */
> > >         ret = drm_of_find_panel_or_bridge(np, 1, 0, &imxpd->panel, &imxpd->bridge);
> > > -       if (ret && ret != -ENODEV)
> > > +       if (ret && ret != -ENODEV) {
> > > +               kfree(imxpd->edid);
> > >                 return ret;
> > > +       }
> > >
> > >         imxpd->dev = dev;
> > >
> > >         ret = imx_pd_register(drm, imxpd);
> > > -       if (ret)
> > > +       if (ret) {
> > > +               kfree(imxpd->edid);
> > >                 return ret;
> > > +       }
> > >
> > >         dev_set_drvdata(dev, imxpd);
> > >
> > > --
> > > 2.17.1
> > >
> >
> >
> > --
> > Navid.
> >
> >
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |



-- 
Navid.
