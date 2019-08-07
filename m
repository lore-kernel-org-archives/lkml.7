Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C04FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FCB229F3
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QK21tnj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387860AbfHGI2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:28:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34486 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387414AbfHGI2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:28:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so101148832otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 01:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6VqkYW5Pb9NPAUWAJ1Hm+13eBgHLhXTSOzj6pGDrWaE=;
        b=QK21tnj2wA2WAGFXzboom94BfRwn1VGhGTG6G9qemB4Z1SDyDwLhNic25qBROeA+AO
         Otpbp/+1Z5xkFz2u3hnoNZl/7sxTpen5B6V3/zwbN6d3y8xKK5XCIRXb4BBm3yOt9/uk
         dmBZXigpTm+moy+wJpK9MV+2TKlKA3eVZ91iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6VqkYW5Pb9NPAUWAJ1Hm+13eBgHLhXTSOzj6pGDrWaE=;
        b=on6h78Lyt0algPISmgjNBgJrObcnE3UjT+VnYrSiA+uhIQqifAatMkHlbOrg1ggJmv
         BLmHH0rph2bz3wDYRlYRs+D1/L4AfasOCJg7qxYGy1gDAxYZl1wJFJY06zDXzpYwPXm/
         jsU28YlbS8XLoixEePMtHtb6PIwD9aCRsDz6wAWElPAUZ+WrbE5N5oICFie54BqVgqET
         Nv7cxsnjj2FOUbG0TGFoSPU8I0+mm5Tj7RtjqSqRIgQv2vrc0ptBbIr58xMpNIUnaIoU
         LxX1XV9fT9XMV+QA36OfSHvwfF5rBDae4kaXk/LEFMzOO7FlL4HgQbMCyQMr1o0/bL/W
         qKwA==
X-Gm-Message-State: APjAAAW39yu92NWKPJdYgCEew3Gu38Grp+GTMXqiFKh/buPdQeMK7d6s
        DffHHfwKGjdMHqWTARMyasQM5gr+Iiu2g+Gs9+Mn0Q==
X-Google-Smtp-Source: APXvYqymZlQCH2slZ+gCrcXV1SxxswvEQuyAECRxiL0EEkmtaR83NXQNrJ+EDazQrKj4+NEKCBEgfpvvPGGKw6+EC7A=
X-Received: by 2002:a05:6808:118:: with SMTP id b24mr4623781oie.128.1565166491437;
 Wed, 07 Aug 2019 01:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190806133454.8254-1-kraxel@redhat.com> <20190806133454.8254-2-kraxel@redhat.com>
 <20190806135426.GA7444@phenom.ffwll.local> <20190807072654.arqvx37p4yxhegcu@sirius.home.kraxel.org>
In-Reply-To: <20190807072654.arqvx37p4yxhegcu@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 7 Aug 2019 10:28:00 +0200
Message-ID: <CAKMK7uFyKd71w4H8nFk=WPSHL3KMwQ6kLwAMXTd_TAkrkJ++KQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm: add gem ttm helpers
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 9:29 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > > +/**
> > > + * drm_gem_ttm_mmap_offset() - Returns a GEM ttm object's mmap offset
> > > + * @gbo:   the GEM ttm object
> > > + *
> > > + * See drm_vma_node_offset_addr() for more information.
> > > + *
> > > + * Returns:
> > > + * The buffer object's offset for userspace mappings on success, or
> > > + * 0 if no offset is allocated.
> > > + */
> > > +u64 drm_gem_ttm_mmap_offset(struct ttm_buffer_object *bo)
> > > +{
> > > +   return drm_vma_node_offset_addr(&bo->base.vma_node);
> >
> > Why do we need a new one here, can't we use the existing gem
> > implementation for this (there really should only be one I hope, but I
> > didn't check).
>
> Havn't found one.

It got reverted out again:

commit 415d2e9e07574d3de63b8df77dc686e0ebf64865
Author: Rob Herring <robh@kernel.org>
Date:   Wed Jul 3 16:38:50 2019 -0600

    Revert "drm/gem: Rename drm_gem_dumb_map_offset() to drm_gem_map_offset()"


> But maybe we don't need this as separate function and can simply move
> the drm_vma_node_offset_addr() call into
> drm_gem_ttm_driver_dumb_mmap_offset().
>
> > > +int drm_gem_ttm_driver_dumb_mmap_offset(struct drm_file *file,
> > > +                                    struct drm_device *dev,
> > > +                                    uint32_t handle, uint64_t *offset)
> > > +{
> > > +   struct drm_gem_object *gem;
> > > +   struct ttm_buffer_object *bo;
> > > +
> > > +   gem = drm_gem_object_lookup(file, handle);
> > > +   if (!gem)
> > > +           return -ENOENT;
> > > +
> > > +   bo = drm_gem_ttm_of_gem(gem);
> > > +   *offset = drm_gem_ttm_mmap_offset(bo);
> > > +
> > > +   drm_gem_object_put_unlocked(gem);
> > > +
> > > +   return 0;
> > > +}
> > > +EXPORT_SYMBOL(drm_gem_ttm_driver_dumb_mmap_offset);
> >
> > Same for this, you're just upcasting to ttm_bo and then downcasting to
> > gem_bo again ... I think just a series to roll out the existing gem
> > helpers everywhere should work?
>
> I don't think so.  drm_gem_dumb_map_offset() calls
> drm_gem_create_mmap_offset(), which I think is not correct for ttm
> objects because ttm_bo_init() handles vma_node initialization.

More code to unify first? This should work exactly the same way for
all gem based drivers I think ... Only tricky bit is making sure
vmwgfx keeps working correctly.
-Daniel

>
> cheers,
>   Gerd
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
