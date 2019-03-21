Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB87C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500CF218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DQsiWDLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfCUOJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:09:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47040 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfCUOJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:09:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id z17so5658381qts.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6d7pLaiQP1ZFnfCbsOUot4AdI7jDcls+c6Qs396FEM=;
        b=DQsiWDLjJgQC+Z9TxfEwxlry+NQOO+ghxpWhuvII+pPJzx8ZaVzEZWDIlHUY3pOa0u
         S6VF6GSMUbglheLAfbH8Aivoz7zwRu5VLrYF01faEwdam8eHZjtAyFv95nZtTlqrhwXy
         nbfxLCD1dKxf0qwgJlQuSlp9fa1RTb2QLRftY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6d7pLaiQP1ZFnfCbsOUot4AdI7jDcls+c6Qs396FEM=;
        b=DQHABKAjyrfc/C6Dc+XUCgLUF9uwA+7YEqzbvg/cl9bc29UnUZsDvdlID1FGgvWtN4
         4tV+hH1S5IIo9PuyjxhX+E8BkbeScn1v9XmFuNuOL5TlozE/E+zLyjDf4imfrQCQP31k
         3XdzSE4Jd2JNB6TMrZfXBp9UsHrB3r4MONuUTMYQEHeKjulnbDstEXykyOL5pCBVfPBb
         ow2Z1lXVkzJr52+Yds2xYf4FRxVCE3a2kKfxL9j5sOOoNBqhskFWtI8zt7iA72tV7IYP
         HiKST9DeAE6bl8nI2FlZDJ4JByZJQdhMnXnVttM5bQMNm+Gplqlk4vOai0t6LcbWSX6e
         Wkjg==
X-Gm-Message-State: APjAAAUbnUgk/KnlPbhBi2FHGZbPC8Pq1eRFL+Pw8A3e+pmmwaTUZfxV
        C8ApSzPSWiNFnbWdu4H3lDye5CydOlxzUkiz3Tvu7w==
X-Google-Smtp-Source: APXvYqwlJviLOZAqCoDZfFoJyYjtfedrR6HKMP+mzjG8UT7aRWyQ8QG7husaUBZYXVrm9q0iVmDH3nQKJsIyskSBfKg=
X-Received: by 2002:ac8:2aa7:: with SMTP id b36mr3091420qta.187.1553177392922;
 Thu, 21 Mar 2019 07:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190320071825.20268-1-hsinyi@chromium.org> <1553131722.18216.10.camel@mtksdaap41>
 <1553132815.18216.18.camel@mtksdaap41>
In-Reply-To: <1553132815.18216.18.camel@mtksdaap41>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 21 Mar 2019 22:09:42 +0800
Message-ID: <CAJMQK-j9af8_L7DsWzgUy3=0Mr65FFeU71owan+acQgRuAnE7w@mail.gmail.com>
Subject: Re: [PATCH v2] gpu/drm: mediatek: call mtk_dsi_stop() after mtk_drm_crtc_atomic_disable()
To:     CK Hu <ck.hu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 9:46 AM CK Hu <ck.hu@mediatek.com> wrote:
>
> Hi, Hsin-yi:
>
> On Thu, 2019-03-21 at 09:28 +0800, CK Hu wrote:
> > Hi, Hsin-yi:
> >
> > On Wed, 2019-03-20 at 15:18 +0800, Hsin-Yi Wang wrote:
> > > mtk_dsi_stop() should be called after mtk_drm_crtc_atomic_disable(), which needs
> > > ovl irq for drm_crtc_wait_one_vblank(), since after mtk_dsi_stop() is called,
> > > ovl irq will be disabled. If drm_crtc_wait_one_vblank() is called after last
> > > irq, it will timeout with this message: "vblank wait timed out on crtc 0". This
> > > happens sometimes when turning off the screen.
> > >
> > > In drm_atomic_helper.c#disable_outputs(),
> > > the calling sequence when turning off the screen is:
> > >
> > > 1. mtk_dsi_encoder_disable()
> > >      --> mtk_output_dsi_disable()
> > >        --> mtk_dsi_stop();  // sometimes make vblank timeout in atomic_disable
> > >        --> mtk_dsi_poweroff();
> > > 2. mtk_drm_crtc_atomic_disable()
> > >      --> drm_crtc_wait_one_vblank();
> > >      ...
> > >        --> mtk_dsi_ddp_stop()
> > >          --> mtk_dsi_poweroff();
> > >
> > > mtk_dsi_poweroff() has reference count design, change to make mtk_dsi_stop()
> > > called in mtk_dsi_poweroff() when refcount is 0.
> > >
> > > Fixes: 0707632b5bac ("drm/mediatek: update DSI sub driver flow for sending commands to panel")
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > ---
> > > change log:
> > > v1->v2:
> > >  * update commit message.
> > >  * call mtk_dsi_stop() in mtk_dsi_poweroff() when refcount is 0.
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_dsi.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > index b00eb2d2e086..e152f37af57d 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > @@ -630,6 +630,8 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
> > >     if (--dsi->refcount != 0)
> > >             return;
> > >
> > > +   mtk_dsi_stop(dsi);
> > > +
> > >     if (!mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500)) {
> > >             if (dsi->panel) {
> > >                     if (drm_panel_unprepare(dsi->panel)) {
> >
> > I think you just move mtk_dsi_stop() into mtk_dsi_poweroff() would works
> > fine, but I would rather like calling mtk_dsi_start() and mtk_dsi_stop()
> > in a symmetric manner. That means you may also move below functions into
> > mtk_dsi_poweron():
> >
> > mtk_dsi_set_mode(dsi);
> > mtk_dsi_clk_hs_mode(dsi, 1);
> > mtk_dsi_start(dsi);

For MT8183 with bridge panel, calling mtk_dsi_start() in
mtk_dsi_poweron() when refcount is 0->1, like the following order,
will results in no irq, not sure why though. I think this might be the
timing issue you mentioned in patch v1. (MT8183 without bridge panel
doesn't have this issue.)

atomic_enable
  --> mtk_crtc_ddp_hw_init
    --> mtk_dsi_ddp_start
      --> mtk_dsi_poweron (ref 0->1)
        --> drm_panel_prepare
        --> *mtk_dsi_start  // results in no irq for MT8183 with bridge
  --> drm_crtc_vblank_on

mtk_output_dsi_enable
  --> mtk_dsi_poweron (ref 1->2, ignored)
  --> mtk_dsi_start //original position

For mtk_dsi_stop() both with or without bridge is fine.

> >
> >
> > > @@ -696,7 +698,6 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
> > >             }
> > >     }
> > >
> > > -   mtk_dsi_stop(dsi);
> > >     mtk_dsi_poweroff(dsi);
> > >
> > >     dsi->enabled = false;
> > > @@ -1178,6 +1179,8 @@ static int mtk_dsi_remove(struct platform_device *pdev)
> > >     struct mtk_dsi *dsi = platform_get_drvdata(pdev);
> > >
> > >     mtk_output_dsi_disable(dsi);
> > > +   mtk_dsi_stop(dsi);
> > > +   mtk_dsi_poweroff(dsi);
> >
> > I think mtk_output_dsi_disable() would call mtk_dsi_poweroff(), and
> > mtk_dsi_poweroff() would call mtk_dsi_stop(), so these two line are
> > redundant. And I think you should remove mtk_dsi_stop() in
> > mtk_output_dsi_disable(), why not in this patch?
>
> You've removed mtk_dsi_stop() in mtk_output_dsi_disable(), I just miss
> it, sorry for this.
>
> Regards,
> CK
>
> >
> > Regards,
> > CK
> >
> > >     component_del(&pdev->dev, &mtk_dsi_component_ops);
> > >
> > >     return 0;
> >
>
>
