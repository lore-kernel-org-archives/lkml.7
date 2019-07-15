Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FA8C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFD12081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMaNwLeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfGOPjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:39:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42358 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbfGOPji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:39:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so2612145wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ApxKfd4/dGSgTrlf0Sey/fxPy5xS/D0myVrb8BNCXsA=;
        b=NMaNwLeIMvQsJR44JNtC2Sq8RfJgsx5xO543hshM9QHe0ctJb4kViTaJ7OTSjIZGyQ
         mACZrfwA3mIAuomTBnxe4A7gnZYHwBxJTXB+38TWjWmAR/OS9kWcO/e4AJV/PhwGe+YJ
         qakkacr+rn7JU6580QnVLyMz6VKu1I/Y2+t+dhjGmiNiU+JnK05YrjIbDw7o4s0k7VOA
         UKIaf5vqaKIkfJhmdvAjcJmWuURDy+KLrXl/GyvvmegC1NiWuhw8KH+XbSMMKQbTthw5
         DqfJxZyfZ0bS4poC9Wt4E9G77BN1UNByCooZZZeRFi97Txz032rAuJPovELRtN4wpv+G
         WM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ApxKfd4/dGSgTrlf0Sey/fxPy5xS/D0myVrb8BNCXsA=;
        b=HfmYpKJV//3ZHU+5iAmzWY1lipV54gWGDDJ+VpDUWOLSBO0LzXnAIdbXPJFboEdiWX
         iJ3rhQuAVOJWRnJW8NCkm0gdioi7KfoD+KifUw6Wtwp8zJUHwk2XMcHFtzl7TqgO5k8D
         N6tik0AudSjrtbX7PTxlBLri6nfFib1zOQEKynZ6kJPr+Wq0voCIL+GdJ/xqzhFw38Qo
         YBarIdM19Ot4xEdbIv+OQ1HsTnYRHvGjuxaFTBGxQdzNldFX7A95MXsmXG8qrZiOi2th
         7LAhKpYPxmsPzQnmdZuGvAXaS0DPdzz4KDrKOvLPvNlENhfBWJeV39LxsajAG/PXbo9S
         u7eg==
X-Gm-Message-State: APjAAAVD87J+SjT3F7+ZWVLbJ4wLwwd28Odmj0c1pENY91XIXGzyoO7N
        r1Fd1oHD5VGQRQgXLF8EGg0=
X-Google-Smtp-Source: APXvYqzn8uIhzmrjHt7o/XOwvHMX9sErWPnWtKDLcyfUbxGbrrCDuH009+6MckgvfwL/Sif3ZGyqJQ==
X-Received: by 2002:adf:f646:: with SMTP id x6mr31705623wrp.18.1563205175486;
        Mon, 15 Jul 2019 08:39:35 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id z25sm19536196wmf.38.2019.07.15.08.39.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 08:39:34 -0700 (PDT)
Date:   Mon, 15 Jul 2019 08:39:32 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kevin Wang <kevin1.wang@amd.com>
Subject: Re: [PATCH 6/7] drm/amd/powerplay: Use proper enums in
 vega20_print_clk_levels
Message-ID: <20190715153932.GA41785@archlinux-threadripper>
References: <20190704055217.45860-1-natechancellor@gmail.com>
 <20190704055217.45860-7-natechancellor@gmail.com>
 <CAK8P3a1e4xKTZc1Fcd9KLwaGG_wpcAnSNu7mrB6zw+aBJ0e0CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1e4xKTZc1Fcd9KLwaGG_wpcAnSNu7mrB6zw+aBJ0e0CA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 11:25:29AM +0200, Arnd Bergmann wrote:
> On Thu, Jul 4, 2019 at 7:52 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > clang warns:
> >
> > drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:995:39: warning:
> > implicit conversion from enumeration type 'PPCLK_e' to different
> > enumeration type 'enum smu_clk_type' [-Wenum-conversion]
> >                 ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
> >                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:1016:39: warning:
> > implicit conversion from enumeration type 'PPCLK_e' to different
> > enumeration type 'enum smu_clk_type' [-Wenum-conversion]
> >                 ret = smu_get_current_clk_freq(smu, PPCLK_FCLK, &now);
> >                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:1031:39: warning:
> > implicit conversion from enumeration type 'PPCLK_e' to different
> > enumeration type 'enum smu_clk_type' [-Wenum-conversion]
> >                 ret = smu_get_current_clk_freq(smu, PPCLK_DCEFCLK, &now);
> >                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
> >
> > The values are mapped one to one in vega20_get_smu_clk_index so just use
> > the proper enums here.
> >
> > Fixes: 096761014227 ("drm/amd/powerplay: support sysfs to get socclk, fclk, dcefclk")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/587
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> 
> Adding Kevin Wang for further review, as he sent a related patch in
> d36893362d22 ("drm/amd/powerplay: fix smu clock type change miss error")
> 
> I assume this one is still required as it triggers the same warning.
> Kevin, can you have a look?
> 
>       Arnd

Indeed, this one and https://github.com/ClangBuiltLinux/linux/issues/586
are still outstanding.

https://patchwork.freedesktop.org/patch/315581/

Cheers,
Nathan

> 
> >  drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> > index 0f14fe14ecd8..e62dd6919b24 100644
> > --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> > +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> > @@ -992,7 +992,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
> >                 break;
> >
> >         case SMU_SOCCLK:
> > -               ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
> > +               ret = smu_get_current_clk_freq(smu, SMU_SOCCLK, &now);
> >                 if (ret) {
> >                         pr_err("Attempt to get current socclk Failed!");
> >                         return ret;
> > @@ -1013,7 +1013,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
> >                 break;
> >
> >         case SMU_FCLK:
> > -               ret = smu_get_current_clk_freq(smu, PPCLK_FCLK, &now);
> > +               ret = smu_get_current_clk_freq(smu, SMU_FCLK, &now);
> >                 if (ret) {
> >                         pr_err("Attempt to get current fclk Failed!");
> >                         return ret;
> > @@ -1028,7 +1028,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
> >                 break;
> >
> >         case SMU_DCEFCLK:
> > -               ret = smu_get_current_clk_freq(smu, PPCLK_DCEFCLK, &now);
> > +               ret = smu_get_current_clk_freq(smu, SMU_DCEFCLK, &now);
> >                 if (ret) {
> >                         pr_err("Attempt to get current dcefclk Failed!");
> >                         return ret;
