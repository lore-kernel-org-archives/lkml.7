Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862B9CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56235214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SKuPRKpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfJ1Whi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:37:38 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33162 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJ1Whi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:37:38 -0400
Received: by mail-il1-f194.google.com with SMTP id s6so6107879iln.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 15:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3tX+ks7PoiFwrJMh00/G0a0ftQIDY3RWS8pN1PA/BQ=;
        b=SKuPRKpveC6kpd0ROoNvdHULXUx99U0LlGRXDpWC4BPC2PLCNKrud8USuQ9T6iTjuu
         yY/RhELZCceNf3/45XZWM6GsNyRX8KOElh1Wg6prkLUzt27uk4jeSXYo/9oCWj7trUCm
         /4sm/8LdQPwR0vw2Ic0Nb7446p1joXFqG8Khw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3tX+ks7PoiFwrJMh00/G0a0ftQIDY3RWS8pN1PA/BQ=;
        b=Ystom5mB5/wWehbF2Q1M0TDs/CV06nqWamO/4ALIiY0bwDlTLnfUixp3vsPGqB3AzL
         bQRuCv9F5WQpVnfa0nEkUgivFN8VUn5tC6rO8Ml5fuF9BCFcfb6ZGsyT81AYb3St2ftg
         rMKHMpbubcUvoiZvXWB1owphig+5FcPjAN34PxaVYcDO9UA9hBH+TNszVxO+v/7gmxXS
         hta94eSgPNA/E6STQ6j91/cciHULKDbNovdUUtGzSJjPaOQlqooPy1sHB4OxyCwxwxDq
         9EP/VPh2GORTbuuVLlsQ5jTOYt1XhVMe5BVkt+lT3UowEk0h7ecP6lX3l8aRXOSyTyUw
         KXIA==
X-Gm-Message-State: APjAAAUE7kuf5VGAjKdRVxNQhLviUpsTKP0TkBRDtPuzE5BvatlUG/+K
        JdwchFbA/UHGB7SgSmAceEJRdzDAhWTFoG8qq3Zx4g==
X-Google-Smtp-Source: APXvYqwIZOpM2fC3dmpYbeGTVPOWxOzVO5pYPcw3MFmyjgnC+e3sCBKiQMsTwG3PiO7rE0i53YmxyINxh4//HXXlb2c=
X-Received: by 2002:a92:91d3:: with SMTP id e80mr24149380ill.77.1572302257323;
 Mon, 28 Oct 2019 15:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191025175625.8011-1-jagan@amarulasolutions.com>
 <20191025175625.8011-3-jagan@amarulasolutions.com> <20191027211737.GA30896@bogus>
In-Reply-To: <20191027211737.GA30896@bogus>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 29 Oct 2019 04:07:26 +0530
Message-ID: <CAMty3ZD8P1KGS+6AZOCbYyLpV=c7wowUdwoJXYvEMq211xbM1g@mail.gmail.com>
Subject: Re: [PATCH v11 2/7] dt-bindings: sun6i-dsi: Add A64 DPHY compatible
 (w/ A31 fallback)
To:     Rob Herring <robh@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 2:47 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 25 Oct 2019 23:26:20 +0530, Jagan Teki wrote:
> > The MIPI DSI PHY controller on Allwinner A64 is similar
> > on the one on A31.
> >
> > Add A64 compatible and append A31 compatible as fallback.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml         | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.

I usually collect the tags when I send next version w/o any change.
but this dt-binding patch has a fixed version compared to previous
version. I have updated changelog on cover patch and may be will write
it on respective patch itself.
