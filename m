Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC59C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FFD227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfLTC5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 21:57:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39719 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLTC5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 21:57:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so512664plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 18:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=K35O8SA1msu5IjgqIlxgzlqgP7XVF9FXgmoFVeNWZbg=;
        b=PJxF/n/+5MJQFqTq0o32MZ8Lu8Tu4s8eRK60Iw20tudu3KOFPbze1LHjce8ywTaXl5
         jYQVTqmr0tuA1PZsiqPhvzwDFrleKgOoyW4PS79ohE6SxzsqAVTvmuhwK7bx8p8ljFYT
         kS+Pj6jTwtXs/fER2RNZ79Uo8Skf2JHExca2KVxJuVdrwE36T9dlB3/Dkz6eEMmhy2wx
         FcoV9R95Inv1vI7WvwPmbf8oY4ySQpglGwvR5EAHz6PS9fpRLQk3gaLBa/+NmYaga4LH
         V4RAbuMLJpMHZ7qhLCFh1CdI7Yj5S1pllRLIDomsSmZRSuWZFmk1s/oRSQ/eIBqiSWhG
         lETQ==
X-Gm-Message-State: APjAAAWbv5MEbizjrTyri1kkwZBF1blGmI8T8P5d9gECRHPrTydbmC0p
        s4T1p+VEgD46iP9FCWE03SkR7yQv
X-Google-Smtp-Source: APXvYqwXHoVr3P1IOwU5RHgS7/ZNe/Mzre69I1T6drEFTY08f64zcKfpDENlpripFkwXLw018g9JFA==
X-Received: by 2002:a17:902:b78b:: with SMTP id e11mr12920137pls.129.1576810637129;
        Thu, 19 Dec 2019 18:57:17 -0800 (PST)
Received: from ?IPv6:2601:647:4000:1108:a155:f521:af71:d5a4? ([2601:647:4000:1108:a155:f521:af71:d5a4])
        by smtp.gmail.com with ESMTPSA id z29sm9763651pge.21.2019.12.19.18.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 18:57:15 -0800 (PST)
Subject: Re: [PATCH] locking/lockdep: Fix potential buffer overrun problem in
 stack_trace[]
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org
References: <20191219182812.20191-1-longman@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <0cdfb26d-7faa-9da0-05b9-79bb21703283@acm.org>
Date:   Thu, 19 Dec 2019 18:57:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191219182812.20191-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-19 10:28, Waiman Long wrote:
> If the lockdep code is really running out of the stack_trace entries,
> there is a possiblity that buffer overrun can happen and corrupt the
             ^^^^^^^^^^
             possibility?
> data immediately after stack_trace[].
> 
> If there is less than LOCK_TRACE_SIZE_IN_LONGS entries left before
> the call to save_trace(), the max_entries computation will leave it
> with a very large positive number because of its unsigned nature. The
> subsequent call to stack_trace_save() will then corrupt the data after
> stack_trace[]. Fix that by changing max_entries to a signed integer
> and check for negative value before calling stack_trace_save().
> 
> Fixes: 12593b7467f9 ("locking/lockdep: Reduce space occupied by stack traces")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/lockdep.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 32282e7112d3..56e260a7582f 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -482,7 +482,7 @@ static struct lock_trace *save_trace(void)
>  	struct lock_trace *trace, *t2;
>  	struct hlist_head *hash_head;
>  	u32 hash;
> -	unsigned int max_entries;
> +	int max_entries;
>  
>  	BUILD_BUG_ON_NOT_POWER_OF_2(STACK_TRACE_HASH_SIZE);
>  	BUILD_BUG_ON(LOCK_TRACE_SIZE_IN_LONGS >= MAX_STACK_TRACE_ENTRIES);
> @@ -490,10 +490,8 @@ static struct lock_trace *save_trace(void)
>  	trace = (struct lock_trace *)(stack_trace + nr_stack_trace_entries);
>  	max_entries = MAX_STACK_TRACE_ENTRIES - nr_stack_trace_entries -
>  		LOCK_TRACE_SIZE_IN_LONGS;
> -	trace->nr_entries = stack_trace_save(trace->entries, max_entries, 3);
>  
> -	if (nr_stack_trace_entries >= MAX_STACK_TRACE_ENTRIES -
> -	    LOCK_TRACE_SIZE_IN_LONGS - 1) {
> +	if (max_entries < 0) {
>  		if (!debug_locks_off_graph_unlock())
>  			return NULL;
>  
> @@ -502,6 +500,7 @@ static struct lock_trace *save_trace(void)
>  
>  		return NULL;
>  	}
> +	trace->nr_entries = stack_trace_save(trace->entries, max_entries, 3);
>  
>  	hash = jhash(trace->entries, trace->nr_entries *
>  		     sizeof(trace->entries[0]), 0);

I'm not sure whether it is useful to call stack_trace_save() if
max_entries == 0. How about changing the "max_entries < 0" test into
"max_entries <= 0"?

Thanks,

Bart.


