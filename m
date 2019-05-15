Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F03EC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF132082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfEOIi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:38:29 -0400
Received: from relay.sw.ru ([185.231.240.75]:48082 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfEOIi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:38:28 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hQpQZ-0006hD-8M; Wed, 15 May 2019 11:38:19 +0300
Subject: Re: [PATCH] mm: fix protection of mm_struct fields in get_cmdline()
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, mkoutny@suse.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
References: <155790813764.2995.13706842444028749629.stgit@buzz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <f0978f70-716c-0272-d8f0-87dc163d0784@virtuozzo.com>
Date:   Wed, 15 May 2019 11:38:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155790813764.2995.13706842444028749629.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Konstantin,

On 15.05.2019 11:15, Konstantin Khlebnikov wrote:
> Since commit 88aa7cc688d4 ("mm: introduce arg_lock to protect arg_start|
> end and env_start|end in mm_struct") related mm fields are protected with
> separate spinlock and mmap_sem held for read is not enough for protection.
> 
> Fixes: 88aa7cc688d4 ("mm: introduce arg_lock to protect arg_start|end and env_start|end in mm_struct")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

is this already fixed in Michal's series: https://lkml.org/lkml/2019/5/2/422 ?

Thanks,
Kirill

> ---
>  mm/util.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index e2e4f8c3fa12..540e7c157cf2 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -717,12 +717,12 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
>  	if (!mm->arg_end)
>  		goto out_mm;	/* Shh! No looking before we're done */
>  
> -	down_read(&mm->mmap_sem);
> +	spin_lock(&mm->arg_lock);
>  	arg_start = mm->arg_start;
>  	arg_end = mm->arg_end;
>  	env_start = mm->env_start;
>  	env_end = mm->env_end;
> -	up_read(&mm->mmap_sem);
> +	spin_unlock(&mm->arg_lock);
>  
>  	len = arg_end - arg_start;
>  
> 

