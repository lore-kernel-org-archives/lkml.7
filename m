Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09035C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22EF20651
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPPQSb4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbfGPREN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:04:13 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34922 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPREM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:04:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id w20so21024172edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5J1jCpDGLRMbPaFuVIDuJAsDJ3kZo81VHBUg/8gudo=;
        b=oPPQSb4pew/H/AtnEeU9cvH+8yyLl7hIKuxjqBwPDdjpW2eAVrEw3390F/xtJMwRtJ
         RpBYPM0v9wuUUXECyCsUkJSJq546FB8TgqsnCH6I+QuV4GYCQEtVN1egdPSiecJdyh7/
         3Bs4ShQdGinhQuH1gbc2YPJtB5cL/BLOSnD09qFYByK1BWI3JEdz764l6+RE4Ru9kDKq
         eh84SWBp1R50G4AJ9P2xi++KlnacTvz+JAjPxgHevjzjV3JzBlcOok7qEeDsB1MPA1Ql
         LtrTIOAw0RjrSSEcFsp1dIneQ/EBst0GqDR/zXBV4TKOlK9t8g+/XUVkHevX9UCHIw0w
         DnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5J1jCpDGLRMbPaFuVIDuJAsDJ3kZo81VHBUg/8gudo=;
        b=qwdIzLTxmYYvDZqfJ+L/TAQlgRcBj1xQoME2Q19oam7b2bLA3YFi7ojeYTzNDBmZx/
         7KdcoyCl8PhOxJVCSayaSEICFyJULC7kjr0Agqny8FRWlBT3EjMX6Mdyc9R5XJUPYnyU
         04DX3qJHHYUeGQia7Xz8B+iA+8yzCPn9+WADm4lV3ugj4ZF5rgQrbOW7FFmKiv7be6zl
         8SlLYUTYL1U9kp5dX2XixD1vYEjBxYOmOgp48S3YwMSnQAaqsyfl0Y0LcDskupaBKqM9
         /DyrrxcY6SE0Q9Y9B4P1fK2RQPeVu6s+WV1fpX+sqFvl/m4Utvjb5lAaBY8v0ovZiZPL
         zQBg==
X-Gm-Message-State: APjAAAUiPaWNZJkSmBgZCQ81Jb4Wk7QkDAkKueNEt0c72nhmpSL8nI+L
        K1Gqzn14PX+U5pY50HUVK2EEhKevNufv5ZdiUWc=
X-Google-Smtp-Source: APXvYqyrg6Z9Dz8LN0IPtG+u1HW2UmEvDSu3FXiog8bhjVz65CftM4480Ww4v2dogAMfniwMK/jSJb0crn9Fe2KUXWU=
X-Received: by 2002:a17:906:3f87:: with SMTP id b7mr26288651ejj.164.1563296651085;
 Tue, 16 Jul 2019 10:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190716164221.15436-1-robdclark@gmail.com> <20190716164221.15436-2-robdclark@gmail.com>
 <156329635647.9436.7142001798245279241@skylake-alporthouse-com>
In-Reply-To: <156329635647.9436.7142001798245279241@skylake-alporthouse-com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 16 Jul 2019 10:03:59 -0700
Message-ID: <CAF6AEGuSZ9sRdBituUWbWNuzEav=ZCuMqan_sgP8JcaW_2aOOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/vgem: use normal cached mmap'ings
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:01 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Rob Clark (2019-07-16 17:42:15)
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Since there is no real device associated with vgem, it is impossible to
> > end up with appropriate dev->dma_ops, meaning that we have no way to
> > invalidate the shmem pages allocated by vgem.  So, at least on platforms
> > without drm_cflush_pages(), we end up with corruption when cache lines
> > from previous usage of vgem bo pages get evicted to memory.
> >
> > The only sane option is to use cached mappings.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> > Possibly we could dma_sync_*_for_{device,cpu}() on dmabuf attach/detach,
> > although the ->gem_prime_{pin,unpin}() API isn't quite ideal for that as
> > it is.  And that doesn't really help for drivers that don't attach/
> > detach for each use.
> >
> > But AFAICT vgem is mainly used for dmabuf testing, so maybe we don't
> > need to care too much about use of cached mmap'ings.
>
> Sadly this regresses with i915 interop.
>
> Starting subtest: 4KiB-tiny-vgem-blt-early-read-child
> (gem_concurrent_blit:8309) CRITICAL: Test assertion failure function dmabuf_cmp_bo, file ../tests/i915/gem_concurrent_all.c:408:
> (gem_concurrent_blit:8309) CRITICAL: Failed assertion: v[((y)*(b->width) + (((y) + pass)%(b->width)))] == val
> (gem_concurrent_blit:8309) CRITICAL: error: 0 != 0xdeadbeef
>
> and igt/prime_vgem
>
> Can you please cc intel-gfx so CI can pick up these changes?
> -Chris

I suppose CI is actually reading the imported VGEM bo from GPU?  I can
try to wire up the attach/detach dma_sync, which might help..

BR,
-R
