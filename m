Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E7BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC8B206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565690941;
	bh=jb1oiHYSFTDUQh6DxEaNA8i4vaoFhYH/ZFtJ7xDH8AM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jjXkQDJCH5dlmmtddK6QJJKrN0CchMDnMVkAKRMSjRRVYoC0v4D5gO9FXWHb2fjsC
	 rXl4gfK5iN8LtlwRZZO7GKjJmGLQQt9TXofr1xmW7hh8emEHDdn7dHwVLOeFNEVOp0
	 SDYsQj/vPvp1UaHlC8wA1QyAyzjuWrJ0eE/ApWtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfHMKJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:09:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:46980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728700AbfHMKJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:09:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42D5EABD9;
        Tue, 13 Aug 2019 10:08:57 +0000 (UTC)
Date:   Tue, 13 Aug 2019 12:08:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>,
        Daniel Colascione <dancol@google.com>, fmayer@google.com,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        kernel-team <kernel-team@android.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>, namhyung@google.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Suren Baghdasaryan <surenb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 1/6] mm/page_idle: Add per-pid idle page tracking
 using virtual index
Message-ID: <20190813100856.GF17933@dhcp22.suse.cz>
References: <20190807171559.182301-1-joel@joelfernandes.org>
 <CAG48ez0ysprvRiENhBkLeV9YPTN_MB18rbu2HDa2jsWo5FYR8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0ysprvRiENhBkLeV9YPTN_MB18rbu2HDa2jsWo5FYR8g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-08-19 20:14:38, Jann Horn wrote:
> On Wed, Aug 7, 2019 at 7:16 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> > The page_idle tracking feature currently requires looking up the pagemap
> > for a process followed by interacting with /sys/kernel/mm/page_idle.
> > Looking up PFN from pagemap in Android devices is not supported by
> > unprivileged process and requires SYS_ADMIN and gives 0 for the PFN.
> >
> > This patch adds support to directly interact with page_idle tracking at
> > the PID level by introducing a /proc/<pid>/page_idle file.  It follows
> > the exact same semantics as the global /sys/kernel/mm/page_idle, but now
> > looking up PFN through pagemap is not needed since the interface uses
> > virtual frame numbers, and at the same time also does not require
> > SYS_ADMIN.
> >
> > In Android, we are using this for the heap profiler (heapprofd) which
> > profiles and pin points code paths which allocates and leaves memory
> > idle for long periods of time. This method solves the security issue
> > with userspace learning the PFN, and while at it is also shown to yield
> > better results than the pagemap lookup, the theory being that the window
> > where the address space can change is reduced by eliminating the
> > intermediate pagemap look up stage. In virtual address indexing, the
> > process's mmap_sem is held for the duration of the access.
> 
> What happens when you use this interface on shared pages, like memory
> inherited from the zygote, library file mappings and so on? If two
> profilers ran concurrently for two different processes that both map
> the same libraries, would they end up messing up each other's data?

Yup PageIdle state is shared. That is the page_idle semantic even now
IIRC.

> Can this be used to observe which library pages other processes are
> accessing, even if you don't have access to those processes, as long
> as you can map the same libraries? I realize that there are already a
> bunch of ways to do that with side channels and such; but if you're
> adding an interface that allows this by design, it seems to me like
> something that should be gated behind some sort of privilege check.

Hmm, you need to be priviledged to get the pfn now and without that you
cannot get to any page so the new interface is weakening the rules.
Maybe we should limit setting the idle state to processes with the write
status. Or do you think that even observing idle status is useful for
practical side channel attacks? If yes, is that a problem of the
profiler which does potentially dangerous things?
-- 
Michal Hocko
SUSE Labs
