Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B4EC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B436A20872
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpz+92MZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfIKNs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:48:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46296 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfIKNs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:48:28 -0400
Received: by mail-qt1-f194.google.com with SMTP id v11so25215454qto.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h2wOUHiWpxKqr+UqStMT79MNVhr6IEzOBzbNm/wb6WA=;
        b=Zpz+92MZ9dy1RH5rw0+hQxc2fh1jHsn1aLA5aaWeCGkEg/eZlVGdRJ9QJQLa0ZIhJx
         tKKt0fuzM2tEweS2GJ7B3pWRdMbsmwBbGnQogTsw3m97yWmWC9QU1nPYlWQErhGbIqEl
         b5+mc0kLelB/lZvAXA0J1d0LNgOMBvPiJS8RTZlVNiGBx0gQOKUQYltuBT006x98GAid
         GMb1w9Pe5WSDDodvSweVCKnqbFSXsRdQvSK1YI4TMY7KrEnRF9Pfgv2a2KsK7j5+oTDn
         2lBB9f+TaRyNkjgwvHROk6Pgem2/KK9lLZ7dRT36GI8F3pf7yXgHZyQIHkgEGfXYEV8F
         2L8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h2wOUHiWpxKqr+UqStMT79MNVhr6IEzOBzbNm/wb6WA=;
        b=f34me2R6uFSrCesz1oaKVZWZI6YkMM4w+B5W1zbbv9V6COe+z7CRZ5MDuDGXzF+QBR
         yapdBwkS0ewF0ffVrBkrGw58M//VF2hQ03GvX3pEiINTlV5Te8Etg08ljltmjncLqpjI
         M4rJLO8fldkVt2B6V+xKDqJKI2tGJcYC1TUm3m9PvxMv2RuJ1efo+LpU3zrW2uOzGylL
         41k025tqWg7pyLz7tmlugdXkArA8oEXqVvvEjhqbsFkYCxwXJu2DSs6JwESSRrArripy
         u6Wn8Qbi8eLroqEStMVzkcL0CvPToXgdBMm/WmfwIz61IhsUOLAZKrphDWY37Opm5TZ0
         K51g==
X-Gm-Message-State: APjAAAUvpu6bIGizfNq/SAAUrYbyjo6u9UfJnNNCQv8Adw+M2lPaIcD3
        Cu2QLN4aKIqSGOPeKaRZcKk1Or/97480mKmy9A33FL7HHRE=
X-Google-Smtp-Source: APXvYqy10LxakIu1PzAG5oDBkwD2N0MBYNmerCIPzvxtK7Czalf18CxqTfRl1Y9sqrRC1lsVrXis1Bs405OxqfJkfIE=
X-Received: by 2002:a0c:ac4b:: with SMTP id m11mr22558727qvb.103.1568209707110;
 Wed, 11 Sep 2019 06:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190911055938.GA130589@LGEARND20B15> <20190911151202.0002d12b@nic.cz>
In-Reply-To: <20190911151202.0002d12b@nic.cz>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Wed, 11 Sep 2019 22:48:22 +0900
Message-ID: <CADLLry5Fk6SsF5JTP-MSUF2b9kgyqg4cr9y2N8eqJpFbd8Kx-g@mail.gmail.com>
Subject: Re: [PATCH] bus: moxtet: Update proper type 'size_t' to 'ssize_t'
To:     Marek Behun <marek.behun@nic.cz>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good!
Thanks for notification.

2019=EB=85=84 9=EC=9B=94 11=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 10:12, =
Marek Behun <marek.behun@nic.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Austin,
> this was already fixed and is staged for soc/for-next, see
> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?h=3Df=
or-next&id=3D6811d26df50d96635dd339cf8cdf43a6abc0c4b6
>
> Thanks,
> Marek
>
> On Wed, 11 Sep 2019 14:59:38 +0900
> Austin Kim <austindh.kim@gmail.com> wrote:
>
> > The simple_write_to_buffer() returns ssize_t type value,
> > which is either positive or negative.
> >
> > However 'res' is declared as size_t(unsigned int)
> > which contains non-negative type.
> >
> > So 'res < 0' statement is always false,
> > this cannot execute execptional-case  handling.
> >
> > To prevent this case,
> > update proper type 'size_t' to 'ssize_t' for execptional handling.
> >
> > Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> > ---
> >  drivers/bus/moxtet.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
> > index 1ee4570..288a9e4 100644
> > --- a/drivers/bus/moxtet.c
> > +++ b/drivers/bus/moxtet.c
> > @@ -514,7 +514,7 @@ static ssize_t output_write(struct file *file, cons=
t char __user *buf,
> >       struct moxtet *moxtet =3D file->private_data;
> >       u8 bin[TURRIS_MOX_MAX_MODULES];
> >       u8 hex[sizeof(bin) * 2 + 1];
> > -     size_t res;
> > +     ssize_t res;
> >       loff_t dummy =3D 0;
> >       int err, i;
> >
>
