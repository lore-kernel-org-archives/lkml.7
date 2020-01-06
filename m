Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3128BC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077FA207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfWGYz/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgAFKtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:49:14 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33959 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgAFKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:49:13 -0500
Received: by mail-vk1-f195.google.com with SMTP id w67so12353174vkf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 02:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFzoZ86uEVjKWHiIx7n2HpYErMeQnxrhPD0oWb4wVqg=;
        b=WfWGYz/RCLTMwYaL53SGSjgLV/BZVFTf8Hb1W6MeEDhZLlbxlTOclpavebEKZo+Ouk
         vucaQKlXWfG9VXqw3WSM9fFrPH0i1ATOv5CdsFE9IleLn7p0nf8anBRhZ8plRZnRfSpl
         yRBzIpzcxcPx1Eymy9tYDLrtnX92vNWAU5fD4a8Oa58sTGy6kGvJxdxpbs4fYS+Ik2zO
         WurZZKXjWBTPzBB0Sd38L7GtvWt50cNfqP3LrRKRPYfpu2SCbaKcZdiBD4iyskUscUWK
         gQ/j2Uo+8mR0LzlegzrTGfO0T3QtDlNw0vTwkseEk/SlZ/GH4n9GHvc/YhvV2eZXo4bN
         ityA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFzoZ86uEVjKWHiIx7n2HpYErMeQnxrhPD0oWb4wVqg=;
        b=GdFbuoYhYTXXPTf/G9+fOtVVc9N6K8Rq1rVNp1aE95mP53Uab7NTfT7SXguFW69TLZ
         rO/zjdaEMvhMq/kt6fWRnbAP1rPMRyWUNkyfeK/mXyjkVhxafSoLJ015KqG4Cc+J0kjE
         j0avuWf3EjmdVTnsCoR0Bl2xsYqgRSr92ICvtPXyGqlJz2UaWawh8DBTKFHWGT/3plvU
         PCWisNE63WOStdjORBirOCqyUwmUXx8ZmEEoEY0NkyUWYKPdYKE8o3WuxRlDkF/qff6A
         I2bHbiRfSZnTvg7dAN/tugE5U0TDMqpPZ/zvnmhLCa7Bpm5A56fdcaDmW+GKtDE2SkCI
         yx6g==
X-Gm-Message-State: APjAAAUkclF5QSSvHN1aMBFTUGvnA+CIxGOp1Q6VanqP2DThw35c5hP2
        kRECQb6HUrjce1pmH0nfj80BvNj1G9yOb+bQ33jauAbB
X-Google-Smtp-Source: APXvYqxOZUpCU+5AFy4RLqhuDjx2AX6pxI9Zqbzh0mrMGe9Q/Xewjj0d9R3JxH1tbh0/Jpc5LMD095MmnifN/SM3DZ4=
X-Received: by 2002:a1f:1806:: with SMTP id 6mr56157586vky.85.1578307751707;
 Mon, 06 Jan 2020 02:49:11 -0800 (PST)
MIME-Version: 1.0
References: <20200102100230.420009-1-christian.gmeiner@gmail.com>
 <20200102100230.420009-6-christian.gmeiner@gmail.com> <82299ef95e44190d9bcea29bacb5651f3dc75b64.camel@pengutronix.de>
In-Reply-To: <82299ef95e44190d9bcea29bacb5651f3dc75b64.camel@pengutronix.de>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 6 Jan 2020 11:49:00 +0100
Message-ID: <CAH9NwWfS2GwL1kTYOOp8tnvCCXkMBQuOarBjiWXOQELWKPEM8A@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/etnaviv: update hwdb selection logic
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas

Am Mo., 6. Jan. 2020 um 11:15 Uhr schrieb Lucas Stach <l.stach@pengutronix.de>:
>
> On Do, 2020-01-02 at 11:02 +0100, Christian Gmeiner wrote:
> > Take product id, customer id and eco id into account. If that
> > delivers no match try a search for model and revision.
> >
> > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > ---
> >  drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> > index eb0f3eb87ced..d1744f1b44b1 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> > @@ -44,9 +44,26 @@ bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
> >       struct etnaviv_chip_identity *ident = &gpu->identity;
> >       int i;
> >
> > +     /* accurate match */
> >       for (i = 0; i < ARRAY_SIZE(etnaviv_chip_identities); i++) {
> >               if (etnaviv_chip_identities[i].model == ident->model &&
> > -                 etnaviv_chip_identities[i].revision == ident->revision) {
> > +                 etnaviv_chip_identities[i].revision == ident->revision &&
> > +                 etnaviv_chip_identities[i].product_id == ident->product_id &&
>
> Why not simply make this:
> (etnaviv_chip_identities[i].product_id == ident->product_id ||
> etnaviv_chip_identities[i].product_id == ~0U)
> and similar for customer and eco ID?
>
> With this we don't need two different walks through the HWDB, as long
> as the more specific entries in the DB are ordered to the front of the
> array.
>

Works for me too.. will be change in v2.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
