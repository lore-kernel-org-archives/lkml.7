Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76135C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448DA20700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="a1WHWnai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfC0Lef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:34:35 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41542 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfC0Lee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:34:34 -0400
Received: by mail-qk1-f193.google.com with SMTP id o129so9598641qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oKXYvkzbAHnLf4Q/hIMN6pMELkeRbB1zoPMlVpolYQU=;
        b=a1WHWnaiQv6dJHCs2ShSvtL8aE2Fv1WGb/onjA9ltzQwFMdf9pOBvhAQXCJfJaIn9J
         euLec8ZUn8hCr4eNEAgYW5GRMfRd0U5lMZhI/8hS5r4GRQ6XcCXsOWFIeUyKwE8WQhLs
         vaKtgpG1BX4PlrPQOJJrIRT6M+rVSgdFFvoa3s7vdeHcVR9IdrA0YmcPIN7BgMJznet7
         oNe0eMGUE4uOVF5+AuxJviWIFAciAEdJsB/9zBYYwb4iydZdR3iRqBhO10SnFHMTbTbT
         r0ZZIYy293WrW0YIYztolQy2xdjDo+Glv8ky9986s/DxMV+SvqDc3iT5io87BuPqTo7a
         xCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oKXYvkzbAHnLf4Q/hIMN6pMELkeRbB1zoPMlVpolYQU=;
        b=rEMPaa6gFnLsaShXNkps1M47l5VN8CIOTVEHZR6N+iP2O/yqbBwea9plDdu67DWuGN
         zGbPUOtORIeqmHtRJqFw5KYmheNyElQ6ue+Uh/MGd6Wg8nHubpOMV9jNlqxbMTpdP2CG
         F6IcIDnaQLr2D422bUS03SJrnPJck/zSv2/HXcxFvcl3zd+C/FEa6fseeytyzyqNMy/3
         kAw2QNZsqfnangr95KaMpF5ElI/Liks39Thnds2hTTsvQ9sZdJs3faBVHQa3CofO8jzx
         Q7eUxFiycB70/9yOGM0eQQscxtp+IHFFwbHPp11tRtbTKCQ15wfosl50VEyNPgmy91IP
         apKA==
X-Gm-Message-State: APjAAAUj2HeUflm+U1GzyPeVk+sv7eIoqhdxi0mOLgYIkQnlxArvvXbT
        9HglqiP0XJ4JB8a26IVnVOF0h9+UJAk=
X-Google-Smtp-Source: APXvYqz6Zcg1acfAJBgk15Q+CQzMSU639OLUibAyEcKgeoMxLcQv5XpzL0DGrNAsf5FjTGfoyJhK5A==
X-Received: by 2002:a37:5c05:: with SMTP id q5mr26594594qkb.20.1553686473610;
        Wed, 27 Mar 2019 04:34:33 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v4sm11903344qtq.94.2019.03.27.04.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 04:34:33 -0700 (PDT)
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com, cl@linux.com,
        willy@infradead.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190327005948.24263-1-cai@lca.pw>
 <20190327084432.GA11927@dhcp22.suse.cz>
From:   Qian Cai <cai@lca.pw>
Message-ID: <651bd879-c8c0-b162-fee7-1e523904b14e@lca.pw>
Date:   Wed, 27 Mar 2019 07:34:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190327084432.GA11927@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/19 4:44 AM, Michal Hocko wrote:
>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index a2d894d3de07..7f4545ab1f84 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -580,7 +580,16 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>>  	struct rb_node **link, *rb_parent;
>>  	unsigned long untagged_ptr;
>>  
>> -	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
>> +	/*
>> +	 * The tracked memory was allocated successful, if the kmemleak object
>> +	 * failed to allocate for some reasons, it ends up with the whole
>> +	 * kmemleak disabled, so try it harder.
>> +	 */
>> +	gfp = (in_atomic() || irqs_disabled()) ?
>> +	       gfp_kmemleak_mask(gfp) | GFP_ATOMIC :
>> +	       gfp_kmemleak_mask(gfp) | __GFP_DIRECT_RECLAIM;
> 
> 
> The comment for in_atomic says:
>  * Are we running in atomic context?  WARNING: this macro cannot
>  * always detect atomic context; in particular, it cannot know about
>  * held spinlocks in non-preemptible kernels.  Thus it should not be
>  * used in the general case to determine whether sleeping is possible.
>  * Do not use in_atomic() in driver code.

That is why it needs both in_atomic() and irqs_disabled(), so irqs_disabled()
can detect kernel functions held spinlocks even in non-preemptible kernels.

According to [1],

"This [2] is useful if you know that the data in question is only ever
manipulated from a "process context", ie no interrupts involved."

Since kmemleak only deal with kernel context, if a spinlock was held, it always
has local interrupt disabled.

ftrace is in the same boat where this commit was merged a while back that has
the same check.

ef99b88b16be
tracing: Handle ftrace_dump() atomic context in graph_trace_open()

[1] https://www.kernel.org/doc/Documentation/locking/spinlocks.txt
[2]
	spin_lock(&lock);
	...
	spin_unlock(&lock);
