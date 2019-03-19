Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B33C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B8C2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfCSKkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:40:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:38304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfCSKkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:40:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF013AC4C;
        Tue, 19 Mar 2019 10:40:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BD12B1E429B; Tue, 19 Mar 2019 11:40:30 +0100 (CET)
Date:   Tue, 19 Mar 2019 11:40:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     viro@zeniv.linux.org.uk, tj@kernel.org, rostedt@goodmis.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: expose cgroup info in
 trace_writeback_pages_written()
Message-ID: <20190319104030.GA20138@quack2.suse.cz>
References: <1550928949-11879-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550928949-11879-1-git-send-email-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 23-02-19 21:35:49, Yafang Shao wrote:
> With cgroup v2 writeback, we can know these pages are written from which
> cgroup.
> So expose the cgroup_ino for better tracking.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Fine by me. You can add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c                | 4 ++--
>  include/trace/events/writeback.h | 9 ++++++---
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 36855c1..e98a33e 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1973,7 +1973,7 @@ void wb_workfn(struct work_struct *work)
>  		 */
>  		do {
>  			pages_written = wb_do_writeback(wb);
> -			trace_writeback_pages_written(pages_written);
> +			trace_writeback_pages_written(wb, pages_written);
>  		} while (!list_empty(&wb->work_list));
>  	} else {
>  		/*
> @@ -1983,7 +1983,7 @@ void wb_workfn(struct work_struct *work)
>  		 */
>  		pages_written = writeback_inodes_wb(wb, 1024,
>  						    WB_REASON_FORKER_THREAD);
> -		trace_writeback_pages_written(pages_written);
> +		trace_writeback_pages_written(wb, pages_written);
>  	}
>  
>  	if (!list_empty(&wb->work_list))
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 32db72c..a806713 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -255,15 +255,18 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
>  DEFINE_WRITEBACK_WORK_EVENT(writeback_wait);
>  
>  TRACE_EVENT(writeback_pages_written,
> -	TP_PROTO(long pages_written),
> -	TP_ARGS(pages_written),
> +	TP_PROTO(struct bdi_writeback *wb, long pages_written),
> +	TP_ARGS(wb, pages_written),
>  	TP_STRUCT__entry(
>  		__field(long,		pages)
> +		__field(unsigned int,	cgroup_ino)
>  	),
>  	TP_fast_assign(
>  		__entry->pages		= pages_written;
> +		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
>  	),
> -	TP_printk("%ld", __entry->pages)
> +	TP_printk("pages=%ld cgroup_ino=%u",
> +		   __entry->pages, __entry->cgroup_ino)
>  );
>  
>  DECLARE_EVENT_CLASS(writeback_class,
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
