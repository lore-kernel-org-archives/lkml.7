Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C41C606C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A01321537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390959AbfGHQFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:05:25 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38420 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbfGHQFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:05:24 -0400
Received: by mail-qk1-f195.google.com with SMTP id a27so13707160qkk.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kh/BqHC53KszKDDOpA1m9G0Zdhod2Cc0oo542rySQuM=;
        b=MHTIrT63Le9f4k/ZT41oFv+36eC/XsANmxB4fo54zmOZgVmKVqMiIej+ZiJGEP/9uT
         MPOLi6f3wqisfExk7XxYBNDXuOOuyfurwBwt+2vZCZqArDjQBfZo1xTNTXEHojQUSwlj
         4QpC5cHxWksS4tv+fwHfFkqtKVQ2yi4KE9htPt10lxFLPT6zkeyf7p8339Bo9EDTn5Z+
         Dpe/WWdznG+w+75YdoWpHmtpnPj9l4gbYIbI30AHOxWw6yiU+vpso0SonFepM/fTyQ1M
         RDXAVH6mevWB22E/oLjX/IBVQxz/w8IJtP6gtS8rEgIdpyK0LTk8jkiHdHMSe+Owjuyn
         5pmA==
X-Gm-Message-State: APjAAAUkySzLQM6SweAjyJe5V0QQQMYGBOc7sLO/27x3IQyzPGqif5gw
        8wj/v3ZwhkSwTdc1SzktMI5PsBqPVIZMSLtf3UM=
X-Google-Smtp-Source: APXvYqwyv3Wsnbd3JvCrgK22inUca15kYBzFQXL7xYy/IZBjNUUDOrMciDAzwaFOOJJ74XiHvWkpVIhSZJrpbV49MPk=
X-Received: by 2002:a37:76c5:: with SMTP id r188mr14771430qkc.394.1562601922991;
 Mon, 08 Jul 2019 09:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190708135725.844960-1-arnd@arndb.de> <20190708145430.GC43693@archlinux-epyc>
In-Reply-To: <20190708145430.GC43693@archlinux-epyc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Jul 2019 18:05:06 +0200
Message-ID: <CAK8P3a0ZVqEYCxoCOcAgJL7oV+su0=eZu_XR6X+9vcXzGDwVSQ@mail.gmail.com>
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
        amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 4:54 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Hi Arnd,
>
> On Mon, Jul 08, 2019 at 03:57:06PM +0200, Arnd Bergmann wrote:
> > A couple of calls to smu_get_current_clk_freq() and smu_force_clk_levels()
> > pass constants of the wrong type, leading to warnings with clang-8:
> >
> > drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:995:39: error: implicit conversion from enumeration type 'PPCLK_e' to different enumeration type 'enum smu_clk_type' [-Werror,-Wenum-conversion]
> >                 ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
> >                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:775:82: note: expanded from macro 'smu_get_current_clk_freq'
> >         ((smu)->funcs->get_current_clk_freq? (smu)->funcs->get_current_clk_freq((smu), (clk_id), (value)) : 0)
> >
> > I could not figure out what the purpose is of mixing the types
> > like this and if it is written like this intentionally.
> > Assuming this is all correct, adding an explict case is an
> > easy way to shut up the warnings.
> >
> > Fixes: bc0fcffd36ba ("drm/amd/powerplay: Unify smu handle task function (v2)")
> > Fixes: 096761014227 ("drm/amd/powerplay: support sysfs to get socclk, fclk, dcefclk")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I sent a series last week for all of the clang warnings that were added
> in this driver recently.
>
> https://lore.kernel.org/lkml/20190704055217.45860-1-natechancellor@gmail.com/
>
> I think it is safe to use the CLK enums from the expected type (from
> what I could see from going down the code flow rabbit hole).
>
> https://lore.kernel.org/lkml/20190704055217.45860-4-natechancellor@gmail.com/
>
> https://lore.kernel.org/lkml/20190704055217.45860-7-natechancellor@gmail.com/

I tried that at first but concluded that it could not work because the constants
are different. Either it's currently broken and you patches fix the runtime
behavior, or it's currently correct and your patches break it.

        Arnd
