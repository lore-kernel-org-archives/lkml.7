Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10887C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA0D2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VbqfDbhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfIQMxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:53:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46964 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfIQMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:53:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id t3so1003406edw.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hO+S2hn6G7IY85utEMPYlFYUwK0C3wWS4/W0+cvkWvo=;
        b=VbqfDbhYu5lY9hD/YtniwKxIj8byA+w6ZYv9TnFclvEWGntf4QTtQMKzIC6r9Q94UR
         6wEfXIofBdkKXWmaOoguT6JyQX+Xm/5qgXuA3d9gXp8/ibLFeVgf9rDDs/28vhIs60Jp
         G9rx1ZwPbHW0jnFONJB0tr8UUPb05EtgaBvIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=hO+S2hn6G7IY85utEMPYlFYUwK0C3wWS4/W0+cvkWvo=;
        b=iaO+u0KY2aq58hge5GEE65w+0GlDPEiv8tngLM80F++KRozUCuOGTAw9yTwwU3G+Kx
         8Bb0EAn5ZWGU+WehliU9Um9GzkWSYOmo+fwnhxUBJZSMpmKBiUiOxhz1lX0EAuZ3EvKy
         pQZNvKxy3cLNhaEn8oIAsyVUPqrA4mhF2Ols4DHbyvZlCXrLDBwRGHo6zu86SnEArSrc
         A3wkWIhtYCAVanC6XPlOM11xgIV1Y55K8hiFbntUCjSWqFFcYDWI1/+3KFp1uJLG61q1
         I2RRiTjV0a4HyRTvRi3+VW8MUV6b2HSF7Ic6gDBXvW4B/zvOPn3LOm3NfXgOie256ja+
         XjJw==
X-Gm-Message-State: APjAAAXglUufs470non2+8H+afyz6HJfSNGhVc0Q2R9yMU25h1u59Yes
        G2O9K3IeL80V1diyqPtFqR384Q==
X-Google-Smtp-Source: APXvYqwMfjAvYVaFs8oW8jSgXu1sWU9T6LkhxnE/tQlcylPsSiT/jdUiW99WUngxF+LYi3GeN9sBeg==
X-Received: by 2002:a17:906:1e0e:: with SMTP id g14mr4455036ejj.247.1568724784844;
        Tue, 17 Sep 2019 05:53:04 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id e44sm422367ede.34.2019.09.17.05.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 05:53:04 -0700 (PDT)
Date:   Tue, 17 Sep 2019 14:53:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [RFC PATCH] drm:- Add a modifier to denote 'protected'
 framebuffer
Message-ID: <20190917125301.GQ3958@phenom.ffwll.local>
Mail-Followup-To: Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
References: <20190909134241.23297-1-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909134241.23297-1-ayan.halder@arm.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 01:42:53PM +0000, Ayan Halder wrote:
> Add a modifier 'DRM_FORMAT_MOD_ARM_PROTECTED' which denotes that the framebuffer
> is allocated in a protected system memory.
> Essentially, we want to support EGL_EXT_protected_content in our komeda driver.
> 
> Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> 
> /-- Note to reviewer
> Komeda driver is capable of rendering DRM (Digital Rights Management) protected
> content. The DRM content is stored in a framebuffer allocated in system memory
> (which needs some special hardware signals for access).
> 
> Let us ignore how the protected system memory is allocated and for the scope of
> this discussion, we want to figure out the best way possible for the userspace
> to communicate to the drm driver to turn the protected mode on (for accessing the
> framebuffer with the DRM content) or off.
> 
> The possible ways by which the userspace could achieve this is via:-
> 
> 1. Modifiers :- This looks to me the best way by which the userspace can
> communicate to the kernel to turn the protected mode on for the komeda driver
> as it is going to access one of the protected framebuffers. The only problem is
> that the current modifiers describe the tiling/compression format. However, it
> does not hurt to extend the meaning of modifiers to denote other attributes of
> the framebuffer as well.
> 
> The other reason is that on Android, we get an info from Gralloc
> (GRALLOC_USAGE_PROTECTED) which tells us that the buffer is protected. This can
> be used to set up the modifier/s (AddFB2) during framebuffer creation.

How does this mesh with other modifiers, like AFBC? That's where I see the
issue here.
> 
> 2. Framebuffer flags :- As of today, this can be one of the two values
> ie (DRM_MODE_FB_INTERLACED/DRM_MODE_FB_MODIFIERS). Unlike modifiers, the drm
> framebuffer flags are generic to the drm subsystem and ideally we should not
> introduce any driver specific constraint/feature.
> 
> 3. Connector property:- I could see the following properties used for DRM
> protected content:-
> DRM_MODE_CONTENT_PROTECTION_DESIRED / ENABLED :- "This property is used by
> userspace to request the kernel protect future content communicated over
> the link". Clearly, we are not concerned with the protection attributes of the
> transmitter. So, we cannot use this property for our case.
> 
> 4. DRM plane property:- Again, we want to communicate that the framebuffer(which
> can be attached to any plane) is protected. So introducing a new plane property
> does not help.
> 
> 5. DRM crtc property:- For the same reason as above, introducing a new crtc
> property does not help.

6. Just track this as part of buffer allocation, i.e. I think it does
matter how you allocate these protected buffers. We could add a "is
protected buffer" flag at the dma_buf level for this.

So yeah for this stuff here I think we do want the full userspace side,
from allocator to rendering something into this protected buffers (no need
to also have the entire "decode a protected bitstream part" imo, since
that will freak people out). Unfortunately, in my experience, that kills
it for upstream :-/ But also in my experience of looking into this for
other gpu's, we really need to have the full picture here to make sure
we're not screwing this up.
-Daniel

> 
> --/
> 
> ---
>  include/uapi/drm/drm_fourcc.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 3feeaa3f987a..38e5e81d11fe 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -742,6 +742,15 @@ extern "C" {
>   */
>  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
>  
> +/*
> + * Protected framebuffer
> + *
> + * The framebuffer is allocated in a protected system memory which can be accessed
> + * via some special hardware signals from the dpu. This is used to support
> + * 'GRALLOC_USAGE_PROTECTED' in our framebuffer for EGL_EXT_protected_content.
> + */
> +#define DRM_FORMAT_MOD_ARM_PROTECTED	fourcc_mod_code(ARM, (1ULL << 55))
> +
>  /*
>   * Allwinner tiled modifier
>   *
> -- 
> 2.23.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
