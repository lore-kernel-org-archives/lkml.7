Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275A9C3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E349C2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="S6sVqqeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbfHOUN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:13:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32799 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOUN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:13:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id v38so3733037qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 13:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mio1xktEO9q23/NS5ON0GXRmSn9NHKr3YSBeJ7ROdYQ=;
        b=S6sVqqeV2cEhfAMUNUoWKW03ZmeT4Q8V2u1Ez10zAFGO4HA9huyr9rt0S2IIbugoLs
         BjKJPyVPythwQA+QLp5/dE1UTzcIF0mCZNp47DlRYMvNPdgDagPGR9fhK9+wYViWWFiu
         DhWdxuYxz7Jey2r3b862MWf/O0H7maCDrcaFhH/STgnhN9JyHUpSOSLrT7xT8Vzh3Rqr
         HyKeBKZuti7SrcbVz0vOnrmluJd5V1yWBGS9oJ7vaxu91B0sSFFBAjf5L/r5KC9Jp7N9
         YPpv6NvCcrv+FDgt9FA1Ry71JAdHbSC+QSHwomxgiOmjWE2z/x/GgqHTXGh24YAUZy6Q
         a58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mio1xktEO9q23/NS5ON0GXRmSn9NHKr3YSBeJ7ROdYQ=;
        b=SgCSigUvPZ+JFbkYhRPZy80MS3hkbZqe2+FNvCxPIWaCsZaud8NJ+odkCHmBtsxkNC
         THFzwceVceafNH2crP32EbQxYUkczvABWH8BK+9/s1AO5ms3UWqTx+bHfgPv1M8oLXGT
         RHWk+zNgMlP+Urvs8cAgva7zWRJJ5WwM1l4EhiUoidE9czjbA7iRQtgcr3v7g2NLI5uG
         tioDSjIem0xsidSvSeMPCxsRqH1VpFF6MlV6ibAR70Rgg6C+rKXFOqoRV/3oGlC1UINM
         cmE4gmRc4DlJzfhC5sJyTskM+hRoHVJ5aqoFqmXI1cq8bl93VubiunrJMShIgVrr9Vbr
         lF4w==
X-Gm-Message-State: APjAAAVomH759RpeUX7SSgbt6BaHp8bK2JyI7cmA2bYa5NY6fRBK+8vs
        PaOK3dJ66zTzljToRtcmOM6dEw==
X-Google-Smtp-Source: APXvYqxRY84lSul6rE4VEDZgKI9Yckn67Kds7s8VhylT1WxyiY8LnBxZ7eyr+D26crtE0YOaENxomw==
X-Received: by 2002:ac8:5491:: with SMTP id h17mr5522593qtq.227.1565900004931;
        Thu, 15 Aug 2019 13:13:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j66sm1870824qkf.86.2019.08.15.13.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 13:13:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hyM7f-0000Bx-WD; Thu, 15 Aug 2019 17:13:24 -0300
Date:   Thu, 15 Aug 2019 17:13:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-ID: <20190815201323.GU21596@ziepe.ca>
References: <20190815122344.GA21596@ziepe.ca>
 <20190815132127.GI9477@dhcp22.suse.cz>
 <20190815141219.GF21596@ziepe.ca>
 <20190815155950.GN9477@dhcp22.suse.cz>
 <20190815165631.GK21596@ziepe.ca>
 <20190815174207.GR9477@dhcp22.suse.cz>
 <20190815182448.GP21596@ziepe.ca>
 <20190815190525.GS9477@dhcp22.suse.cz>
 <20190815191810.GR21596@ziepe.ca>
 <20190815193526.GT9477@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815193526.GT9477@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 09:35:26PM +0200, Michal Hocko wrote:

> > The last detail is I'm still unclear what a GFP flags a blockable
> > invalidate_range_start() should use. Is GFP_KERNEL OK?
> 
> I hope I will not make this muddy again ;)
> invalidate_range_start in the blockable mode can use/depend on any sleepable
> allocation allowed in the context it is called from. 

'in the context is is called from' is the magic phrase, as
invalidate_range_start is called while holding several different mm
related locks. I know at least write mmap_sem and i_mmap_rwsem
(write?)

Can GFP_KERNEL be called while holding those locks?

This is the question of indirect dependency on reclaim via locks you
raised earlier.

> So in other words it is no different from any other function in the
> kernel that calls into allocator. As the API is missing gfp context
> then I hope it is not called from any restricted contexts (except
> from the oom which we have !blockable for).

Yes, the callers are exactly my concern.
 
> > Lockdep has
> > complained on that in past due to fs_reclaim - how do you know if it
> > is a false positive?
> 
> I would have to see the specific lockdep splat.

See below. I found it when trying to understand why the registration
of the mmu notififer was so oddly coded.

The situation was:

  down_write(&mm->mmap_sem);
  mm_take_all_locks(mm);
  kmalloc(GFP_KERNEL);  <--- lockdep warning

I understood Daniel said he saw this directly on a recent kernel when
working with his lockdep patch?

Checking myself, on todays kernel I see a call chain:

shrink_all_memory
  fs_reclaim_acquire(sc.gfp_mask);
  [..]
  do_try_to_free_pages
   shrink_zones
    shrink_node
     shrink_node_memcg
      shrink_list
       shrink_active_list
        page_referenced
         rmap_walk
          rmap_walk_file
           i_mmap_lock_read
            down_read(i_mmap_rwsem)

So it is possible that the down_read() above will block on
i_mmap_rwsem being held in the caller of invalidate_range_start which
is doing kmalloc(GPF_KERNEL).

Is this OK? The lockdep annotation says no..

Jason

commit 35cfa2b0b491c37e23527822bf365610dbb188e5
Author: Gavin Shan <shangw@linux.vnet.ibm.com>
Date:   Thu Oct 25 13:38:01 2012 -0700

    mm/mmu_notifier: allocate mmu_notifier in advance
    
    While allocating mmu_notifier with parameter GFP_KERNEL, swap would start
    to work in case of tight available memory.  Eventually, that would lead to
    a deadlock while the swap deamon swaps anonymous pages.  It was caused by
    commit e0f3c3f78da29b ("mm/mmu_notifier: init notifier if necessary").
    
      =================================
      [ INFO: inconsistent lock state ]
      3.7.0-rc1+ #518 Not tainted
      ---------------------------------
      inconsistent {RECLAIM_FS-ON-W} -> {IN-RECLAIM_FS-W} usage.
      kswapd0/35 [HC0[0]:SC0[0]:HE1:SE1] takes:
       (&mapping->i_mmap_mutex){+.+.?.}, at: page_referenced+0x9c/0x2e0
      {RECLAIM_FS-ON-W} state was registered at:
         mark_held_locks+0x86/0x150
         lockdep_trace_alloc+0x67/0xc0
         kmem_cache_alloc_trace+0x33/0x230
         do_mmu_notifier_register+0x87/0x180
         mmu_notifier_register+0x13/0x20
         kvm_dev_ioctl+0x428/0x510
         do_vfs_ioctl+0x98/0x570
         sys_ioctl+0x91/0xb0
         system_call_fastpath+0x16/0x1b
