Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718FFC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439942173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5OUB74q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390526AbfHBQQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:16:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43282 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfHBQQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:16:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id e3so72875211edr.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=yq678WdcyRIfxxz1DjqvitXgUUTXiKqpiBLFlR7X/ao=;
        b=J5OUB74qGq7b2/ibzxcih2qZHgXqBteTmx95ced/ZyqN00DC5mOxDTYKiC/QKDK1LD
         Roetp66a85vdOGabzMr3kYXd0TfKwXCepHWrs0fTkiERptOPXSZwS3dq4Lo6fQt8xNR4
         WCRk812zkJDBWQxKrT4fn94oIBmB2coZaDAZNqOzb00KZDujo/DuX9VSoUG0OAuOIZ7p
         V72pdqpwUpaXsRuZeO3TpIVMQJR0uCBW79i/zl6/KzCYAQn6cswnGEoEqdoZTrWoykBk
         Uu1cTTow/8IhgF49dP9tEpEb9yrPy1yrl99/XvWHS0B+AsrcvOHcdqo/6VWN3qQvWd+t
         cJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=yq678WdcyRIfxxz1DjqvitXgUUTXiKqpiBLFlR7X/ao=;
        b=pouprswrJrpRzdje20NkQ3LWISh3ei5H8mY5x6KzH4QLgs+svJs7FNpzaTESU3jmxG
         t/qpA7Kc9BQOvl8IiSJnpObcUMjc5Zq2nFXren0aS4GGvwJvjljbDeX/1/fEFgXJkhh2
         g92+oRVT3Vk9nFpCEh7oJnbDjAVLsA98fMM7E5v4st0Nr4N3dln8hizn6/Ud43oQaLrP
         Q9RTffH2n/CU8BEAFpruQfYB6lib2ENTOBa/MZvww7JFb2mKVikoWWS/zUg5UcNoID59
         YDTRzzg1MiERKegu4ExoKaMfdaioVb/8gpY9waAfTRlwOC+UWphat7FcMISw08Sgj3bi
         Oa5w==
X-Gm-Message-State: APjAAAXOs6vulUUhqXItKDAefPdt8RbWGJOc3CuACFTdCFvCI1Hqq9GT
        6kwXbtH+IUDupExLLn2t3NhH/YPXTpLy0l/PAro=
X-Received: by 2002:a17:906:7cd6:: with SMTP id h22mt13232787ejp.254.1564762577156;
 Fri, 02 Aug 2019 09:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190802125720.22363-1-hslester96@gmail.com>
In-Reply-To: <20190802125720.22363-1-hslester96@gmail.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Sat, 3 Aug 2019 00:16:06 +0800
Message-ID: <CANhBUQ3L29NzKEdpK5MvUZh7E97Co_vHRzjH2KaXxx+93_9WWg@mail.gmail.com>
Subject: Re: [PATCH] niu: Use refcount_t for refcount
Cc:     "David S . Miller" <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chuhong Yuan <hslester96@gmail.com> =E4=BA=8E2019=E5=B9=B48=E6=9C=882=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:57=E5=86=99=E9=81=93=EF=BC=9A
>
> refcount_t is better for reference counters since its
> implementation can prevent overflows.
> So convert atomic_t ref counters to refcount_t.
>
> Also convert refcount from 0-based to 1-based.

It seems that directly converting refcount from 0-based to
1-based is infeasible.
I am sorry for this mistake.

Regards,
Chuhong

>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/net/ethernet/sun/niu.c | 6 +++---
>  drivers/net/ethernet/sun/niu.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/ni=
u.c
> index 0bc5863bffeb..5bf096e51db7 100644
> --- a/drivers/net/ethernet/sun/niu.c
> +++ b/drivers/net/ethernet/sun/niu.c
> @@ -9464,7 +9464,7 @@ static struct niu_parent *niu_new_parent(struct niu=
 *np,
>         memcpy(&p->id, id, sizeof(*id));
>         p->plat_type =3D ptype;
>         INIT_LIST_HEAD(&p->list);
> -       atomic_set(&p->refcnt, 0);
> +       refcount_set(&p->refcnt, 1);
>         list_add(&p->list, &niu_parent_list);
>         spin_lock_init(&p->lock);
>
> @@ -9524,7 +9524,7 @@ static struct niu_parent *niu_get_parent(struct niu=
 *np,
>                                         port_name);
>                 if (!err) {
>                         p->ports[port] =3D np;
> -                       atomic_inc(&p->refcnt);
> +                       refcount_inc(&p->refcnt);
>                 }
>         }
>         mutex_unlock(&niu_parent_lock);
> @@ -9552,7 +9552,7 @@ static void niu_put_parent(struct niu *np)
>         p->ports[port] =3D NULL;
>         np->parent =3D NULL;
>
> -       if (atomic_dec_and_test(&p->refcnt)) {
> +       if (refcount_dec_and_test(&p->refcnt)) {
>                 list_del(&p->list);
>                 platform_device_unregister(p->plat_dev);
>         }
> diff --git a/drivers/net/ethernet/sun/niu.h b/drivers/net/ethernet/sun/ni=
u.h
> index 04c215f91fc0..755e6dd4c903 100644
> --- a/drivers/net/ethernet/sun/niu.h
> +++ b/drivers/net/ethernet/sun/niu.h
> @@ -3071,7 +3071,7 @@ struct niu_parent {
>
>         struct niu              *ports[NIU_MAX_PORTS];
>
> -       atomic_t                refcnt;
> +       refcount_t              refcnt;
>         struct list_head        list;
>
>         spinlock_t              lock;
> --
> 2.20.1
>
