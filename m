Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B25C3A59B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C3A2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BGaLtEn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbfHOSCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 14:02:02 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45116 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731524AbfHOSCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:02:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so2499947qki.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BnI8+uYTBZJKnMRavU1hA2TnI4rNr0e2aXC8LBXC9rk=;
        b=BGaLtEn0xYdBTNlc96MSvc0pra1wpogvEbh9GdU2lucZLzHp357V0Gu4O4fnG6AOf2
         BybrSFZaeZEzYMjh/IoUujmDgJd5IpCUR3tMstVXWjLAycVo9JtMa+b7MtCAS3YLD4Pd
         dgFmBtsLGh7Dhx4A4xWk9JocKdxSNpTPeGr8QLfny4yWKeB/twiqSr+/O8137DgtxKMx
         Jl9VLmWm8wQswZBqORI5f4rKt93iNPd/i6wk0e2H0oUug4hUvei5Afb61IF1snBw6wXa
         nsMBUVu57cjgGfgQB8mcQJtzDfAZ+xarKGUIbjN5S3r8JHADl8l+z4uWQ7PDRLewWs2y
         zxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BnI8+uYTBZJKnMRavU1hA2TnI4rNr0e2aXC8LBXC9rk=;
        b=TGJDBU4QdbN7oQPFvRjlL9oC9VKSAAi4+ILbr7LD/SXd9XpZYx0lz2Yn1m+jEj8Iz2
         A3mYf6zVhq8CTmS8MSxqEF83WJVkv0/7PbZSnsz+qJVaALbCujR+OmdRiZ9faoxrJoZv
         jLvBYE1UvwRUUVXmRUqAGocV9IwnJgB/ICLQLOR4pILjCJT+fNMUV5a9zk3sBaSJkHYA
         svlagp3v/JmC99rcteE82KGqLIY2SxQyUDdoDBGg5vGxIaBei8ts6PfEZ2IdWLM919ko
         FdjSBC/yaunRNrrvYtRiwDgudpAmZffQl3uB5Y5k0LQQp0Kk/cuDRCiEyvfXvLQ9b25g
         sisQ==
X-Gm-Message-State: APjAAAWNS9+de6Du5EM/G0x/uRl29RjLl7wcUUxQ9WHOYmy5SgIAqg95
        1hJxxkNs9JKHB/Y/1x8G6BNsJQ==
X-Google-Smtp-Source: APXvYqzUY9aELsjIwCbnfSumedqkjr92TBjXJsVE8TgDEc+tCA2CiEijqX4gn5MCyrtpQlRHD8QVUw==
X-Received: by 2002:a37:311:: with SMTP id 17mr4904431qkd.466.1565892120753;
        Thu, 15 Aug 2019 11:02:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p126sm2042871qkc.84.2019.08.15.11.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 11:02:00 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hyK4V-0007BP-Uc; Thu, 15 Aug 2019 15:01:59 -0300
Date:   Thu, 15 Aug 2019 15:01:59 -0300
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
Message-ID: <20190815180159.GO21596@ziepe.ca>
References: <20190814134558.fe659b1a9a169c0150c3e57c@linux-foundation.org>
 <20190815084429.GE9477@dhcp22.suse.cz>
 <20190815130415.GD21596@ziepe.ca>
 <CAKMK7uE9zdmBuvxa788ONYky=46GN=5Up34mKDmsJMkir4x7MQ@mail.gmail.com>
 <20190815143759.GG21596@ziepe.ca>
 <CAKMK7uEJQ6mPQaOWbT_6M+55T-dCVbsOxFnMC6KzLAMQNa-RGg@mail.gmail.com>
 <20190815151028.GJ21596@ziepe.ca>
 <CAKMK7uG33FFCGJrDV4-FHT2FWi+Z5SnQ7hoyBQd4hignzm1C-A@mail.gmail.com>
 <20190815173557.GN21596@ziepe.ca>
 <20190815173922.GH30916@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815173922.GH30916@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 01:39:22PM -0400, Jerome Glisse wrote:
> On Thu, Aug 15, 2019 at 02:35:57PM -0300, Jason Gunthorpe wrote:
> > On Thu, Aug 15, 2019 at 06:25:16PM +0200, Daniel Vetter wrote:
> > 
> > > I'm not really well versed in the details of our userptr, but both
> > > amdgpu and i915 wait for the gpu to complete from
> > > invalidate_range_start. Jerome has at least looked a lot at the amdgpu
> > > one, so maybe he can explain what exactly it is we're doing ...
> > 
> > amdgpu is (wrongly) using hmm for something, I can't really tell what
> > it is trying to do. The calls to dma_fence under the
> > invalidate_range_start do not give me a good feeling.
> > 
> > However, i915 shows all the signs of trying to follow the registration
> > cache model, it even has a nice comment in
> > i915_gem_userptr_get_pages() explaining that the races it has don't
> > matter because it is a user space bug to change the VA mapping in the
> > first place. That just screams registration cache to me.
> > 
> > So it is fine to run HW that way, but if you do, there is no reason to
> > fence inside the invalidate_range end. Just orphan the DMA buffer and
> > clean it up & release the page pins when all DMA buffer refs go to
> > zero. The next access to that VA should get a new DMA buffer with the
> > right mapping.
> > 
> > In other words the invalidation should be very simple without
> > complicated locking, or wait_event's. Look at hfi1 for example.
> 
> This would break the today usage model of uptr and it will
> break userspace expectation ie if GPU is writting to that
> memory and that memory then the userspace want to make sure
> that it will see what the GPU write.

How exactly? This is holding the page pin, so the only way the VA
mapping can be changed is via explicit user action.

ie:

   gpu_write_something(va, size)
   mmap(.., va, size, MMAP_FIXED);
   gpu_wait_done()

This is racy and indeterminate with both models.

Based on the comment in i915 it appears to be going on the model that
changes to the mmap by userspace when the GPU is working on it is a
programming bug. This is reasonable, lots of systems use this kind of
consistency model.

Since the driver seems to rely on a dma_fence to block DMA access, it
looks to me like the kernel has full visibility to the
'gpu_write_something()' and 'gpu_wait_done()' markers.

I think trying to use hmm_range_fault on HW that can't do HW page
faulting and HW 'TLB shootdown' is a very, very bad idea. I fear that
is what amd gpu is trying to do.

I haven't yet seen anything that looks like 'TLB shootdown' in i915??

Jason
