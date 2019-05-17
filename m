Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A70C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5815E2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558123668;
	bh=IkVGNrM3mkdkCp1ruLguz7iPAsoAAPm6bhm62l6C0l4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sUmWrVRj+yi14Z++z/SQC5hEhe9rfwP31aeK2uJVlFl0oqk8W3DGGKItmFrz+5oQo
	 RCGrBOnCbHTXAcVeY+spxoqODn+HhcodCl5Sbk+dsNzWQXXzrFrKX+5wRSWP4o3Ni8
	 YeFD3KVNs8I1a9IOyCjhYvRCeapc8Tj4aSm/zKbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfEQUHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 16:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfEQUHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 16:07:47 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A3E72087E;
        Fri, 17 May 2019 20:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558123666;
        bh=IkVGNrM3mkdkCp1ruLguz7iPAsoAAPm6bhm62l6C0l4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D7KoCjgNCYuzAKFnaeZMIowcKdNjhe/bHfunIg0phnFQGUNm7Si+IswAnpAuc8H6I
         6Juv7ClQ+lDWVypoiyNPgrHPlYddKlyshbbCP2el4CrhQiWah4/LMWx6fgC/bWtuFU
         E4aSZreYUPIbR5Wj7iA7bqvpJU7ENIrsynXOu2+M=
Received: by mail-qt1-f181.google.com with SMTP id i26so9408044qtr.10;
        Fri, 17 May 2019 13:07:46 -0700 (PDT)
X-Gm-Message-State: APjAAAWgwJmxHtzHkMgeNiIpOwUgS1LUZPDFxfrc1G+stk7+j8mhXA6W
        ueSa6S6nP5ky34kJEuckVTOnEsbR6+yZtsJhBQ==
X-Google-Smtp-Source: APXvYqyorKmxc+J4KVhOQBHBImhJm18kRJeWl2YZpK+ASt7DMCb593EYeTOi8eZBw90uGhvevJaQVOjh6CpzEWMWRDg=
X-Received: by 2002:ac8:2d48:: with SMTP id o8mr50643532qta.136.1558123665768;
 Fri, 17 May 2019 13:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190517184659.18828-1-peron.clem@gmail.com> <20190517184659.18828-2-peron.clem@gmail.com>
In-Reply-To: <20190517184659.18828-2-peron.clem@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 17 May 2019 15:07:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKPazGn+g1zS4NMwvQZ_6GcAm0tgcOTqyQA0dz0+2dp3g@mail.gmail.com>
Message-ID: <CAL_JsqKPazGn+g1zS4NMwvQZ_6GcAm0tgcOTqyQA0dz0+2dp3g@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] drm: panfrost: add optional bus_clock
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 1:47 PM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.c=
om> wrote:
>
> Allwinner H6 has an ARM Mali-T720 MP2 which required a bus_clock.
>
> Add an optional bus_clock at the init of the panfrost driver.
>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 25 +++++++++++++++++++++-
>  drivers/gpu/drm/panfrost/panfrost_device.h |  1 +
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 3b2bced1b015..8da6e612d384 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -44,7 +44,8 @@ static int panfrost_clk_init(struct panfrost_device *pf=
dev)
>
>         pfdev->clock =3D devm_clk_get(pfdev->dev, NULL);
>         if (IS_ERR(pfdev->clock)) {
> -               dev_err(pfdev->dev, "get clock failed %ld\n", PTR_ERR(pfd=
ev->clock));
> +               dev_err(pfdev->dev, "get clock failed %ld\n",
> +                       PTR_ERR(pfdev->clock));

Please drop this whitespace change.

>                 return PTR_ERR(pfdev->clock);
>         }
>
