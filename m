Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D511EC41514
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1A72086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f5hy2L4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbfHOS5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 14:57:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36300 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731649AbfHOS5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:57:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so3455141qtc.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 11:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FHRVs8d/XUYBFJ0v54ixeAZNXrYoqSp3PXhqb8jtHuk=;
        b=f5hy2L4ne+Nk9hvc+Cs1SmyIY0e0sZgq3H9QjMGhICCOQyK1i3auQwTufLME4Mv974
         0aulvZuvp1aV19tl7YBvcpnpH4UbGlSErRpK6IN8M0MgEsCOm/Pd3elvLwczS1QoYGfZ
         CRLxHag/OPjHZ8TMWYRgHwSM8G5hs7ib7icsD2B5BZeSW9+S8YNH9RNazv0umrEp66sb
         fTeBUGnFlJ++gZcie138/gu1kox+IYbNnbpG13WRGRjjWQbzc1VFafHpodwfitsLNIep
         qRYhhiS1ZosqrJXeIbsiAVf0BXg8QpjquImzVnd4ua8nDBvtbBZ7CRxayONNl5vMbgjF
         5wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FHRVs8d/XUYBFJ0v54ixeAZNXrYoqSp3PXhqb8jtHuk=;
        b=Z74dILnhdjMIi/Qc/gtulyleHWYYq7xkSwbJ48XKI4BcoTc2ZulygXFkTlQcrHvQzb
         0hYqX5HCitu+bBJHR5Hib5gS7dwp6PjWXXturkANEhpJyUVWGH1oFDa88obyu/M2Wq97
         p3lyZkKl9xuEpIgwT93OZSF531DcofgKvwX6RPg+v35XqxFv2JVTpiHp0j6pD8QgnPbS
         nwd/T3QP1wmRvI6wXLXPI1LRL9LrQkNDY2ZnQrTgkljY8jTbpvOmDWurMWCp61yziSyi
         CVpkccK6/cvIG26/JT4mHfwtfx4Hln1N+l31lL7FQPHSERY8T1vuzz/gQ6ELnJehvvvo
         HJnQ==
X-Gm-Message-State: APjAAAWKpeXjupXci5vdVA7Ny6+v8qxkqcCjIWy2QFcCQqoI9fxoK+9J
        nqR5jv4io9l0jfwEy6F5e0du8rqMH9M=
X-Google-Smtp-Source: APXvYqxjLmxNeFjmli8wX4zskAvMxPbirFP9zV8m/2PlRmhm3DonMF9Q6OJuAF/HRcwUiH7YcMzZ6g==
X-Received: by 2002:ad4:41cc:: with SMTP id a12mr4452947qvq.0.1565895465226;
        Thu, 15 Aug 2019 11:57:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q62sm1993341qkb.69.2019.08.15.11.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 11:57:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hyKwR-0007hH-UA; Thu, 15 Aug 2019 15:57:43 -0300
Date:   Thu, 15 Aug 2019 15:57:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-ID: <20190815185743.GQ21596@ziepe.ca>
References: <20190815130415.GD21596@ziepe.ca>
 <CAKMK7uE9zdmBuvxa788ONYky=46GN=5Up34mKDmsJMkir4x7MQ@mail.gmail.com>
 <20190815143759.GG21596@ziepe.ca>
 <CAKMK7uEJQ6mPQaOWbT_6M+55T-dCVbsOxFnMC6KzLAMQNa-RGg@mail.gmail.com>
 <20190815151028.GJ21596@ziepe.ca>
 <CAKMK7uG33FFCGJrDV4-FHT2FWi+Z5SnQ7hoyBQd4hignzm1C-A@mail.gmail.com>
 <20190815173557.GN21596@ziepe.ca>
 <20190815173922.GH30916@redhat.com>
 <20190815180159.GO21596@ziepe.ca>
 <20190815182719.GB4920@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815182719.GB4920@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 02:27:19PM -0400, Jerome Glisse wrote:
> > How exactly? This is holding the page pin, so the only way the VA
> > mapping can be changed is via explicit user action.
> > 
> > ie:
> > 
> >    gpu_write_something(va, size)
> >    mmap(.., va, size, MMAP_FIXED);
> >    gpu_wait_done()
> > 
> > This is racy and indeterminate with both models.
> > 
> > Based on the comment in i915 it appears to be going on the model that
> > changes to the mmap by userspace when the GPU is working on it is a
> > programming bug. This is reasonable, lots of systems use this kind of
> > consistency model.
> 
> Well userspace process doing munmap(), mremap(), fork() and things like
> that are a bug from the i915 kernel and userspace contract point of view.
> 
> But things like migration or reclaim are not cover under that contract
> and for those the expectation is that CPU access to the same virtual address
> should allow to get what was last written to it either by the GPU or the
> CPU.

Okay, this is a more reasonable point - I agree the i915 registration
cache model precludes using migration and thus DEVICE_PRIVATE. This is
a strong motivation to use the hmm approach

But we started out this converstation asking if i915 is correct, and I
still say a registration cache model is a functionally correct way to
use notifiers.

> Because of the reference on the page the i915 driver can forego the mmu
> notifier end callback. The thing here is that taking a page reference
> is pointless if we have better synchronization and tracking of mmu
> notifier. Hence converting to hmm mirror allows to avoid taking a ref
> on the page while still keeping the same functionality as of today.

However, there is a huge trade off here. Drivers like this are going
to have a very complicated locking inside invalidate_range_start as
they must sleep waiting for dma buffer references to go to zero.

> GPU driver have complex usage pattern the tlb shootdown is implicit
> once the GEM object associated with the uptr is invalidated it means
> next time userspace submit command against that GEM object it will
> have to re-validate it which means re-program the GPU page table to
> point to the proper address (and re-call GUP).

I think it is a mistake to try and cram the very different approaches
to notifiers into the same API. SW ref counting of DMA buffers vs HW
async page faulting have totally different requirements and locking
schemes.

This explains why AMDGPU gets away with not using the hmm API
properly, it is probably relying on its DMA refcount, not the hmm
valid, to keep things in order?

I think the API approach in hmm_mirror is reasonable for page faulting
HW, but does not serve refcounting HW well at all.

Jason
