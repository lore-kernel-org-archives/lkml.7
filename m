Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E227C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFA52184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfCTO2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:28:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33082 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfCTO2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:28:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id k14so2754062qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=smCGIeI6unDecV1aEBVbWWQkZNXXruDfYTpgXklMZKc=;
        b=rNacqltbMGgWdJk3L7yVm7cj6oExDOCGLV2XJNfXihjSa+QPgZHO6min6eJRXjI9Xb
         6Y/Yd+RGAyu21OfGd3CTpmHtS1jVDPJTlfX0YrtkI6PHtJImvKh2DBEFQzbZeR6ezysN
         sgp3HdgpjdIVaFpn9+Gzpz+qmKramnQGU3gubhYOvCeOwfBOwHSzSfetHKxUusoZld4t
         R1buenliF+K1P73ekyw2qIo5tgN/ZVkYKgi0BoPZzFH5jerhMiZbqvdhmngA6//cC/1v
         sw7H/eNR0+1AN1CHE/8Ml5EJgTyY5siIMA5+jnjTVXyLtjcuQ4JKYsJECrDwdBo66KKl
         l96g==
X-Gm-Message-State: APjAAAUH4X2CMhAS8wcwsWsD7Z+rA5dbavmc3qEH5hRzi92mvRWXBq7i
        2Z7PYCGfnF5zN5G2Yff27PaoXQ==
X-Google-Smtp-Source: APXvYqw8nqgdlvVmWGpdsXaRt8lJKqqLwoeke1NlThzqJJzb2ijpW0P2BGlHJcE72TgE2lldw3Lvow==
X-Received: by 2002:ac8:1637:: with SMTP id p52mr1634425qtj.212.1553092117360;
        Wed, 20 Mar 2019 07:28:37 -0700 (PDT)
Received: from ?IPv6:2601:602:9800:dae6::c6a6? ([2601:602:9800:dae6::c6a6])
        by smtp.gmail.com with ESMTPSA id q75sm1200600qke.17.2019.03.20.07.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 07:28:36 -0700 (PDT)
Subject: Re: [PATCH] driver : staging : ion: optimization for decreasing
 memory fragmentaion
To:     Vlastimil Babka <vbabka@suse.cz>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        David Rientjes <rientjes@google.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        devel@driverdev.osuosl.org,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <1552561599-23662-1-git-send-email-huangzhaoyang@gmail.com>
 <ca8bb8d0-3252-f9a7-3bf7-98d5a97e40cf@suse.cz>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <73eb235f-9515-916e-ff20-0491fe2e107e@redhat.com>
Date:   Wed, 20 Mar 2019 07:28:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ca8bb8d0-3252-f9a7-3bf7-98d5a97e40cf@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/19 7:23 AM, Vlastimil Babka wrote:
> You should have CC'd the ION maintainers/lists per
> ./scripts/get_maintainer.pl - CCing now.
> 
> On 3/14/19 12:06 PM, Zhaoyang Huang wrote:
>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>
>> Two action for this patch:
>> 1. set a batch size for system heap's shrinker, which can have it buffer
>> reasonable page blocks in pool for future allocation.
>> 2. reverse the order sequence when free page blocks, the purpose is also
>> to have system heap keep as more big blocks as it can.
>>
>> By testing on an android system with 2G RAM, the changes with setting
>> batch = 48MB can help reduce the fragmentation obviously and improve
>> big block allocation speed for 15%.
>>
>> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>> ---
>>   drivers/staging/android/ion/ion_heap.c        | 12 +++++++++++-
>>   drivers/staging/android/ion/ion_system_heap.c |  2 +-
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
>> index 31db510..9e9caf2 100644
>> --- a/drivers/staging/android/ion/ion_heap.c
>> +++ b/drivers/staging/android/ion/ion_heap.c
>> @@ -16,6 +16,8 @@
>>   #include <linux/vmalloc.h>
>>   #include "ion.h"
>>   
>> +unsigned long ion_heap_batch = 0;
>> +
>>   void *ion_heap_map_kernel(struct ion_heap *heap,
>>   			  struct ion_buffer *buffer)
>>   {
>> @@ -303,7 +305,15 @@ int ion_heap_init_shrinker(struct ion_heap *heap)
>>   	heap->shrinker.count_objects = ion_heap_shrink_count;
>>   	heap->shrinker.scan_objects = ion_heap_shrink_scan;
>>   	heap->shrinker.seeks = DEFAULT_SEEKS;
>> -	heap->shrinker.batch = 0;
>> +	heap->shrinker.batch = ion_heap_batch;
>>   
>>   	return register_shrinker(&heap->shrinker);
>>   }
>> +
>> +static int __init ion_system_heap_batch_init(char *arg)
>> +{
>> +	 ion_heap_batch = memparse(arg, NULL);
>> +
>> +	return 0;
>> +}
>> +early_param("ion_batch", ion_system_heap_batch_init);
>> diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
>> index 701eb9f..d249f8d 100644
>> --- a/drivers/staging/android/ion/ion_system_heap.c
>> +++ b/drivers/staging/android/ion/ion_system_heap.c
>> @@ -182,7 +182,7 @@ static int ion_system_heap_shrink(struct ion_heap *heap, gfp_t gfp_mask,
>>   	if (!nr_to_scan)
>>   		only_scan = 1;
>>   
>> -	for (i = 0; i < NUM_ORDERS; i++) {
>> +	for (i = NUM_ORDERS - 1; i >= 0; i--) {
>>   		pool = sys_heap->pools[i];
>>   
>>   		if (only_scan) {
>>
> 

We're in the process of significantly reworking Ion so I
don't think it makes sense to take these as we work to
get things out of staging. You can resubmit this later,
but when you do please split this into two separate
patches since it's actually two independent changes.

Thanks,
Laura

