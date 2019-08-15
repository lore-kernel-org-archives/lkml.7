Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF91BC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819F42054F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DOotlbxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbfHOQZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:25:40 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36336 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbfHOQZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:25:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id c15so2661722oic.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wAN07Aej6p7Hd2hVE0xjo/DUiYqDdqV1ia2cD28NFxQ=;
        b=DOotlbxSe+oEc7h+VfeydF2jzAD8OEvRpE+Mg/T7l9NuSqDLgxqy80Rm7yaUhdlUsq
         XgZgOuBZPynYHO4pUyg0M+oxFE8PtShe6V/b9aN3W9gEmBvrEDd3jLri92IEvOnBd8yU
         d6tqu6UAtAcEGMC2AAWjeIO4ADYzS2PbO0fdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wAN07Aej6p7Hd2hVE0xjo/DUiYqDdqV1ia2cD28NFxQ=;
        b=FduP1MwkOK55cQBwKU9/H6zCKcDdpDGvjyZVeLLluzHxLrDAQ7Qut8C9Iw33CgQrFh
         GyslbxsyaDqprC4LtRuFn1QuM9s9Wlx06qsqqHerlweWKkMfwttPYr7PG4nIeO3TyMT5
         7Cg8j6BHoPJRkbEI+pUuMsGa2AJIk30BVjGn1r9WTUzrxnYRuSmWcOGirvtSLjWsglGt
         YTDaCJdwI4BdXOwBuymcGJFF77walM8UXSGIGt8zonBMkCWMJ6hf79eJV5ChzXs+tcZN
         S/3i/Ye9OKEP1PAKcobAoOg5ug8nQ2Jml878DENpoN88kNYoNYk4XUfuWv6PuLgHqGRf
         51HA==
X-Gm-Message-State: APjAAAUmu6fra06p9lLJgXuXBI23p436XRDUMvBVKgWMngkCbZcC3bXo
        HB0sHEaeP4eUnJIHVLRTQMRUFvaGlUUdcnA36c98pw==
X-Google-Smtp-Source: APXvYqx5YhSWqsE1qNwb3e6Mk3OQ7+I0+E8yd7D6yMtzpx5rSV3pk3wPcLHj+cK8qGuWQRqpgPomSdRixh5Xeblp1Ps=
X-Received: by 2002:a54:4f89:: with SMTP id g9mr2267959oiy.110.1565886327298;
 Thu, 15 Aug 2019 09:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-3-daniel.vetter@ffwll.ch> <20190814134558.fe659b1a9a169c0150c3e57c@linux-foundation.org>
 <20190815084429.GE9477@dhcp22.suse.cz> <20190815130415.GD21596@ziepe.ca>
 <CAKMK7uE9zdmBuvxa788ONYky=46GN=5Up34mKDmsJMkir4x7MQ@mail.gmail.com>
 <20190815143759.GG21596@ziepe.ca> <CAKMK7uEJQ6mPQaOWbT_6M+55T-dCVbsOxFnMC6KzLAMQNa-RGg@mail.gmail.com>
 <20190815151028.GJ21596@ziepe.ca>
In-Reply-To: <20190815151028.GJ21596@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 15 Aug 2019 18:25:16 +0200
Message-ID: <CAKMK7uG33FFCGJrDV4-FHT2FWi+Z5SnQ7hoyBQd4hignzm1C-A@mail.gmail.com>
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 5:10 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Aug 15, 2019 at 04:43:38PM +0200, Daniel Vetter wrote:
>
> > You have to wait for the gpu to finnish current processing in
> > invalidate_range_start. Otherwise there's no point to any of this
> > really. So the wait_event/dma_fence_wait are unavoidable really.
>
> I don't envy your task :|
>
> But, what you describe sure sounds like a 'registration cache' model,
> not the 'shadow pte' model of coherency.
>
> The key difference is that a regirstationcache is allowed to become
> incoherent with the VMA's because it holds page pins. It is a
> programming bug in userspace to change VA mappings via mmap/munmap/etc
> while the device is working on that VA, but it does not harm system
> integrity because of the page pin.
>
> The cache ensures that each initiated operation sees a DMA setup that
> matches the current VA map when the operation is initiated and allows
> expensive device DMA setups to be re-used.
>
> A 'shadow pte' model (ie hmm) *really* needs device support to
> directly block DMA access - ie trigger 'device page fault'. ie the
> invalidate_start should inform the device to enter a fault mode and
> that is it.  If the device can't do that, then the driver probably
> shouldn't persue this level of coherency. The driver would quickly get
> into the messy locking problems like dma_fence_wait from a notifier.
>
> It is important to identify what model you are going for as defining a
> 'registration cache' coherence expectation allows the driver to skip
> blocking in invalidate_range_start. All it does is invalidate the
> cache so that future operations pick up the new VA mapping.
>
> Intel's HFI RDMA driver uses this model extensively, and I think it is
> well proven, within some limitations of course.
>
> At least, 'registration cache' is the only use model I know of where
> it is acceptable to skip invalidate_range_end.

I'm not really well versed in the details of our userptr, but both
amdgpu and i915 wait for the gpu to complete from
invalidate_range_start. Jerome has at least looked a lot at the amdgpu
one, so maybe he can explain what exactly it is we're doing ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
