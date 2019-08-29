Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2421C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861382173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=volatile.bz header.i=@volatile.bz header.b="d0uj69xo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfH2RKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:10:11 -0400
Received: from mx1.volatile.bz ([185.163.46.97]:38298 "EHLO mx1.volatile.bz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfH2RKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:10:11 -0400
Received: from TheDarkness.local (unknown [IPv6:2600:6c5d:4200:1e2a:a077:9bc9:2f0:8eb9])
        by mx1.volatile.bz (Postfix) with ESMTPSA id C72EB590;
        Thu, 29 Aug 2019 17:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=volatile.bz;
        s=default; t=1567098606;
        bh=S+o2J+owdblBkkWC9LHtU/ruSRBVwfwplyhgfA2Ch4E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=d0uj69xoJI1nnoh2dMn+f6LJn2KwnUep+KVGsYedDdqJwM1oLZAg8nihhIcv3hfId
         Ocxad7wXbbWNCT8DDTmvaJViquVM/1eB+UiOOsxhkM73BKDYT7aOfv/S6KfFeOquCR
         +De78K+qoZKmkd3qZPOGRiLomi8bKD1bWiEFb0kY=
Date:   Thu, 29 Aug 2019 13:10:01 -0400
From:   Dark <dark@volatile.bz>
To:     Richard Weinberger <richard@nod.at>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>
Subject: Re: [PATCH] um: Rewrite host RNG driver.
Message-ID: <20190829130804.5e644540@TheDarkness>
In-Reply-To: <1851013915.76434.1567092659763.JavaMail.zimbra@nod.at>
References: <20190828204609.02a7ff70@TheDarkness>
 <CAFLxGvyiviQxr_Bj57ibTU4DQ1H5wQC4DE5DNFBtAFoohcgbsg@mail.gmail.com>
 <20190829103628.61953f50@thedarkness.local>
 <1851013915.76434.1567092659763.JavaMail.zimbra@nod.at>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, it does not block but passing -EAGAIN directly back is not nice.
> Or does the hw_random framework handle this?

The framework is passing -EAGAIN to userspace which isn't very nice at
all. Luckily, handling it is pretty trival so I went ahead and made an
updated patch to address this. (I'm unsure of how to submit an update
to my patch so I'll need a bit of guidence on this.)

> Maybe our -EAGAIN handling is buggy.
> That said I'm all for changing the driver to use the right framework
> but please make sure that we don't drop useful stuff like -EAGAIN handlin=
g.

Most of the old code was pulled from the framework anyway so it's very
unlikely that anything else would be dropped here.

On Thu, 29 Aug 2019 17:30:59 +0200 (CEST), Richard Weinberger <richard@nod.=
at> wrote:

> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Dark" <dark@volatile.bz>
> > An: "Richard Weinberger" <richard.weinberger@gmail.com>, "linux-kernel"=
 <linux-kernel@vger.kernel.org>
> > CC: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgeg=
reys.com>, "linux-um"
> > <linux-um@lists.infradead.org>
> > Gesendet: Donnerstag, 29. August 2019 16:36:28
> > Betreff: Re: [PATCH] um: Rewrite host RNG driver. =20
>=20
> > On Thu, 29 Aug 2019 15:26:24 +0200, Richard Weinberger
> > <richard.weinberger@gmail.com> wrote: =20
> >> So, you removed -EAGAIN handling, made everything synchronous,
> >> and changed the interface.t
> >> I'm not sure if this really a much better option. =20
> >=20
> > I should have been more clear here that I'm using the interfaces
> > provided by `drivers/char/hw_random/core.c` for consistency with the
> > other hardware RNG drivers and to avoid reimplementing stuff that's
> > already there. =20
>=20
> I got this, and this is a good thing!
> =20
> > It might be a bit hard to see in the diff, but I pass the file
> > descriptor to `os_set_fd_async()` to prevent it from blocking. =20
>=20
> Well, it does not block but passing -EAGAIN directly back is not nice.
> Or does the hw_random framework handle this?
>=20
> > For the -EAGAIN handling, I'm passing it onto the caller. Since you
> > mentioned it, It would be better to handle it in the driver itself
> > so I'll update the patch to address that.
> >  =20
> >> Rewriting the driver in a modern manner is a good thing, but throwing =
the
> >> old one way with a little hand weaving just because of a unspecified i=
ssue
> >> is a little harsh.
> >> Can you at lest provide more infos what problem you're facing with the
> >> old driver? =20
> >=20
> > Most of it boiled down to it silently breaking if /dev/random on the
> > host were to block for any reason, and there was the userspace tool
> > requirement to properly make use of it. With that said, the interface
> > was also inconsistent with the other hardware RNG drivers which would
> > require a rewrite to address anyway. =20
>=20
> Maybe our -EAGAIN handling is buggy.
> That said I'm all for changing the driver to use the right framework
> but please make sure that we don't drop useful stuff like -EAGAIN handlin=
g.
>=20
> Thanks,
> //richard

