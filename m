Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19006C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CEE2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfGALhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:37:09 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37081 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfGALhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:37:09 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so10656629qkl.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 04:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IUwvWn3iirU6aSLcx0XYXnnFEG+ttMdH3zsQIc5/cho=;
        b=hSTaHVglSajdqpvVqe6XkeNh48zkC2QygPE6dFQrgbvEGrzOAHm1g9ckQcrshhK8RB
         Hm9iHxCJsLBFr73ZKRNbKj+Za3NsghuK5G1sPDJPlzKynbNxnZ/KHO8gTkK/5gNUnJtK
         ZkzJm8R3RRwgmAKJW4+942ruvghPbllaIqdQ3lXTCCdHchu1dd4SKpgsgfTiaDcMf/DH
         dbXZRyUi1Cx8OrKZuM8Vi5b4jbgfHdFYpi96/2kv//7FwBNkfzpm2NcYP87/9c4BLLDY
         TqeHlwIHu4UDyDri2ga1vnjyEvb+CB5avbIm7H7+lvu2O3FvMujNMLDYOpIgvmsIjLxm
         vgxg==
X-Gm-Message-State: APjAAAVEh0xYIRDC56qObTGvETsiOtJDTxtpHeJq+XS4qay4tmsejKbX
        i+owTbuZG9f+FHm7cBSUm19KLqRTltw=
X-Google-Smtp-Source: APXvYqyjMh9lOt930wg2sfQ4Cycs8D6QMVYcRFOrBsM+nFpdsaVZFhmwFvJYFQPezBDdy7M/eGWuTw==
X-Received: by 2002:ae9:ed8f:: with SMTP id c137mr20511697qkg.471.1561981028308;
        Mon, 01 Jul 2019 04:37:08 -0700 (PDT)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id x8sm5151422qka.106.2019.07.01.04.36.58
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 04:37:07 -0700 (PDT)
Subject: Re: [PATCH] staging: android: ion: Bail out upon SIGKILL when
 allocating memory.
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org
References: <000000000000a861f6058b2699e0@google.com>
 <03763360-a7de-de87-eb90-ba7838143930@I-love.SAKURA.ne.jp>
 <d088f188-5f32-d8fc-b9a0-0b404f7501cc@I-love.SAKURA.ne.jp>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <ceef00e8-819a-c0f0-cbb5-60e60e6631fe@redhat.com>
Date:   Mon, 1 Jul 2019 07:36:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d088f188-5f32-d8fc-b9a0-0b404f7501cc@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/19 6:55 AM, Tetsuo Handa wrote:
> Andrew, can you pick up this patch? No response from Laura Abbott nor Sumit Semwal.
> 
> On 2019/06/21 18:58, Tetsuo Handa wrote:
>>  From e0758655727044753399fb4f7c5f3eb25ac5cccd Mon Sep 17 00:00:00 2001
>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Date: Fri, 21 Jun 2019 11:22:51 +0900
>> Subject: [PATCH] staging: android: ion: Bail out upon SIGKILL when allocating memory.
>>
>> syzbot found that a thread can stall for minutes inside
>> ion_system_heap_allocate() after that thread was killed by SIGKILL [1].
>> Let's check for SIGKILL before doing memory allocation.
>>
>> [1] https://syzkaller.appspot.com/bug?id=a0e3436829698d5824231251fad9d8e998f94f5e
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Reported-by: syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
>> ---
>>   drivers/staging/android/ion/ion_page_pool.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
>> index fd4995fb676e..f85ec5b16b65 100644
>> --- a/drivers/staging/android/ion/ion_page_pool.c
>> +++ b/drivers/staging/android/ion/ion_page_pool.c
>> @@ -8,11 +8,14 @@
>>   #include <linux/list.h>
>>   #include <linux/slab.h>
>>   #include <linux/swap.h>
>> +#include <linux/sched/signal.h>
>>   
>>   #include "ion.h"
>>   
>>   static inline struct page *ion_page_pool_alloc_pages(struct ion_page_pool *pool)
>>   {
>> +	if (fatal_signal_pending(current))
>> +		return NULL;
>>   	return alloc_pages(pool->gfp_mask, pool->order);
>>   }
>>   
>>
> 

Acked-by: Laura Abbott <labbott@redhat.com>
