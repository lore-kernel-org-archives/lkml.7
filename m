Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AE6C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 21:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66E3217D4
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 21:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfHCVgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 17:36:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34976 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbfHCVgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 17:36:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so77541554qto.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 14:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EkifmyHxwnsPs8regEBTA5tK93nCtmZrIpRMe8ScOn4=;
        b=pozg1dSRKjEU13w2HBoStZrcc1JNPoerWcbMmJHyu7pNxUGHP5POZ+HLfHWhUdh8wf
         Nf1pgH7loHVYurh/92r4IgfdeXJ1DWvbIBFbl9tgRm7t9YqydOOQi2BU3lN0HCO6uxFr
         v5va9YKXIxhs1PbqSJHMD2v+S52qKcDDr+mODa5J0AbREgMMsyd+DsjDhfrV/EOFtW/m
         t2huwgG6VSExCBoM8HmF1+KBpYmLvzQAv0aaG6WyCI/CzRz2gth2C1hgE4Y/aNwsF3O6
         xqY3Di4bJ12Yjf5jKFsGtAaiaDyPcY4y52dVGPU47TFHf/9ge6hIRaX4wA0yV8kC/DTG
         E6cQ==
X-Gm-Message-State: APjAAAWu3OnXI/FP7px9tT9pGfp6XAGl5gQ52x6QZ1WIZHfpLRNw7Rs0
        ewKba5xJHubHSuvlo7s1yV24OA==
X-Google-Smtp-Source: APXvYqyFdgNs0jCQVpmdi8dR64CNPy6wD73snHAaLEfC40B+RZ0ZopacAYTEXjRinq1ReEeoFWNEuA==
X-Received: by 2002:ac8:32ec:: with SMTP id a41mr103176717qtb.375.1564868179417;
        Sat, 03 Aug 2019 14:36:19 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id g3sm33648801qke.105.2019.08.03.14.36.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 03 Aug 2019 14:36:18 -0700 (PDT)
Date:   Sat, 3 Aug 2019 17:36:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 7/9] vhost: do not use RCU to synchronize MMU notifier
 with worker
Message-ID: <20190803172944-mutt-send-email-mst@kernel.org>
References: <20190731084655.7024-8-jasowang@redhat.com>
 <20190731123935.GC3946@ziepe.ca>
 <7555c949-ae6f-f105-6e1d-df21ddae9e4e@redhat.com>
 <20190731193057.GG3946@ziepe.ca>
 <a3bde826-6329-68e4-2826-8a9de4c5bd1e@redhat.com>
 <20190801141512.GB23899@ziepe.ca>
 <42ead87b-1749-4c73-cbe4-29dbeb945041@redhat.com>
 <20190802124613.GA11245@ziepe.ca>
 <20190802100414-mutt-send-email-mst@kernel.org>
 <20190802172418.GB11245@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802172418.GB11245@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 02:24:18PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 02, 2019 at 10:27:21AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Aug 02, 2019 at 09:46:13AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Aug 02, 2019 at 05:40:07PM +0800, Jason Wang wrote:
> > > > > This must be a proper barrier, like a spinlock, mutex, or
> > > > > synchronize_rcu.
> > > > 
> > > > 
> > > > I start with synchronize_rcu() but both you and Michael raise some
> > > > concern.
> > > 
> > > I've also idly wondered if calling synchronize_rcu() under the various
> > > mm locks is a deadlock situation.
> > > 
> > > > Then I try spinlock and mutex:
> > > > 
> > > > 1) spinlock: add lots of overhead on datapath, this leads 0 performance
> > > > improvement.
> > > 
> > > I think the topic here is correctness not performance improvement
> > 
> > The topic is whether we should revert
> > commit 7f466032dc9 ("vhost: access vq metadata through kernel virtual address")
> > 
> > or keep it in. The only reason to keep it is performance.
> 
> Yikes, I'm not sure you can ever win against copy_from_user using
> mmu_notifiers?

Ever since copy_from_user started playing with flags (for SMAP) and
added speculation barriers there's a chance we can win by accessing
memory through the kernel address.


Another reason would be to access it from e.g. softirq
context. copy_from_user will only work if the
correct mmu is active.


> The synchronization requirements are likely always
> more expensive unless large and scattered copies are being done..
> 
> The rcu is about the only simple approach that could be less
> expensive, and that gets back to the question if you can block an
> invalidate_start_range in synchronize_rcu or not..
> 
> So, frankly, I'd revert it until someone could prove the rcu solution is
> OK..

I have it all disabled at compile time, so reverting isn't urgent
anymore. I'll wait a couple more days to decide what's cleanest.

> BTW, how do you get copy_from_user to work outside a syscall?

By switching to the correct mm.

> 
> Also, why can't this just permanently GUP the pages? In fact, where
> does it put_page them anyhow? Worrying that 7f466 adds a get_user page
> but does not add a put_page??
> 
> Jason
