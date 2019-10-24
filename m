Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C2CCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98216222CE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ce2z1v+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502133AbfJXMtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:49:49 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34877 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502121AbfJXMts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:49:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id z6so20542490otb.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 05:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PyaL5FR9d/jZB2FfWAIqD9mvnFhdj/C8GIiTAS5nB5E=;
        b=Ce2z1v+kSoWNglTt3WTllLp6U0xvVrQ58wmZZsFzSkJD2t3+lWNZy085pZDtxpY+zJ
         rUcaX977WLwXD5060KJzO2dq3EKxq+VND5w7OMOxURBBF+OASxA/W2pSivJdHp+2QiQp
         +cFIcuPS1SLujURbUtaSktkgsNnlh5lM3TVFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PyaL5FR9d/jZB2FfWAIqD9mvnFhdj/C8GIiTAS5nB5E=;
        b=brI76p/xzs/u3typkjHDndoaApLBLBvvx98tyfQEKgRfhXHDEcc9novAky/6DjTa6t
         /4WKxo4+gkBE4XfkHUHajMMUvrDCr88fqNAdhf9edw5rvFs1VDnotrpSbq4OswG9RjLE
         kzyabcXpu/JBnKWsiQwUPWx/+B0V+cL8PajEbezQU4vzpt0H/qgPvpwm/G9ljhpGUSEJ
         VqC9czEF1LMQI1clyTgAAQfnDGCuT2jJXtGU/yEwRecs5R8pOiJEzHNo6JSlyL8Ma25u
         gDrDKxkdsEHcUQApHCv962jhU6aK2Y5syccCuSRNB1OgVvNmjYbgdlyEwuqteFnGsJdi
         tcNQ==
X-Gm-Message-State: APjAAAUbZ2xmhujqmMsGMg9elsqKsoFBoeSGa2cG6iatCnfIt1VR44EH
        +ohtBwgK2UoM89l6GGMj5zZ0lj1hYZpmBwQOAOxIST6f
X-Google-Smtp-Source: APXvYqyBIm/+WjVbGnSqvCqrpKyxMyAB4TFsKoUFfjuFU1JyyjPDGC0E5vf2MNMJj7EyC3WH+PQTxnzIDxkDciHoSKo=
X-Received: by 2002:a9d:b92:: with SMTP id 18mr12068647oth.188.1571921387385;
 Thu, 24 Oct 2019 05:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191024104801.3122-1-colin.king@canonical.com>
 <20191024123853.GH11828@phenom.ffwll.local> <821f0799-1f37-c853-d2c6-dd95883e02d8@canonical.com>
In-Reply-To: <821f0799-1f37-c853-d2c6-dd95883e02d8@canonical.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 24 Oct 2019 14:49:36 +0200
Message-ID: <CAKMK7uGbMx21+g2kQyGu5H-L7N-guKJhsZ6b1ROnz5+kDRt3LA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/v3d: fix double free of bin
To:     Colin Ian King <colin.king@canonical.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Sean Paul <sean@poorly.run>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Iago Toral Quiroga <itoral@igalia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 2:43 PM Colin Ian King <colin.king@canonical.com> wrote:
>
> On 24/10/2019 13:38, Daniel Vetter wrote:
> > On Thu, Oct 24, 2019 at 11:48:01AM +0100, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> Two different fixes have addressed the same memory leak of bin and
> >> this now causes a double free of bin.  While the individual memory
> >> leak fixes are fine, both fixes together are problematic.
> >>
> >> Addresses-Coverity: ("Double free")
> >> Fixes: 29cd13cfd762 ("drm/v3d: Fix memory leak in v3d_submit_cl_ioctl")
> >> Fixes: 0d352a3a8a1f (" rm/v3d: don't leak bin job if v3d_job_init fails.")
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >
> > That sounds like wrong merge resolution somewhere, and we don't have those
> > patches merged together in any final tree yet anywhere. What's this based
> > on?
> > -Daniel
>
> linux-next

Ok adding Stephen. There's a merge conflict between drm-misc-fixes and
drm-next (I think) and the merge double-added the kfree(bin). See
above for the relevant sha1. Dave is already on here as a heads-up,
but also adding drm-misc maintainers.

Cheers, Daniel

>
> Colin
> >
> >> ---
> >>  drivers/gpu/drm/v3d/v3d_gem.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> >> index 549dde83408b..37515e47b47e 100644
> >> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> >> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> >> @@ -568,7 +568,6 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
> >>              ret = v3d_job_init(v3d, file_priv, &bin->base,
> >>                                 v3d_job_free, args->in_sync_bcl);
> >>              if (ret) {
> >> -                    kfree(bin);
> >>                      v3d_job_put(&render->base);
> >>                      kfree(bin);
> >>                      return ret;
> >> --
> >> 2.20.1
> >>
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
