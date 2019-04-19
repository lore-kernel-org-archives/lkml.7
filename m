Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1AAC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A7720821
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhVHUIIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfDSTLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:11:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33596 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfDSTLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:11:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so9512786wmi.0;
        Fri, 19 Apr 2019 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GNJ3RkMrKl9P9lQidkVLtKmlmIRdvnXQ085gf79FKuM=;
        b=ZhVHUIIP71BZcbTpkDSMuPa5xRArGlGJRjS+p76q6KXAb8VRS5hiq7P27kIQkweV4z
         oi+Y/l6eMcNF92QfpZOwH62UTQVRuQqrFuQhxX91OWKrNBD3pKBqXAyGt+BlvhwI9vAc
         U5Lmz4CWZxG2oDKgU7hsXQDx/xXaEMA+ZP37+wMRa2FYW77IliKFKTIjYr57thek2TA8
         zv4BFcE1fQmV5Eh+zTN9+rEmXDFV1nhpQXcmM4edbD6ar4CGaEUso2qH9tPTm58it5dJ
         A2nm6qW7k43RbrjTrvwx7xhyKIzQbqxKfD/wxz0T0jgn4HxALoNTXK3I8BDok0NwCG2c
         FA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GNJ3RkMrKl9P9lQidkVLtKmlmIRdvnXQ085gf79FKuM=;
        b=NaApZFGAxsIjLEsJRFPfiS4zQ7CshIyftlOAWWsQkngQ0H6y5WgWQtkERNbN45sIyI
         z7noYmvuf19gZVH/N0/R4CYncZJggvR62T2eGhXPB2LdedESHlrtoUxxMrg1weQHrR+Z
         jcrbe/L7F8kBcnyK8aoHGybV/rISTLX6zZJwyT+eX5PPRvVnpQqMXvlsX6Wz8sv2LVSz
         D9VjfUAKN7KMzmY1sFI2VMgHcByuyh9r5lZfMHUxSFhL9qTni3xbRvNZD60L8tHBRotr
         h2GvE0r05EmmyyU+y0CXDbs0rl8kz7RZzxiHh/P1eHJbJON/q3lm9h4X9Hv+vnhfihYu
         QZPA==
X-Gm-Message-State: APjAAAXCm6vq2uhim/IvwRQZ7CVkOQ7XwnfNNfLzDHFZuz8EAeaTrn3H
        xVojzzQanDFjmS/Fv40FHfImEFEtGyrbh1HosUTnOJZKMt4=
X-Google-Smtp-Source: APXvYqzSakJPKmc9VC7mybutyXNBb/6fydFdOSMz+peR/eoLYsAi6czX2xOPoKeMNR9TQLEp998V8gU4wmyQPAsobYI=
X-Received: by 2002:a1c:a64d:: with SMTP id p74mr2854468wme.89.1555686237736;
 Fri, 19 Apr 2019 08:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190416115926.32669-1-colin.king@canonical.com> <2849eabb-6f89-08b9-4537-b75971b205bd@codeaurora.org>
In-Reply-To: <2849eabb-6f89-08b9-4537-b75971b205bd@codeaurora.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 19 Apr 2019 11:03:45 -0400
Message-ID: <CADnq5_M-bLsJH9VCE17xBSgnay5CKfVhGDQxm5H7vH=NkVVe2w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix spelling mistake "gateing" -> "gating"
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Colin King <colin.king@canonical.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 3:04 AM Mukesh Ojha <mojha@codeaurora.org> wrote:
>
>
> On 4/16/2019 5:29 PM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is a spelling mistake in a DRM_INFO message. Fix it.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>


Applied.  thanks!

Alex

>
> Cheers,
> -Mukesh
> > ---
> >   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> > index bed78a778e3f..40363ca6c5f1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> > @@ -283,7 +283,7 @@ static int vce_v2_0_stop(struct amdgpu_device *adev)
> >       }
> >
> >       if (vce_v2_0_wait_for_idle(adev)) {
> > -             DRM_INFO("VCE is busy, Can't set clock gateing");
> > +             DRM_INFO("VCE is busy, Can't set clock gating");
> >               return 0;
> >       }
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
