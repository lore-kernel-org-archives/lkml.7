Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5DAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309F820685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDWImb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:42:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:49580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbfDWIma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:42:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2AE73ACAC;
        Tue, 23 Apr 2019 08:42:29 +0000 (UTC)
Date:   Tue, 23 Apr 2019 10:42:28 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Convert error about unsupported reliable
 stacktrace into a warning
In-Reply-To: <20190418135858.n3lzq2oxkj52m6bi@treble>
Message-ID: <alpine.LSU.2.21.1904231041500.19172@pobox.suse.cz>
References: <20190418112936.13295-1-pmladek@suse.com> <20190418135858.n3lzq2oxkj52m6bi@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019, Josh Poimboeuf wrote:

> On Thu, Apr 18, 2019 at 01:29:36PM +0200, Petr Mladek wrote:
> > The commit d0807da78e11d46f ("livepatch: Remove immediate feature") caused
> > that any livepatch was refused when reliable stacktraces were not supported
> > on the given architecture.
> > 
> > The limitation is too strong. User space processes are safely migrated
> > even when entering or leaving the kernel. Kthreads transition would
> > need to get forced. But it is safe when:
> > 
> >    + The livepatch does not change the semantic of the code.
> >    + Callbacks do not depend on a safely finished transition.
> > 
> > Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  kernel/livepatch/core.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index eb0ee10a1981..14f33ab6c583 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -1003,11 +1003,10 @@ int klp_enable_patch(struct klp_patch *patch)
> >  		return -ENODEV;
> >  
> >  	if (!klp_have_reliable_stack()) {
> > -		pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
> > -		return -EOPNOTSUPP;
> > +		pr_warn("This architecture doesn't have support for the livepatch consistency model.\n");
> > +		pr_warn("The livepatch transition may never complete.\n");
> >  	}
> >  
> > -
> >  	mutex_lock(&klp_mutex);
> >  
> >  	ret = klp_init_patch_early(patch);
> 
> Thanks Petr.  I would also suggest that we remove the WARN_ONCE() from
> the weak version of save_stack_trace_tsk_reliable(), since we expect it
> to be used in this case.

Moreover, we have WARN_ON_ONCE(ret == -ENOSYS) in klp_check_stack() where 
save_stack_trace_tsk_reliable() is called.

Miroslav
