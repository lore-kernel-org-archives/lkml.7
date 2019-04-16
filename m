Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4584C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3825206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfDPSwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:52:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:58640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728032AbfDPSwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:52:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1368BAFAF;
        Tue, 16 Apr 2019 18:52:13 +0000 (UTC)
Date:   Tue, 16 Apr 2019 20:52:12 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Enforce reliable stack trace as config
 dependency
In-Reply-To: <20190416125446.hh2dpzwgixnkubwr@treble>
Message-ID: <alpine.LSU.2.21.1904162047180.9731@pobox.suse.cz>
References: <20190209091728.23046-1-kamalesh@linux.vnet.ibm.com> <20190211140813.z7kap634gz3gp6a4@treble> <20190212094608.bzwc26j67daqnx6x@pathway.suse.cz> <nycvar.YFH.7.76.1904161345560.9803@cbobk.fhfr.pm> <20190416125446.hh2dpzwgixnkubwr@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019, Josh Poimboeuf wrote:

> On Tue, Apr 16, 2019 at 01:47:30PM +0200, Jiri Kosina wrote:
> > On Tue, 12 Feb 2019, Petr Mladek wrote:
> > 
> > > > I think I'd rather go in the opposite direction: allow the patches to be
> > > > loaded.  Then they can be forced, if needed.  That enables both compile
> > > > and runtime testing.  That way we don't make any backward progress,
> > > > until such arches get reliable stacktraces.
> > > 
> > > Do you mean to convert the error into warning?
> > > 
> > > For example, the change below. Note that I did not mention
> > > the possibility to force the transition by intention. It is risky
> > > and people should not get used to it.
> > > 
> > > Heh, I think that this was the main reason why it was the error.
> > > We did not want to get people used to forcing livepatches.
> > > 
> > > 
> > > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > > index d1af69e9f0e3..8d9bce251516 100644
> > > --- a/kernel/livepatch/core.c
> > > +++ b/kernel/livepatch/core.c
> > > @@ -1035,11 +1035,10 @@ int klp_enable_patch(struct klp_patch *patch)
> > >  		return -ENODEV;
> > >  
> > >  	if (!klp_have_reliable_stack()) {
> > > -		pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
> > > -		return -EOPNOTSUPP;
> > > +		pr_warn("This architecture doesn't have support for the livepatch consistency model.\n");
> > > +		pr_warn("Only one livepatch can be installed.\n");
> > >  	}
> > >  
> > > -
> > 
> > This seems to have been lost.
> 
> Sorry, this must have gotten lost in my inbox - yes, something like the
> above is what I had in mind.  Though instead of "one livepatch can be
> installed" it might say that the patch transition may never complete.

Sounds better to me too.
 
> BTW, might we want to consider adding a way to say "this patch doesn't
> need the consistency model", which just applies the patch immediately
> like we used to?  Like patch->simple = true?  Then we could easily
> support all arches for basic patches.

I'd rather not return to immediate. There was a bug (commit d0807da78e11 
("livepatch: Remove immediate feature") explains it), it made the code 
complicated and it was impossible to disable patches/remove modules with 
that. After all, the consistency model gives us not only the consistency, 
but also assurance that all tasks were migrated outside of patched 
functions.

> > I think we should take this aproach before Miroslav is ready with 
> > realiable stack traces for s390. At the same time, I'd suggest issuing a 
> > proper WARN() there instead of just pr_warn(). The kernel might be in a 
> > potentially funky state, so let's at least get the 'W' taint in place.
> 
> I don't think it would be in a dangerous state, because
> save_stack_trace_tsk_reliable() will return -ENOSYS and the patch will
> remain in transition forever because the signaling doesn't work for
> kthreads.  So I don't think a warning is necessary.  In fact we may want
> to remove the warning in the generic version of
> save_stack_trace_tsk_reliable().

I would not mind.

Miroslav
