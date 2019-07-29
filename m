Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905C0C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E94206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfG2KEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:04:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:48288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726358AbfG2KEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:04:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 74108AE86;
        Mon, 29 Jul 2019 10:04:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7E6DC1E4379; Mon, 29 Jul 2019 12:04:49 +0200 (CEST)
Date:   Mon, 29 Jul 2019 12:04:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Qian Cai <cai@lca.pw>, mingo@redhat.com, tj@kernel.org,
        dchinner@redhat.com, fengguang.wu@intel.com, jack@suse.cz,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] trace/writeback: fix Wstringop-truncation warnings
Message-ID: <20190729100449.GA17833@quack2.suse.cz>
References: <1562948087-5374-1-git-send-email-cai@lca.pw>
 <20190716170339.1c44719d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716170339.1c44719d@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16-07-19 17:03:39, Steven Rostedt wrote:
> On Fri, 12 Jul 2019 12:14:47 -0400
> Qian Cai <cai@lca.pw> wrote:
> 
> > There are many of those warnings.
> > 
> > In file included from ./arch/powerpc/include/asm/paca.h:15,
> >                  from ./arch/powerpc/include/asm/current.h:13,
> >                  from ./include/linux/thread_info.h:21,
> >                  from ./include/asm-generic/preempt.h:5,
> >                  from ./arch/powerpc/include/generated/asm/preempt.h:1,
> >                  from ./include/linux/preempt.h:78,
> >                  from ./include/linux/spinlock.h:51,
> >                  from fs/fs-writeback.c:19:
> > In function 'strncpy',
> >     inlined from 'perf_trace_writeback_page_template' at
> > ./include/trace/events/writeback.h:56:1:
> > ./include/linux/string.h:260:9: warning: '__builtin_strncpy' specified
> > bound 32 equals destination size [-Wstringop-truncation]
> >   return __builtin_strncpy(p, q, size);
> >          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Fix it by using strlcpy() which will always be NUL-terminated instead of
> > strncpy(). strlcpy() has already been used at some places in this file.
> > 
> > Fixes: 455b2864686d ("writeback: Initial tracing support")
> > Fixes: 028c2dd184c0 ("writeback: Add tracing to balance_dirty_pages")
> > Fixes: e84d0a4f8e39 ("writeback: trace event writeback_queue_io")
> > Fixes: b48c104d2211 ("writeback: trace event bdi_dirty_ratelimit")
> > Fixes: cc1676d917f3 ("writeback: Move requeueing when I_SYNC set to writeback_sb_inodes()")
> > Fixes: 9fb0a7da0c52 ("writeback: add more tracepoints")
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  include/trace/events/writeback.h | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> > index aa7f3aeac740..8e3b3c4fd964 100644
> > --- a/include/trace/events/writeback.h
> > +++ b/include/trace/events/writeback.h
> > @@ -66,7 +66,7 @@
> >  	),
> >  
> >  	TP_fast_assign(
> > -		strncpy(__entry->name,
> > +		strlcpy(__entry->name,
> >  			mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)", 32);
> 
> 
> Not sure this is an issue or not, but although the fix looks legit (in
> case a string is more that 31 bytes), strlcpy() does not pad the rest
> of the string like strncpy() does. This means we can possibly leak data
> through the ring buffer.
> 
> This may not be an issue as ftrace can only be used by a super user
> account, but this code can also be used by perf. If it is possible for
> a non admin account to enable these events through perf, then there is
> a case of data leak.
> 
> Again, it may not be a big issue, but I'm just letting people know.
> 
> Note, this needs to go through the maintainer of the writeback.h, who
> are those that created it, not the tracing maintainers.

Yeah, I'd prefer to use strscpy_pad() for the copying as I'd be calmer if
we don't leak uninitialized memory to userspace. Thanks!

								Honza

> 
> -- Steve
> 
> 
> >  		__entry->ino = mapping ? mapping->host->i_ino : 0;
> >  		__entry->index = page->index;
> > @@ -110,7 +110,7 @@
> >  		struct backing_dev_info *bdi = inode_to_bdi(inode);
> >  
> >  		/* may be called for files on pseudo FSes w/ unregistered bdi */
> > -		strncpy(__entry->name,
> > +		strlcpy(__entry->name,
> >  			bdi->dev ? dev_name(bdi->dev) : "(unknown)", 32);
> >  		__entry->ino		= inode->i_ino;
> >  		__entry->state		= inode->i_state;
> > @@ -190,7 +190,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
> >  	),
> >  
> >  	TP_fast_assign(
> > -		strncpy(__entry->name,
> > +		strlcpy(__entry->name,
> >  			dev_name(inode_to_bdi(inode)->dev), 32);
> >  		__entry->ino		= inode->i_ino;
> >  		__entry->sync_mode	= wbc->sync_mode;
> > @@ -234,7 +234,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
> >  		__field(unsigned int, cgroup_ino)
> >  	),
> >  	TP_fast_assign(
> > -		strncpy(__entry->name,
> > +		strlcpy(__entry->name,
> >  			wb->bdi->dev ? dev_name(wb->bdi->dev) : "(unknown)", 32);
> >  		__entry->nr_pages = work->nr_pages;
> >  		__entry->sb_dev = work->sb ? work->sb->s_dev : 0;
> > @@ -288,7 +288,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
> >  		__field(unsigned int, cgroup_ino)
> >  	),
> >  	TP_fast_assign(
> > -		strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
> > +		strlcpy(__entry->name, dev_name(wb->bdi->dev), 32);
> >  		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
> >  	),
> >  	TP_printk("bdi %s: cgroup_ino=%u",
> > @@ -310,7 +310,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
> >  		__array(char, name, 32)
> >  	),
> >  	TP_fast_assign(
> > -		strncpy(__entry->name, dev_name(bdi->dev), 32);
> > +		strlcpy(__entry->name, dev_name(bdi->dev), 32);
> >  	),
> >  	TP_printk("bdi %s",
> >  		__entry->name
> > @@ -335,7 +335,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
> >  	),
> >  
> >  	TP_fast_assign(
> > -		strncpy(__entry->name, dev_name(bdi->dev), 32);
> > +		strlcpy(__entry->name, dev_name(bdi->dev), 32);
> >  		__entry->nr_to_write	= wbc->nr_to_write;
> >  		__entry->pages_skipped	= wbc->pages_skipped;
> >  		__entry->sync_mode	= wbc->sync_mode;
> > @@ -386,7 +386,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
> >  	),
> >  	TP_fast_assign(
> >  		unsigned long *older_than_this = work->older_than_this;
> > -		strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
> > +		strlcpy(__entry->name, dev_name(wb->bdi->dev), 32);
> >  		__entry->older	= older_than_this ?  *older_than_this : 0;
> >  		__entry->age	= older_than_this ?
> >  				  (jiffies - *older_than_this) * 1000 / HZ : -1;
> > @@ -597,7 +597,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
> >  	),
> >  
> >  	TP_fast_assign(
> > -		strncpy(__entry->name,
> > +		strlcpy(__entry->name,
> >  		        dev_name(inode_to_bdi(inode)->dev), 32);
> >  		__entry->ino		= inode->i_ino;
> >  		__entry->state		= inode->i_state;
> > @@ -671,7 +671,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
> >  	),
> >  
> >  	TP_fast_assign(
> > -		strncpy(__entry->name,
> > +		strlcpy(__entry->name,
> >  			dev_name(inode_to_bdi(inode)->dev), 32);
> >  		__entry->ino		= inode->i_ino;
> >  		__entry->state		= inode->i_state;
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
