Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C097C41514
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A16C2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kV+NV+qW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403802AbfHHQcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:32:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44027 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfHHQcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:32:32 -0400
Received: by mail-ot1-f67.google.com with SMTP id j11so20619973otp.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=erfhL7VDoeVN6LjjmIrSkztKG2I43YnuXIQ5QoKPdbc=;
        b=kV+NV+qW/5qJZ2Z48xBPFEZ6LJYAXKY5/LhYbls4LmwDokugWNdTa16wJmKp0yXodN
         iVYJzFf9wKMlE++n5p9Whx3JnTaCk53pROAM7OZ8x0kFxKIh5rsaR/LnSEl93Lnc1C2A
         Hfwb5Y/I4iLfY0pVARlG0U/1rzE7/uJK5ZkZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erfhL7VDoeVN6LjjmIrSkztKG2I43YnuXIQ5QoKPdbc=;
        b=QKcKMbqjfUSoceLHFuwVQVH6JdwS3nr2iApR9satzPFr9VIyBRFTtledowltWT28Ls
         dpgHbax9wxCbYQ1bRsGtTa/6lI0JiQBQX3BhLs+kjubZXhOH0esKDN1f9RUgJX1+5tZc
         2hIr71K9DTj7lFwx8GhK+2UPfcfSrysjlRWbNCQKN7+bEZI5x0ylNGk3XGrPkwOSEXSP
         7Kw6RcQs5kECb4fZ5HYNJMbZXewfLp2Ig0K0g5Ou5xRK2jPOR7ETQMZkRhBEaC62eu5Z
         E9zQia5qFWEAvsKNXgk9lbxHgG9fLmhowhILCDpFN/70L2tzEHGyRWOs3LF8s94qmIlL
         b1HQ==
X-Gm-Message-State: APjAAAV3ncTykO7w7BZUXnvfaXD0jy7o7rtoevpvnsBtjlNvL6Oc5/M2
        jdTokhSEryujhs1D8xVPLyu+NPe+gtTd9n8JvzG5ZA==
X-Google-Smtp-Source: APXvYqy8Y64Qwzaj+EcuykgpBje7tkhZgHMn/Tvi8eNyfMMvhJLC6rMpyPg9xxizaeKi+hpK8mPldF+gfVafFe2ZGzs=
X-Received: by 2002:a6b:90c1:: with SMTP id s184mr15573418iod.244.1565281952009;
 Thu, 08 Aug 2019 09:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de>
 <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com>
 <20190806155044.GC25050@lst.de> <CAJs_Fx6uztwDy2PqRy3Tc9p12k8r_ovS2tAcsMV6HqnAp=Ggug@mail.gmail.com>
 <20190807062545.GF6627@lst.de> <CAJs_Fx7tqbr_gqRdqJEwOcRFReP0DqZzOu11Dxhxkp8+PygUQw@mail.gmail.com>
 <20190808100031.GA32658@lst.de>
In-Reply-To: <20190808100031.GA32658@lst.de>
From:   Rob Clark <robdclark@chromium.org>
Date:   Thu, 8 Aug 2019 09:32:21 -0700
Message-ID: <CAJs_Fx6ikxob7Mu6GM1ESe4pBXAbVv4NNnbZN7YUQdmyfPnxgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: add cache support for arm64
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 3:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Aug 07, 2019 at 09:09:53AM -0700, Rob Clark wrote:
> > > > (Eventually I'd like to support pages passed in from userspace.. but
> > > > that is down the road.)
> > >
> > > Eww.  Please talk to the iommu list before starting on that.
> >
> > This is more of a long term goal, we can't do it until we have
> > per-context/process pagetables, ofc.
> >
> > Getting a bit off topic, but I'm curious about what problems you are
> > concerned about.  Userspace can shoot it's own foot, but if it is not
> > sharing GPU pagetables with other processes, it can't shoot other's
> > feet.  (I'm guessing you are concerned about non-page-aligned
> > mappings?)
>
> Maybe I misunderstood what you mean above, I though you mean messing
> with page cachability attributes for userspace pages.  If what you are
> looking into is just "standard" SVM I only hope that our APIs for that
> which currently are a mess are in shape by then, as all users currently
> have their own crufty and at least slightly buggy versions of that.  But
> at least it is an issue that is being worked on.

ahh, ok.. and no, we wouldn't be remapping 'malloc' memory as
writecombine.  We'd have to wire up better support for cached buffers.

Currently we use WC for basically all GEM buffers allocated from
kernel, since that is a good choice for most GPU workloads.. ie. CPU
isn't reading back from GPU buffers in most cases.  I'm told cached
buffers are useful for compute workloads where there is more back and
forth between GPU and CPU, but we haven't really crossed that bridge
yet.  Compute workloads is also were the SVM interest is.

> > > So back to the question, I'd like to understand your use case (and
> > > maybe hear from the other drm folks if that is common):
> > >
> > >  - you allocate pages from shmem (why shmem, btw?  if this is done by
> > >    other drm drivers how do they guarantee addressability without an
> > >    iommu?)
> >
> > shmem for swappable pages.  I don't unpin and let things get swapped
> > out yet, but I'm told it starts to become important when you have 50
> > browser tabs open ;-)
>
> Yes,  but at that point the swapping can use the kernel linear mapping
> and we are going into aliasing problems that can disturb the cache.  So
> as-is this is going to problematic without new hooks into shmemfs.
>

My expectation is that we'd treat the pages as cached when handing
them back to shmemfs, and wb+inv when we take them back again from
shmemfs and re-pin.  I think this works out to be basically the same
scenario as having to wb+inv when we first get the pages from shmemfs.

> > >  - then the memory is either mapped to userspace or vmapped (or even
> > >    both, althrough the lack of aliasing you mentioned would speak
> > >    against it) as writecombine (aka arm v6+ normal uncached).  Does
> > >    the mapping live on until the memory is freed?
> >
> > (side note, *most* of the drm/msm supported devices are armv8, the
> > exceptions are 8060 and 8064 which are armv7.. I don't think drm/msm
> > will ever have to deal w/ armv6)
>
> Well, the point was that starting from v6 the kernels dma uncached
> really is write combine.  So that applied to v7 and v8 as well.

ahh, gotcha

BR,
-R
