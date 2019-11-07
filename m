Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36196C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F404721882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388267AbfKGLun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:50:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:54862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfKGLun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:50:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5CC9B0A5;
        Thu,  7 Nov 2019 11:50:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 41CE61E4415; Thu,  7 Nov 2019 12:50:41 +0100 (CET)
Date:   Thu, 7 Nov 2019 12:50:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] fs/quota: use unsigned int helper for sysctl fs.quota.*
Message-ID: <20191107115041.GC11400@quack2.suse.cz>
References: <157312129151.3890.6076128127053624123.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157312129151.3890.6076128127053624123.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-11-19 13:08:11, Konstantin Khlebnikov wrote:
> Report counters as unsigned, otherwise they turn negative at overflow:
> 
> # sysctl fs.quota
> fs.quota.allocated_dquots = 22327
> fs.quota.cache_hits = -489852115
> fs.quota.drops = -487288718
> fs.quota.free_dquots = 22083
> fs.quota.lookups = -486883485
> fs.quota.reads = 22327
> fs.quota.syncs = 335064
> fs.quota.writes = 3088689
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Fair enough but then 'stats' array in dqstats should be unsigned as well
for consistency and why not actually make everything long when we are at
it? percpu_counter we use is s64 anyway...

								Honza

> ---
>  fs/quota/dquot.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 6e826b454082..606e1e39674b 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2865,7 +2865,7 @@ static int do_proc_dqstats(struct ctl_table *table, int write,
>  	/* Update global table */
>  	dqstats.stat[type] =
>  			percpu_counter_sum_positive(&dqstats.counter[type]);
> -	return proc_dointvec(table, write, buffer, lenp, ppos);
> +	return proc_douintvec(table, write, buffer, lenp, ppos);
>  }
>  
>  static struct ctl_table fs_dqstats_table[] = {
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
