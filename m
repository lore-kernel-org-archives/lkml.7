Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D95C47E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95531217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Zb6XWmzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfKFR4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:56:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41001 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfKFR4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:56:25 -0500
Received: by mail-ot1-f65.google.com with SMTP id 94so21573289oty.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVNAkLALcXf3ECseCh6fIvYcw+YM/ecsEduyd+L1OzY=;
        b=Zb6XWmzK5jZjbch2MifX0aU6MslUtqvH7JbhSPtSBmHPH66O7HbtFoy6LpphJKLUwB
         723tGBxQfPxaoBW6PpvIpwg6lf3XhiiVWKXW1UzkcxiMbWml24UT3FTI+Lageu5vNGFT
         INVLdgOdIaQLo3ou/yTt8IgVtwT6MW23mq+KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVNAkLALcXf3ECseCh6fIvYcw+YM/ecsEduyd+L1OzY=;
        b=jNeSt/VnX/h8Pm2DFqFQ0m5T0mEaTw++KpOsZj/iMLl9hBZYdMF1bca4ZNtVMlKe4O
         Uo991kD18VKXpRHeUeWYqgJ2gQAhnDtOc9TCN57/Qq+12Hw4+m2bi+NoWGoeoPUGtNPw
         w6ar0zU749dkLdHVOceUHVMXSMreTcL2D4UbW0WO2ogjVn9cYOchqiMvzbNP58C1uf3l
         Big+a5DdJM7Ymt9/hs/cn84U8DlIfqb7Otb3joGmKslB3pPBfq4E6XnVly0eXYgy8Oc6
         NX5OjKxJoGZYSWk94fQWs4Ugx5DDPDKeMjPiDTzUxjnFmga822YA4gLa7tTSd6VyjhfN
         D2cw==
X-Gm-Message-State: APjAAAWmBPk6EAfKOvbHiT04oaBUCxrRzrAwyl4Ky0HnfiRiy/ciqEWM
        QeBuQIzPiRvFiYGYjjdIQ2u2mRk7L03mKwaUD2gDjw==
X-Google-Smtp-Source: APXvYqzxbABqhuHazS+yjloa/OpTTnWvOIpez+z4/iPCKEvqK9ko+QH4PbBYKrqM2WqcfHeTeq609guGaPY66JUrYAc=
X-Received: by 2002:a9d:62d8:: with SMTP id z24mr2924164otk.188.1573062983862;
 Wed, 06 Nov 2019 09:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20191106164755.31478-1-daniel.vetter@ffwll.ch> <201911060920.71D7E76E@keescook>
In-Reply-To: <201911060920.71D7E76E@keescook>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 6 Nov 2019 18:56:12 +0100
Message-ID: <CAKMK7uGq5o+jj-YigTomfx2XEHh5eUjnKD70Trkc6opZOViUHg@mail.gmail.com>
Subject: Re: [PATCH] drm: Limit to INT_MAX in create_blob ioctl
To:     Kees Cook <keescook@chromium.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 6:24 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Nov 06, 2019 at 05:47:55PM +0100, Daniel Vetter wrote:
> > The hardened usercpy code is too paranoid ever since:
> >
> > commit 6a30afa8c1fbde5f10f9c584c2992aa3c7f7a8fe
> > Author: Kees Cook <keescook@chromium.org>
> > Date:   Wed Nov 6 16:07:01 2019 +1100
> >
> >     uaccess: disallow > INT_MAX copy sizes
> >
> > Code itself should have been fine as-is.
>
> I had to go read the syzbot report to understand what was actually being
> fixed here. Can you be a bit more verbose in this commit log? It sounds
> like huge usercopy sizes were allowed by drm (though I guess they would
> fail gracefully in some other way?) but after 6a30afa8c1fb, the copy
> would yell about sizes where INT_MAX < size < ULONG_MAX - sizeof(...) ?

The WARNING seems to have been the only bad effect. I guess in
practice the real big stuff fails at memory allocation time, but
shouldn't overflow. Or maybe I still don't get how this C thing works.
Anyway I figured the cited patch is good enough, userptr copies >
INT_MAX aren't allowed anymore, so we need to adjust our overflow
checks.
-Daniel

> What was the prior failure mode that made the existing ULONG_MAX check
> safe? Your patch looks fine, though:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> > Reported-by: syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com
> > Fixes: 6a30afa8c1fb ("uaccess: disallow > INT_MAX copy sizes")
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > --
> > Kees/Andrew,
> >
> > Since this is -mm can I have a stable sha1 or something for
> > referencing? Or do you want to include this in the -mm patch bomb for
> > the merge window?
>
> Traditionally these things live in akpm's tree when they are fixes for
> patches in there. I have no idea how the Fixes tags work in that case,
> though...
>
> -Kees
>
> > -Daniel
> > ---
> >  drivers/gpu/drm/drm_property.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
> > index 892ce636ef72..6ee04803c362 100644
> > --- a/drivers/gpu/drm/drm_property.c
> > +++ b/drivers/gpu/drm/drm_property.c
> > @@ -561,7 +561,7 @@ drm_property_create_blob(struct drm_device *dev, size_t length,
> >       struct drm_property_blob *blob;
> >       int ret;
> >
> > -     if (!length || length > ULONG_MAX - sizeof(struct drm_property_blob))
> > +     if (!length || length > INT_MAX - sizeof(struct drm_property_blob))
> >               return ERR_PTR(-EINVAL);
> >
> >       blob = kvzalloc(sizeof(struct drm_property_blob)+length, GFP_KERNEL);
> > --
> > 2.24.0.rc2
> >
>
> --
> Kees Cook



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
