Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447C6ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BD82067B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgcxoFlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfJGP5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:57:41 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:40127 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfJGP5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:57:40 -0400
Received: by mail-wr1-f50.google.com with SMTP id h4so7234787wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pv3zbzHRa52jlg0ha3vzroZyZv2t03ZKCGOX1Q6sDuY=;
        b=GgcxoFlXi+10opvKk9r3xkS9Fe+6LhAhKpIdgDWee0bQNbfnkc15HaccnA/Xsrh7Jo
         FQbsk5iq02nE6EFzmTlg69Hx3XiQHMgUrCcGFy3YgnwUT91syhJHOGo+mAbJhA23dWhs
         f1S6dDl0S0i6+HuBLi6IDz6p5Y7KwCbOWHpFkL2LuzUvHdHqje1wbft7EhZ4NGOhRjep
         TwlZK2VbVksWFg6Nmd+glPEMdo8SlLAIXB6SELimT4miZ1AoaWR2QImtbUbifB8+2haW
         Wn2dEWLbQxRlaQ0IMhm4J/UjhcYNgsyQ62Xyi7Dm/oUzIJoFIQMrCj5fFuMQO8INimtq
         39AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pv3zbzHRa52jlg0ha3vzroZyZv2t03ZKCGOX1Q6sDuY=;
        b=Vi0hh3UYfVSOgjAgbGcCU2E9kugIkFU4g1z9KOqwx7vfUnetsjLDdRLbol/91Qv/Lg
         S/7Wb2/Brpr0MBTbcSrL85y29KW5nhXO1R6bjRINHmRUenBC8RRhUaNjOPSMaW6UXStN
         oGQ/lXiIA/RCfQUbxPzZjMJtWqkE3OnwU0vUrzwUidJP6nwlOB+GH+ja1FmhrOy6KPCB
         zqiHVldFxO8FDPFbwMRBWgikgFFyrXXcfVbnyGMv9MswXQl/Ka3Np//t0N2yIn69U9pU
         ECa+NU7zaaG7hWlfMM69O58oOL/tQIqss3EMgNa7YnHYkOcZdEPW6XlOqyDg+E4Hribg
         4qUg==
X-Gm-Message-State: APjAAAX+CkKsDeu9HMaHgenExt3lQbyUTHI3TS9moCMlie/JoODNLOyW
        sBYba0OBaVY4pkUX9x3wQB7n6MYF3zL/cLqAPFo=
X-Google-Smtp-Source: APXvYqw/4ecyBOzTC2pj7nSYubj1XPsTw7OxMpAZa1s6+UKfxUBqhUAlxlmmXQImS7B42KVKV9Jx8B87HepbEix+NQ0=
X-Received: by 2002:adf:fc07:: with SMTP id i7mr8227762wrr.50.1570463858274;
 Mon, 07 Oct 2019 08:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191006105735.60708-1-yuehaibing@huawei.com> <db644945-24df-7d67-7fc6-880833466593@amd.com>
In-Reply-To: <db644945-24df-7d67-7fc6-880833466593@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Oct 2019 11:57:26 -0400
Message-ID: <CADnq5_M_c90Gd0w4Hp+xChdYjxCE4=nVogsntVD+vd3U4+N36A@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: remove set but not used variable 'core_freesync'
To:     Harry Wentland <hwentlan@amd.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        "Koo, Anthony" <Anthony.Koo@amd.com>,
        "Cyr, Aric" <Aric.Cyr@amd.com>,
        "Harmanprit.Tatla@amd.com" <Harmanprit.Tatla@amd.com>,
        "bayan.zabihiyan@amd.com" <bayan.zabihiyan@amd.com>,
        "Othman, Ahmad" <Ahmad.Othman@amd.com>,
        "Amini, Reza" <Reza.Amini@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 10:06 AM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-10-06 6:57 a.m., YueHaibing wrote:
> > Fixes gcc '-Wunused-but-set-variable' warning:
> >
> > rivers/gpu/drm/amd/amdgpu/../display/modules/freesync/freesync.c:
> >  In function mod_freesync_get_settings:
> > drivers/gpu/drm/amd/amdgpu/../display/modules/freesync/freesync.c:984:24:
> >  warning: variable core_freesync set but not used [-Wunused-but-set-variable]
> >
> > It is not used since commit 98e6436d3af5 ("drm/amd/display: Refactor FreeSync module")
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Applied.  Thanks!

Alex

> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > index 9ce56a8..237dda7 100644
> > --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > @@ -981,13 +981,9 @@ void mod_freesync_get_settings(struct mod_freesync *mod_freesync,
> >               unsigned int *inserted_frames,
> >               unsigned int *inserted_duration_in_us)
> >  {
> > -     struct core_freesync *core_freesync = NULL;
> > -
> >       if (mod_freesync == NULL)
> >               return;
> >
> > -     core_freesync = MOD_FREESYNC_TO_CORE(mod_freesync);
> > -
> >       if (vrr->supported) {
> >               *v_total_min = vrr->adjust.v_total_min;
> >               *v_total_max = vrr->adjust.v_total_max;
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
