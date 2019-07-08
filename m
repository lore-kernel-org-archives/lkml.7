Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52943C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3303D21537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391499AbfGHQIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:08:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39136 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbfGHQIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:08:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id w190so1201443qkc.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIRM9fJTuV02DInLnXfPQr/Kf49I2+6ORUwr6RxGn7I=;
        b=rmt7xCqIN9Mj9fIjyScbxvzsh320zvMKDn+CEfch4TUP1tlXFgqJBOhmqDBuSKDaPO
         5KcP/SHuzm2InTbOvleNxjPyEcbQIT5LoidBsyZh5zKE1a31zPUjyemdHEf7pupMnDNb
         imcsCEo8E0IpJOwjZ93a8UJ2q3S6rFcA8iWWluQ5stDUGxArTZAdSgcLBmouihB8NgrM
         dn5uhzrSCOsPL/nNhfkdwBZYHt8eh1VECSWU9z/Y4SEZiuLeBdHGTACgcfB6vvd6tuh+
         SxXIlv35p4D4b2i9g8/snKelbPqYM4yDHLdqjeRMkFTn9kS0GjP0mpxHTen/sKeYW5RS
         xFwQ==
X-Gm-Message-State: APjAAAW+70iAMhLj1Uqtn1AKi9TH96WiZ7VoDDYdljrshKjpWNc7z3rr
        bAJY1mgzQBte5U/yrb7ShdfLhBXW+jTVajgrHOM=
X-Google-Smtp-Source: APXvYqxEteI4pKZ99QH7i/UIVpoxSSPej/jTeoSq5Gb18AgTvCR6/QaNyJI3G6p/aYnV/vglL8CaZcuN2VjZYVTutxc=
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr11264883qki.352.1562602119294;
 Mon, 08 Jul 2019 09:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190708144205.2770771-1-arnd@arndb.de> <20190708144205.2770771-2-arnd@arndb.de>
 <CADnq5_MFi1cGxo-AGMcGzY4nW8HAuX8SiPfAD=eRrdo0w-aoJQ@mail.gmail.com>
In-Reply-To: <CADnq5_MFi1cGxo-AGMcGzY4nW8HAuX8SiPfAD=eRrdo0w-aoJQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Jul 2019 18:08:21 +0200
Message-ID: <CAK8P3a1m-aDAsiVFYyQcoq0a=Y8rA5R3P5TSuBfmK2Gync-8eQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] amdgpu: make SOC15/navi support conditional
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>, Evan Quan <evan.quan@amd.com>,
        Yong Zhao <Yong.Zhao@amd.com>, Amber Lin <Amber.Lin@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        xinhui pan <xinhui.pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Emily Deng <Emily.Deng@amd.com>, Huang Rui <ray.huang@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Rex Zhu <Rex.Zhu@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shaoyun Liu <Shaoyun.Liu@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 4:46 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Jul 8, 2019 at 10:42 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Enabling amdgpu but not CONFIG_DRM_AMD_DC leads to a warning:
> >
> > drivers/gpu/drm/amd/amdgpu/nv.c: In function 'nv_set_ip_blocks':
> > drivers/gpu/drm/amd/amdgpu/nv.c:400:3: error: #warning "Enable CONFIG_DRM_AMD_DC for display support on navi." [-Werror=cpp]
> >  # warning "Enable CONFIG_DRM_AMD_DC for display support on navi."
> >    ^~~~~~~
> > drivers/gpu/drm/amd/amdgpu/soc15.c: In function 'soc15_set_ip_blocks':
> > drivers/gpu/drm/amd/amdgpu/soc15.c:653:3: error: #warning "Enable CONFIG_DRM_AMD_DC for display support on SOC15." [-Werror=cpp]
> >
> > However, CONFIG_DRM_AMD_DC can only be enabled on x86, so we
> > cannot do that when building for other architectures.
>
> DC is not limited to x86.

Ah, right, only DRM_AMD_DC_DCN1_0 is x86-only.

>  I can drop the warning if that is the concern.

That would be great, yes.

      Arnd
