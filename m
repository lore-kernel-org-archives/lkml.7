Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458A9C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF6D2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR2GArgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389040AbfGQANX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 20:13:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44627 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfGQANX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 20:13:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so22640127edr.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 17:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/eYjZgozPvgUajffWeA6V7Zmj+rx5wYX1ns8tvrFbI=;
        b=RR2GArgAq8SesCevWMlZ5weS7j9gS98QGvXopun5L+UMHZUEPYDRk7AR/hrFKt2KFl
         3VNfgodCd8uXhPrO4XxCDQ2MG29ysjEOy6uPp3vv7bF74W6m+oPGR90Ourw+MKZJUzM5
         8pBDtTwWh8prYLzslqKOH0QEA+7njMI9z7kGUAlir6GHXr3ybP+rkZ4huzQ8QbY0SGeX
         xr4/4LAMBS2Q9OrUarPlsFPMDTnBlWfaFlS64HCXZuoSW7kDHtLF6p7oEHH4yMSkYRaV
         E7LC/1VEvDBR4r8tN4TmUxj4B3rZ8rH4z+5Z5EkYlH18TOM0uSrtrVcHxt5ZUl6bT15Z
         abeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/eYjZgozPvgUajffWeA6V7Zmj+rx5wYX1ns8tvrFbI=;
        b=bDDzlbmg1Cl5XZNYTmrXYWNe5WM3npdZt4Jpup5NhlmggPZWS091CS61BCe150II81
         edjUPG498k+CPO8r+gItRXavqfdRm8g8aY3/Jcr9tw6JZ4kyVrS4oSdVmQBV0lwEjINu
         +eWPKNMUFzUNaBE9s1yMX2E0DnBjs8ooCBZWU6TfngUu9C3t8ZV4j/aCQhIfImGZp38M
         nLMZwGttox2Xp4Xcz5S021FXW+7KEKJ9xci0j+29UcdCK9CAimoXQKZeZ7obwhhL5znB
         JhqvBiJgCFfN+X0PZ4ZZ/1C+ooRxOZPP0ZI8V7WlkG6i0V/VVpW3d5MG+E/r7S5dohvr
         jFNg==
X-Gm-Message-State: APjAAAV21CIWCjs2LT22+bbcIjhKsxRKQUhuJ6fIUN4Rv3U9kssWcvAf
        j6S3A0I/IaVXX0JoXqGrV9kzc9dcA1FULzbeFdg=
X-Google-Smtp-Source: APXvYqyHiCjJpxSGuBP6Fd33Qm/rC+RvBui769ELlk9BhgppASdcNbXIsf9BRgWPqBi8iO1wrRc2+n1oZ0BSQTOT0ls=
X-Received: by 2002:a50:9177:: with SMTP id f52mr32148765eda.294.1563322401427;
 Tue, 16 Jul 2019 17:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190716213746.4670-1-robdclark@gmail.com> <20190716213746.4670-3-robdclark@gmail.com>
 <87lfwxh7mo.fsf@anholt.net>
In-Reply-To: <87lfwxh7mo.fsf@anholt.net>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 16 Jul 2019 17:13:10 -0700
Message-ID: <CAF6AEGsrJu8r+t35zWxbq8KXFSoyPSJ_3+MjTii00Pb=YOMxHQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/vgem: use normal cached mmap'ings
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Emil Velikov <emil.velikov@collabora.com>,
        Eric Biggers <ebiggers@google.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 4:39 PM Eric Anholt <eric@anholt.net> wrote:
>
> Rob Clark <robdclark@gmail.com> writes:
>
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Since there is no real device associated with VGEM, it is impossible to
> > end up with appropriate dev->dma_ops, meaning that we have no way to
> > invalidate the shmem pages allocated by VGEM.  So, at least on platforms
> > without drm_cflush_pages(), we end up with corruption when cache lines
> > from previous usage of VGEM bo pages get evicted to memory.
> >
> > The only sane option is to use cached mappings.
>
> This may be an improvement, but...
>
> pin/unpin is only on attaching/closing the dma-buf, right?  So, great,
> you flushed the cached map once after exporting the vgem dma-buf to the
> actual GPU device, but from then on you still have no interface for
> getting coherent access through VGEM's mapping again, which still
> exists.

In *theory* one would detach before doing further CPU access to
buffer, and then re-attach when passing back to GPU.

Ofc that isn't how actual drivers do things.  But maybe it is enough
for vgem to serve it's purpose (ie. test code).

> I feel like this is papering over something that's really just broken,
> and we should stop providing VGEM just because someone wants to write
> dma-buf test code without driver-specific BO alloc ioctl code.

yup, it is vgem that is fundamentally broken (or maybe more
specifically doesn't fit in w/ dma-mappings view of how to do cache
maint), and I'm just papering over it because people and CI systems
want to be able to use it to do some dma-buf tests ;-)

I'm kinda wondering, at least for arm/dt based systems, if there is a
way (other than in early boot) that we can inject a vgem device node
into the dtb.  That isn't a thing drivers should normally do, but (if
possible) since vgem is really just test infrastructure, it could be a
way to make dma-mapping happily think vgem is a real device.

BR,
-R
