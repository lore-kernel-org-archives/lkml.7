Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0FDECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC32920679
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAkfGW2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfJGP4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:56:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36845 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfJGP4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:56:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so15974239wrd.3;
        Mon, 07 Oct 2019 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKl/PfgKAr8YhYEpS+YymS2q68h7uKqU67+A+i7H4JI=;
        b=JAkfGW2fPhaHwu0r9uGVsSnnwKsartCh6UKqSuYnahS/t+YLlfImE2qxkw0cKF1IuD
         k8ym2ZMJljbeH0v2fLjNn0tx29Pyi1Kjmxr0QJnPF4ppQmP39wc21eO5wxswpJ5FrOA7
         Pn1d5rIc42LYilntEcM6NsrZxRShz3m2TO3SpXLqNNq7CmgBc532yIy7+RzubAMwjbaZ
         bOEBt2Oo7IQ1B5ROl4U+YyNc+DKU8HfWBT9iCMPsyrY4aSI2ywXr4yJ4KVpdDPEvTp6t
         LHqxKeFN5iLPeCYKWvCeuoxU3gEOxfKG/b6D6GYjg1Uu0fYdMDrJfXUP3F6XJmGrw1Aj
         wWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKl/PfgKAr8YhYEpS+YymS2q68h7uKqU67+A+i7H4JI=;
        b=Eg0JuFM3DNIqjb1pINgN8tFwJna0MB/hSUE7+BxBfu73J4n2WNSy5ILcs7cz2DNz7N
         DlYAE/52fm6vcAs5DHLHMWpgj9RvsgQRg4pc0bPJN1vA9F7pjzHq/8QLWWwr/JBEnyeP
         QoEDqrQbkAPfaEck2NqZkuTGSOwzpmt4focLZw8t87bJW5XRE9tk7Wj+Ppn0QA5hW9ZC
         KflEAg4iONoxEsPt9nrRrA4wFQozVgp+xCnwLVIxXUIOwnwcjd7PzjYTuBvuMg4YhWK6
         ProHcupv0uEOSg0kLGim1GdkFvqV7Wy7gK5fHQZp5il+VAvcB+/hqbB7tugq4WNd0m3g
         OxYQ==
X-Gm-Message-State: APjAAAXH2mj1Xfg5zwoffNTA+qdw0rQpHiGajc6cH0flF7zO9u1+DAi+
        N+6wn5ORLboIAtDofqVMm95tgO7NsDkj3siBNz0=
X-Google-Smtp-Source: APXvYqzWRusk54BRlh8Vj4kcGxAB4PQIYCfS3CJJZ8LD48feZ0ZtBtZKhBITIHTmurRV0B3SD7aw+dSJ7U9VUoYljLo=
X-Received: by 2002:adf:fc07:: with SMTP id i7mr8222186wrr.50.1570463770859;
 Mon, 07 Oct 2019 08:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191005113205.14601-1-christophe.jaillet@wanadoo.fr> <04e006aa-a354-dfe3-3d13-d674c662c300@amd.com>
In-Reply-To: <04e006aa-a354-dfe3-3d13-d674c662c300@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Oct 2019 11:55:58 -0400
Message-ID: <CADnq5_NhypGdi6z78BbWimAZVtEDxhe1Rw=D4p7JPQNH0Kdqyw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix typo in some comments
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 10:13 AM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-10-05 7:32 a.m., Christophe JAILLET wrote:
> > p and g are switched in 'amdpgu_dm'
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Applied.  thanks!

Alex

>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 92932d521d7f..b9c2e1a930ab 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -1043,7 +1043,7 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
> >
> >  /**
> >   * dm_hw_init() - Initialize DC device
> > - * @handle: The base driver device containing the amdpgu_dm device.
> > + * @handle: The base driver device containing the amdgpu_dm device.
> >   *
> >   * Initialize the &struct amdgpu_display_manager device. This involves calling
> >   * the initializers of each DM component, then populating the struct with them.
> > @@ -1073,7 +1073,7 @@ static int dm_hw_init(void *handle)
> >
> >  /**
> >   * dm_hw_fini() - Teardown DC device
> > - * @handle: The base driver device containing the amdpgu_dm device.
> > + * @handle: The base driver device containing the amdgpu_dm device.
> >   *
> >   * Teardown components within &struct amdgpu_display_manager that require
> >   * cleanup. This involves cleaning up the DRM device, DC, and any modules that
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
