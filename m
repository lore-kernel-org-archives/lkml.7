Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED9AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AA921473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554137973;
	bh=8Zu8GE1ELFdcQnJhXcLPpDIyjEmYagEMkGPivKASCyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YIOapkcnAiCzbdoWBvPETzgvMLXnzsMUb0ew8sTWzlmmWz9lGkYCqmyBre2umV4Na
	 wwHsDn9ZlhtBFN/xc+SjTTbzzR9dRKY9thkNO9t8gIjmMvFbSxQ/RmXatsCzMWepXZ
	 3idEiNIsu++X7x4cTttEtXSzXOlXQBXIsLjICuL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfDAQ7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbfDAQ7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:59:31 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4857217D4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554137969;
        bh=8Zu8GE1ELFdcQnJhXcLPpDIyjEmYagEMkGPivKASCyY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GbxnvSS1jqsPiJ+uD/21Q1FMSGRxLwdLw3uOduJ21M/No+B4brt8l2kY5W9I7X/l6
         MVKbyLO4OG0tQuQ9fHF6Qc5SLbwhjO5PVrx1s1b0XmUL5khJZA0mQXPzEF7oEIqYdH
         QEb6hHAhML15lYCeOMXfVEe38b7bi7KV/kpePoqY=
Received: by mail-qt1-f179.google.com with SMTP id x12so11690168qts.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 09:59:29 -0700 (PDT)
X-Gm-Message-State: APjAAAXdvVJWnSdemyBuAOoGxh8p4CR0SFln4A/7ZbOrR7hGjQ19c6/V
        xrrdquAiDLtOTbYOpbJ7T1BRXtwtgw513nsXGQ==
X-Google-Smtp-Source: APXvYqx13UQgyuLWsJlsn6PI20o9DZ8FwDO7VwzczaZIOEiGZ8VzK7tyQFmx49+CYSl6NtRCNVcL+f8ClDfujCmSzvA=
X-Received: by 2002:aed:3e3d:: with SMTP id l58mr54635319qtf.77.1554137968967;
 Mon, 01 Apr 2019 09:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190401074730.12241-1-robh@kernel.org> <20190401074730.12241-3-robh@kernel.org>
 <CAKMK7uE7-XV3cZxS8GT_EDa7yojOLPQi+LqkF85h_0z_JL6gYw@mail.gmail.com>
In-Reply-To: <CAKMK7uE7-XV3cZxS8GT_EDa7yojOLPQi+LqkF85h_0z_JL6gYw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 1 Apr 2019 11:59:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ4uppXc_Sti67z0ZBJ4sw1RPgNHCg6usqpUmbQcGQmpQ@mail.gmail.com>
Message-ID: <CAL_JsqJ4uppXc_Sti67z0ZBJ4sw1RPgNHCg6usqpUmbQcGQmpQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm: Add a drm_gem_objects_lookup helper
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 8:07 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Apr 1, 2019 at 9:47 AM Rob Herring <robh@kernel.org> wrote:
> >
> > Similar to the single handle drm_gem_object_lookup(),
> > drm_gem_objects_lookup() takes an array of handles and returns an array
> > of GEM objects.
> >
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/gpu/drm/drm_gem.c | 46 +++++++++++++++++++++++++++++++--------
> >  include/drm/drm_gem.h     |  2 ++
> >  2 files changed, 39 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index 388b3742e562..5c9bff45e5e1 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> > @@ -663,6 +663,42 @@ void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
> >  }
> >  EXPORT_SYMBOL(drm_gem_put_pages);
> >
> > +/**
> > + * drm_gem_objects_lookup - look up GEM objects from an array of handles
> > + * @filp: DRM file private date
> > + * @handle: pointer to array of userspace handle
> > + * @count: size of handle array
> > + * @objs: pointer to array of drm_gem_object pointers
> > + *
> > + * Returns:
> > + *
> > + * @objs filled in with GEM object pointers. -ENOENT is returned on a lookup
> > + * failure. 0 is returned on success.
>
> Bonus points for adding references between the array and normal lookup
> functions to guide people around. Also a comment that the buffers need
> to be released with drm_gem_object_put().
>
> > + */
> > +int drm_gem_objects_lookup(struct drm_file *filp, u32 *handle, int count,
> > +                          struct drm_gem_object **objs)
>
> With a pointer to a pointer I'd expect this function to do the
> allocation, but it doesn't. Normal pointer is enough to pass an array.
> Also maybe make the handle pointer
> const, so it's clear that it's an input parameter.

I thought about doing the allocation here, but then I couldn't
implement the single drm_gem_object_lookup() using this function.
Maybe I can refactor in 3 functions making this one a static function.

Rob
