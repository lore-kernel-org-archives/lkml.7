Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB37C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13F121721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbhLpV+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfGAMnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 08:43:03 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42231 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfGAMnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:43:03 -0400
Received: by mail-ua1-f65.google.com with SMTP id a97so4998643uaa.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3jn62uRqDDtMfGSPLqczsPcfH+yK4fZYdwDPBUJ9p0=;
        b=GbhLpV+AH96F+DztaPdUMOLia9bsRPFhOxnwM5nfLyLBUGwObVkdKGjNH7SkQD0ihj
         8IXr9UnczQV8dtTOevWQmMRTbPEgDWDyadWBrApGXxqfmaFD7h3geJEEi7Pgqvkz9A8G
         dkTlL+49nwq6ftLE1XbrSX5iEICSnJcN+goRsX2ofg5teUgDj2psMTlamkNgVqHuPxKK
         fdBtVbWRk49W1eyi0HLil9RaroAxwff1/c3D/Bufslwc07bSFN1fDU6DDTTW6DSghykj
         llMQIGnbGQsTSf3IzN3OJoz1a2M+pf2iYXb0twY5ZuRlUEWaZV4CnjUPTBiSz7XYajT4
         KI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3jn62uRqDDtMfGSPLqczsPcfH+yK4fZYdwDPBUJ9p0=;
        b=rnmgllAqYgwwrm5Hk8Yl6s6ldhhfWIQXHRPW1cUmBUa6PVjZa9wBjYGNXlatmkpKGQ
         yKF8bGspOlfHuUBgxXVHEeJRy2oB6FZlMwd8kHY3gTZw84ECAhxDR7YmSi64TtXBK7WT
         pXzyEClpFyqCtAiQ0OiIG5h5loJfVpZjeQUFJGrAPnpgo/vGm5sFhtapdc5VOevZy+40
         Lesb7NMfkFNp/BHMALjvJN/CQtjSI7+5auXw4k+MfbXkPmJ2qIXAl+TPwsJ9shW3qSwi
         rQBXyuC57IjPU3OHUwZgBITq9OYgcu7dUOCNQ85aCqTwzJMn3eLMae+IIPYrmfXEQIRf
         /5UA==
X-Gm-Message-State: APjAAAUv7j+ZRdJmg5GKISNDe13PssFVctk7Lif/Du3Dl8a/pSxkzvPB
        V9KxQVQ64NtjXBmKOm0RJ+e8B9xAw7qCTZcWW/qKHQkk
X-Google-Smtp-Source: APXvYqxywlnTdPSPmdCseZKudC27fw/bhXEBeJ9DnY8UG/svaAtgHnOvqEPjimSJtJ/B+M7qeQAoK9JlTIk32++9jUo=
X-Received: by 2002:ab0:2556:: with SMTP id l22mr8965354uan.46.1561984982144;
 Mon, 01 Jul 2019 05:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190628024700.15141-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190628024700.15141-1-huangfq.daxian@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 1 Jul 2019 13:43:16 +0100
Message-ID: <CACvgo52dW16DahT37aAxF8snZSJo_42ie3M0Le_edF19SBYL0Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/27] gpu: drm: remove memset after zalloc
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Francis <David.Francis@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fuqian,

On Fri, 28 Jun 2019 at 09:30, Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> zalloc has already zeroed the memory.
> so memset is unneeded.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c       | 2 --
>  drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c | 2 --
>  drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c            | 2 --
>  drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c       | 2 --
>  drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c         | 2 --
>  5 files changed, 10 deletions(-)
>
Thanks for fixing these. One nit pick: the commit message should start
with "drm/amdgpu:" as you can see from git log.
With that:

Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
