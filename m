Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABBBC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4AE20880
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTVCASN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfGRHVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:21:41 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40917 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfGRHVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 03:21:41 -0400
Received: by mail-yw1-f67.google.com with SMTP id b143so11857401ywb.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 00:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I7RxY7r3Jgx1B32VLDVMayLONGfb/45rCMfF68XdUAg=;
        b=eTVCASN/nT7UvlP4b2X/hXHaLQJXMUscbQC9BC69DYGyPbL5539AeuPk0d0lVuNnFB
         94C85zw3keVa0UWRcTL7/iGcxD2GoaJLbsEOeuzl7SzOaXTXuuSkatIwiqUUkz0Ct9xE
         mGjy62wdb3x1vH6IxM68zd3oFq5NJ7lL4c6N1qGUMn49oUG7bagRqGf2qPFEb2IEzUe3
         koODk1TdrlZk8rfnxf3R1i1527woiDDZn1VyNTHdATm+EqtapeyaDGfXCotryhLL6zl8
         dXugt/fxJlPXUHWrvY1Fiwv4s6ZgoH08QSVOMRsPpumfPgdGQPiNKaQWD/oHCyK1xxCa
         rtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I7RxY7r3Jgx1B32VLDVMayLONGfb/45rCMfF68XdUAg=;
        b=IjxenuSEBqIxr/hcVHb0t9bR9rqmPXeYJcHm6JV+VKEWq6KGWOS6A1wVsLbsQggzG2
         AZZzyTDg80m/TtYS0avhM+k7OqAg+Ip8WWgh9CZgpqLwpx61NBSml7Nh7Cx4/xMNg/NL
         BFCUY2t1ZS7VoE+aFtmwVTrRCz/4u/p7lz+JvOgPgGoeF/qF9o0Jyz11SCOBFliMOzGf
         TIjcMJiU/W7kBJIIndGa+mSMmejYQHQeAo26Frj6f+ln0S1QmIrl7Z4x3tehQ7uowYom
         YzJiPlYbe6jSkn5Lt4BM89UIUc4n3LbUGLzDX7jVxTsqV2fA7G3h8PJpm6SXx/K6l8KO
         6pLA==
X-Gm-Message-State: APjAAAVGgv7xvsjuY0EWxFwyjeZtB3ZXojYVj2G045WrXMu+bS5ro6Cv
        DO0FKCkt3JIuHrGSUXtUFWEm7sHUL1clIqgHPpOWaJcP
X-Google-Smtp-Source: APXvYqzyn24R75IvV9NOa9XZXY2XO7T0KL4m6uKnklrU5aFhxWobVyBsowaxjq35Rnfl9y9O3v18nyMMlKx/oST5D10=
X-Received: by 2002:a0d:f2c4:: with SMTP id b187mr27527652ywf.103.1563434500147;
 Thu, 18 Jul 2019 00:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190711031021.23512-1-huangfq.daxian@gmail.com> <6f28e750-02e4-438a-3680-a4697014689d@amd.com>
In-Reply-To: <6f28e750-02e4-438a-3680-a4697014689d@amd.com>
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Date:   Thu, 18 Jul 2019 15:21:29 +0800
Message-ID: <CABXRUiTG4=isYUHkoha9dYX0P=k6AuQAnrZkcWHT=-Yf2gk6Vg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/ttm: use the same attributes when freeing d_page->vaddr
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "Huang, Ray" <Ray.Huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Koenig, Christian <Christian.Koenig@amd.com> =E6=96=BC 2019=E5=B9=B47=E6=9C=
=8816=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:38=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Am 11.07.19 um 05:10 schrieb Fuqian Huang:
> > In function __ttm_dma_alloc_page(), d_page->addr is allocated
> > by dma_alloc_attrs() but freed with use dma_free_coherent() in
> > __ttm_dma_free_page().
> > Use the correct dma_free_attrs() to free d_page->vaddr.
> >
> > Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> How do you want to upstream that? Should I pull it into our tree?

I just came across this misuse case accidentally.
I am not very clear about 'How to upstream that'.
Are there more than one way to upstream the code and fix the problem?

From my side, it is ok that you pull it into your tree and fix it or
fix it in other way.
:) It will be fine if the problem is fixed.

Thanks.

>
> Thanks,
> Christian.
>
> > ---
> >   drivers/gpu/drm/ttm/ttm_page_alloc_dma.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm=
/ttm/ttm_page_alloc_dma.c
> > index d594f7520b7b..7d78e6deac89 100644
> > --- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> > +++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> > @@ -285,9 +285,13 @@ static int ttm_set_pages_caching(struct dma_pool *=
pool,
> >
> >   static void __ttm_dma_free_page(struct dma_pool *pool, struct dma_pag=
e *d_page)
> >   {
> > +     unsigned long attrs =3D 0;
> >       dma_addr_t dma =3D d_page->dma;
> >       d_page->vaddr &=3D ~VADDR_FLAG_HUGE_POOL;
> > -     dma_free_coherent(pool->dev, pool->size, (void *)d_page->vaddr, d=
ma);
> > +     if (pool->type & IS_HUGE)
> > +             attrs =3D DMA_ATTR_NO_WARN;
> > +
> > +     dma_free_attrs(pool->dev, pool->size, (void *)d_page->vaddr, dma,=
 attrs);
> >
> >       kfree(d_page);
> >       d_page =3D NULL;
>
