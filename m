Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C449FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990DE2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389372AbfDRPmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:42:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387519AbfDRPmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:42:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32069C059B9F;
        Thu, 18 Apr 2019 15:42:21 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-16.phx2.redhat.com [10.3.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 801FE60BE5;
        Thu, 18 Apr 2019 15:42:09 +0000 (UTC)
Date:   Thu, 18 Apr 2019 11:42:06 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        sgrubb@redhat.com, omosnace@redhat.com,
        Eric Paris <eparis@parisplace.org>, ebiederm@xmission.com,
        oleg@redhat.com
Subject: Re: [PATCH ghak111 V1] audit: deliver siginfo regarless of syscall
Message-ID: <20190418154206.itjcwd5mjxwfvwe5@madcap2.tricolour.ca>
References: <c7b092894ac6d611f8c5083e712da41e6685f94a.1554781852.git.rgb@redhat.com>
 <CAHC9VhSCRrbFYy3KnSAt4GhADCfTXW-_uSm8focUk-i7_FPjrA@mail.gmail.com>
 <20190418151642.nb5mgrxfw55hqecs@madcap2.tricolour.ca>
 <CAHC9VhQGqywNxBs-LbrYh5xZ12GyWDS9Ju=kmLnzeV3ZsXiv9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQGqywNxBs-LbrYh5xZ12GyWDS9Ju=kmLnzeV3ZsXiv9g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 18 Apr 2019 15:42:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-18 11:37, Paul Moore wrote:
> On Thu, Apr 18, 2019 at 11:16 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2019-04-18 10:59, Paul Moore wrote:
> > > On Mon, Apr 8, 2019 at 11:53 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > When a process signals the audit daemon (shutdown, rotate, resume,
> > > > reconfig) but syscall auditing is not enabled, we still want to know the
> > > > identity of the process sending the signal to the audit daemon.
> > > >
> > > > Move audit_signal_info() out of syscall auditing to general auditing but
> > > > create a new function audit_signal_info_syscall() to take care of the
> > > > syscall dependent parts for when syscall auditing is enabled.
> > > >
> > > > Please see the github kernel audit issue
> > > > https://github.com/linux-audit/audit-kernel/issues/111
> > > >
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > ---
> > > >  include/linux/audit.h |  6 ++++++
> > > >  kernel/audit.c        | 27 +++++++++++++++++++++++++++
> > > >  kernel/audit.h        |  4 ++--
> > > >  kernel/auditsc.c      | 19 +++----------------
> > > >  kernel/signal.c       |  2 +-
> > > >  5 files changed, 39 insertions(+), 19 deletions(-)
> > >
> > > ...
> > >
> > > > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > > > index 1e69d9fe16da..4a22fc3f824f 100644
> > > > --- a/include/linux/audit.h
> > > > +++ b/include/linux/audit.h
> > > > @@ -226,6 +229,9 @@ static inline unsigned int audit_get_sessionid(struct task_struct *tsk)
> > > >  }
> > > >
> > > >  #define audit_enabled AUDIT_OFF
> > > > +
> > > > +#define audit_signal_info(s, t) AUDIT_OFF
> > > > +
> > >
> > > Should this be AUDIT_DISABLED to preserve the current value/behavior?
> > > Technically they should both have a value of zero right now, but since
> > > the AUDIT_DISABLED value isn't explicit it seems safer to go with
> > > AUDIT_DISABLED.
> >
> > I did that first, but that symbol was not available when one or both of
> > CONFIG_AUDITSYSCALL or CONFIG_AUDIT was off, so I had to change it to
> > AUDIT_OFF.  I followed the logic to confirm that is what was intended by
> > the original code.
> >
> > When auidit is off, we want to just return zero so it gets skipped
> > rather than throwing an error.
> 
> I understand the desire to return zero in that case, I'm not arguing
> against that, I'm just not really in love with how these are defined
> when CONFIG_AUDIT isn't.  Part of it is the AUDIT_DISABLED/AUDIT_OFF
> change, part of it is the function being defined as a cpp macro
> instead of a dummy function (this of course predates your change).
> Based on other comments in this thread it looks like you're looking
> into a few things and will likely be respinning this patch, since that
> is the case, I would prefer if you changed this to just using simply
> "0" as opposed to AUDIT_OFF.
> 
> If you really want to make me happy about this patch, you would also
> change this to a dummy function instead of a cpp macro.  This is a
> style nit, and isn't strictly necessary, but I would appreciate it :)

In fact, I'd started with a dummy function, then changed it to match the
style of the rest of the file when I got a pile of unused function
complaints from all over the kernel...  I'll see what I can do to go
back to the dummy function.

> > > > diff --git a/kernel/audit.h b/kernel/audit.h
> > > > index 958d5b8fc1b3..18a8ae812e9f 100644
> > > > --- a/kernel/audit.h
> > > > +++ b/kernel/audit.h
> > > > @@ -299,7 +299,7 @@ extern bool audit_tree_match(struct audit_chunk *chunk,
> > > >  extern void audit_put_tree(struct audit_tree *tree);
> > > >  extern void audit_kill_trees(struct audit_context *context);
> > > >
> > > > -extern int audit_signal_info(int sig, struct task_struct *t);
> > > > +extern int audit_signal_info_syscall(struct task_struct *t);
> > > >  extern void audit_filter_inodes(struct task_struct *tsk,
> > > >                                 struct audit_context *ctx);
> > > >  extern struct list_head *audit_killed_trees(void);
> > > > @@ -330,7 +330,7 @@ extern void audit_filter_inodes(struct task_struct *tsk,
> > > >  #define audit_tree_path(rule) ""       /* never called */
> > > >  #define audit_kill_trees(context) BUG()
> > > >
> > > > -#define audit_signal_info(s, t) AUDIT_DISABLED
> > > > +#define audit_signal_info_syscall(t) AUDIT_OFF
> > >
> > > Similar as above.
> 
> -- 
> paul moore
> www.paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
