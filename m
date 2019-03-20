Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2507CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6262184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfCTGsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 02:48:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:24802 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726169AbfCTGsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 02:48:15 -0400
X-UUID: 7e1cab0520674881afbe688c90c5af3b-20190320
X-UUID: 7e1cab0520674881afbe688c90c5af3b-20190320
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 909345915; Wed, 20 Mar 2019 14:47:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Mar 2019 14:47:57 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Mar 2019 14:47:57 +0800
Message-ID: <1553064478.28297.3.camel@mtksdaap41>
Subject: Re: [PATCH] gpu/drm: mediatek: call mtk_dsi_stop() after
 mtk_drm_crtc_atomic_disable()
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 20 Mar 2019 14:47:58 +0800
In-Reply-To: <CAJMQK-gSWiqu-cdBpsz54U_427bB7w3vZ01u6n2L0Ghd9vG6Dw@mail.gmail.com>
References: <20190318040915.101218-1-hsinyi@chromium.org>
         <1553051356.20221.23.camel@mtksdaap41>
         <CAJMQK-gSWiqu-cdBpsz54U_427bB7w3vZ01u6n2L0Ghd9vG6Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-yi:

On Wed, 2019-03-20 at 13:39 +0800, Hsin-Yi Wang wrote:
> On Wed, Mar 20, 2019 at 11:09 AM CK Hu <ck.hu@mediatek.com> wrote:
> >
> > Hi, Hsin-yi:
> >
> > On Mon, 2019-03-18 at 12:09 +0800, Hsin-Yi Wang wrote:
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
> > >          --> mtk_dsi_poweroff();
> > > 2. mtk_drm_crtc_atomic_disable()
> > >      --> drm_crtc_wait_one_vblank();
> > >      ...
> > >        --> mtk_dsi_ddp_stop()
> > >          --> mtk_dsi_poweroff();
> > >
> >
> > Thanks for your inference, but I wonder this patch meet all
> > consideration. In MT8173 with a bridge chip, the timing to disable dsi
> > signal output would influence bridge chip output garbage or not. It's
> > better that you could test this on MT8173, or let this patch go for
> > weeks and wait for someone to test. If no one care about MT8173, I could
> > accept this patch.
> We care about MT8173, but it's not easy to test since we have to bring
> the whole kernel to >= 4.19 to be able to test latest dsi driver.
> The patch (0707632b5bac) that added mtk_dsi_stop() was after MT8173
> (on 3.18), for panel without bridge, so I think without mtk_dsi_stop()
> was also working fine for MT8173.

OK, I find that in the first version of this driver, there is no
mtk_dsi_stop() before mtk_dsi_poweroff(), so I think MT8173 does not do
mtk_dsi_stop(). So maybe this works fine for MT8173.

Regards,
CK

> 
> >
> > > Change to make mtk_dsi_stop() called in mtk_dsi_ddp_stop() instead of
> > > mtk_output_dsi_disable().
> >
> > mtk_dsi_poweroff() has reference count, why not just move mtk_dsi_stop()
> > into mtk_dsi_poweroff()?
> Yes, we can also call mtk_dsi_stop() in mtk_dsi_poweroff() when
> refcount is 0. I can send v2 if you think this way is better.
> 
> Thanks
> >
> > Regards,
> > CK
> >
> > >
> > > Fixes: 0707632b5bac ("drm/mediatek: update DSI sub driver flow for sending commands to panel")
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_dsi.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > index b00eb2d2e086..cdd9637dd517 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > @@ -696,7 +696,6 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
> > >               }
> > >       }
> > >
> > > -     mtk_dsi_stop(dsi);
> > >       mtk_dsi_poweroff(dsi);
> > >
> > >       dsi->enabled = false;
> > > @@ -857,6 +856,7 @@ static void mtk_dsi_ddp_stop(struct mtk_ddp_comp *comp)
> > >  {
> > >       struct mtk_dsi *dsi = container_of(comp, struct mtk_dsi, ddp_comp);
> > >
> > > +     mtk_dsi_stop(dsi);
> > >       mtk_dsi_poweroff(dsi);
> > >  }
> > >
> > > @@ -1178,6 +1178,8 @@ static int mtk_dsi_remove(struct platform_device *pdev)
> > >       struct mtk_dsi *dsi = platform_get_drvdata(pdev);
> > >
> > >       mtk_output_dsi_disable(dsi);
> > > +     mtk_dsi_stop(dsi);
> > > +     mtk_dsi_poweroff(dsi);
> > >       component_del(&pdev->dev, &mtk_dsi_component_ops);
> > >
> > >       return 0;
> >
> >


