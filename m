Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561F3C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3472721A4C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfJBPjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:39:43 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43859 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfJBPjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:39:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id h126so15425941qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 08:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N9xgxObyHlo32PssmGV4PbxM2Gv46DJwY2CihzT//HU=;
        b=hp3/XGu2+owEKBNxFkdkvNZ6pHXmtFmq8YlPiwmaNWCMttgEdGz0efXtezl1iNae9R
         eTE7pYGu/g+h2mXu9KY/pjKR2uahjtreNC2RAcMFlvsI/seZQBZbswZmXCeC70jRWVol
         4M2Xf2uixThQqfCQO9tl/XE4/BPUKPMGMbSVRsExhCcaSwdDb4eUHtFfuvcv3RISMCce
         xgEtIFAmgF9Neupp9n+R543SMnToXyB/57867AAiLGXydmZmuLLlH+6EMcT0btZR0HTW
         yKbw8jI1qFROEHFEBX0m7NXQr6vCqhSgCbqowHXPX9jZKpHXmO+md8XT6C/9zpPBQGI0
         RZ1Q==
X-Gm-Message-State: APjAAAWRTcC0hK/izrqWfAz+SYvFTpwxpbuNPaJycZT5hWHPu3Fpe2+V
        kVqQkXVTOrAcVglSrI6Sf1nrXk5lUI9ne0i74sY=
X-Google-Smtp-Source: APXvYqxIIie+ioLh/sY/tvwAt7uW3G9LAGSG/pVeE7kRPGqPrqsGloWfg5qjshHoZxBwIbW08vbocy/QOIw3DfO4kPY=
X-Received: by 2002:ae9:f503:: with SMTP id o3mr4266633qkg.3.1570030780522;
 Wed, 02 Oct 2019 08:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191002120136.1777161-1-arnd@arndb.de> <20191002120136.1777161-5-arnd@arndb.de>
 <CADnq5_PkTwTBbQY9JatZD2_sWjdU5_hK7V2GLfviEvMh_QB12Q@mail.gmail.com>
 <CAK8P3a0KMT437okhobg=Vzi5LRDgUO7L-x35LczBGXE2jYLg2A@mail.gmail.com> <CADnq5_PWWndBomBOXTYgmFqo+U8f8d8+OdJ5Ym3+a2mgO5=E0A@mail.gmail.com>
In-Reply-To: <CADnq5_PWWndBomBOXTYgmFqo+U8f8d8+OdJ5Ym3+a2mgO5=E0A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 2 Oct 2019 17:39:24 +0200
Message-ID: <CAK8P3a05ZSWcw=XUZrLyjMLY7wCHLKhpe+MF9p5P3URWpAcj+A@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amd/display: fix dcn21 Makefile for clang
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 5:12 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> On Wed, Oct 2, 2019 at 10:51 AM Arnd Bergmann <arnd@arndb.de> wrote:

> >
> > Nothing should really change with regards to the -msse flag here, only
> > the stack alignment flag changed. Maybe there was some other change
> > in your Makefile that conflicts with my my patch?
>
> This patch on top of yours seems to fix it and aligns better with the
> other Makefiles:
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> index ef673bffc241..e71f3ee76cd1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> @@ -9,10 +9,10 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
>         cc_stack_align := -mstack-alignment=16
>  endif
>
> -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse
> $(cc_stack_align)
> +CFLAGS_dcn21_resource.o := -mhard-float -msse $(cc_stack_align)
>
>  ifdef CONFIG_CC_IS_CLANG
> -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -msse2
> +CFLAGS_dcn21_resource.o += -msse2
>  endif

Ok, so there is clearly a global change that went into your tree, or
is missing from it:

I see that as of linux-5.4-rc1, I have commit 54b8ae66ae1a ("kbuild: change
 *FLAGS_<basetarget>.o to take the path relative to $(obj)"), which changed
all these path names to include the AMDDALPATH.

It seems you are either on an older kernel that does not yet have this,
or you have applied another patch that reverts it.

       Arnd
