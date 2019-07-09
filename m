Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8928C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC0921537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDfy0y1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfGIUV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 16:21:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46051 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfGIUVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:21:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so112923wre.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 13:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BqI5outTIh2mJn+SptLleo59V8v3BzRwFRtZPJVwOgQ=;
        b=lDfy0y1VmUYZm1hrtwGJCJEuJGPi7rFi+/pbmnmsrMTVoUFkUnGonIB13rNvMQlRPC
         SlkpU3JCozmm5fbgcDROoEPRMZ5bAyGGUWPZo9RHq0Q+xILn0PujWqDPjN4mxZPzh/mI
         0ShwBlUjnW89bm/kFkjgkNpTnGNvR+Xm0ZkLzU9YBmTUxsBrGFznL/9FrU7vXsrmL1TF
         Cao+XoJGkMy5CunOwQ/qAUX2SzT+3Os7R71/kJTxxB9R8En3qINQIEGYnkeVJEmAYrsw
         qMAN62Gr8MExsOpPuF+wRVhymwl4te7xnNP/M2QomcFItK9FHaNrtLJhxtbRloWUVD2a
         yCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BqI5outTIh2mJn+SptLleo59V8v3BzRwFRtZPJVwOgQ=;
        b=HDe4FA5fdtEkVsXr0FtKUY6efLig1+VAsxCUgizptmDgf4ZfY8cBKiEaCV5HU08pDf
         SAqQlNTEavFGZO1jmmrcO7BydSSHfVlo7q0DpCO1xHykyQL60epgTIxKhWniLu9t/jih
         H758SKUh6ma1CLSj53pHluvde3AoN4J9wg5A7IO5MoaMrSN1sk19pCpTyCnytGB1f0d7
         6j6Bjwwldmf7MrYyk2Npfamq5adkY4kiSOEiz+CnUOxA53Li06VYbHUQGEUS8CUr7Sa9
         +BY9vi9hhAykwP2UfcIaJK+r4u3uT4BHYHelbzBkrUT5VTRG1a63NVm7nO94AXhp4y7p
         Chag==
X-Gm-Message-State: APjAAAU/ku/E5SwE+NKU901M3jxfsA9OKBTTrr8Sm9x2ZyfMwhWD914x
        29boYNcuXAWbyuwVzoMZNDY=
X-Google-Smtp-Source: APXvYqyyg9ffu3I2DUs4oDtP0JbKuVnQZDgZxqg1ttyjXVjkFyhhdUXslaD72h3W+yVXC0DikmuOKA==
X-Received: by 2002:a5d:62c1:: with SMTP id o1mr26819925wrv.293.1562703713114;
        Tue, 09 Jul 2019 13:21:53 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id w24sm16601wmc.30.2019.07.09.13.21.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 13:21:52 -0700 (PDT)
Date:   Tue, 9 Jul 2019 13:21:50 -0700
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
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 5/7] drm/amd/display: Use proper enum conversion functions
Message-ID: <20190709202150.GB96242@archlinux-threadripper>
References: <20190704055217.45860-1-natechancellor@gmail.com>
 <20190704055217.45860-6-natechancellor@gmail.com>
 <CAK8P3a1vEtrS7SbhCPVxoYBcroT+Hr3Q4LFs6AJJ8G8GVw5SVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1vEtrS7SbhCPVxoYBcroT+Hr3Q4LFs6AJJ8G8GVw5SVA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 08:51:33PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 4, 2019 at 7:52 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > clang warns:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:336:8:
> > warning: implicit conversion from enumeration type 'enum smu_clk_type'
> > to different enumeration type 'enum amd_pp_clock_type'
> > [-Wenum-conversion]
> >                                         dc_to_smu_clock_type(clk_type),
> >                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:421:14:
> > warning: implicit conversion from enumeration type 'enum
> > amd_pp_clock_type' to different enumeration type 'enum smu_clk_type'
> > [-Wenum-conversion]
> >                                         dc_to_pp_clock_type(clk_type),
> >                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > There are functions to properly convert between all of these types, use
> > them so there are no longer any warnings.
> 
> I had a different solution for this one as well. The difference is that your
> patch keeps the types and assumes that the functions do the right thing
> (i.e. the warning was correct), while my version assumes that the code
> works correctly, but the types are wrong (a false positive warning).
> 
> One of the two patches is correct, the other one is broken, but I have
> no idea which one.
> 
>       Arnd

Indeed. I would personally argue that if using the correct conversion
functions (which are here to specifically avoid this type of warning)
causes issues, this code should probably not be using enumerated types
at all since the entire point is to enforce semantic correctness, not
just be a special way to represent small integer values, especially in
the case where the CLK values are completely different numerical values
in various enumerated types. I think enumerated type casts are ugly and
defeat the purpose of them but that's obviously just my opinion :)

Hopefully we can get some clarity on this soon.

Cheers,
Nathan
