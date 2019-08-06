Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C806C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3636C20717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VvVVfZAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbfHFJiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 05:38:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34295 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFJiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:38:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so46892739edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 02:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lXyS+3a5qcDEyEF5LisBaQWkib6lVU2+K34nQBXYqTA=;
        b=VvVVfZAImggq+hv+uSLRfZNheEhVjvL+W5UVpgopska+tQ8Ns32KSgvyatrllNVad8
         8GXMBagHGD5RYCv4YfaSEOmkLu2BiH8CqUfZr0AvoqzTNY8/+hR40D4CrQXnT4khXUlf
         mxChHJ1ZYcKjNhkwkqyFKIV2AgxEs20G4jtB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=lXyS+3a5qcDEyEF5LisBaQWkib6lVU2+K34nQBXYqTA=;
        b=f/MbZBNlJ6wfc/iEI+b+h4DEpWfUlDs/XPZg4E3bxTv1tIvTs9EUPwVMSiNVAv1kcT
         QKsy4FO02IoFw2JNCphkTEoDCx70Yelq5ZMwgemNcDOySHAy3dE/2DuGTqzxy1lVoKIH
         vBW9BPX8xc4BlJMxqLBc/hl7c5l/V4bZPCRKy3CXQ7wbbmdKRd3gY2YuOFx4GqK4uz10
         AIHzjk61JGnQUVs07Q3xw2cWG+zkI3siQCqvufB9SQYYrXSWC6lfrxlqBb9TjdYuHMhI
         L7+mexKAu6ofEIvDk0y4N4ltF80rm15NrWiOb8M0SIevrMRjwhGG9sDYmtHd0XwdjcE8
         Z8Aw==
X-Gm-Message-State: APjAAAUP9ndJQzpg5oAEsT1cjcp2qX5WtMlt9PCqnF7U+NQNTvHbXpRh
        Q2RhBDlhsjtcbSbYyf75dejBag==
X-Google-Smtp-Source: APXvYqzqH6/bXZ26nVBNYTN2PzoLaN+S9OSr40dprY04zqgu8B5JxMBvPeFFL2JFhDIKf3hdZUQCxA==
X-Received: by 2002:a50:d79b:: with SMTP id w27mr2729896edi.126.1565084299696;
        Tue, 06 Aug 2019 02:38:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id cw14sm14578958ejb.91.2019.08.06.02.38.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 02:38:18 -0700 (PDT)
Date:   Tue, 6 Aug 2019 11:38:16 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: add cache support for arm64
Message-ID: <20190806093816.GY7444@phenom.ffwll.local>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190805211451.20176-1-robdclark@gmail.com>
 <20190806084821.GA17129@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806084821.GA17129@lst.de>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 10:48:21AM +0200, Christoph Hellwig wrote:
> This goes in the wrong direction.  drm_cflush_* are a bad API we need to
> get rid of, not add use of it.  The reason for that is two-fold:
> 
>  a) it doesn't address how cache maintaince actually works in most
>     platforms.  When talking about a cache we three fundamental operations:
> 
> 	1) write back - this writes the content of the cache back to the
> 	   backing memory
> 	2) invalidate - this remove the content of the cache
> 	3) write back + invalidate - do both of the above
> 
>  b) which of the above operation you use when depends on a couple of
>     factors of what you want to do with the range you do the cache
>     maintainance operations
> 
> Take a look at the comment in arch/arc/mm/dma.c around line 30 that
> explains how this applies to buffer ownership management.  Note that
> "for device" applies to "for userspace" in the same way, just that
> userspace then also needs to follow this protocol.  So the whole idea
> that random driver code calls random low-level cache maintainance
> operations (and use the non-specific term flush to make it all more
> confusing) is a bad idea.  Fortunately enough we have really good
> arch helpers for all non-coherent architectures (this excludes the
> magic i915 won't be covered by that, but that is a separate issue
> to be addressed later, and the fact that while arm32 did grew them
> very recently and doesn't expose them for all configs, which is easily
> fixable if needed) with arch_sync_dma_for_device and
> arch_sync_dma_for_cpu.  So what we need is to figure out where we
> have valid cases for buffer ownership transfer outside the DMA
> API, and build proper wrappers around the above function for that.
> My guess is it should probably be build to go with the iommu API
> as that is the only other way to map memory for DMA access, but
> if you have a better idea I'd be open to discussion.

I just read through all the arch_sync_dma_for_device/cpu functions and
none seem to use the struct *dev argument. Iirc you've said that's on the
way out?

That dev parameter is another holdup for the places where we do not yet
know what the new device will be (e.g. generic dma-buf exporters like
vgem). And sprinkling a fake dev or passing NULL is a bit silly.

Add a HAVE_ARCH_SYNC_DMA and the above refactor (assuming it's ok to roll
out everywhere) and we should indeed be able to use this. We still need to
have all the others for x86 and all that. Plus I guess we should roll out
the split into invalidate and flush.

The other bit is phys vs. virt addr confusion, but looks like standard if
phys_addr and you kmap underneath (except from drm_clflush_virt_range,
only used by i915).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
