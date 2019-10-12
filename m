Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05953C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBB420679
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfJLTYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 15:24:23 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:10410
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729384AbfJLTYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 15:24:23 -0400
X-IronPort-AV: E=Sophos;i="5.67,289,1566856800"; 
   d="scan'208";a="322500714"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2019 21:24:19 +0200
Date:   Sat, 12 Oct 2019 21:24:19 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
cc:     Markus Elfring <Markus.Elfring@web.de>,
        dri-devel@lists.freedesktop.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/imx: Fix error handling for a kmemdup() call in
 imx_pd_bind()
In-Reply-To: <CAEkB2ERCGJ6abNXfPNX7nbwkwD7qYTPYjYsNGzZwynn5CbPCzg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910122122370.3049@hadrien>
References: <20191004190938.15353-1-navid.emamdoost@gmail.com> <540321eb-7699-1d51-59d5-dde5ffcb8fc4@web.de> <CAEkB2ETtVwtmkpup65D3wqyLn=84ZHt0QRo0dJK5GsV=-L=qVw@mail.gmail.com> <2abf545b-023b-853a-95ef-ce99e1896a5d@web.de> <3fd6aa8b-2529-7ff5-3e19-05267101b2a4@web.de>
 <CAEkB2ERCGJ6abNXfPNX7nbwkwD7qYTPYjYsNGzZwynn5CbPCzg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2018450889-1570908260=:3049"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2018450889-1570908260=:3049
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 12 Oct 2019, Navid Emamdoost wrote:

> On Sat, Oct 12, 2019 at 4:07 AM Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sat, 12 Oct 2019 10:30:21 +0200
> >
> > The return value from a call of the function “kmemdup” was not checked
> > in this function implementation. Thus add the corresponding error handling.
> >
> > Fixes: 19022aaae677dfa171a719e9d1ff04823ce65a65 ("staging: drm/imx: Add parallel display support")
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  drivers/gpu/drm/imx/parallel-display.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
> > index 35518e5de356..39c4798f56b6 100644
> > --- a/drivers/gpu/drm/imx/parallel-display.c
> > +++ b/drivers/gpu/drm/imx/parallel-display.c
> > @@ -210,8 +210,13 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
> >                 return -ENOMEM;
> >
> >         edidp = of_get_property(np, "edid", &imxpd->edid_len);
> > -       if (edidp)
> > +       if (edidp) {
> >                 imxpd->edid = kmemdup(edidp, imxpd->edid_len, GFP_KERNEL);
> > +               if (!imxpd->edid) {
> > +                       devm_kfree(dev, imxpd);
>
> You should not try to free imxpd here as it is a resource-managed
> allocation via devm_kzalloc(). It means memory allocated with this
> function is
>  automatically freed on driver detach. So, this patch introduces a double-free.

No, it's not double freed since the proposed code frees it with a devm
function, removing it from the list of things to free later.  One can
wonder why the free has to be made apparent, though.

julia

>
> > +                       return -ENOMEM;
> > +               }
> > +       }
> >
> >         ret = of_property_read_string(np, "interface-pix-fmt", &fmt);
> >         if (!ret) {
> > --
> > 2.23.0
> >
>
>
> --
> Navid.
>
--8323329-2018450889-1570908260=:3049--
