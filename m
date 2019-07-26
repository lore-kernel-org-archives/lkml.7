Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFB9C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA3421850
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387489AbfGZO1P convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:27:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40932 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfGZO1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:27:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id m8so18071514lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 07:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2GwRCg9i1fckl1zL5hoyucrASZN65m4kd1+MnYjmS0o=;
        b=MFsXm3lDCuJ9NORvB06et5hrMBGTSvnTBWXLhKJSvhjZFs7FAacwCUIpIWMf+DptDf
         l4+Ap3knLPYzwTP7Kc6pssy+713HoVGfthPSHryoE2CoRyiJD3EULcNyvZMizUTvCrkL
         A5AgoOQiqIl3D8c691Gibsaf+r7/sd7k0xwsMGx8S55n4JSB2rbRm0T5nWPutGCkivKt
         6uEY/E7TuE4p47vZHmVqhls0rKPc0gHV+XUZLgtBldEdeIE8jHx2mauF7ZmSFY6YQ8uD
         h4xuhXpTrAwqVwW5I8wO1jnvKGUgAz2Mkm3woqI8P0SNVPq5YonAY4obiamd1fDtPhjT
         ursA==
X-Gm-Message-State: APjAAAWL8pvw9FzUYZ5YEc0ShZxu5HrvTt0tnwfhvBLmDs4yps3W5G80
        biQHN5HATlvv8eIa7c7JaJUMNFKFtQ9FDMh86EjC2g==
X-Google-Smtp-Source: APXvYqx6y/gYkl9KQ//0ALzglvmw9jmhK6DG4w87eYEZgRAGFSH+j6cVH/GssHddyl/b9Gt/agK5IHiVzBcYJNFu9YA=
X-Received: by 2002:a2e:8756:: with SMTP id q22mr50525884ljj.108.1564151233595;
 Fri, 26 Jul 2019 07:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190725231931.24073-1-mcroce@redhat.com> <20190726125053.GA5031@kwain>
In-Reply-To: <20190726125053.GA5031@kwain>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Fri, 26 Jul 2019 16:26:37 +0200
Message-ID: <CAGnkfhxr5qrppkQL=c-hLLuh9ENRri9+wR2FGrDYjWj2E=W_Bg@mail.gmail.com>
Subject: Re: [PATCH net] mvpp2: refactor MTU change code
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     netdev <netdev@vger.kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 2:50 PM Antoine Tenart
<antoine.tenart@bootlin.com> wrote:
>
> Hi Matteo,
>
> On Fri, Jul 26, 2019 at 01:19:31AM +0200, Matteo Croce wrote:
> > The MTU change code can call napi_disable() with the device already down,
> > leading to a deadlock. Also, lot of code is duplicated unnecessarily.
> >
> > Rework mvpp2_change_mtu() to avoid the deadlock and remove duplicated code.
> >
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
>
> As this is a fix sent to net, you could add a Fixes: tag.
>
> Otherwise this looks good,
> Acked-by: Antoine Tenart <antoine.tenart@bootlin.com>
>
> Thanks!
> Antoine
>
> > ---
> >  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 41 ++++++-------------
> >  1 file changed, 13 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > index 2f7286bd203b..60eb98f99571 100644
> > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > @@ -3612,6 +3612,7 @@ static int mvpp2_set_mac_address(struct net_device *dev, void *p)
> >  static int mvpp2_change_mtu(struct net_device *dev, int mtu)
> >  {
> >       struct mvpp2_port *port = netdev_priv(dev);
> > +     bool running = netif_running(dev);
> >       int err;
> >
> >       if (!IS_ALIGNED(MVPP2_RX_PKT_SIZE(mtu), 8)) {
> > @@ -3620,40 +3621,24 @@ static int mvpp2_change_mtu(struct net_device *dev, int mtu)
> >               mtu = ALIGN(MVPP2_RX_PKT_SIZE(mtu), 8);
> >       }
> >
> > -     if (!netif_running(dev)) {
> > -             err = mvpp2_bm_update_mtu(dev, mtu);
> > -             if (!err) {
> > -                     port->pkt_size =  MVPP2_RX_PKT_SIZE(mtu);
> > -                     return 0;
> > -             }
> > -
> > -             /* Reconfigure BM to the original MTU */
> > -             err = mvpp2_bm_update_mtu(dev, dev->mtu);
> > -             if (err)
> > -                     goto log_error;
> > -     }
> > -
> > -     mvpp2_stop_dev(port);
> > +     if (running)
> > +             mvpp2_stop_dev(port);
> >
> >       err = mvpp2_bm_update_mtu(dev, mtu);
> > -     if (!err) {
> > +     if (err) {
> > +             netdev_err(dev, "failed to change MTU\n");
> > +             /* Reconfigure BM to the original MTU */
> > +             mvpp2_bm_update_mtu(dev, dev->mtu);
> > +     } else {
> >               port->pkt_size =  MVPP2_RX_PKT_SIZE(mtu);
> > -             goto out_start;
> >       }
> >
> > -     /* Reconfigure BM to the original MTU */
> > -     err = mvpp2_bm_update_mtu(dev, dev->mtu);
> > -     if (err)
> > -             goto log_error;
> > -
> > -out_start:
> > -     mvpp2_start_dev(port);
> > -     mvpp2_egress_enable(port);
> > -     mvpp2_ingress_enable(port);
> > +     if (running) {
> > +             mvpp2_start_dev(port);
> > +             mvpp2_egress_enable(port);
> > +             mvpp2_ingress_enable(port);
> > +     }
> >
> > -     return 0;
> > -log_error:
> > -     netdev_err(dev, "failed to change MTU\n");
> >       return err;
> >  }
> >
> > --
> > 2.21.0
> >
>
> --
> Antoine Ténart, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

It seems to me that the fixes tag should refer to the driver inclusion:

Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375
network unit")

-- 
Matteo Croce
per aspera ad upstream
