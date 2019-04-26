Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDFFC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D2B20878
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6HnH68f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfDZC5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:57:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36070 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfDZC5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:57:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id c35so2587153qtk.3;
        Thu, 25 Apr 2019 19:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LxPxwUz4tqzKMwfIuNkMy7Ymq7NsmOQHnTRJFFhwtJs=;
        b=m6HnH68fR+ehOaOscaX0TBGB3ZWi0h6yUoC4anDxgVuSO8OoTwEqNHtF9o9OT6NGwX
         vYpZOIoeXv9fo7BajkQo4v9GAw+OJTo+p9t1Vs+9RtTgmlwG0A5HYFsvEdjkj0B6Dd8S
         G2+aq0ngjrYOkG4YLzK7IDHG4iqZQmMQr8L5pwQI9OM6t35Bjfvb5SSTUxXX5I6k97tb
         Wc7lMYHnmwVIfGtPDKKUEvqr30trjCoDrvruRbdv/m2QvGr6QcNGCu+fc7ETuHN14wzV
         Bd8FYvEogZT/NpgJs1Jh/dkz+QMrORHtkpHH1wTyWN7tH4UNjsKYbBmpZcJ8vdGsYJzu
         RH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LxPxwUz4tqzKMwfIuNkMy7Ymq7NsmOQHnTRJFFhwtJs=;
        b=ZRajzAW+vrMQgumqhBIb02L/WFdeQGG0zqTbhP76bPAjzMY+b+RlHDRoKbJ3ZoNrZB
         /98GPpbtPs6Xs025MXgLvTpJqDp/AYGeaCVU1npex2TBBzbMzCnTtPHEcIlByd/LQvmz
         wTplKRelH8eIYh389wqj8Zxwj9oEBGS5T+LhmcmEDQQ1ocoOhO5Po48DIMTt+q5T+HXB
         Dz0cQtCnTNN3apKQrK4K/uyKcX6ye05rSSGjW4z6URvsjW396LoJ+h2a5kC0qckTKgA+
         4NEl1HhTlD8X+pda0pzBI9cGXkNA5WInikUxddmNpX0I3agTC9wGRLeuBuUXBEA4RjZT
         G8eg==
X-Gm-Message-State: APjAAAUi838+OyUdPPIjqcURpBBOXnpspjK/2Y5KOH/1kF56ycYbPofc
        KvcckCFufIVl84OPexPlMcCGBAw6QaO0ef0KF/M=
X-Google-Smtp-Source: APXvYqw1lfMc2nIMVhbGwlI8RxDxh9ctaQFCnHqf8qXneWLvc0Tqln8Z6EBxF48GDwUL1Glpgqmu+TjxAuSLGDAhxBo=
X-Received: by 2002:ad4:44af:: with SMTP id n15mr3131368qvt.35.1556247419963;
 Thu, 25 Apr 2019 19:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <1553859161-2628-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAR6bT93kmyPCzJg2ZFvk239nz0nyVX5z23G+8Y0Wiba1Q@mail.gmail.com>
 <CAPM=9txpmjQqh0eLA1sMjcDatQG83vk=juLehiUDi=sBO+c9Tg@mail.gmail.com> <8d04d30e86a54b3e9b27b30ac0ab3822@SOC-EX01V.e01.socionext.com>
In-Reply-To: <8d04d30e86a54b3e9b27b30ac0ab3822@SOC-EX01V.e01.socionext.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 26 Apr 2019 12:56:48 +1000
Message-ID: <CAPM=9tyRHNp2R_No_0Gx0N59XR2RvD4=1G2GWgLLDxmKNk6JVg@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v2] drm: prefix header search paths with $(srctree)/
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>, zhoucm1 <David1.Zhou@amd.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel, drm-misc-next-fixes?

Dave.

On Fri, 26 Apr 2019 at 12:25, <yamada.masahiro@socionext.com> wrote:
>
> Hi Dave,
>
> > -----Original Message-----
> > From: Dave Airlie [mailto:airlied@gmail.com]
> > Sent: Friday, April 26, 2019 11:19 AM
> > To: Yamada, Masahiro/=E5=B1=B1=E7=94=B0 =E7=9C=9F=E5=BC=98 <yamada.masa=
hiro@socionext.com>
> > Cc: David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>;
> > dri-devel <dri-devel@lists.freedesktop.org>; nouveau
> > <nouveau@lists.freedesktop.org>; Sam Ravnborg <sam@ravnborg.org>; David
> > (ChunMing) Zhou <David1.Zhou@amd.com>; amd-gfx mailing list
> > <amd-gfx@lists.freedesktop.org>; James (Qian) Wang
> > <james.qian.wang@arm.com>; Ben Skeggs <bskeggs@redhat.com>;
> > linux-arm-msm <linux-arm-msm@vger.kernel.org>; Intel Graphics
> > Development <intel-gfx@lists.freedesktop.org>;
> > intel-gvt-dev@lists.freedesktop.org; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; Christian K=C3=B6nig
> > <christian.koenig@amd.com>; Alex Deucher <alexander.deucher@amd.com>;
> > freedreno@lists.freedesktop.org
> > Subject: Re: [Intel-gfx] [PATCH v2] drm: prefix header search paths wit=
h
> > $(srctree)/
> >
> > On Fri, 26 Apr 2019 at 11:46, Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > Hi.
> > >
> > >
> > > On Fri, Mar 29, 2019 at 8:37 PM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > > >
> > > > Currently, the Kbuild core manipulates header search paths in a cra=
zy
> > > > way [1].
> > > >
> > > > To fix this mess, I want all Makefiles to add explicit $(srctree)/ =
to
> > > > the search paths in the srctree. Some Makefiles are already written
> > in
> > > > that way, but not all. The goal of this work is to make the notatio=
n
> > > > consistent, and finally get rid of the gross hacks.
> > > >
> > > > Having whitespaces after -I does not matter since commit 48f6e3cf5b=
c6
> > > > ("kbuild: do not drop -I without parameter").
> > > >
> > > > [1]: https://patchwork.kernel.org/patch/9632347/
> > > >
> > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> > > > ---
> > > >
> > > > I put all gpu/drm changes into a single patch because
> > > > they are trivial conversion.
> > > >
> > > > If you are interested in the big picture of this work,
> > > > the full patch set is available at the following URL.
> > > >
> > > >
> > git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.g
> > it build-test
> > >
> > >
> > > Is somebody taking care of this?
> > >
> >
> > Are you expecting this to be merged in the drm tree? if so please
> > indicate that when posting.
>
>
> Sorry for unclearness.
>
> Could you apply this to your drm tree?
>
> Thanks.
>
>
>
>
> > I'd assumed this would go via kbuild tree.
> >
> > If the later,
> > Acked-by: Dave Airlie <airlied@redhat.com>
> > Dave.
