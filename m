Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0B9CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD41E2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fgcbUMOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390820AbfJWJQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:16:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37392 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390436AbfJWJQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:16:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id e11so12491985wrv.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 02:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eywcCaEl0jz6RGI5YWFAlnC1Cla8qjgA+dIAqYIUG7Y=;
        b=fgcbUMOFI8gUtVdMcTlFTKeyAVQfLshXZQANnWPhoGkW80jfOfruzvvp7zk+Vn1KOI
         8Q9j4ZI7cYxWWDdgqmbpPLx8jydPFisGCcnEayTl95BJUqOhn2KZgruUhepU0CJ6ks4c
         hBIPkxAnWKGsgtZ4NuRj6lgzwNAS7w6rR84jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=eywcCaEl0jz6RGI5YWFAlnC1Cla8qjgA+dIAqYIUG7Y=;
        b=ZX0e2zd3O7s9Xuy16fKtPljTZB6wXAQ7vxNsvFgi/17Lka3jBN4JUqd83pyTe7oZ/2
         jGL1NWLwbHwc8S5SqiTIyYYcaV+NDCiRiq6YAg9UKr2yY2LPB93Ut27kyN9Q6yWtE3hR
         fslrKz0ZhDyN7vfqdblOlHxL7uPiAk4iiDs5Ws7681W6iOU1Naz5vgAGfWVPvqu2ylYX
         xoQhEfytD0rv4OTaBBifZRGcpfs4u/Dtk9aLzpalA9Fl4xmbT2nB0WtA6D82hYcIzc/q
         6E7QX+TEM+G4tXKqjjsdLIdaBY1fYLVyfTyyyul3A3pJQaY5ASCY4h9tN8JVu1TCmnxR
         ZCaA==
X-Gm-Message-State: APjAAAVJ1VlBqKHpRpkZ29mFWgbxWB6wIx8YPRwMe9Hbvijg2XKfgAY7
        oGBjdZw7DP6y7dMDRHASVFKp8Q==
X-Google-Smtp-Source: APXvYqyaF98maFdt+uzC2JWe68HL1C0ih9eBMEV/s9zDffMzTcLVvCxAL3+nYdCjPic9cQVAZAjlQQ==
X-Received: by 2002:a5d:424a:: with SMTP id s10mr7122969wrr.108.1571822164224;
        Wed, 23 Oct 2019 02:16:04 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id c16sm7802240wrw.32.2019.10.23.02.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:16:03 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:16:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/v3d: Fix memory leak in v3d_submit_cl_ioctl
Message-ID: <20191023091601.GX11828@phenom.ffwll.local>
Mail-Followup-To: Navid Emamdoost <navid.emamdoost@gmail.com>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20191021185250.26130-1-navid.emamdoost@gmail.com>
 <20191022093654.GF11828@phenom.ffwll.local>
 <CAEkB2ETFM7u6YiUOT3fz4UQ3U_za9iM1arTnYNg-rjs5+wxOfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkB2ETFM7u6YiUOT3fz4UQ3U_za9iM1arTnYNg-rjs5+wxOfw@mail.gmail.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:53:57PM -0500, Navid Emamdoost wrote:
> On Tue, Oct 22, 2019 at 4:36 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Mon, Oct 21, 2019 at 01:52:49PM -0500, Navid Emamdoost wrote:
> > > In the impelementation of v3d_submit_cl_ioctl() there are two memory
> > > leaks. One is when allocation for bin fails, and the other is when bin
> > > initialization fails. If kcalloc fails to allocate memory for bin then
> > > render->base should be put. Also, if v3d_job_init() fails to initialize
> > > bin->base then allocated memory for bin should be released.
> > >
> > > Fixes: a783a09ee76d ("drm/v3d: Refactor job management.")
> > > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > > ---
> > >  drivers/gpu/drm/v3d/v3d_gem.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> > > index 5d80507b539b..19c092d75266 100644
> > > --- a/drivers/gpu/drm/v3d/v3d_gem.c
> > > +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> > > @@ -557,13 +557,16 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
> > >
> > >       if (args->bcl_start != args->bcl_end) {
> > >               bin = kcalloc(1, sizeof(*bin), GFP_KERNEL);
> > > -             if (!bin)
> > > +             if (!bin) {
> > > +                     v3d_job_put(&render->base);
> >
> > The job isn't initialized yet, this doesn't work.
> Do you mean we have to release render via kfree() here?
> 
> >
> > >                       return -ENOMEM;
> > > +             }
> > >
> > >               ret = v3d_job_init(v3d, file_priv, &bin->base,
> > >                                  v3d_job_free, args->in_sync_bcl);
> > >               if (ret) {
> > >                       v3d_job_put(&render->base);
> >
> > v3d_job_put will call kfree, if you chase the callchain long enough (in
> > v3d_job_free). So no bug here, this would lead to a double kfree and
> > crash.
> Yes, v3d_job_put() takes care of render,
> 
> > -Daniel
> >
> > > +                     kfree(bin);
> but how about leaking bin?

Sorry, I totally missed that this is bin, no render. Patch looks correct
to me.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
> > >                       return ret;
> > >               }
> > >
> > > --
> > > 2.17.1
> > >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> 
> 
> 
> -- 
> Navid.

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
