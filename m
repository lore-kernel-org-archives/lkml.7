Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0372DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04D62085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfCRMc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:32:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726697AbfCRMc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:32:58 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 275ACBA58C5474322C2A;
        Mon, 18 Mar 2019 20:32:57 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.180) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Mar 2019
 20:32:53 +0800
Subject: Re: [PATCH] workqueue, lockdep: Fix new alloc_workqueue() error path
To:     <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190318115833.67468-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <572e8287-f9b8-d29d-be8b-f9edf7784cda@huawei.com>
Date:   Mon, 18 Mar 2019 20:32:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190318115833.67468-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.177.19.180]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore, no check lkml again,  see https://lkml.org/lkml/2019/3/11/1274:-)

On 2019/3/18 19:58, Kefeng Wang wrote:
> If alloc_workqueue_attrs() fails, the workqueue lockdep is
> uninitialized, it will trigger a warning in err_free_wq path
> when try to unregister workqueue lockdep.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Fixes: 009bb421b6ce ("workqueue, lockdep: Fix an alloc_workqueue() error path")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  kernel/workqueue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 4026d1871407..2c19f2968bc7 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -4242,7 +4242,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>  	if (flags & WQ_UNBOUND) {
>  		wq->unbound_attrs = alloc_workqueue_attrs(GFP_KERNEL);
>  		if (!wq->unbound_attrs)
> -			goto err_free_wq;
> +			goto err_unbound_attrs;
>  	}
>  
>  	va_start(args, max_active);
> @@ -4296,6 +4296,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>  	wq_unregister_lockdep(wq);
>  	wq_free_lockdep(wq);
>  	free_workqueue_attrs(wq->unbound_attrs);
> +err_unbound_attrs:
>  	kfree(wq);
>  	return NULL;
>  err_destroy:

