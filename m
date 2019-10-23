Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B94C47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A9B20640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="i0jlpYaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405868AbfJWNel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:34:41 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37181 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391453AbfJWNel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:34:41 -0400
Received: by mail-oi1-f193.google.com with SMTP id i16so17367430oie.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 06:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rlgAUb4WY4bYebtDST8C0ocqKTOSomIXSLYZGI3cJAU=;
        b=i0jlpYaBX/vOYcjTU0UXPJ7iDxNoV+6RP+NKrDfSO8B7MpNwF0xXYjeLKlOhInFTTq
         CeWj1wBO4K3Z8iR2m9Itkbz1pbmSzuKwcj8h21fX5f8O1g4QkS2Vxfshh4JIPC9TVj25
         7nhx916QgsQRibCng0aNrDPEFl3hVJtEoztmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlgAUb4WY4bYebtDST8C0ocqKTOSomIXSLYZGI3cJAU=;
        b=jp3M18cdvG2xXpqmV0cSLQ3e7sWkHcoTCFNqDGUCR8idLsH5ldHbDhuy7N1H7zki1S
         aw9oKImTc47sN1yPnwTtCrzACm5tFj+sxlMUXFh0ZeFuZ/8i9mwRWgaY+NQNzIjPCF8H
         eC555eO2hmyTewavVgZ5reTgZcu27k9by3o1aD8/lIXFgEyLYink5cyGIz4UR3tGdUWX
         vvM+AlAQg1r6ZkTDuoFMUQguye44Ui94l3Eq2HDYsPVXeG640wkBj8qpaNfKTl/ZqnsV
         Z0kAkCuLUd07pot/KR1+VAzWF7cZDZRhJCSYWBLYs83aJNdxjZL8AgvfGKnnLCVbL6/c
         2hVQ==
X-Gm-Message-State: APjAAAUeUCYQU7RsCGYJEPJjZBhFQuUSEcF8F6S1NfH554YJr5ZPBS7h
        M42uOSGgjTHh40JWz8mfGluSfNU8OnmJera3AyPEKK6U
X-Google-Smtp-Source: APXvYqy6RDvKXlzgV6NahYfYxTpMsFQqfwHGTFFoshW8+fYVQTSO5pSR4bQUi60/9B5kzbnKoIVIfHs8KxTFUlcyEc4=
X-Received: by 2002:aca:1b10:: with SMTP id b16mr7955262oib.110.1571837680242;
 Wed, 23 Oct 2019 06:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191018113832.5460-1-kraxel@redhat.com> <20191022090533.GB11828@phenom.ffwll.local>
 <87mudreh2p.fsf@intel.com>
In-Reply-To: <87mudreh2p.fsf@intel.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 23 Oct 2019 15:34:27 +0200
Message-ID: <CAKMK7uGm7gYQoEyoZDYYzGO6OBw6AdEwHRDOPDtvNOm-ijWJMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: print a single line with device features
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 3:18 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Tue, 22 Oct 2019, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Fri, Oct 18, 2019 at 01:38:32PM +0200, Gerd Hoffmann wrote:
> >> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >> ---
> >>  drivers/gpu/drm/virtio/virtgpu_kms.c | 9 ++++-----
> >>  1 file changed, 4 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> >> index 0b3cdb0d83b0..2f5773e43557 100644
> >> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> >> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> >> @@ -155,16 +155,15 @@ int virtio_gpu_init(struct drm_device *dev)
> >>  #ifdef __LITTLE_ENDIAN
> >>      if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
> >>              vgdev->has_virgl_3d = true;
> >> -    DRM_INFO("virgl 3d acceleration %s\n",
> >> -             vgdev->has_virgl_3d ? "enabled" : "not supported by host");
> >> -#else
> >> -    DRM_INFO("virgl 3d acceleration not supported by guest\n");
> >>  #endif
> >>      if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
> >>              vgdev->has_edid = true;
> >> -            DRM_INFO("EDID support available.\n");
> >>      }
> >>
> >> +    DRM_INFO("features: %cvirgl %cedid\n",
> >> +             vgdev->has_virgl_3d ? '+' : '-',
> >> +             vgdev->has_edid     ? '+' : '-');
> >
> > Maybe we should move the various yesno/onoff/enableddisabled helpers from
> > i915_utils.h to drm_utils.h and use them more widely?
>
> I'm trying to take it one step further by adding them to
> include/linux/string-choice.h [1]. Maybe, uh, fourth time's the charm?
>
> BR,
> Jani.
>
> [1] http://lore.kernel.org/r/20191023131308.9420-1-jani.nikula@intel.com

Oh nice, r-b: me on that.

I think the rule for new headers like this is "just do it" once you
have enough senior kernel maintainers' approval. Maybe ask Dave Airlie
for ack and with Greg's r-b then just stuff it into drm-misc-next or
so?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
