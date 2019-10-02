Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64841C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F3821783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWOsCp6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfJBVYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:24:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46845 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbfJBVYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:24:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so552115wrv.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A8w+FHe5743TtHJppD6AZXCm6HeNHuSZ/rMyNlKuO+I=;
        b=CWOsCp6RJXD5p63VAhR0/e8P4e16fm4w7VS+yzJkkbFkXb9HUBLq8eKopcqtC/YkfD
         sK6T9bTA7ZspZkR0XtuaCl9J2wpBdNcZZN9Wg8q9zGQK05aWY0+DmNZo9B5a4QVFV10g
         nbcBIOgOILYKWpb8umu36AazgoOTJSizgvatsXd+OvlCSU1ZjKDLtGYEZTU3czzmYMlH
         OtfNImw1iJK3z9mGecbMdqC+5eEyqIEIk7HZkzxwUK+kquDfBXhE2eNI6KAvJibVjNMz
         4DH4lZYz7TkY3NwARn61gA+Xj7IA7lu3j80mntK1f9iYThbSyfezx8GEy6mxNbvfqnBt
         5evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A8w+FHe5743TtHJppD6AZXCm6HeNHuSZ/rMyNlKuO+I=;
        b=VVYULpXADEaIbmdjtNyL1OgrhPs+qq2TSTUqadUzUZk/+Zd9la70dFoqYUsq8qKhrL
         YxZIcAWvheHbTarAP4BYdqLIHMW4HsYUbOxmp34BRtaQL6rwpV69gy5228jGQ+MMg4z7
         MJewB+KzB3iO9sgfKVsa28FNX9MzrhxiG0tdRDfY3CgeNSRmJf95e8M1hYflaOBses6a
         rhOf3mhiTuu6xoYfNdUyDIN0uXi7mlb3J7tmp7TsKess1G3zEY/alUsXEveyRZ6NsWW8
         pBVph6serBYKpL8xCWgsG+wfpZ2tTpjNDbwkbRe1V0C6o7RJYDeJhmIsC6nXeIHXCw73
         3GUw==
X-Gm-Message-State: APjAAAUDzCyrQmlxe5XXdIUicwofx0V/SVDa7PO6/rkm10UqKUwS4lWS
        qj5V5q+iu63e1m730bJsFdx3UcvsTUCKTfMFdK0=
X-Google-Smtp-Source: APXvYqwURm4pH78jPsrdQn+DZphGzmWgFOKtmQM5jeQCxCirfuJH7g/TlbaJQvO4fBWtdxeyzi7PwrH5nXwp/CAl4z8=
X-Received: by 2002:adf:f287:: with SMTP id k7mr4526852wro.206.1570051490794;
 Wed, 02 Oct 2019 14:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191002120136.1777161-1-arnd@arndb.de> <20191002120136.1777161-5-arnd@arndb.de>
 <CAKwvOdmjM80XP7VH83iLn=8mz6W1+SbXST2FChEnH0LSRRm4pA@mail.gmail.com>
In-Reply-To: <CAKwvOdmjM80XP7VH83iLn=8mz6W1+SbXST2FChEnH0LSRRm4pA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Oct 2019 17:24:37 -0400
Message-ID: <CADnq5_MyUp9OkqM+MUHZ8BpLEe5afBpAqOwQxDwAWgvVvqbpoQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amd/display: fix dcn21 Makefile for clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Leo Li <sunpeng.li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 5:19 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Wed, Oct 2, 2019 at 5:03 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Just like all the other variants, this one passes invalid
> > compile-time options with clang after the new code got
> > merged:
> >
> > clang: error: unknown argument: '-mpreferred-stack-boundary=4'
> > scripts/Makefile.build:265: recipe for target 'drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.o' failed
> >
> > Use the same variant that we have for dcn20 to fix compilation.
> >
> > Fixes: eced51f9babb ("drm/amd/display: Add hubp block for Renoir (v2)")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> (Though I think it's already been merged)
>
> Alex, do you know why the AMDGPU driver uses a different stack
> alignment (16B) than the rest of the x86 kernel?  (see
> arch/x86/Makefile which uses 8B stack alignment).

Not sure.  Maybe Harry can comment.  I think it was added for the
floating point stuff.  Not sure if it's strictly required or not.

Alex

>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> > index 8cd9de8b1a7a..ef673bffc241 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> > @@ -3,7 +3,17 @@
> >
> >  DCN21 = dcn21_hubp.o dcn21_hubbub.o dcn21_resource.o
> >
> > -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse -mpreferred-stack-boundary=4
> > +ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
> > +       cc_stack_align := -mpreferred-stack-boundary=4
> > +else ifneq ($(call cc-option, -mstack-alignment=16),)
> > +       cc_stack_align := -mstack-alignment=16
> > +endif
> > +
> > +CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse $(cc_stack_align)
> > +
> > +ifdef CONFIG_CC_IS_CLANG
> > +CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -msse2
> > +endif
> >
> >  AMD_DAL_DCN21 = $(addprefix $(AMDDALPATH)/dc/dcn21/,$(DCN21))
> >
> > --
> > 2.20.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191002120136.1777161-5-arnd%40arndb.de.
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
