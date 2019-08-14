Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2377FC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4D72173E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565815562;
	bh=EZBLwiP0N1eStQ84ag5nDU6Qw/MvJKG//W915vWDF64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iEohD3qf0io+Npl5P1Ag/HIgGUhvtmzlPRmO1xhx0R6QDkSYf5Cj1i8Sdn1TDyzB+
	 /EJB1WQVtX4y30wamGpd6HSPxQHgvb1pBhdxC8Mp5EQtTdQaJwgnQhlVdLGGojdxsf
	 9EPWvdyDbCZVY+Clz9Z8DstigT7HhdCN8Fjyokmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfHNUqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:46:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfHNUqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:46:00 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1AC216F4;
        Wed, 14 Aug 2019 20:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565815559;
        bh=EZBLwiP0N1eStQ84ag5nDU6Qw/MvJKG//W915vWDF64=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C8M74AF9gR0yIHtwYXvV9mYooDdtRaEbsAeu6xdcjm7MiFRBUgOgksIa9IbyRynX1
         8CovqClt4Zok7omZXMvrQ3krCm6iGcZ0/itlgYZhj1RoQID2VjQjF4gGY4TQptnckQ
         TYHTpL4yrQVOBgTIBym0nVj3v8+ixtaD2yCXXF1c=
Date:   Wed, 14 Aug 2019 13:45:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?ISO-8859-1?Q?J=E9r?= =?ISO-8859-1?Q?=F4me?= Glisse 
        <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-Id: <20190814134558.fe659b1a9a169c0150c3e57c@linux-foundation.org>
In-Reply-To: <20190814202027.18735-3-daniel.vetter@ffwll.ch>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
        <20190814202027.18735-3-daniel.vetter@ffwll.ch>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 22:20:24 +0200 Daniel Vetter <daniel.vetter@ffwll.ch> wrote:

> In some special cases we must not block, but there's not a
> spinlock, preempt-off, irqs-off or similar critical section already
> that arms the might_sleep() debug checks. Add a non_block_start/end()
> pair to annotate these.
> 
> This will be used in the oom paths of mmu-notifiers, where blocking is
> not allowed to make sure there's forward progress. Quoting Michal:
> 
> "The notifier is called from quite a restricted context - oom_reaper -
> which shouldn't depend on any locks or sleepable conditionals. The code
> should be swift as well but we mostly do care about it to make a forward
> progress. Checking for sleepable context is the best thing we could come
> up with that would describe these demands at least partially."
> 
> Peter also asked whether we want to catch spinlocks on top, but Michal
> said those are less of a problem because spinlocks can't have an
> indirect dependency upon the page allocator and hence close the loop
> with the oom reaper.

I continue to struggle with this.  It introduces a new kernel state
"running preemptibly but must not call schedule()".  How does this make
any sense?

Perhaps a much, much more detailed description of the oom_reaper
situation would help out.

