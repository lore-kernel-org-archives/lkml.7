Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E23C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269E5206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moj7sj9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfLSPb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:31:57 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35482 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfLSPb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:31:57 -0500
Received: by mail-yw1-f66.google.com with SMTP id i190so2305696ywc.2;
        Thu, 19 Dec 2019 07:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0NS200i4beBiDZcSz17C86J6e+34gJkf3amB13gbLIc=;
        b=moj7sj9dWzaMwXqnydmBqHVoerql4EHQnEu72gFSsz9GpTEj13ur2Xs8HafibbOQX3
         m12zHFaCiU6KKivTGbERgf9NocnKQywhOYisr/O0Yr+WkBTR7rrc84dGBhJSouFVm+jf
         4BTWIDhBdLdQCoXiDZHyR4Qt5WWWbGzqcwj9mwz7ZVqMCpYEcUnFd4J+hkhiqgolppt0
         9X7gY0yyOXA8ZrTD4xl6/gPqWVJ/jBqEzg6V3D8ch9UKI1h32Hpv6XkKDkjNu9WfSJvq
         letZDm8gNn6ZN7nT+ZyKMpbLpaU8za4JklAN/8PYroPUqiXdrp3Q7vpfUOYacoesyJPA
         vBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0NS200i4beBiDZcSz17C86J6e+34gJkf3amB13gbLIc=;
        b=HpUNg6YHIuYJ6xUi6Dhr23MDi5KVBZwiRcvn/kKR/cpw9sIBwBbtnqNiOGs1zg1keS
         Pp/XvhwHOrcoxYgVIRfyj+fvgs8i1WR3P5eH2wbXwlCA1OYx+P8hbcSlBPA7UvXlpYLD
         gI2SjVt24Z5yNf5ywBkYbp5rFvNyFeFCojy4eEtQQpx2jrijGXZ7zD0ZYDBP4DSmR4P3
         t0k3Wd8JvA8Jfvvxauegj/RLKM4pmcMcQm2nXHpRDWTCq2U/YN9tYk1w4CRAf+dgODxt
         zRJ7UHUNxaR7BrTSpwruHfyUu2dLAkK0AQB8nSHR/W7AldkehF5GC1f8UCDVd0UQm076
         Imug==
X-Gm-Message-State: APjAAAXDZNTrRRdFh1R/QiZOZXy69Snsu036Le32oZxdk6BrcZjNchNr
        VI0W46buOY//47rFZwyDPvE=
X-Google-Smtp-Source: APXvYqz3/28lqTRv8g8ivv0VFBMm0tMO5Jy/MfUDHMKSsLxcSBaUZYBjxWp5bOW3WlLHaFy+oZpeCA==
X-Received: by 2002:a81:ae51:: with SMTP id g17mr6957536ywk.302.1576769515399;
        Thu, 19 Dec 2019 07:31:55 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id h193sm2462864ywc.88.2019.12.19.07.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 07:31:54 -0800 (PST)
Subject: Re: [PATCH] of: Rework and simplify phandle cache to use a fixed size
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <20191211232345.24810-1-robh@kernel.org>
 <CAL_JsqKfV-4mx_uidUupQJT4qfq+y+qx1=S=Du-Qsaweh4CPUQ@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <597da13c-585b-4091-ecb6-da3cd19fcbc3@gmail.com>
Date:   Thu, 19 Dec 2019 09:31:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKfV-4mx_uidUupQJT4qfq+y+qx1=S=Du-Qsaweh4CPUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 5:48 PM, Rob Herring wrote:
> On Wed, Dec 11, 2019 at 5:23 PM Rob Herring <robh@kernel.org> wrote:
>>
>> The phandle cache was added to speed up of_find_node_by_phandle() by
>> avoiding walking the whole DT to find a matching phandle. The
>> implementation has several shortcomings:
>>
>>   - The cache is designed to work on a linear set of phandle values.
>>     This is true for dtc generated DTs, but not for other cases such as
>>     Power.
>>   - The cache isn't enabled until of_core_init() and a typical system
>>     may see hundreds of calls to of_find_node_by_phandle() before that
>>     point.
>>   - The cache is freed and re-allocated when the number of phandles
>>     changes.
>>   - It takes a raw spinlock around a memory allocation which breaks on
>>     RT.
>>
>> Change the implementation to a fixed size and use hash_32() as the
>> cache index. This greatly simplifies the implementation. It avoids
>> the need for any re-alloc of the cache and taking a reference on nodes
>> in the cache. We only have a single source of removing cache entries
>> which is of_detach_node().
>>
>> Using hash_32() removes any assumption on phandle values improving
>> the hit rate for non-linear phandle values. The effect on linear values
>> using hash_32() is about a 10% collision. The chances of thrashing on
>> colliding values seems to be low.
>>
>> To compare performance, I used a RK3399 board which is a pretty typical
>> system. I found that just measuring boot time as done previously is
>> noisy and may be impacted by other things. Also bringing up secondary
>> cores causes some issues with measuring, so I booted with 'nr_cpus=1'.
>> With no caching, calls to of_find_node_by_phandle() take about 20124 us
>> for 1248 calls. There's an additional 288 calls before time keeping is
>> up. Using the average time per hit/miss with the cache, we can calculate
>> these calls to take 690 us (277 hit / 11 miss) with a 128 entry cache
>> and 13319 us with no cache or an uninitialized cache.
>>
>> Comparing the 3 implementations the time spent in
>> of_find_node_by_phandle() is:
>>
>> no cache:        20124 us (+ 13319 us)
>> 128 entry cache:  5134 us (+ 690 us)
>> current cache:     819 us (+ 13319 us)
>>
>> We could move the allocation of the cache earlier to improve the
>> current cache, but that just further complicates the situation as it
>> needs to be after slab is up, so we can't do it when unflattening (which
>> uses memblock).
>>
>> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Segher Boessenkool <segher@kernel.crashing.org>
>> Cc: Frank Rowand <frowand.list@gmail.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  drivers/of/base.c       | 133 ++++++++--------------------------------
>>  drivers/of/dynamic.c    |   2 +-
>>  drivers/of/of_private.h |   4 +-
>>  drivers/of/overlay.c    |  10 ---
>>  4 files changed, 28 insertions(+), 121 deletions(-)
> 
> [...]
> 
>> -       if (phandle_cache) {
>> -               if (phandle_cache[masked_handle] &&
>> -                   handle == phandle_cache[masked_handle]->phandle)
>> -                       np = phandle_cache[masked_handle];
>> -               if (np && of_node_check_flag(np, OF_DETACHED)) {
>> -                       WARN_ON(1); /* did not uncache np on node removal */
>> -                       of_node_put(np);
>> -                       phandle_cache[masked_handle] = NULL;
>> -                       np = NULL;
>> -               }
>> +       if (phandle_cache[handle_hash] &&
>> +           handle == phandle_cache[handle_hash]->phandle)
>> +               np = phandle_cache[handle_hash];
>> +       if (np && of_node_check_flag(np, OF_DETACHED)) {
>> +               WARN_ON(1); /* did not uncache np on node removal */
> 
> BTW, I don't think this check is even valid. If we failed to detach
> and remove the node from the cache, then we could be accessing np
> after freeing it.
> 
> Rob
> 

I added the OF_DETACHED checks out of extreme paranoia.  They can be
removed.

-Frank
