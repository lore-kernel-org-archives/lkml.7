Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14DDC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D07D2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565907312;
	bh=uN4VcpeCW2jBJTI1Si370+ePLjzfshSmi9q5RwHK3zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=k+l3FlTbUNv47bCIHF8Iu3fcUY5fUxvNpOloMTvnRUwwytDO2FQy/rNoal9ldbzTE
	 dmYwX8AOTGWlRgYwLmzkhHsxBWy9JLFC2FHb0EF/8KSEVjw3Vi6hQouS/nguwb2w55
	 jhCmeXunxY/fePcJNSNHR6qmYkhP4LfvtVXZ57ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbfHOWPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 18:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbfHOWPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 18:15:11 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C578E20644;
        Thu, 15 Aug 2019 22:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565907310;
        bh=uN4VcpeCW2jBJTI1Si370+ePLjzfshSmi9q5RwHK3zw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aTOvUoVh3yDGHY2VKKGjzrt2j37IUIAGRxiOv+BFw5caUUjN4/hUeJnHSChr2JqpI
         ttZvBwHNpv3VJSotvsrCun1FEqYSEDpoeVcWA9n9Ed8qlXTHvUVYtRTbD5b2RUVVCX
         GolZZPhsHLpPwXJ8M/alcsoSO7uLILhwTOk/xb7I=
Date:   Thu, 15 Aug 2019 15:15:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-Id: <20190815151509.9ddbd1f11fb9c4c3e97a67a5@linux-foundation.org>
In-Reply-To: <20190815084429.GE9477@dhcp22.suse.cz>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
        <20190814202027.18735-3-daniel.vetter@ffwll.ch>
        <20190814134558.fe659b1a9a169c0150c3e57c@linux-foundation.org>
        <20190815084429.GE9477@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2019 10:44:29 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> > I continue to struggle with this.  It introduces a new kernel state
> > "running preemptibly but must not call schedule()".  How does this make
> > any sense?
> > 
> > Perhaps a much, much more detailed description of the oom_reaper
> > situation would help out.
>  
> The primary point here is that there is a demand of non blockable mmu
> notifiers to be called when the oom reaper tears down the address space.
> As the oom reaper is the primary guarantee of the oom handling forward
> progress it cannot be blocked on anything that might depend on blockable
> memory allocations. These are not really easy to track because they
> might be indirect - e.g. notifier blocks on a lock which other context
> holds while allocating memory or waiting for a flusher that needs memory
> to perform its work. If such a blocking state happens that we can end up
> in a silent hang with an unusable machine.
> Now we hope for reasonable implementations of mmu notifiers (strong
> words I know ;) and this should be relatively simple and effective catch
> all tool to detect something suspicious is going on.
> 
> Does that make the situation more clear?

Yes, thanks, much.  Maybe a code comment along the lines of

  This is on behalf of the oom reaper, specifically when it is
  calling the mmu notifiers.  The problem is that if the notifier were
  to block on, for example, mutex_lock() and if the process which holds
  that mutex were to perform a sleeping memory allocation, the oom
  reaper is now blocked on completion of that memory allocation.

btw, do we need task_struct.non_block_count?  Perhaps the oom reaper
thread could set a new PF_NONBLOCK (which would be more general than
PF_OOM_REAPER).  If we run out of PF_ flags, use (current == oom_reaper_th).

