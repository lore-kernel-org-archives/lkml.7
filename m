Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9357AC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663B12342B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MHOAWosS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfH3Rtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:49:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34452 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfH3Rtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:49:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so4894113wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 10:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a9y5rfT6nLtA1XdTe+7F8mFNtN6YI5hHOXo6XezMGeM=;
        b=MHOAWosS69n1MZDxUnmAZoQlakafemLqnOX8xOYY8UiBq/bvmqmNbOLhBAEZGOx/H3
         EppFwORAEbQmjiKohgFOV1fCDNDfgXbB/5fpFe0bcwhibf+L5BgSkJ4IsPQsKiDRwwO5
         ORSa/SlDl7oy4nJLHwtYjPeFduAKi9JbeFOoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a9y5rfT6nLtA1XdTe+7F8mFNtN6YI5hHOXo6XezMGeM=;
        b=rIz4TjAn0HkaBqQ8eCKxIyflgjAd7+PC9rP1JvMts6gHiRuEASfHiuXSMuBOOxo24g
         lQFKbIGjGQqM9CDFP+fcAle2SYSblSVlbwIJVkG/kIKwYsiZIoB0IEg5w/oDTIV0VWBb
         InjSUj6iKtgmzqtC7k9OELQUbgGcrxDT768Ilj9eEtpXdaoA+JN9JeUp78xIaQPns9AE
         1F3m7RhI+PHpzAZYkZpewQ9d4qtPHozaj/PYO5nrki+VckeesJg1wgOjNrOOtRvhgVH8
         P/S+M9Az7C74yj77OuWuWEexBgwCRMo5f+U3AIQ21tGnGmfCc/5BTmRAs/O4jiqrtGX4
         fS8Q==
X-Gm-Message-State: APjAAAVdg6byUSNapT1f5lX5MILa1B/6tI36aHUyEEHI//1AD3wn7cVT
        mypyFDeg9KXjp41RbmXH+tpqNa9hk4p6+Z5zvgwJ9g==
X-Google-Smtp-Source: APXvYqys1bqBF6qilHbFw8ePP8Oz0kqMCC/OyqNSyE71nRg4AfWBpT/ltc4wsYnBZWUacn7ta7ZaDkRg7iZTRYkT488=
X-Received: by 2002:a1c:f702:: with SMTP id v2mr20309772wmh.114.1567187377255;
 Fri, 30 Aug 2019 10:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190829212417.257397-1-davidriley@chromium.org>
 <20190830060857.tzrzgoi2hrmchdi5@sirius.home.kraxel.org> <CAASgrz2v0DYb_5A3MnaWFM4Csx1DKkZe546v7DG7R+UyLOA8og@mail.gmail.com>
 <20190830111605.twzssycagmjhfa45@sirius.home.kraxel.org>
In-Reply-To: <20190830111605.twzssycagmjhfa45@sirius.home.kraxel.org>
From:   David Riley <davidriley@chromium.org>
Date:   Fri, 30 Aug 2019 10:49:25 -0700
Message-ID: <CAASgrz0SXc2bEXq4xPCry_oHMXNbau36Q9i20anbFq1X0FsoMQ@mail.gmail.com>
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

Hi Gerd,

On Fri, Aug 30, 2019 at 4:16 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > > -     kfree(vbuf->data_buf);
> > > > +     kvfree(vbuf->data_buf);
> > >
> > > if (is_vmalloc_addr(vbuf->data_buf)) ...
> > >
> > > needed here I gues?
> > >
> >
> > kvfree() handles vmalloc/kmalloc/kvmalloc internally by doing that check.
>
> Ok.
>
> > - videobuf_vmalloc_to_sg in drivers/media/v4l2-core/videobuf-dma-sg.c,
> > assumes contiguous array of scatterlist and that the buffer being converted
> > is page aligned
>
> Well, vmalloc memory _is_ page aligned.

True, but this function gets called for all potential enqueuings (eg
resource_create_3d, resource_attach_backing) and I was concerned that
some other usage in the future might not have that guarantee.  But if
that's overly being paranoid, I'm willing to backtrack on that.

> sg_alloc_table_from_pages() does alot of what you need, you just need a
> small loop around vmalloc_to_page() create a struct page array
> beforehand.

That feels like an extra allocation when under memory pressure and
more work, to not gain much -- there still needs to be a function that
iterates through all the pages.  But I don't feel super strongly about
it and can change it if you think that it will be less maintenance
overhead.

> Completely different approach: use get_user_pages() and don't copy the
> execbuffer at all.

This one I'd rather not do unless we can show that the copy is
actually a problem.  As it stands I expect this to be a fallback
instead of the regular case, and if it's not then the VMs need to
revisit how long the control queue size is.  Right now most
execbuffers end up being copied into a single contiguous buffer which
results in 3 descriptors of the virtio queue.  If vmalloc ends up
being used (which is only a fallback because vmemdup_user tries
kmalloc first still), then there'll be 66 descriptors for a 256KB
buffer.   I think that's fine for exceptional cases, but not ideal if
it was commonplace.

Chia-I suggested that we could have a flag for the ioctl execbuffer
indicating that the buffer is BO to solve that, but again I'd prefer
to see that it's actually a problem.

I'll also be moving the sg table construction out of the critical
section and properly accounting for the required number of descriptors
before entering it in response to his comments.

Thanks,
Dave
