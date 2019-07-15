Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDA0C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8E420C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfGOJVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:21:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46326 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbfGOJVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:21:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so14803973qtn.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 02:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxKKZuQtCI1ZkIIYkRW9QnKWr4iswbDh01TB7Vwu9Eo=;
        b=UiFr2SQhHmlcIlP37yuHJaaJNBmrA/eQ1J9kMP7y4bJAOms7OXZv9rIOOJJYKGNwK3
         yRAdlCF+zsU6MDt9yTBCUD/8OsOqGyjGpmLLWQlFh/NHsGzXOj7cDV9nkMamOYkTaVj3
         8K7g7ZtDetY7AzjmJJJ1YVeOSWjJnWPBhvHKBXn9j9tVF44A3hFK+Pc5NEwaoIxebxoy
         q03bszaPQaQXzlQa8fw4CHhnbMFnnGG/7OqZ22VGXjoSrtL18aNQGp4W0A36/NhB0xid
         Lv/6eBC17GMAo03Dj7uK0SBa2IuiBUF04bivinTTisGu5llr6XiH9A8sFqKf/gItbOrO
         XTLw==
X-Gm-Message-State: APjAAAVuumncVosJkFLH15tu/KDKMtFqQpLvuTyxYrWH3BTqhqvnsd8z
        mgGJ42k2vryMJsX3c/7y48old0V7H2A+wmjXfrY=
X-Google-Smtp-Source: APXvYqzbLgU/zk6+aWcCuPJHWM96YBukyXO3Tbp280xuz2YfGvj8YrJR3gNAcwgYOhyCNbbuJuuJq+IUsUHr6xXIiRU=
X-Received: by 2002:ac8:5311:: with SMTP id t17mr16507653qtn.304.1563182465343;
 Mon, 15 Jul 2019 02:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190708135725.844960-1-arnd@arndb.de> <20190708145430.GC43693@archlinux-epyc>
 <CAK8P3a0ZVqEYCxoCOcAgJL7oV+su0=eZu_XR6X+9vcXzGDwVSQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0ZVqEYCxoCOcAgJL7oV+su0=eZu_XR6X+9vcXzGDwVSQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Jul 2019 11:20:48 +0200
Message-ID: <CAK8P3a0FyzThq_8dO27OxP7nXVORGf5jQQnfUnnG0u272ChRtQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: work around enum conversion warnings
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Likun Gao <Likun.Gao@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Gui Chengming <Jack.Gui@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 6:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jul 8, 2019 at 4:54 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:

> > On Mon, Jul 08, 2019 at 03:57:06PM +0200, Arnd Bergmann wrote:
> > > A couple of calls to smu_get_current_clk_freq() and smu_force_clk_levels()
> > > pass constants of the wrong type, leading to warnings with clang-8:
> > >
> > > drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:995:39: error: implicit conversion from enumeration type 'PPCLK_e' to different enumeration type 'enum smu_clk_type' [-Werror,-Wenum-conversion]
> > >                 ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
> > >                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> > > drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:775:82: note: expanded from macro 'smu_get_current_clk_freq'
> > >         ((smu)->funcs->get_current_clk_freq? (smu)->funcs->get_current_clk_freq((smu), (clk_id), (value)) : 0)
> > >
> > > I could not figure out what the purpose is of mixing the types
> > > like this and if it is written like this intentionally.
> > > Assuming this is all correct, adding an explict case is an
> > > easy way to shut up the warnings.
> > >
> > > Fixes: bc0fcffd36ba ("drm/amd/powerplay: Unify smu handle task function (v2)")
> > > Fixes: 096761014227 ("drm/amd/powerplay: support sysfs to get socclk, fclk, dcefclk")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > I sent a series last week for all of the clang warnings that were added
> > in this driver recently.
> >
> > https://lore.kernel.org/lkml/20190704055217.45860-1-natechancellor@gmail.com/
> >
> > I think it is safe to use the CLK enums from the expected type (from
> > what I could see from going down the code flow rabbit hole).
> >
> > https://lore.kernel.org/lkml/20190704055217.45860-4-natechancellor@gmail.com/
> >
> > https://lore.kernel.org/lkml/20190704055217.45860-7-natechancellor@gmail.com/
>
> I tried that at first but concluded that it could not work because the constants
> are different. Either it's currently broken and you patches fix the runtime
> behavior, or it's currently correct and your patches break it.

d36893362d22 ("drm/amd/powerplay: fix smu clock type change miss error")
was now applied and contains the same change as your first patch.

I assume the other one is still needed though.

       Arnd
