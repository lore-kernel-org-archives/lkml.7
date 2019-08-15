Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A364C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EAB4206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IuZwSs1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbfHONER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:04:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36098 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732150AbfHONER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:04:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id d23so1790473qko.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 06:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+sQD+zsr7vGI2rnBo9g+oJW06UyfnJhHIGQAqNbFxW4=;
        b=IuZwSs1/sg2gs7X8/HMGOKYXzgvI7hKzDGdggZttJSURMRYxJVZftP0NCXoTx9kR26
         O/sfZwzz3+w3TlMh5kO0BfG0INa47kk9US5Bl/a8MKcvzoVehrnJPWGzU7V9y+o2d5Nk
         Kju7MceUpwoVwA5wyNNFaVyXu7PG6ntN3MFy/C4bxnPqmzJLs9UnB1hl3gHgOa65jxUB
         Hvu5s57zRVawIe+YlelM+eNZ9DvN83kuurmv37XNGarrXfBulYC73YTxo9UVkxrcQTnK
         C9zb4BzCqLARK8nWnPlz/aG4w3K7tBt1aXiP8Ag8AjtMBvt7ltpyGMaiGvt2NqgiRt4O
         TqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+sQD+zsr7vGI2rnBo9g+oJW06UyfnJhHIGQAqNbFxW4=;
        b=c9pH0kvsZo2q2toB+mZPY4dwM7FCykTraAH0UPbXz11MbC6dzlS5EIjCFMZNelzG0h
         id8UjLRlBNpgfVvSNqTJmitA9PjAfdema6gXCoUyTbXjMeTaCrdEA8yvFWZAvHVui8XS
         sVkIGBLk2Ah6bvgLBMzNKvqrtMsZhYhpZqehY6I3+1O/jJJ0IIYo4KRoTzWsPDKUR1/N
         eijoOplBs4L9iK+9hntNQ7nMDB0uG3Xm9su6gW3OXVsTqLv48fiMbitPBmRrytNw+Mra
         JqyMrPicRhZI58k0TjPpKN1UalQJr8PVrSHIhOQU8dBvkyBi4RiKkhZbtQFsCj4Wcu6n
         RiBg==
X-Gm-Message-State: APjAAAWs8Qi1zfM6NrgjunnNNy4d0ECkaiQWLd5ionSvYeOKJB6L/Lnr
        DEXOLGAbfdxioE5SuEJvdjCmJg==
X-Google-Smtp-Source: APXvYqxbHXTewYAACJxzRXNX2TlZ2cOD0GDfUS0iL50gokJ8s5uWAlQ8FDekdfBBzYw8ePlgf2CSQA==
X-Received: by 2002:a05:620a:52e:: with SMTP id h14mr4017748qkh.358.1565874256038;
        Thu, 15 Aug 2019 06:04:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z7sm1468623qki.88.2019.08.15.06.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 06:04:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hyFQN-0004HN-58; Thu, 15 Aug 2019 10:04:15 -0300
Date:   Thu, 15 Aug 2019 10:04:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20190815130415.GD21596@ziepe.ca>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-3-daniel.vetter@ffwll.ch>
 <20190814134558.fe659b1a9a169c0150c3e57c@linux-foundation.org>
 <20190815084429.GE9477@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815084429.GE9477@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 10:44:29AM +0200, Michal Hocko wrote:

> As the oom reaper is the primary guarantee of the oom handling forward
> progress it cannot be blocked on anything that might depend on blockable
> memory allocations. These are not really easy to track because they
> might be indirect - e.g. notifier blocks on a lock which other context
> holds while allocating memory or waiting for a flusher that needs memory
> to perform its work.

But lockdep *does* track all this and fs_reclaim_acquire() was created
to solve exactly this problem.

fs_reclaim is a lock and it flows through all the usual lockdep
schemes like any other lock. Any time the page allocator wants to do
something the would deadlock with reclaim it takes the lock.

Failure is expressed by a deadlock cycle in the lockdep map, and
lockdep can handle arbitary complexity through layers of locks, work
queues, threads, etc.

What is missing?

Jason
