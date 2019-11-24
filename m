Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60D5C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90782067D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFZgmMQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfKXXSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 18:18:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28697 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726952AbfKXXSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 18:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574637490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PClP5vcK7H2hH8iu9CCJfFi1HH/SjqItErOS3dnGhZA=;
        b=dFZgmMQhN3bnF781esT2h5gsaMX504c370/e+LQwFpOWS83c771GqLousDrIXRI8Qlhude
        B/gieVGPw++v0jD/bmV/jeECznEqHaJUFK0YVgjW4z2Mz3iqaIR7yizzDXiYdRbV7m9uFL
        ndj+4yCkfjcoGM/OAKA4uEC2AfdfH7g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-7XrRfKr8M8Oaj_QLcEbJCQ-1; Sun, 24 Nov 2019 18:18:08 -0500
Received: by mail-qv1-f69.google.com with SMTP id m12so9107209qvv.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 15:18:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fuJZGXqNTPkHKKy9Zo1tRW4D2w7eYV51Z20agxm/QfY=;
        b=tBR2/+XfkvfyXYDdEso66gMZQkRsZKntHfHuJEsd//aBRs6dMd9KsiKbylNfxga10R
         ey67iOgEa9vxqF3kkT0LxAsiXf5+5V5O66jP9Fss8NBGTbGuhq819Y9n8qFzT5sXK2fR
         uTjvr4VagKcsDDlfQATWpClGgOLPjaxNyw1JlnYH/c4Oo34qc06rGJWpZ6zdhPAx+Vr+
         KQsCQ08vfUEKNHVCGMIPPI7SPk1rWPY3lFpSLrw1ddrRnzi0K0+oPPpGoJfSgp3ff7JP
         yE+WrNInEJksbdifxC/Cb5WGJxJCkwODr4HNynFOAA87OOXWDUDdn3NUWceAbu24dG/x
         BOmw==
X-Gm-Message-State: APjAAAWpJhwvFWktanx09X1Ujuai3AE8F0s7qOYvsiarV+h8cJuxtWX2
        IdsaL/sra2beBNb2CGLiNDlz4zXmlqGH2eCCngRXuVwba0xbZ2WIqfa2OL+KvxW27414IFfPvU3
        f7spYNKe1AaFN1T2HE4I0KFFT
X-Received: by 2002:ac8:754c:: with SMTP id b12mr16779095qtr.291.1574637488459;
        Sun, 24 Nov 2019 15:18:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqzifxug591hBiIzAoyGSEYaT6MrOBiQSwRPRmdW7PdE6LTobqahiQLu0xVWQAlGqwHRLz37Eg==
X-Received: by 2002:ac8:754c:: with SMTP id b12mr16779087qtr.291.1574637488287;
        Sun, 24 Nov 2019 15:18:08 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id l45sm2841796qtb.32.2019.11.24.15.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 15:18:07 -0800 (PST)
Date:   Sun, 24 Nov 2019 18:18:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Julio Faracco <jcfaracco@gmail.com>, netdev@vger.kernel.org,
        Daiane Mendes <dnmendes76@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] drivers: net: virtio_net: Implement a
 dev_watchdog handler
Message-ID: <20191124181750-mutt-send-email-mst@kernel.org>
References: <20191122013636.1041-1-jcfaracco@gmail.com>
 <20191122052506-mutt-send-email-mst@kernel.org>
 <CAENf94KX1XR4_KXz9KLZQ09Ngeaq2qzYY5OE68xJMXMu13SuEg@mail.gmail.com>
 <20191124100157-mutt-send-email-mst@kernel.org>
 <20191124164411-mutt-send-email-mst@kernel.org>
 <20191124150352.5cab3209@cakuba.netronome.com>
MIME-Version: 1.0
In-Reply-To: <20191124150352.5cab3209@cakuba.netronome.com>
X-MC-Unique: 7XrRfKr8M8Oaj_QLcEbJCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2019 at 03:03:52PM -0800, Jakub Kicinski wrote:
> On Sun, 24 Nov 2019 16:48:35 -0500, Michael S. Tsirkin wrote:
> > diff --git a/arch/m68k/emu/nfeth.c b/arch/m68k/emu/nfeth.c
> > index a4ebd2445eda..8e06e7407854 100644
> > --- a/arch/m68k/emu/nfeth.c
> > +++ b/arch/m68k/emu/nfeth.c
> > @@ -167,7 +167,7 @@ static int nfeth_xmit(struct sk_buff *skb, struct n=
et_device *dev)
> >  =09return 0;
> >  }
> > =20
> > -static void nfeth_tx_timeout(struct net_device *dev)
> > +static void nfeth_tx_timeout(struct net_device *dev, int txqueue)
>=20
> Given the recent vf ndo problems, I wonder if it's worth making the
> queue id unsigned from the start? Since it's coming from the stack
> there should be no range checking required, but also signed doesn't
> help anything so why not?
>=20
> >  {
> >  =09dev->stats.tx_errors++;
> >  =09netif_wake_queue(dev);

You are right. I'll change this.

