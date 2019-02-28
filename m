Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C722FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906B120842
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0WBsZti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbfB1Gl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:41:57 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37445 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbfB1Gl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 01:41:57 -0500
Received: by mail-it1-f195.google.com with SMTP id z124so14112116itc.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 22:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oM4hTOT2OCF1A/yD/tVGVsaXROzs37e+3No7f+S/dkw=;
        b=N0WBsZtijllghBiFDgw2A6j/BtYUWaCvjKx9o3A7dWzicUQCQkkCSnxvP5TeUKOO5W
         cO4EA2WDc6T0fjOOyS73/o1OoDcF2HkoVmjAxKDk6YbSJNvN1euavdhsFWFDME2DcH0M
         5bH8yp1vWOSd6nixG4WN9/QJ+eywZQdHTpcwsEDwCu2z2twWfGtGq8KNljAwWIkTmQgv
         rPkmc6T/7Z3F7Mrq/1/jOde95F2WHL6A5QwfKnmfR/XYtHalL+KBfFjxxJJmUC7lWBXf
         aHj7EarEEbGGQ7t2asoupH3TQTELf/EGhDf9FXYM/2tKNdxMYo/ctcphXTy9tqUShwdS
         1qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oM4hTOT2OCF1A/yD/tVGVsaXROzs37e+3No7f+S/dkw=;
        b=EhLIdItf5tnbNN3xOWZfYDKoqXJ+XdZIL1detQ5tHesTslszy1FkiCwH7ehoFosdlU
         pUjtNs6boxNabDaZcZtd+tJBREp0afmtopz6nxnmcTor45g9FvmHReOwJ/kIg9JVWbG9
         QZTH8aSywMYvmHgCK/8QaMTg2ZHK3yxGYOhou3zKxIArXP5zxEI74mfldhDHS1hfX06D
         qSDxqih/TbCNtf1fu8VijTQUzJkH4pajxLa+vDkzfmvfZN5TiESNjdWinGJC9wZ3UNuT
         m9MpF4+ZsQDg0MDDpCfNUtpfymPW7uIPlr3O+si5BjELKY2g0qLG8hEKA6GBwMKb1XnI
         /5VA==
X-Gm-Message-State: AHQUAuabqjYOg7OrxcKI6znDmw9DEyUsXfEKKuDdUVweoPe8KHGAQNr0
        7HvyteXS53ug05gpTrs2rJfWbdBJuz2uNx84QPFGnw==
X-Google-Smtp-Source: APXvYqzXlea6ugCUXlh40SKnvEEIh1wzshonTfMJdQE+5Q1vIM5er3WcHQcFg9Wiowp6vmsafQeIzEFXj7bRunJfajQ=
X-Received: by 2002:a24:674a:: with SMTP id u71mr2059481itc.12.1551336115765;
 Wed, 27 Feb 2019 22:41:55 -0800 (PST)
MIME-Version: 1.0
References: <20190226213053.GC218103@gmail.com> <20190226220858.214438-1-ebiggers@kernel.org>
 <20190227231202.tycdbcqtk5ylwp4k@smtp.gmail.com>
In-Reply-To: <20190227231202.tycdbcqtk5ylwp4k@smtp.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Feb 2019 07:41:44 +0100
Message-ID: <CACT4Y+bXsD3FjOYMnpfPz3PtUpNNkpLtxqmZPmnQuk=r2OSpDw@mail.gmail.com>
Subject: Re: [PATCH] drm/vkms: fix use-after-free when drm_gem_handle_create() fails
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 12:12 AM Rodrigo Siqueira
<rodrigosiqueiramelo@gmail.com> wrote:
>
> On 02/26, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> >
> > If drm_gem_handle_create() fails in vkms_gem_create(), then the
> > vkms_gem_object is freed twice: once when the reference is dropped by
> > drm_gem_object_put_unlocked(), and again by the extra calls to
> > drm_gem_object_release() and kfree().
> >
> > Fix it by skipping the second release and free.
> >
> > This bug was originally found in the vgem driver by syzkaller using
> > fault injection, but I noticed it's also present in the vkms driver.
> >
> > Fixes: 559e50fd34d1 ("drm/vkms: Add dumb operations")
> > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_gem.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkm=
s_gem.c
> > index 138b0bb325cf9..69048e73377dc 100644
> > --- a/drivers/gpu/drm/vkms/vkms_gem.c
> > +++ b/drivers/gpu/drm/vkms/vkms_gem.c
> > @@ -111,11 +111,8 @@ struct drm_gem_object *vkms_gem_create(struct drm_=
device *dev,
> >
> >       ret =3D drm_gem_handle_create(file, &obj->gem, handle);
> >       drm_gem_object_put_unlocked(&obj->gem);
> > -     if (ret) {
> > -             drm_gem_object_release(&obj->gem);
> > -             kfree(obj);
> > +     if (ret)
> >               return ERR_PTR(ret);
> > -     }
> >
> >       return &obj->gem;
> >  }
> > --
> > 2.21.0.rc2.261.ga7da99ff1b-goog
> >
>
> Hi,
>
> Thanks for your patch! :)
>
> The patch looks good for me. I also tested it under the IGT tests on my
> local VM and everything was fine.

Hi Rodrigo,

What are IGT tests? How can I run them?

>
> Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
>
> --
> Rodrigo Siqueira
> https://siqueira.tech
> Graduate Student
> Department of Computer Science
> University of S=C3=A3o Paulo
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/20190227231202.tycdbcqtk5ylwp4k%40smtp.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
