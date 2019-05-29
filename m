Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F498C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540E820B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfE2Kst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:48:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58399 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725914AbfE2Kst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:48:49 -0400
X-UUID: 1d9e1bea161e45bba2bb111fb52ffd89-20190529
X-UUID: 1d9e1bea161e45bba2bb111fb52ffd89-20190529
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1860894148; Wed, 29 May 2019 18:48:43 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs01n1.mediatek.inc
 (172.21.101.68) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 29 May
 2019 18:48:41 +0800
Received: from [10.16.6.141] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 29 May 2019 18:48:39 +0800
Message-ID: <1559126919.12097.6.camel@mszsdaap41>
Subject: Re: [PATCH v2] gpu/drm: mediatek: call mtk_dsi_stop() after
 mtk_drm_crtc_atomic_disable()
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?= 
        <ck.hu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 29 May 2019 18:48:39 +0800
In-Reply-To: <CAJMQK-g3JZ3Eg5U9OmYP9UU3k22VXGWOvZSBrFtAFFHw0Uq0cA@mail.gmail.com>
References: <20190320071825.20268-1-hsinyi@chromium.org>
         <1553131722.18216.10.camel@mtksdaap41>
         <1553132815.18216.18.camel@mtksdaap41>
         <CAJMQK-j9af8_L7DsWzgUy3=0Mr65FFeU71owan+acQgRuAnE7w@mail.gmail.com>
         <1553217695.25217.5.camel@mtksdaap41>
         <CAJMQK-g3JZ3Eg5U9OmYP9UU3k22VXGWOvZSBrFtAFFHw0Uq0cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-22 at 13:05 +0800, Hsin-Yi Wang wrote:
> On Fri, Mar 22, 2019 at 9:21 AM CK Hu <ck.hu@mediatek.com> wrote:
> >
> > Hi, Hsin-yi:
> >
> > On Thu, 2019-03-21 at 22:09 +0800, Hsin-Yi Wang wrote:
> > > On Thu, Mar 21, 2019 at 9:46 AM CK Hu <ck.hu@mediatek.com> wrote:
> > > >
> > > > Hi, Hsin-yi:
> > > >
> > > > On Thu, 2019-03-21 at 09:28 +0800, CK Hu wrote:
> > > > > Hi, Hsin-yi:
> > > > >
> > > > > On Wed, 2019-03-20 at 15:18 +0800, Hsin-Yi Wang wrote:
> > > > > > mtk_dsi_stop() should be called after mtk_drm_crtc_atomic_disable(), which needs
> > > > > > ovl irq for drm_crtc_wait_one_vblank(), since after mtk_dsi_stop() is called,
> > > > > > ovl irq will be disabled. If drm_crtc_wait_one_vblank() is called after last
> > > > > > irq, it will timeout with this message: "vblank wait timed out on crtc 0". This
> > > > > > happens sometimes when turning off the screen.
> > > > > >
> > > > > > In drm_atomic_helper.c#disable_outputs(),
> > > > > > the calling sequence when turning off the screen is:
> > > > > >
> > > > > > 1. mtk_dsi_encoder_disable()
> > > > > >      --> mtk_output_dsi_disable()
> > > > > >        --> mtk_dsi_stop();  // sometimes make vblank timeout in atomic_disable
> > > > > >        --> mtk_dsi_poweroff();
> > > > > > 2. mtk_drm_crtc_atomic_disable()
> > > > > >      --> drm_crtc_wait_one_vblank();
> > > > > >      ...
> > > > > >        --> mtk_dsi_ddp_stop()
> > > > > >          --> mtk_dsi_poweroff();
> > > > > >
> > > > > > mtk_dsi_poweroff() has reference count design, change to make mtk_dsi_stop()
> > > > > > called in mtk_dsi_poweroff() when refcount is 0.
> > > > > >
> > > > > > Fixes: 0707632b5bac ("drm/mediatek: update DSI sub driver flow for sending commands to panel")
> > > > > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > > > > ---
> > > > > > change log:
> > > > > > v1->v2:
> > > > > >  * update commit message.
> > > > > >  * call mtk_dsi_stop() in mtk_dsi_poweroff() when refcount is 0.
> > > > > > ---
> > > > > >  drivers/gpu/drm/mediatek/mtk_dsi.c | 5 ++++-
> > > > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > > > > index b00eb2d2e086..e152f37af57d 100644
> > > > > > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > > > > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > > > > @@ -630,6 +630,8 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
> > > > > >     if (--dsi->refcount != 0)
> > > > > >             return;
> > > > > >
> > > > > > +   mtk_dsi_stop(dsi);
> > > > > > +
> > > > > >     if (!mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500)) {
> > > > > >             if (dsi->panel) {
> > > > > >                     if (drm_panel_unprepare(dsi->panel)) {
> > > > >
> > > > > I think you just move mtk_dsi_stop() into mtk_dsi_poweroff() would works
> > > > > fine, but I would rather like calling mtk_dsi_start() and mtk_dsi_stop()
> > > > > in a symmetric manner. That means you may also move below functions into
> > > > > mtk_dsi_poweron():
> > > > >
> > > > > mtk_dsi_set_mode(dsi);
> > > > > mtk_dsi_clk_hs_mode(dsi, 1);
> > > > > mtk_dsi_start(dsi);
> > >
> > > For MT8183 with bridge panel, calling mtk_dsi_start() in
> > > mtk_dsi_poweron() when refcount is 0->1, like the following order,
> > > will results in no irq, not sure why though. I think this might be the
> > > timing issue you mentioned in patch v1. (MT8183 without bridge panel
> > > doesn't have this issue.)
> > >
> > > atomic_enable
> > >   --> mtk_crtc_ddp_hw_init
> > >     --> mtk_dsi_ddp_start
> > >       --> mtk_dsi_poweron (ref 0->1)
> > >         --> drm_panel_prepare
> > >         --> *mtk_dsi_start  // results in no irq for MT8183 with bridge
> > >   --> drm_crtc_vblank_on
> > >
> > > mtk_output_dsi_enable
> > >   --> mtk_dsi_poweron (ref 1->2, ignored)
> > >   --> mtk_dsi_start //original position
> > >
> > > For mtk_dsi_stop() both with or without bridge is fine.
> Add cc Jitao.
> 
> Hi Jitao,
> Do you know if this is a known hardware behavior?
> 
> Thanks

mtk_dsi_start must after dsi full setting.

If you put it in mtk_dsi_ddp_start, mtk_dsi_set_mode won't work. DSI
will keep cmd mode. So you see no irq.

I think we show keep the mtk_dsi_start in mtk_output_dsi_enable 

Best Regards
Jitao

> >
> > I'm not familiar with dsi hardware, so I could not answer why this
> > problem happen. Jitao is familiar with dsi hardware, you may ask him for
> > help. If this is hardware behavior, I could accept asymmetric flow, but
> > please be sure this is hardware behavior not software bug.
> >
> > Regards,
> > CK
> >
> > >
> > > > >
> > > > >
> > > > > > @@ -696,7 +698,6 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
> > > > > >             }
> > > > > >     }
> > > > > >
> > > > > > -   mtk_dsi_stop(dsi);
> > > > > >     mtk_dsi_poweroff(dsi);
> > > > > >
> > > > > >     dsi->enabled = false;
> > > > > > @@ -1178,6 +1179,8 @@ static int mtk_dsi_remove(struct platform_device *pdev)
> > > > > >     struct mtk_dsi *dsi = platform_get_drvdata(pdev);
> > > > > >
> > > > > >     mtk_output_dsi_disable(dsi);
> > > > > > +   mtk_dsi_stop(dsi);
> > > > > > +   mtk_dsi_poweroff(dsi);
> > > > >
> > > > > I think mtk_output_dsi_disable() would call mtk_dsi_poweroff(), and
> > > > > mtk_dsi_poweroff() would call mtk_dsi_stop(), so these two line are
> > > > > redundant. And I think you should remove mtk_dsi_stop() in
> > > > > mtk_output_dsi_disable(), why not in this patch?
> > > >
> > > > You've removed mtk_dsi_stop() in mtk_output_dsi_disable(), I just miss
> > > > it, sorry for this.
> > > >
> > > > Regards,
> > > > CK
> > > >
> > > > >
> > > > > Regards,
> > > > > CK
> > > > >
> > > > > >     component_del(&pdev->dev, &mtk_dsi_component_ops);
> > > > > >
> > > > > >     return 0;
> > > > >
> > > >
> > > >
> >
> >


