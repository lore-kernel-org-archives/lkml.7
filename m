Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0356C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E1621848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNkjivrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfJBQdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:33:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44070 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfJBQdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:33:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so7293968wrl.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 09:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oWuxqHH990fVUCMM6jqcLulz0ftwLl/bnFae9PcvIP8=;
        b=qNkjivrTES56/Lb0XjDQ2f1+acHL7hCLr0wo1luiHenEDywJXL0H9oRpRStksAoLOu
         5JkCuYENZAc9RXCSLMsmzgabPQRs4LhiuaYbYRJAe9eUEfHceNMGgaovwrUjcSHfSHh6
         85T7OExyO6u1EPyDwTWGIDgv1G8PSbgAEx31jc7IcJMfRJ2+2ywqGo6HQKn+8Zt0ZBOt
         qbwWhnmpWRB9toTjePUwj1LVIG9S9lQ4jyRNaDVj3HRjWBlc4SNGtU9J6G65kmpOg43T
         U96vCFcVMFlQsj/8k/okZgNE9btL+YGbfI30IFIj2fbd74xEHbRtOHDZqh7pNg/awCbb
         iczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWuxqHH990fVUCMM6jqcLulz0ftwLl/bnFae9PcvIP8=;
        b=mkiV4CB2KiZdVPcwowQz08qJx6pBRw7YDo/6mt34E8ZuEomkMx/5osw76PLe7HjX88
         yJHyehv80q3YUpM1lDokOe8+3K7BvmYZrFmGAKyvFQuCup2cNrChAzwbahXJ9eoe9c1P
         gGzk1X/w6E83hbqENEXkoxsK6yrXTfF1qdyabSgCgaxBYGTQstdCVdEbL86kKKLSco5g
         lfMrt3I6T2ib/DgjCWmnLhbEzN872yjNEQpVvAhe+ZPUXDR41q268iuuXvz2iXzrHPxg
         qD0q8WYR4XFkiBfFqgHXy9LF4O+1Klntq2uA6crNhcLT3eV7QLlUMYrVq0FEn88+tlx6
         bznw==
X-Gm-Message-State: APjAAAW7awyQxf7qzDmdw+bM9QXorslqKyc/6v5G10zchw6VvOxWH511
        fZ4jOMfg2Uwypo3WBzhcyMyujJL0c/Q5vR95UI0=
X-Google-Smtp-Source: APXvYqyJQ4kvU7WEh3bv0w5uz9bqzf9VG2CQeCEIBlVvoU8s61BA4sw5HD3OOn5Pew/wZJQal7k6gbo/0T3JrPsxt4c=
X-Received: by 2002:adf:e951:: with SMTP id m17mr3421662wrn.154.1570034020467;
 Wed, 02 Oct 2019 09:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191002120136.1777161-1-arnd@arndb.de> <20191002120136.1777161-5-arnd@arndb.de>
 <CADnq5_PkTwTBbQY9JatZD2_sWjdU5_hK7V2GLfviEvMh_QB12Q@mail.gmail.com>
 <CAK8P3a0KMT437okhobg=Vzi5LRDgUO7L-x35LczBGXE2jYLg2A@mail.gmail.com>
 <CADnq5_PWWndBomBOXTYgmFqo+U8f8d8+OdJ5Ym3+a2mgO5=E0A@mail.gmail.com> <CAK8P3a05ZSWcw=XUZrLyjMLY7wCHLKhpe+MF9p5P3URWpAcj+A@mail.gmail.com>
In-Reply-To: <CAK8P3a05ZSWcw=XUZrLyjMLY7wCHLKhpe+MF9p5P3URWpAcj+A@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Oct 2019 12:33:27 -0400
Message-ID: <CADnq5_M9H2R_6KnxutJ2F3ZkZ1FxqPufcyTxwcQ1cdWYFDbdLw@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amd/display: fix dcn21 Makefile for clang
To:     Arnd Bergmann <arnd@arndb.de>
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

On Wed, Oct 2, 2019 at 11:39 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Oct 2, 2019 at 5:12 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> > On Wed, Oct 2, 2019 at 10:51 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > >
> > > Nothing should really change with regards to the -msse flag here, only
> > > the stack alignment flag changed. Maybe there was some other change
> > > in your Makefile that conflicts with my my patch?
> >
> > This patch on top of yours seems to fix it and aligns better with the
> > other Makefiles:
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> > b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> > index ef673bffc241..e71f3ee76cd1 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> > @@ -9,10 +9,10 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
> >         cc_stack_align := -mstack-alignment=16
> >  endif
> >
> > -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse
> > $(cc_stack_align)
> > +CFLAGS_dcn21_resource.o := -mhard-float -msse $(cc_stack_align)
> >
> >  ifdef CONFIG_CC_IS_CLANG
> > -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -msse2
> > +CFLAGS_dcn21_resource.o += -msse2
> >  endif
>
> Ok, so there is clearly a global change that went into your tree, or
> is missing from it:
>
> I see that as of linux-5.4-rc1, I have commit 54b8ae66ae1a ("kbuild: change
>  *FLAGS_<basetarget>.o to take the path relative to $(obj)"), which changed
> all these path names to include the AMDDALPATH.
>
> It seems you are either on an older kernel that does not yet have this,
> or you have applied another patch that reverts it.

Ah, I don't have that patch yet in my tree.  That explains it.

Alex
