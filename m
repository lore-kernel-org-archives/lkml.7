Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FE1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE98B21897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GCMat47+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfICU1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:27:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36548 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfICU1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:27:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id p13so963815wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 13:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/b2QHbCNP+aT9un1NN+bENpn3vUoUF45wJf6gW6ANh0=;
        b=GCMat47+ln2ZL+YdHP0Tk7eE6pnHP0TvcZwh5LKi/Mw6LL7vl/KQy9uPMwMikh2YTc
         8nkINnJeY/vz1F42wZNhvV1MpdoTOcNMgjQfPgLTWju+e2zSZdyRSVoZ9us5Pe+xpQVZ
         gSwMG+cj4PS7ZvMY617QkEGh8fuckVn0Ahbzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/b2QHbCNP+aT9un1NN+bENpn3vUoUF45wJf6gW6ANh0=;
        b=j8w3jfnHxSwcRs9R71ERF9aLLLfbDfaoOR6Llxbr0ksGh4hjc+eGpA8EuOu2Myh1Co
         NoKsCB9y1ZZn9k4501CVBJcEh9mH6e7q45fJO+N2tj3KE7JPChEM6JBsjmwDguSPL3E6
         Am5RE8xcbQQNdiPtFon5OGJOlb0KrYix/+NyrdoU0QyJs1cj7/0xY0p0IRE0NWDdFmUe
         c68Qb6FnhbUsX/c9YeJPjqUsIxhJFMmVBZ2behCA+979jnN4gxygG3mJJ8Enwijpu9ip
         zU2OwVxkCnnlO+NsbRPJbLH0IMW2ECrKd4kA+X4kP2fDeemQzx3RrpINFqL4XeJ5IHPu
         JQTQ==
X-Gm-Message-State: APjAAAXwDQCqIXNlKW9280nuZi5b8Imfw35PT2TettMEqpXj/w2k/cd6
        dFyXINqj7RFSsiDxq9iCIsktBHGs6pGIta9JAw0yJw==
X-Google-Smtp-Source: APXvYqwf5YJGifCM+NEVFPPjuCChvoU5yCQm/Yq9u+hrQ8LuXqKbrI/Jc5ugnZkobaG2J3YOiX6RhsCZ32+T8arEsTs=
X-Received: by 2002:a7b:c8ca:: with SMTP id f10mr1364009wml.36.1567542469567;
 Tue, 03 Sep 2019 13:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190829212417.257397-1-davidriley@chromium.org>
 <20190830060857.tzrzgoi2hrmchdi5@sirius.home.kraxel.org> <CAASgrz2v0DYb_5A3MnaWFM4Csx1DKkZe546v7DG7R+UyLOA8og@mail.gmail.com>
 <20190830111605.twzssycagmjhfa45@sirius.home.kraxel.org> <CAASgrz0SXc2bEXq4xPCry_oHMXNbau36Q9i20anbFq1X0FsoMQ@mail.gmail.com>
 <20190902052852.vqejjqrib6tvv2v5@sirius.home.kraxel.org>
In-Reply-To: <20190902052852.vqejjqrib6tvv2v5@sirius.home.kraxel.org>
From:   David Riley <davidriley@chromium.org>
Date:   Tue, 3 Sep 2019 13:27:37 -0700
Message-ID: <CAASgrz1GKRGncD_6aDUKnDuBiZpZOjkP0P62Ukmk+DN6csKm7w@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Use vmalloc for command buffer allocations.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 1, 2019 at 10:28 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Aug 30, 2019 at 10:49:25AM -0700, David Riley wrote:
> > Hi Gerd,
> >
> > On Fri, Aug 30, 2019 at 4:16 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > >   Hi,
> > >
> > > > > > -     kfree(vbuf->data_buf);
> > > > > > +     kvfree(vbuf->data_buf);
> > > > >
> > > > > if (is_vmalloc_addr(vbuf->data_buf)) ...
> > > > >
> > > > > needed here I gues?
> > > > >
> > > >
> > > > kvfree() handles vmalloc/kmalloc/kvmalloc internally by doing that check.
> > >
> > > Ok.
> > >
> > > > - videobuf_vmalloc_to_sg in drivers/media/v4l2-core/videobuf-dma-sg.c,
> > > > assumes contiguous array of scatterlist and that the buffer being converted
> > > > is page aligned
> > >
> > > Well, vmalloc memory _is_ page aligned.
> >
> > True, but this function gets called for all potential enqueuings (eg
> > resource_create_3d, resource_attach_backing) and I was concerned that
> > some other usage in the future might not have that guarantee.
>
> The vmalloc_to_sg call is wrapped into "if (is_vmalloc())", so this
> should not be a problem.
>
> > > sg_alloc_table_from_pages() does alot of what you need, you just need a
> > > small loop around vmalloc_to_page() create a struct page array
> > > beforehand.
> >
> > That feels like an extra allocation when under memory pressure and
> > more work, to not gain much -- there still needs to be a function that
> > iterates through all the pages.  But I don't feel super strongly about
> > it and can change it if you think that it will be less maintenance
> > overhead.
>
> Lets see how vmalloc_to_sg looks like when it assumes page-aligned
> memory.  It's probably noticeable shorter then.

It's not really.  The allocation of the table is one unit less, and
doesn't need to take into account that data might be an offset within
the page.  It still needs error handling, partial final page handling,
and marking of the end of the scatterlist.  Things could be slightly
simplified to assume that you can always get a contiguous allocation
of the table instead of using sg_alloc_table/for_each_sg, but given
that we're only going down this path when memory is fragmented and in
a fallback, doesn't seem worthwhile to make that trade-off.

I've written a different version of vmalloc_to_sgt which uses
sg_alloc_table_from_pages under the covers and it comes in slightly
shorter (39 lines vs 55 lines), but incurs another allocation as
previously so I'm personally in favour of things as written.
fpga_mgr_buf_load is another function which roughly does the same sort
of operation and it's a bit longer.

I'll post a v2 shortly, but if you think it's worth making the extra
allocation of the pages array to use, I can post that instead.

> cheers,
>   Gerd
>
