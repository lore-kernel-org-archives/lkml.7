Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14248C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0198216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfEHQz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:55:28 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:44752 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728686AbfEHQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:55:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TRCE-nj_1557334521;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TRCE-nj_1557334521)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 May 2019 00:55:25 +0800
Subject: Re: [PATCH] mm: filemap: correct the comment about VM_FAULT_RETRY
To:     josef@toxicpanda.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1556234531-108228-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <66e2f965-4f4d-a755-69b3-5342aa761ff3@linux.alibaba.com>
Date:   Wed, 8 May 2019 09:55:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1556234531-108228-1-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.


Josef, any comment on this one?


Thanks,

Yang



On 4/25/19 4:22 PM, Yang Shi wrote:
> The commit 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking
> operations") changed when mmap_sem is dropped during filemap page fault
> and when returning VM_FAULT_RETRY.
>
> Correct the comment to reflect the change.
>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>   mm/filemap.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d78f577..f0d6250 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2545,10 +2545,8 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>    *
>    * vma->vm_mm->mmap_sem must be held on entry.
>    *
> - * If our return value has VM_FAULT_RETRY set, it's because
> - * lock_page_or_retry() returned 0.
> - * The mmap_sem has usually been released in this case.
> - * See __lock_page_or_retry() for the exception.
> + * If our return value has VM_FAULT_RETRY set, it's because the mmap_sem
> + * may be dropped before doing I/O or by lock_page_maybe_drop_mmap().
>    *
>    * If our return value does not have VM_FAULT_RETRY set, the mmap_sem
>    * has not been released.

