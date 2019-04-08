Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299DEC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7C72087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StEfq8Pf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfDHM0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:26:15 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51398 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfDHM0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:26:15 -0400
Received: by mail-it1-f196.google.com with SMTP id s3so20321818itk.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nVpbujjS1PPkNA9KbS0Zdp9nYAr7Luhd/h8B2PIs/U8=;
        b=StEfq8PfEEi3Wm7m2QUx7WjXRhjRoSi9v7giHye54+HnZYmH+29fIxXW0Fnts1/SIJ
         HAgfbWkrQIG6p4wRZGvIne54qrD2fG9qlwFRtRboeiJbkSEfaOyivuy6qUysJguVD1S1
         1K/EgyTHP41AZyoG/YtjPxS7Bq4IsNCGjFuExO8wDpz7YpVimrCha2M9Mzwm5ROGEw49
         vP/jyVrNtRP+WQnHNdOgJr1oaSZKzs8I465Fbw7wDW9Nwcv+utqQ2lhUvmeMgwUprRYq
         +tDqxWB4bEJnt0NPSaudOT1BfXL8h8VJHhm0XBtB2UBRv5MU5AjPDrS9HEFqcnJGVpZl
         06Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVpbujjS1PPkNA9KbS0Zdp9nYAr7Luhd/h8B2PIs/U8=;
        b=qEtT0GK+GE5wTQ41GhVuQ4mVv8yfZXgdx9X1eeN2NVbFPJoXZJWHidWwVQEcdltEwT
         fPhOPfWgRGwSg0lY0v4kg6+NhAU5R6mG0txZk1ShIVL9nYsMYZVTxIj+tuN+GVbgODkU
         7C1DhZp5xcr4rH4g01+uLEisxoRW6DNHfxVskUJM3uhyKx1kapBPtGHlHCnKfGbiqD7+
         jqe+jd786flzEiN44Q7hlC/QiekUU22yx39jdFaAlib/1/9IvQwWMZ6crmaUtQ6gSYBh
         HjWpSvr4KpobYhKMMo1dAbhUSi4IIsF1rzJOndZN3H9ujzzBMQEDFPhCsvmSUhQ/clhN
         njhw==
X-Gm-Message-State: APjAAAUW3jkTwNSWgorFlVM7jflPCMZ0KpWfztxsVQuwjuKdvKMUkYMZ
        WSn4/KCeEEviow2fPC8flsRU5qkDXeUeLvfx7JM=
X-Google-Smtp-Source: APXvYqwQF73dOcj5lU5ZZAtl98FZzb96iLwZcecujpDwI9zWvdir2s8Xj86qiINiALYgv+w9Jo5o5ajhuM1eAX8P65Y=
X-Received: by 2002:a24:78c8:: with SMTP id p191mr17436227itc.58.1554726374582;
 Mon, 08 Apr 2019 05:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <9138d8e8-5390-0650-9bc3-050b869e978c@infradead.org>
 <CAKGbVbugBGrxfHm3k7WB+FS_O-Bjj9PyKrSDteTy1sra=nd6cw@mail.gmail.com> <054b9d43-cf4e-057d-132d-7c1758956595@baylibre.com>
In-Reply-To: <054b9d43-cf4e-057d-132d-7c1758956595@baylibre.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 8 Apr 2019 20:26:03 +0800
Message-ID: <CAKGbVbtok8RUzDqw=WShAHoiLqWLaKA8coKhcW5EPrsHCO89pA@mail.gmail.com>
Subject: Re: [Lima] [PATCH -next] MAINTAINERS: mark lima mailing list as moderated
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lima@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 8:00 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 08/04/2019 03:37, Qiang Yu wrote:
> > Looks good for me, patch is:
> > Reviewed-by: Qiang Yu <yuq825@gmail.com>
>
> Also:
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>
> >
> > Should I apply this patch to drm-misc in this case? Or this patch will be
> > submitted in other kernel tree and back merged to drm-misc?
>
> You can push it yourself on the drm-misc-next branch now.
>
> (Then you can reply to the original patch when you applied it)

Thanks for the guidance. I'll push it soon.

Regards,
Qiang

>
> Neil
>
> >
> > Regards,
> > Qiang
> >
> > On Mon, Apr 8, 2019 at 3:12 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> Note that the lima mailing list is moderated.
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Qiang Yu <yuq825@gmail.com>
> >> Cc: dri-devel@lists.freedesktop.org
> >> Cc: lima@lists.freedesktop.org
> >> ---
> >>  MAINTAINERS |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> --- mmotm-2019-0405-1828.orig/MAINTAINERS
> >> +++ mmotm-2019-0405-1828/MAINTAINERS
> >> @@ -5226,7 +5226,7 @@ F:        Documentation/devicetree/bindings/dis
> >>  DRM DRIVERS FOR LIMA
> >>  M:     Qiang Yu <yuq825@gmail.com>
> >>  L:     dri-devel@lists.freedesktop.org
> >> -L:     lima@lists.freedesktop.org
> >> +L:     lima@lists.freedesktop.org (moderated for non-subscribers)
> >>  S:     Maintained
> >>  F:     drivers/gpu/drm/lima/
> >>  F:     include/uapi/drm/lima_drm.h
> >>
> >>
> > _______________________________________________
> > lima mailing list
> > lima@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/lima
> >
>
