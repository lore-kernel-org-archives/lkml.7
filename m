Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F71CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56FC21D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYW0esZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfJYTgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:36:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40236 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfJYTgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:36:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id o28so3615123wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 12:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vKgsFbx8Ep6iOXlXatCgfl2QJqYHidBhx0D+NEJMyLo=;
        b=OYW0esZZ6B8EKsDTY2vGfRPRy99SJ3ZPr9FUu3Pu00ygV96AVxKm2XvVThu2GBAKBE
         IP8FqmojtSAn97B4Lnko6Vl/CndCsFkjQRCZk0Qxwx9aYtaPvvzHsKjf1zUQjW0VfNR/
         WtSXgiVb0XdlwJ/9mBbEY/qE/44PoZJUbuVFtiHJjj/PSHL4+SSu77q6wDgeS91MArDg
         CFKAaEIYWSsWWAjy1u4icShmr+I5DJekVSuWShrkT7XD0obab0nMc9O4eML32tB31tqm
         ebfh++CM8OfUbK+c4gTIw2SnurUjVhfdzazZWgqY7dIsctZ870wOjpFN4wqwrhNzpQnM
         5eXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKgsFbx8Ep6iOXlXatCgfl2QJqYHidBhx0D+NEJMyLo=;
        b=C46SxJantUuFypDvOJzasKcYrL80UEElq4HadrjO4UhqzLmF5nhk0a1gTxPZARAttd
         tQBEutpAm7p+RVQYvOFwOzCzZCUDN3tDBStU0WHNqe8U8DwGtcGqSaj7GvG6KqppKBHP
         hZjXpK9YErKziB7U+l5JFrywS/9hyzq3xN586SQqaIRbqumDu4fE4vUftvFza6926xEB
         397T5MVx7EP7DWENwv40TtLMl+8xCUBGLzTyj3uueqErf7QyQxW4DZNLWr+nedGwuGrK
         0BuNliRKRIhq/siNY47PxdjI2rplCAVQhVyDG5RQk7nB4rgbFb2JSsERwVWCBbffL8cF
         0TZw==
X-Gm-Message-State: APjAAAVcUObpO893re+9Nt988Q4y5njFR1fiUtXxfi1sduwZdzIdVTEW
        CG2VHewKj6+TIXgTc2/JBjRWkXkSzCxU/jn2EBk=
X-Google-Smtp-Source: APXvYqwMDwW4AyIxm3bcNrPMq1dwCxnVICIYRR/Y5+vKCesA43Yg/x9R3k2Irdc3Pwz6VVvg8ChPIZGNsdg/LFMO7nw=
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr4661857wrw.206.1572032195543;
 Fri, 25 Oct 2019 12:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191019073242.21652-1-wambui@karuga.xyz> <2bed3fab-e84d-226d-b552-1ac088fc5d9c@amd.com>
In-Reply-To: <2bed3fab-e84d-226d-b552-1ac088fc5d9c@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 25 Oct 2019 15:36:23 -0400
Message-ID: <CADnq5_PeCmE-rmUaVDXtLNi20aMzYkeoLUtxHr9yT7P0Nix+qw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: remove assignment for return value
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Wambui Karuga <wambui@karuga.xyz>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "outreachy-kernel@googlegroups.com" 
        <outreachy-kernel@googlegroups.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Oct 23, 2019 at 11:09 AM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-10-19 3:32 a.m., Wambui Karuga wrote:
> > Remove unnecessary assignment for return value and have the
> > function return the required value directly.
> > Issue found by coccinelle:
> > @@
> > local idexpression ret;
> > expression e;
> > @@
> >
> > -ret =
> > +return
> >      e;
> > -return ret;
> >
> > Signed-off-by: Wambui Karuga <wambui@karuga.xyz>
>
> Thanks for your patch.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
>
> > ---
> >  drivers/gpu/drm/radeon/cik.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
> > index 62eab82a64f9..daff9a2af3be 100644
> > --- a/drivers/gpu/drm/radeon/cik.c
> > +++ b/drivers/gpu/drm/radeon/cik.c
> > @@ -221,9 +221,7 @@ int ci_get_temp(struct radeon_device *rdev)
> >       else
> >               actual_temp = temp & 0x1ff;
> >
> > -     actual_temp = actual_temp * 1000;
> > -
> > -     return actual_temp;
> > +     return actual_temp * 1000;
> >  }
> >
> >  /* get temperature in millidegrees */
> > @@ -239,9 +237,7 @@ int kv_get_temp(struct radeon_device *rdev)
> >       else
> >               actual_temp = 0;
> >
> > -     actual_temp = actual_temp * 1000;
> > -
> > -     return actual_temp;
> > +     return actual_temp * 1000;
> >  }
> >
> >  /*
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
