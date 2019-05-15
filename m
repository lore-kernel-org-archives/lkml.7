Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49053C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2620A2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfEOJQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:16:19 -0400
Received: from relay.sw.ru ([185.231.240.75]:49850 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfEOJQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:16:19 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hQq1H-00071z-GC; Wed, 15 May 2019 12:16:15 +0300
Subject: Re: [PATCH 1/5] proc: use down_read_killable for /proc/pid/maps
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <155790967258.1319.11531787078240675602.stgit@buzz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <77650cec-70cc-149a-74e9-2256c6138032@virtuozzo.com>
Date:   Wed, 15 May 2019 12:16:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155790967258.1319.11531787078240675602.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.05.2019 11:41, Konstantin Khlebnikov wrote:
> Do not stuck forever if something wrong.
> This function also used for /proc/pid/smaps.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

For the series:

Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  fs/proc/task_mmu.c   |    6 +++++-
>  fs/proc/task_nommu.c |    6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 01d4eb0e6bd1..2bf210229daf 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -166,7 +166,11 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  	if (!mm || !mmget_not_zero(mm))
>  		return NULL;
>  
> -	down_read(&mm->mmap_sem);
> +	if (down_read_killable(&mm->mmap_sem)) {
> +		mmput(mm);
> +		return ERR_PTR(-EINTR);
> +	}
> +
>  	hold_task_mempolicy(priv);
>  	priv->tail_vma = get_gate_vma(mm);
>  
> diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
> index 36bf0f2e102e..7907e6419e57 100644
> --- a/fs/proc/task_nommu.c
> +++ b/fs/proc/task_nommu.c
> @@ -211,7 +211,11 @@ static void *m_start(struct seq_file *m, loff_t *pos)
>  	if (!mm || !mmget_not_zero(mm))
>  		return NULL;
>  
> -	down_read(&mm->mmap_sem);
> +	if (down_read_killable(&mm->mmap_sem)) {
> +		mmput(mm);
> +		return ERR_PTR(-EINTR);
> +	}
> +
>  	/* start from the Nth VMA */
>  	for (p = rb_first(&mm->mm_rb); p; p = rb_next(p))
>  		if (n-- == 0)

