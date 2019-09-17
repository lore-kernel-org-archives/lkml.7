Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4DCC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C0B2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UIBgNPUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfIQRhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 13:37:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33361 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfIQRhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:37:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id g25so3866297otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 10:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=myeTOn4EKbWCeWZItyJ7dMix4az19A16YH/1zXwAx38=;
        b=UIBgNPUkxeU/nT/tdJm8N1s4KusyfUdYDd1AG6sO6n+eMl46OgijLNddXwcY+dbYN8
         TTFvJ+3+HriNWqTy7pY+7kVuYVGcdqtz8zUvZ9jVga+VdAKWCP4AvkRAbQQGVR2Ffskc
         0nNxCLIQDRd8ZKSf9XfUNd4tnjKDRaBfVQSwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myeTOn4EKbWCeWZItyJ7dMix4az19A16YH/1zXwAx38=;
        b=LUJ/rv2i4QlpPkMMnN3GdzBwvUQY/WE8Eswl6O2wpSBgHo3ecSv/GTzGpQojbyVqs4
         LOncY4Obz3BbLGnvmskvghhZ/zYZV+TTUVtp7bp+6XQUj8DWkOdSvXiTngs5ExlXlPRN
         MF4kMVjPXdrDOolQr1iJYb8/TKwVDgYCqC6tzhXw+t3sspWGIylpzqrLn3PB4ZL82jzQ
         iaFxOHhbNVOo78DoFyIjoHdBJ9ajhkYsO+PwnCpWcH0kXi0ItqQtQ5c2DRnQfuxVI8s5
         Abv8Gk7xLE/zGuL4JQypbDONPOoEqnWRwQv6nf3jCtQHt82K0BYAgn8lVh1lIhu3sgEb
         A6cA==
X-Gm-Message-State: APjAAAVGoZcI7wq7N5pyqHaEYge2yiFAsHUbSIsVwNNjEWiCkmLLyXOK
        tULcZ5I8AEce3H13sVQR6v6qEsCcxlK2h/EIK73kNA==
X-Google-Smtp-Source: APXvYqzXvwT/07N+UI1uozfGGA8k2QE35LBv2qMI6EgYgPOhZ/9rrwHrX11ivt0KfMDbFoYAHjvEHYpG/cCuGZrhrzQ=
X-Received: by 2002:a9d:404:: with SMTP id 4mr29166otc.204.1568741817335; Tue,
 17 Sep 2019 10:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190909134241.23297-1-ayan.halder@arm.com> <20190917125301.GQ3958@phenom.ffwll.local>
 <20190917160730.hutzlbuqtpmmtdz3@e110455-lin.cambridge.arm.com> <11689dc3-6c3e-084b-b66d-e6ccf75cb8fb@baylibre.com>
In-Reply-To: <11689dc3-6c3e-084b-b66d-e6ccf75cb8fb@baylibre.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 17 Sep 2019 19:36:45 +0200
Message-ID: <CAKMK7uF7oKV4609Ca4mLj7gYC1rkWnWAV7_hM5Z48Ez1cBoMqA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm:- Add a modifier to denote 'protected' framebuffer
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 6:15 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 17/09/2019 18:07, Liviu Dudau wrote:
> > On Tue, Sep 17, 2019 at 02:53:01PM +0200, Daniel Vetter wrote:
> >> On Mon, Sep 09, 2019 at 01:42:53PM +0000, Ayan Halder wrote:
> >>> Add a modifier 'DRM_FORMAT_MOD_ARM_PROTECTED' which denotes that the framebuffer
> >>> is allocated in a protected system memory.
> >>> Essentially, we want to support EGL_EXT_protected_content in our komeda driver.
> >>>
> >>> Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> >>>
> >>> /-- Note to reviewer
> >>> Komeda driver is capable of rendering DRM (Digital Rights Management) protected
> >>> content. The DRM content is stored in a framebuffer allocated in system memory
> >>> (which needs some special hardware signals for access).
> >>>
> >>> Let us ignore how the protected system memory is allocated and for the scope of
> >>> this discussion, we want to figure out the best way possible for the userspace
> >>> to communicate to the drm driver to turn the protected mode on (for accessing the
> >>> framebuffer with the DRM content) or off.
> >>>
> >>> The possible ways by which the userspace could achieve this is via:-
> >>>
> >>> 1. Modifiers :- This looks to me the best way by which the userspace can
> >>> communicate to the kernel to turn the protected mode on for the komeda driver
> >>> as it is going to access one of the protected framebuffers. The only problem is
> >>> that the current modifiers describe the tiling/compression format. However, it
> >>> does not hurt to extend the meaning of modifiers to denote other attributes of
> >>> the framebuffer as well.
> >>>
> >>> The other reason is that on Android, we get an info from Gralloc
> >>> (GRALLOC_USAGE_PROTECTED) which tells us that the buffer is protected. This can
> >>> be used to set up the modifier/s (AddFB2) during framebuffer creation.
> >>
> >> How does this mesh with other modifiers, like AFBC? That's where I see the
> >> issue here.
> >
> > AFBC modifiers are currently under Arm's namespace, the thought behind the DRM
> > modifiers would be to have it as a "generic" modifier.

But if it's a generic flag, how do you combine that with other
modifiers? Like if you have a tiled buffer, but also encrypted? Or
afbc compressed, or whatever else. I'd expect for your hw encryption
is orthogonal to the buffer/tiling/compression format used?

> >>> 2. Framebuffer flags :- As of today, this can be one of the two values
> >>> ie (DRM_MODE_FB_INTERLACED/DRM_MODE_FB_MODIFIERS). Unlike modifiers, the drm
> >>> framebuffer flags are generic to the drm subsystem and ideally we should not
> >>> introduce any driver specific constraint/feature.
> >>>
> >>> 3. Connector property:- I could see the following properties used for DRM
> >>> protected content:-
> >>> DRM_MODE_CONTENT_PROTECTION_DESIRED / ENABLED :- "This property is used by
> >>> userspace to request the kernel protect future content communicated over
> >>> the link". Clearly, we are not concerned with the protection attributes of the
> >>> transmitter. So, we cannot use this property for our case.
> >>>
> >>> 4. DRM plane property:- Again, we want to communicate that the framebuffer(which
> >>> can be attached to any plane) is protected. So introducing a new plane property
> >>> does not help.
> >>>
> >>> 5. DRM crtc property:- For the same reason as above, introducing a new crtc
> >>> property does not help.
> >>
> >> 6. Just track this as part of buffer allocation, i.e. I think it does
> >> matter how you allocate these protected buffers. We could add a "is
> >> protected buffer" flag at the dma_buf level for this.
> >>
> >> So yeah for this stuff here I think we do want the full userspace side,
> >> from allocator to rendering something into this protected buffers (no need
> >> to also have the entire "decode a protected bitstream part" imo, since
> >> that will freak people out). Unfortunately, in my experience, that kills
> >> it for upstream :-/ But also in my experience of looking into this for
> >> other gpu's, we really need to have the full picture here to make sure
> >> we're not screwing this up.
> >
> > Maybe Ayan could've been a bit clearer in his message, but the ask here is for ideas
> > on how userspace "communicates" (stores?) the fact that the buffers are protected to
> > the kernel driver. In our display processor we need to the the hardware that the
> > buffers are protected before it tries to fetch them so that it can 1) enable the
> > additional hardware signaling that sets the protection around the stream; and 2) read
> > the protected buffers in a special mode where there the magic happens.

That was clear, but for the full picture we also need to know how
these buffers are produced and where they are allocated. One approach
would be to have a dma-buf heap that gives you encrypted buffers back.
With that we need to make sure that only encryption-aware drivers
allow such buffers to be imported, and the entire problem becomes a
kernel-internal one - aside from allocating the right kind of buffer
at the right place.

> > So yeah, we know we do want full userspace support, we're prodding the community on
> > answers on how to best let the kernel side know what userspace has done.
>
> Actually this is interesting for other multimedia SoCs implementing secure video decode
> paths where video buffers are allocated and managed by a trusted app.

Yeah I expect there's more than just arm wanting this. I also wonder
how that interacts with the secure memory allocator that was bobbing
around on dri-devel for a while, but seems to not have gone anywhere.
That thing implemented my idea of "secure memory is only allocated by
a special entity".
-Daniel

>
> Neil
>
> >
> > Best regards,
> > Liviu
> >
> >
> >> -Daniel
> >>
> >>>
> >>> --/
> >>>
> >>> ---
> >>>  include/uapi/drm/drm_fourcc.h | 9 +++++++++
> >>>  1 file changed, 9 insertions(+)
> >>>
> >>> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> >>> index 3feeaa3f987a..38e5e81d11fe 100644
> >>> --- a/include/uapi/drm/drm_fourcc.h
> >>> +++ b/include/uapi/drm/drm_fourcc.h
> >>> @@ -742,6 +742,15 @@ extern "C" {
> >>>   */
> >>>  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
> >>>
> >>> +/*
> >>> + * Protected framebuffer
> >>> + *
> >>> + * The framebuffer is allocated in a protected system memory which can be accessed
> >>> + * via some special hardware signals from the dpu. This is used to support
> >>> + * 'GRALLOC_USAGE_PROTECTED' in our framebuffer for EGL_EXT_protected_content.
> >>> + */
> >>> +#define DRM_FORMAT_MOD_ARM_PROTECTED       fourcc_mod_code(ARM, (1ULL << 55))
> >>> +
> >>>  /*
> >>>   * Allwinner tiled modifier
> >>>   *
> >>> --
> >>> 2.23.0
> >>>
> >>
> >> --
> >> Daniel Vetter
> >> Software Engineer, Intel Corporation
> >> http://blog.ffwll.ch
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
