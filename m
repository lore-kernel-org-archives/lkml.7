Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05122C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8B4214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzkDXYOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfHFS7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:59:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41783 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfHFS7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:59:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so85702184wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdYR5EY08dTrABja8SUaSb/bjYgZpuHfqWAB/BpsnN0=;
        b=KzkDXYOptvkwojTFBCmVBlV+3tIliyzrdwY+53s8Esprf/Qgz2f1eCQC0QZw//ozZE
         RcNDjvbJB0Cq3mVPeQ15pOOzXvlweppXj6YAayOw27YWsleceaonHnL4Nzg52TLIthMV
         rYjlL0699xdOcqu7sevttzOxuBg4lN0lkzV2K+uunyzS+RpjhuoPhqdSTlnWnb+T7JCY
         HjZ7JWiEwVAUgYx71nCzkRtYctAe5o7uJNxjGtB37j8Kd+2mGvXbEYuFLbnlo+SIJTJp
         +5YjsJV6IoI9YUlqfsHsDvbDUa1C/1KA3eKWNZE2oqsn4qlL+cyH/WoPyn6i66w9Lttj
         o0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdYR5EY08dTrABja8SUaSb/bjYgZpuHfqWAB/BpsnN0=;
        b=Hsl2FePBd8msHu2k3lddBnTGuZtrOAm4W42nCP3HIRcSDruCKwE9E4gNWZImDin/Vx
         xsevUNkC1fwoU9j2tklKC6gg07jVbbh0kUnd21zTn1cxdP/fDw475xbBA45Max09+YGI
         jkIJ5sTqbbqcoS9XwZzKeMI2+7jW4TlfIlnmseaqwz2LDVuRxNqmrXzSUc9Qd/TdKyyn
         BpqJ+dj35oj0/k2fS9XQykuEj/8gocPodAdeC+tI7bTPuFLXrzK7Oe/N/7vMst6azW/c
         dxToEK84l2vxTtYSs8nw86Pr45foYt22ma/u8iqoCbjfLYcu+mfl6m3XEnGGNhjDtYzR
         1/EQ==
X-Gm-Message-State: APjAAAVQr0Ffb3DbJWa4CSFOhFnhBPLurpvM35R7Q03eCOe33M1liYU6
        Sq6dn8EgYOadsZrB9DqMOJkuXWaPvtpY5QOMu60=
X-Google-Smtp-Source: APXvYqyvIOyL3ta7PNqlaft8AIjrG08VwxtlFNFvdOLUq+AjfF7aZKuWk+kMq57BwYyz3aJneYaERa/Thq7ouYxDQUo=
X-Received: by 2002:adf:dfc5:: with SMTP id q5mr6393234wrn.142.1565117950081;
 Tue, 06 Aug 2019 11:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190806160554.14046-1-hch@lst.de> <20190806160554.14046-16-hch@lst.de>
 <20190806174437.GK11627@ziepe.ca> <587b1c3c-83c4-7de9-242f-6516528049f4@amd.com>
In-Reply-To: <587b1c3c-83c4-7de9-242f-6516528049f4@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 6 Aug 2019 14:58:58 -0400
Message-ID: <CADnq5_Puv-N=FVpNXhv7gOWZ8=tgBD2VjrKpVzEE0imWqJdD1A@mail.gmail.com>
Subject: Re: [PATCH 15/15] amdgpu: remove CONFIG_DRM_AMDGPU_USERPTR
To:     "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 1:51 PM Kuehling, Felix <Felix.Kuehling@amd.com> wrote:
>
> On 2019-08-06 13:44, Jason Gunthorpe wrote:
> > On Tue, Aug 06, 2019 at 07:05:53PM +0300, Christoph Hellwig wrote:
> >> The option is just used to select HMM mirror support and has a very
> >> confusing help text.  Just pull in the HMM mirror code by default
> >> instead.
> >>
> >> Signed-off-by: Christoph Hellwig <hch@lst.de>
> >> ---
> >>   drivers/gpu/drm/Kconfig                 |  2 ++
> >>   drivers/gpu/drm/amd/amdgpu/Kconfig      | 10 ----------
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  6 ------
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 12 ------------
> >>   4 files changed, 2 insertions(+), 28 deletions(-)
> > Felix, was this an effort to avoid the arch restriction on hmm or
> > something? Also can't see why this was like this.
>
> This option predates KFD's support of userptrs, which in turn predates
> HMM. Radeon has the same kind of option, though it doesn't affect HMM in
> that case.
>
> Alex, Christian, can you think of a good reason to maintain userptr
> support as an option in amdgpu? I suspect it was originally meant as a
> way to allow kernels with amdgpu without MMU notifiers. Now it would
> allow a kernel with amdgpu without HMM or MMU notifiers. I don't know if
> this is a useful thing to have.

Right.  There were people that didn't have MMU notifiers that wanted
support for the GPU.  For a lot of older APIs, a lack of userptr
support was not a big deal (it just disabled some optimizations and
API extensions), but as it becomes more relevant it may make sense to
just make it a requirement.

Alex

>
> Regards,
>    Felix
>
> >
> > Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> >
> > Jason
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
