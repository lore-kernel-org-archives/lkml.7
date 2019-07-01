Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B171C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2911208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfGAKzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:55:50 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58554 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfGAKzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:55:50 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x61AtM1h012989;
        Mon, 1 Jul 2019 19:55:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Mon, 01 Jul 2019 19:55:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x61AtLTD012983
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 1 Jul 2019 19:55:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: [PATCH] staging: android: ion: Bail out upon SIGKILL when allocating
 memory.
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org
References: <000000000000a861f6058b2699e0@google.com>
 <03763360-a7de-de87-eb90-ba7838143930@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <d088f188-5f32-d8fc-b9a0-0b404f7501cc@I-love.SAKURA.ne.jp>
Date:   Mon, 1 Jul 2019 19:55:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <03763360-a7de-de87-eb90-ba7838143930@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, can you pick up this patch? No response from Laura Abbott nor Sumit Semwal.

On 2019/06/21 18:58, Tetsuo Handa wrote:
> From e0758655727044753399fb4f7c5f3eb25ac5cccd Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Fri, 21 Jun 2019 11:22:51 +0900
> Subject: [PATCH] staging: android: ion: Bail out upon SIGKILL when allocating memory.
> 
> syzbot found that a thread can stall for minutes inside
> ion_system_heap_allocate() after that thread was killed by SIGKILL [1].
> Let's check for SIGKILL before doing memory allocation.
> 
> [1] https://syzkaller.appspot.com/bug?id=a0e3436829698d5824231251fad9d8e998f94f5e
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
> ---
>  drivers/staging/android/ion/ion_page_pool.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
> index fd4995fb676e..f85ec5b16b65 100644
> --- a/drivers/staging/android/ion/ion_page_pool.c
> +++ b/drivers/staging/android/ion/ion_page_pool.c
> @@ -8,11 +8,14 @@
>  #include <linux/list.h>
>  #include <linux/slab.h>
>  #include <linux/swap.h>
> +#include <linux/sched/signal.h>
>  
>  #include "ion.h"
>  
>  static inline struct page *ion_page_pool_alloc_pages(struct ion_page_pool *pool)
>  {
> +	if (fatal_signal_pending(current))
> +		return NULL;
>  	return alloc_pages(pool->gfp_mask, pool->order);
>  }
>  
> 

