Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6BBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339B42175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRSjBEvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfCTBKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:10:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39518 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfCTBKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:10:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so625873pfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 18:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=hIdsISv5yPCS5cuuuJe1mtyrZh/Lcqy2MMFx/vVZ7bA=;
        b=rRSjBEvuq6CwPO6V8PH4QpUhIcHsuJza6P4nOekQnxYO9upU6QfONfU7Di8xmmLY5T
         tuWWsYMB5NiYqWVk78vNyqORKp/d4ZMAUSJ/Skney/omDNoBJqjkTDKMIj2QGWjxYwLB
         DkxUhvqhj4Nhr2kOpHknroYrlpltyEGKDrnLPFZTsRDgYDdsmqLutK8qY8p+rFNvjRAB
         PmH9xtdWdo36iAELA9Zmnn8XsL8Ofyrkrl6uQv2mvWLXbOndc+cMQJYlS/q1MToeTQeB
         QUlgeEKe12NnNZPyCSR/jXPyuBQVkHyZzugzRsiaFWed6LgtIFISI0ObvmnHT5v1wQUy
         cfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=hIdsISv5yPCS5cuuuJe1mtyrZh/Lcqy2MMFx/vVZ7bA=;
        b=UEWw2sySwDWzdc7BqPJ0XWxC+ycVkD+6D4MqLRrACEOwiwcxgBbik8QVb1NpRkLPQh
         tOK6MolFO9eEm3sE7Y2CDiDXrPaI7PSSu5RQVyCAQTBrWjdObAHyfzfSDLCbJhLE4tHN
         P7641mFtA/unIa58gEiYfzvnAk44sy7I/KnJH/3Awm+nf/kOZE2VJMaxHqOcvXMslfit
         PchA7j5PsSO+xM0XQyHDP/c4TsNcuj3R6YGPqbrRh5Rb4JLQiVa+PxhD37GE4bxXdX3H
         2RBaTY4K4AbZX1B1/i5aG5FTzWajon9pb92Q6SAJToYeo+t/fNR4Qd3azy/gc70inyCF
         BJeg==
X-Gm-Message-State: APjAAAUNDxugyTa0+rau9zQKOhypp/StGaXMng76vkSuZVTrWNaXP4g9
        udzSp4HqhCNI6zZFn6mm/EuiNg==
X-Google-Smtp-Source: APXvYqzNqxQ10Cek3L6LMJxVKefwkQ2rsGRE5G0ZuTEekssOFYsim2t3TLLX3pEP6tJmdMNScHADlA==
X-Received: by 2002:a63:e554:: with SMTP id z20mr11865916pgj.234.1553044250539;
        Tue, 19 Mar 2019 18:10:50 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id b8sm332538pfi.129.2019.03.19.18.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 18:10:49 -0700 (PDT)
Date:   Tue, 19 Mar 2019 18:10:49 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
cc:     Chintan Pandya <cpandya@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver : staging : ion: optimization for decreasing
 memory fragmentaion
In-Reply-To: <1552561599-23662-1-git-send-email-huangzhaoyang@gmail.com>
Message-ID: <alpine.DEB.2.21.1903191809420.18028@chino.kir.corp.google.com>
References: <1552561599-23662-1-git-send-email-huangzhaoyang@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019, Zhaoyang Huang wrote:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Two action for this patch:
> 1. set a batch size for system heap's shrinker, which can have it buffer
> reasonable page blocks in pool for future allocation.
> 2. reverse the order sequence when free page blocks, the purpose is also
> to have system heap keep as more big blocks as it can.
> 
> By testing on an android system with 2G RAM, the changes with setting
> batch = 48MB can help reduce the fragmentation obviously and improve
> big block allocation speed for 15%.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  drivers/staging/android/ion/ion_heap.c        | 12 +++++++++++-
>  drivers/staging/android/ion/ion_system_heap.c |  2 +-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
> index 31db510..9e9caf2 100644
> --- a/drivers/staging/android/ion/ion_heap.c
> +++ b/drivers/staging/android/ion/ion_heap.c
> @@ -16,6 +16,8 @@
>  #include <linux/vmalloc.h>
>  #include "ion.h"
>  
> +unsigned long ion_heap_batch = 0;

static?

> +
>  void *ion_heap_map_kernel(struct ion_heap *heap,
>  			  struct ion_buffer *buffer)
>  {
> @@ -303,7 +305,15 @@ int ion_heap_init_shrinker(struct ion_heap *heap)
>  	heap->shrinker.count_objects = ion_heap_shrink_count;
>  	heap->shrinker.scan_objects = ion_heap_shrink_scan;
>  	heap->shrinker.seeks = DEFAULT_SEEKS;
> -	heap->shrinker.batch = 0;
> +	heap->shrinker.batch = ion_heap_batch;
>  
>  	return register_shrinker(&heap->shrinker);
>  }
> +
> +static int __init ion_system_heap_batch_init(char *arg)
> +{
> +	 ion_heap_batch = memparse(arg, NULL);
> +

No bounds checking?  What are the legitimate upper and lower bounds here?

> +	return 0;
> +}
> +early_param("ion_batch", ion_system_heap_batch_init);
> diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> index 701eb9f..d249f8d 100644
> --- a/drivers/staging/android/ion/ion_system_heap.c
> +++ b/drivers/staging/android/ion/ion_system_heap.c
> @@ -182,7 +182,7 @@ static int ion_system_heap_shrink(struct ion_heap *heap, gfp_t gfp_mask,
>  	if (!nr_to_scan)
>  		only_scan = 1;
>  
> -	for (i = 0; i < NUM_ORDERS; i++) {
> +	for (i = NUM_ORDERS - 1; i >= 0; i--) {
>  		pool = sys_heap->pools[i];
>  
>  		if (only_scan) {

Can we get a Documentation update on how we can use ion_batch and what the 
appropriate settings are (and in what circumstances)?
