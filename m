Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4F1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50EB218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y5LkwRP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfCOV3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:29:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36887 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfCOV3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:29:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id x10so7343548wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rk+sbPv23pHB0SWVyfwfAqc8+OMYSMQjLRlRw9iLKG8=;
        b=y5LkwRP23VJGXrO05dM+Ihrt10z3/80/BTc5ODyZyAJ0sosI5x1XV1mMdnGcXSQt7G
         A0doSU3k1KyN3l/kYavE9bHgPNh06zS6yc9Nz64Jw1K9OYF/lAQIrytfhF3qNaH24pq+
         cCs7Oqhu1U0GBYKMtntjzOI98u2XB2DexwQ1qmu0ZGsLAXAkENpEfldYY/svcJTFIUPe
         MNFkXsJVxXtWo3u8UD6/75p+Q+LmDAbrV/fnoBm0EhZPNYlBsLOhRf/4WcfWSG2Dmvh/
         MqAT8opvaATntIZKcuuCiCjCWwlF2OlxEEZWyrjWN8hz0Qf1mWnE6BoW4WaV3fKzz9Yq
         GyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rk+sbPv23pHB0SWVyfwfAqc8+OMYSMQjLRlRw9iLKG8=;
        b=hQBqDsRfskvVTaGKGs5JeukOy/PqWxYOtgEXyaJGXo0V6xO1UFyq5Rcg10TPdAFMiP
         Pca3/B9Bys1c35+7bpTSZ+47lbv7GzyO0e7Z/dEQhmba3fEwSy3eOR25G3D0DQONjBtr
         TKWqqSzd3QoXUogy3XZWtLJ58kv0noFOpXNVKJcAFjEsJCMt+7ax5+8a5R4Zcr0jXOi2
         xK1b8S74lj7R6Y75PJdeG2vi0goBkVxGgWYdPZCOxp4IIifwrUow/ztlpdqdNCFMqgGA
         r6+E1zTSch0xwCvSLJ4gJbvUib7tSNPwEMTJqqbE1rcv4SY63oEVOgpvtuwN+eXqaQ+Y
         +aVQ==
X-Gm-Message-State: APjAAAVb3WNPTfASOL3dOM0LgiUdsEEwJZUzE9v5XMjimuHaxAc+u/9U
        c3AGSkb6+N4ZlQW6R5c/ZWm6Nwhu2IsYl8E9vGHAIw==
X-Google-Smtp-Source: APXvYqyiXO5zgF7uA4+q8K94OEhrydZxa52oOalPf3TwW+0umCrFFGWQLd8H4/i9m7sITrP9BKzxqQcnUPnD9sIiCtM=
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr3250176wmb.23.1552685356434;
 Fri, 15 Mar 2019 14:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-2-git-send-email-john.stultz@linaro.org> <b090063c-86ce-bc7b-4da0-80ca19883a47@redhat.com>
In-Reply-To: <b090063c-86ce-bc7b-4da0-80ca19883a47@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 15 Mar 2019 14:29:03 -0700
Message-ID: <CALAqxLXho_rwsdAY9u3=oTXukQnTzqfP_EFmwgdZm+A1bQRVuw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
To:     Laura Abbott <labbott@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 1:18 PM Laura Abbott <labbott@redhat.com> wrote:
>
> On 3/5/19 12:54 PM, John Stultz wrote:
> > +DMA-BUF HEAPS FRAMEWORK
> > +M:   Laura Abbott<labbott@redhat.com>
> > +R:   Liam Mark<lmark@codeaurora.org>
> > +R:   Brian Starkey<Brian.Starkey@arm.com>
> > +R:   "Andrew F. Davis"<afd@ti.com>
> > +R:   John Stultz<john.stultz@linaro.org>
> > +S:   Maintained
> > +L:   linux-media@vger.kernel.org
> > +L:   dri-devel@lists.freedesktop.org
> > +L:   linaro-mm-sig@lists.linaro.org  (moderated for non-subscribers)
> > +F:   include/uapi/linux/dma-heap.h
> > +F:   include/linux/dma-heap.h
> > +F:   drivers/dma-buf/dma-heap.c
> > +F:   drivers/dma-buf/heaps/*
> > +T:   git git://anongit.freedesktop.org/drm/drm-misc
>
> So I talked about this with Sumit privately but I think
> it might make sense to have me step down as maintainer when
> this goes out of staging. I mostly worked on Ion at my
> previous position and anything I do now is mostly a side
> project. I still want to see it succeed which is why I
> took on the maintainer role but I don't want to become blocking
> for people who have a stronger vision about where this needs
> to go (see also, I'm not working with this on a daily basis).
>
> If you just want someone to help review or take patches
> to be pulled, I'm happy to do so but I'd hate to become
> the bottleneck on getting things done for people who
> are attempting to do real work.

I worry this will make everyone to touch the side of their nose and
yell "NOT IT!" :)

First of all, thank you so much for your efforts maintaining ION along
with your attempts to drag out requirements from interested parties
and the numerous attempts to get collaborative discussion going at
countless conferences! Your persistence and continual nudging in the
face of apathetic private users of the code probably cannot be
appreciated enough!

Your past practical experience with ION and active work with the
upstream community made you a stand out pick for this, but I
understand not wanting to be eternally stuck with a maintainership if
your not active in the area.  I'm happy to volunteer as a neutral
party, but I worry my limited experience with some of the more
complicated usage would make my opinions less informed then they
probably need to be.  Further, as a neutral party, Sumit would
probably be a better pick since he's already maintaining the dmabuf
core.

So I'd nominate Andrew, Liam or Benjamin (or all three?) as they all
have more practical experience enabling past ION heaps on real devices
and have demonstrated active interest in working in the community.

So, in other words... NOT IT! :)
-john
