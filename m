Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF224C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8E12086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfHPPFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:05:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfHPPFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 11:05:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82BA23001472;
        Fri, 16 Aug 2019 15:05:05 +0000 (UTC)
Received: from redhat.com (ovpn-123-168.rdu2.redhat.com [10.10.123.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B2FA18780;
        Fri, 16 Aug 2019 15:05:02 +0000 (UTC)
Date:   Fri, 16 Aug 2019 11:05:01 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org DRI Development" 
        <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-ID: <20190816150501.GA3149@redhat.com>
References: <20190815174207.GR9477@dhcp22.suse.cz>
 <20190815182448.GP21596@ziepe.ca>
 <20190815190525.GS9477@dhcp22.suse.cz>
 <20190815191810.GR21596@ziepe.ca>
 <20190815193526.GT9477@dhcp22.suse.cz>
 <20190815201323.GU21596@ziepe.ca>
 <20190816081029.GA27790@dhcp22.suse.cz>
 <20190816121906.GC5398@ziepe.ca>
 <20190816122625.GA10499@dhcp22.suse.cz>
 <20190816143145.GD5398@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190816143145.GD5398@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 16 Aug 2019 15:05:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 11:31:45AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 16, 2019 at 02:26:25PM +0200, Michal Hocko wrote:
> > On Fri 16-08-19 09:19:06, Jason Gunthorpe wrote:
> > > On Fri, Aug 16, 2019 at 10:10:29AM +0200, Michal Hocko wrote:
> > > > On Thu 15-08-19 17:13:23, Jason Gunthorpe wrote:
> > > > > On Thu, Aug 15, 2019 at 09:35:26PM +0200, Michal Hocko wrote:

[...]

> > > I would like to inject it into the notifier path as this is very
> > > difficult for driver authors to discover and know about, but I'm
> > > worried about your false positive remark.
> > > 
> > > I think I understand we can use only GFP_ATOMIC in the notifiers, but
> > > we need a strategy to handle OOM to guarentee forward progress.
> > 
> > Your example is from the notifier registration IIUC. 
> 
> Yes, that is where this commit hit it.. Triggering this under an
> actual notifier to get a lockdep report is hard.
> 
> > Can you pre-allocate before taking locks? Could you point me to some
> > examples when the allocation is necessary in the range notifier
> > callback?
> 
> Hmm. I took a careful look, I only found mlx5 as obviously allocating
> memory:
> 
>  mlx5_ib_invalidate_range()
>   mlx5_ib_update_xlt()
>    __get_free_pages(gfp, get_order(size));
> 
> However, I think this could be changed to fall back to some small
> buffer if allocation fails. The existing scheme looks sketchy
> 
> nouveau does:
> 
>  nouveau_svmm_invalidate
>   nvif_object_mthd
>    kmalloc(GFP_KERNEL)
> 
> But I think it reliably uses a stack buffer here
> 
> i915 I think Daniel said he audited.
> 
> amd_mn.. The actual invalidate_range_start does not allocate memory,
> but it is entangled with so many locks it would need careful analysis
> to be sure.
> 
> The others look generally OK, which is good, better than I hoped :)

It is on my TODO list to get rid of allocation in notifier callback
(iirc nouveau already use the stack unless it was lost in all the
revision it wants through). Anyway i do not think we need allocation
in notifier.

Cheers,
Jérôme
