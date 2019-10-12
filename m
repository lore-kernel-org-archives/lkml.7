Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A19CC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6246F2089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nS7hNDn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfJLTRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 15:17:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37001 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729678AbfJLTRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 15:17:10 -0400
Received: by mail-io1-f65.google.com with SMTP id b19so28561399iob.4;
        Sat, 12 Oct 2019 12:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nnXOz+PRi58QoHjbu8c9O+WK1XkBB4tTUc2/yDJUsyM=;
        b=nS7hNDn8VxzSjURlBE78kATwaL7qPglBjODaQGeiluWc7L3KMJe9YDZ1nbMjCPg2k1
         NmdpST3hzIfFgjjtm2k71t7RDTL5skpsie5QY7FAslM77IIOl0JgTi9qvN5Effnmvm4F
         QTb+x6j7CdtoOqx0Ko0vBaWDwGLJt3fUamR6zgAoIXZSs+BG6kUPAhNPbypt9dl0GbBi
         6avvmlrRrLi3bU+ixPrRNh7CE6AxmSB4ZJTTTGxLBW8ymbvXkKkbKXHdhMDf3sn6Saua
         tCmiBnq8pNsZV5EM1pikTlxsuxSKlPYCnEuij0vSYKUvTLc171zWgrvQIwYl/pejOLK2
         DmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nnXOz+PRi58QoHjbu8c9O+WK1XkBB4tTUc2/yDJUsyM=;
        b=sDG5bxhIBLDfZI5mxYUEmWfeW3th7DcKTP3Cwq3u0se8/60cmEVuo7PK1lVOcG/T6/
         0spyhpeBBjGcs+lHCMayXs4eyFlm1bdscu0vBERzplM4buFCBePfFXZGfk2MOaBCBhOa
         u2BtFuQhT+Mh2d/f/Hhti79/kG3vQjZ7PGv62KamnGiMcb1gYpa3bhC3PfHJo7KBSXva
         Lv6X+rZmj6OaKzNV5gHWzoY3RZ7LOaBvgcZorDgeV03v4TV4Xn78FdJrB15A4wMRerCk
         04A+yMoJgUj5jNmgI1AWE9Gux2IILW5jF+pV6t5FYkiAo/dZtBtjCcvf2HuPMB7Z/9pN
         x7gg==
X-Gm-Message-State: APjAAAVP/O3PHaCzRPdRHGy0z+RpbPBmB7oqkAOWD2mvm1kW3LAkjdIt
        n7qLm5ivd7zhskxmV7VUsNwHAn0PQQEPQ2Zfs1w=
X-Google-Smtp-Source: APXvYqxrom5F5F07hOHPrw4GFvS2e6x6PfewZxqWfECjkUV75TnmcPI1mn3HAIFnkC8yXUkttiOV5Yh5LUUXo7eNKzc=
X-Received: by 2002:a02:a11e:: with SMTP id f30mr26789400jag.95.1570907829709;
 Sat, 12 Oct 2019 12:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191004190938.15353-1-navid.emamdoost@gmail.com>
 <540321eb-7699-1d51-59d5-dde5ffcb8fc4@web.de> <CAEkB2ETtVwtmkpup65D3wqyLn=84ZHt0QRo0dJK5GsV=-L=qVw@mail.gmail.com>
 <2abf545b-023b-853a-95ef-ce99e1896a5d@web.de> <3fd6aa8b-2529-7ff5-3e19-05267101b2a4@web.de>
In-Reply-To: <3fd6aa8b-2529-7ff5-3e19-05267101b2a4@web.de>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Sat, 12 Oct 2019 14:16:58 -0500
Message-ID: <CAEkB2ERCGJ6abNXfPNX7nbwkwD7qYTPYjYsNGzZwynn5CbPCzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/imx: Fix error handling for a kmemdup() call in imx_pd_bind()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dri-devel@lists.freedesktop.org,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 4:07 AM Markus Elfring <Markus.Elfring@web.de> wrot=
e:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 12 Oct 2019 10:30:21 +0200
>
> The return value from a call of the function =E2=80=9Ckmemdup=E2=80=9D wa=
s not checked
> in this function implementation. Thus add the corresponding error handlin=
g.
>
> Fixes: 19022aaae677dfa171a719e9d1ff04823ce65a65 ("staging: drm/imx: Add p=
arallel display support")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/imx/parallel-display.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx=
/parallel-display.c
> index 35518e5de356..39c4798f56b6 100644
> --- a/drivers/gpu/drm/imx/parallel-display.c
> +++ b/drivers/gpu/drm/imx/parallel-display.c
> @@ -210,8 +210,13 @@ static int imx_pd_bind(struct device *dev, struct de=
vice *master, void *data)
>                 return -ENOMEM;
>
>         edidp =3D of_get_property(np, "edid", &imxpd->edid_len);
> -       if (edidp)
> +       if (edidp) {
>                 imxpd->edid =3D kmemdup(edidp, imxpd->edid_len, GFP_KERNE=
L);
> +               if (!imxpd->edid) {
> +                       devm_kfree(dev, imxpd);

You should not try to free imxpd here as it is a resource-managed
allocation via devm_kzalloc(). It means memory allocated with this
function is
 automatically freed on driver detach. So, this patch introduces a double-f=
ree.

> +                       return -ENOMEM;
> +               }
> +       }
>
>         ret =3D of_property_read_string(np, "interface-pix-fmt", &fmt);
>         if (!ret) {
> --
> 2.23.0
>


--=20
Navid.
