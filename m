Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581F7C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4242089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfG3RWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:22:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:44800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727532AbfG3RWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:22:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 724C9AF77;
        Tue, 30 Jul 2019 17:22:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DA3681E4370; Tue, 30 Jul 2019 19:22:48 +0200 (CEST)
Date:   Tue, 30 Jul 2019 19:22:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, tobin@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, tj@kernel.org, dchinner@redhat.com,
        fengguang.wu@intel.com, jack@suse.cz, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] writeback: fix -Wstringop-truncation warnings
Message-ID: <20190730172248.GL28829@quack2.suse.cz>
References: <1564075099-27750-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564075099-27750-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-07-19 13:18:19, Qian Cai wrote:
> There are many of those warnings.
> 
> In file included from ./arch/powerpc/include/asm/paca.h:15,
>                  from ./arch/powerpc/include/asm/current.h:13,
>                  from ./include/linux/thread_info.h:21,
>                  from ./include/asm-generic/preempt.h:5,
>                  from ./arch/powerpc/include/generated/asm/preempt.h:1,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/spinlock.h:51,
>                  from fs/fs-writeback.c:19:
> In function 'strncpy',
>     inlined from 'perf_trace_writeback_page_template' at
> ./include/trace/events/writeback.h:56:1:
> ./include/linux/string.h:260:9: warning: '__builtin_strncpy' specified
> bound 32 equals destination size [-Wstringop-truncation]
>   return __builtin_strncpy(p, q, size);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix it by using the new strscpy_pad() which was introduced in the
> commit 458a3bf82df4 ("lib/string: Add strscpy_pad() function") and will
> always be NUL-terminated instead of strncpy(). Also, changes strlcpy()
> to use strscpy_pad() in this file for consistency.
> 
> Fixes: 455b2864686d ("writeback: Initial tracing support")
> Fixes: 028c2dd184c0 ("writeback: Add tracing to balance_dirty_pages")
> Fixes: e84d0a4f8e39 ("writeback: trace event writeback_queue_io")
> Fixes: b48c104d2211 ("writeback: trace event bdi_dirty_ratelimit")
> Fixes: cc1676d917f3 ("writeback: Move requeueing when I_SYNC set to writeback_sb_inodes()")
> Fixes: 9fb0a7da0c52 ("writeback: add more tracepoints")
> Signed-off-by: Qian Cai <cai@lca.pw>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> v3: Rearrange a long-line a bit to make the code more readable.
> v2: Use strscpy_pad() to address the possible data leaking concern from Steve [1].
>     Replace strlcpy() as well for consistency.
> 
> [1] https://lore.kernel.org/lkml/20190716170339.1c44719d@gandalf.local.home/
> 
>  include/trace/events/writeback.h | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index aa7f3aeac740..79095434c1be 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -66,8 +66,9 @@
>  	),
>  
>  	TP_fast_assign(
> -		strncpy(__entry->name,
> -			mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)", 32);
> +		strscpy_pad(__entry->name,
> +			    mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)",
> +			    32);
>  		__entry->ino = mapping ? mapping->host->i_ino : 0;
>  		__entry->index = page->index;
>  	),
> @@ -110,8 +111,8 @@
>  		struct backing_dev_info *bdi = inode_to_bdi(inode);
>  
>  		/* may be called for files on pseudo FSes w/ unregistered bdi */
> -		strncpy(__entry->name,
> -			bdi->dev ? dev_name(bdi->dev) : "(unknown)", 32);
> +		strscpy_pad(__entry->name,
> +			    bdi->dev ? dev_name(bdi->dev) : "(unknown)", 32);
>  		__entry->ino		= inode->i_ino;
>  		__entry->state		= inode->i_state;
>  		__entry->flags		= flags;
> @@ -190,8 +191,8 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
>  	),
>  
>  	TP_fast_assign(
> -		strncpy(__entry->name,
> -			dev_name(inode_to_bdi(inode)->dev), 32);
> +		strscpy_pad(__entry->name,
> +			    dev_name(inode_to_bdi(inode)->dev), 32);
>  		__entry->ino		= inode->i_ino;
>  		__entry->sync_mode	= wbc->sync_mode;
>  		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
> @@ -234,8 +235,9 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
>  		__field(unsigned int, cgroup_ino)
>  	),
>  	TP_fast_assign(
> -		strncpy(__entry->name,
> -			wb->bdi->dev ? dev_name(wb->bdi->dev) : "(unknown)", 32);
> +		strscpy_pad(__entry->name,
> +			    wb->bdi->dev ? dev_name(wb->bdi->dev) :
> +			    "(unknown)", 32);
>  		__entry->nr_pages = work->nr_pages;
>  		__entry->sb_dev = work->sb ? work->sb->s_dev : 0;
>  		__entry->sync_mode = work->sync_mode;
> @@ -288,7 +290,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
>  		__field(unsigned int, cgroup_ino)
>  	),
>  	TP_fast_assign(
> -		strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
> +		strscpy_pad(__entry->name, dev_name(wb->bdi->dev), 32);
>  		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
>  	),
>  	TP_printk("bdi %s: cgroup_ino=%u",
> @@ -310,7 +312,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
>  		__array(char, name, 32)
>  	),
>  	TP_fast_assign(
> -		strncpy(__entry->name, dev_name(bdi->dev), 32);
> +		strscpy_pad(__entry->name, dev_name(bdi->dev), 32);
>  	),
>  	TP_printk("bdi %s",
>  		__entry->name
> @@ -335,7 +337,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
>  	),
>  
>  	TP_fast_assign(
> -		strncpy(__entry->name, dev_name(bdi->dev), 32);
> +		strscpy_pad(__entry->name, dev_name(bdi->dev), 32);
>  		__entry->nr_to_write	= wbc->nr_to_write;
>  		__entry->pages_skipped	= wbc->pages_skipped;
>  		__entry->sync_mode	= wbc->sync_mode;
> @@ -386,7 +388,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
>  	),
>  	TP_fast_assign(
>  		unsigned long *older_than_this = work->older_than_this;
> -		strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
> +		strscpy_pad(__entry->name, dev_name(wb->bdi->dev), 32);
>  		__entry->older	= older_than_this ?  *older_than_this : 0;
>  		__entry->age	= older_than_this ?
>  				  (jiffies - *older_than_this) * 1000 / HZ : -1;
> @@ -472,7 +474,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
>  	),
>  
>  	TP_fast_assign(
> -		strlcpy(__entry->bdi, dev_name(wb->bdi->dev), 32);
> +		strscpy_pad(__entry->bdi, dev_name(wb->bdi->dev), 32);
>  		__entry->write_bw	= KBps(wb->write_bandwidth);
>  		__entry->avg_write_bw	= KBps(wb->avg_write_bandwidth);
>  		__entry->dirty_rate	= KBps(dirty_rate);
> @@ -537,7 +539,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
>  
>  	TP_fast_assign(
>  		unsigned long freerun = (thresh + bg_thresh) / 2;
> -		strlcpy(__entry->bdi, dev_name(wb->bdi->dev), 32);
> +		strscpy_pad(__entry->bdi, dev_name(wb->bdi->dev), 32);
>  
>  		__entry->limit		= global_wb_domain.dirty_limit;
>  		__entry->setpoint	= (global_wb_domain.dirty_limit +
> @@ -597,8 +599,8 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
>  	),
>  
>  	TP_fast_assign(
> -		strncpy(__entry->name,
> -		        dev_name(inode_to_bdi(inode)->dev), 32);
> +		strscpy_pad(__entry->name,
> +			    dev_name(inode_to_bdi(inode)->dev), 32);
>  		__entry->ino		= inode->i_ino;
>  		__entry->state		= inode->i_state;
>  		__entry->dirtied_when	= inode->dirtied_when;
> @@ -671,8 +673,8 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
>  	),
>  
>  	TP_fast_assign(
> -		strncpy(__entry->name,
> -			dev_name(inode_to_bdi(inode)->dev), 32);
> +		strscpy_pad(__entry->name,
> +			    dev_name(inode_to_bdi(inode)->dev), 32);
>  		__entry->ino		= inode->i_ino;
>  		__entry->state		= inode->i_state;
>  		__entry->dirtied_when	= inode->dirtied_when;
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
