Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DEBC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B102190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="SpxtKcru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfJKAdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:33:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39006 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfJKAdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:33:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id n7so11430729qtb.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=7/A8Xxx5/kwMMMCkC8UKPkaUdHo3nQv3ZdijCXAMEqs=;
        b=SpxtKcrus8Kh6IrZX4AjyUhmRTkWpipAW9IrgqMoZ7Ci8WRgCe8vTmxqpk7Njdv1YC
         WQutXDfCh8zexf3jblsyhAAEu00bWbb+P7Qzq7p2M7EbQieOMLpG6AYGSxiOZP9YN4BY
         ddXZKtoWR9Rh4/QTRaSeAuUGzKR9EqmTAVsvRbufIfdtOvMAEOHXBb1X46TwnPA44zIu
         r49+KLWW1LGBb9l4HulH/jZs1ZnjDgyzjIa8ciAHGyWhWTq9XAJqRLwk4Nj+6qXycqzC
         vNNzMAHKrrw0xSuUgjt6xg358nf6cfFCW2hvJ3qctyM6UIW3zuEoodRD6lkoWJd9PfRa
         /Ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=7/A8Xxx5/kwMMMCkC8UKPkaUdHo3nQv3ZdijCXAMEqs=;
        b=OtdyGuW59df1NhPipGrbTVA3Xk7euIPWfA/k+JIPgjLN+hsia5SDw/IFuxnlCkEFZi
         HmdjA2mt3Z7JWShpdWC7dJmrcC/zGd6Bv+VTLJG++7ulOzDFM69E3Sw/GGxhwrEhT9f2
         RClDe64E5PTzjb3I1af1eeV93qwl6CxYQy/5DlSHqklJVPoEQfafEzoBOknr7r3Gl1AU
         kWVPoijpO7OEDNmrQPoZEmSSTWjEeJvsk2qxOp27oO6pZrgPPSe2VIACn4u60dFK6Tx9
         k60O1fidr2GfPge3VijvDk1TDMG43AH6nsxqx+Keh8Ae2pjV6qpBu+/pTsvTP0t7slC3
         dMkg==
X-Gm-Message-State: APjAAAWOetLHu29R1kV8qJ86qKJ9Le1UkXY18jdUXNFUs7ojpmj/1+4T
        xup7AGPJhp5ujjXT4TxgjNb71Q==
X-Google-Smtp-Source: APXvYqwEAUW7wANQwbHXyoWUib3bzwrwaHcZZ908+vAdpeLcDM4zbN0Ops9wHNFwTX+BlU66vUuuYw==
X-Received: by 2002:a0c:aedd:: with SMTP id n29mr13472783qvd.139.1570753983741;
        Thu, 10 Oct 2019 17:33:03 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id x19sm3364445qkf.26.2019.10.10.17.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:33:03 -0700 (PDT)
Date:   Thu, 10 Oct 2019 17:32:46 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Andy Duan <fugang.duan@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] net: fec_main: Use
 platform_get_irq_byname_optional() to avoid error message
Message-ID: <20191010173246.2cd02164@cakuba.netronome.com>
In-Reply-To: <DB3PR0402MB3916FF4583577B182D9BF60CF5970@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1570616148-11571-1-git-send-email-Anson.Huang@nxp.com>
        <20191010160811.7775c819@cakuba.netronome.com>
        <DB3PR0402MB3916FF4583577B182D9BF60CF5970@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019 00:03:22 +0000, Anson Huang wrote:
> > On Wed,  9 Oct 2019 18:15:47 +0800, Anson Huang wrote: =20
> > > Failed to get irq using name is NOT fatal as driver will use index to
> > > get irq instead, use platform_get_irq_byname_optional() instead of
> > > platform_get_irq_byname() to avoid below error message during
> > > probe:
> > >
> > > [    0.819312] fec 30be0000.ethernet: IRQ int0 not found
> > > [    0.824433] fec 30be0000.ethernet: IRQ int1 not found
> > > [    0.829539] fec 30be0000.ethernet: IRQ int2 not found
> > >
> > > Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to
> > > platform_get_irq*()")
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com> =20
> >=20
> > Hi Anson,
> >=20
> > looks like there may be some dependency which haven't landed in the
> > networking tree yet?  Because this doesn't build:
> >=20
> > drivers/net/ethernet/freescale/fec_main.c: In function =E2=80=98fec_pro=
be=E2=80=99:
> > drivers/net/ethernet/freescale/fec_main.c:3561:9: error: implicit decla=
ration
> > of function =E2=80=98platform_get_irq_byname_optional=E2=80=99; did you=
 mean
> > =E2=80=98platform_get_irq_optional=E2=80=99? [-Werror=3Dimplicit-functi=
on-declaration]
> >  3561 |   irq =3D platform_get_irq_byname_optional(pdev, irq_name);
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       |         platform_get_irq_optional
> > cc1: some warnings being treated as errors
> >=20
> > Could you please repost once that's resolved?  Please add Andy's and
> > Stephen's acks when reposting.
> >=20
> > Thank you! =20
>=20
> Sorry, I did this patch set based on linux-next tree, the below patch is =
landing
> on Linux-next tree on Oct 5th, so maybe network tree is NOT sync with Lin=
ux-next tree?

linux-next is an integration tree, which merges all development trees
together to help with conflict resolution. Subsystem maintainers never
pull from it.

> I saw many other similar patches are already landing on Linux-next tree a=
lso, so what
> do you suggest I should do? Or can you sync the network tree with Linux-n=
ext tree first? I do
> NOT know the rule/schedule of network tree update to Linux-next.
>=20
> commit f1da567f1dc1b55d178b8f2d0cfe8353858aac19
> Author: Hans de Goede <hdegoede@redhat.com>
> Date:   Sat Oct 5 23:04:47 2019 +0200
>=20
>     driver core: platform: Add platform_get_irq_byname_optional()

Hm. Looks like the commit you need is commit f1da567f1dc1 ("driver core:
platform: Add platform_get_irq_byname_optional()") and it's currently
in Greg's tree. You have to wait for that commit to make its way into
Linus'es main tree and then for Dave Miller to pull from Linus.

I'd suggest you check if your patches builds on the net tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git

once a week. My guess is it'll probably take two weeks or so for
Greg's patches to propagate to Dave.
