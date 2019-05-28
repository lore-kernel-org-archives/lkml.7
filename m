Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45816C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166AC20989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qva2eZi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfE1XN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 19:13:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56726 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfE1XN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zhr6QUwZxGz7WiU0jZBWJVPKfwJ1v3Kt4Ac6JtF6cYo=; b=qva2eZi08rrz1erP0NOMc+QrBF
        qAEXOMYgiIMlB/J00mgYfCp4HEUoOQsvaX2ED0mhrlidTj/bN+kWO82j4mL2a+BDmvS67smHNVa9i
        RGr9CV0XHiKmXQbIeAGPttPWBjHOgrNlP3iShAcDCEQHVc4UsYV8N+xje+dqCS7jpIlXkX1kj7CUW
        xMuDyNTbnnw1jbTc2yqLOi17w7OCQhC8MhUoBpIvA+VVz244fqlfcRc+TZTEPv7SJa1wlCC8pY8iv
        /cezCWqCxKgiQIE4ebPop2xfHaUseYS0H0pg92/czNxcZzFovtk1VCqLcwhWZDmmsfwGbUecaegYw
        vaswB1gg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVlHN-0008VO-NM; Tue, 28 May 2019 23:13:13 +0000
Subject: Re: lib/test_overflow.c causes WARNING and tainted kernel
To:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <9fa84db9-084b-cf7f-6c13-06131efb0cfa@infradead.org>
 <CAGXu5j+yRt_yf2CwvaZDUiEUMwTRRiWab6aeStxqodx9i+BR4g@mail.gmail.com>
 <e2646ac0-c194-4397-c021-a64fa2935388@infradead.org>
 <97c4b023-06fe-2ec3-86c4-bfdb5505bf6d@rasmusvillemoes.dk>
 <201905281518.756178E7@keescook>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <38fd6e5d-3259-82d3-2e2a-8e65a40914d7@infradead.org>
Date:   Tue, 28 May 2019 16:13:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905281518.756178E7@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/19 3:47 PM, Kees Cook wrote:
> On Mon, May 27, 2019 at 09:53:33AM +0200, Rasmus Villemoes wrote:
>> On 25/05/2019 17.33, Randy Dunlap wrote:
>>> On 3/13/19 7:53 PM, Kees Cook wrote:
>>>> Hi!
>>>>
>>>> On Wed, Mar 13, 2019 at 2:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>>
>>>>> This is v5.0-11053-gebc551f2b8f9, MAR-12 around 4:00pm PT.
>>>>>
>>>>> In the first test_kmalloc() in test_overflow_allocation():
>>>>>
>>>>> [54375.073895] test_overflow: ok: (s64)(0 << 63) == 0
>>>>> [54375.074228] WARNING: CPU: 2 PID: 5462 at ../mm/page_alloc.c:4584 __alloc_pages_nodemask+0x33f/0x540
>>>>> [...]
>>>>> [54375.079236] ---[ end trace 754acb68d8d1a1cb ]---
>>>>> [54375.079313] test_overflow: kmalloc detected saturation
>>>>
>>>> Yup! This is expected and operating as intended: it is exercising the
>>>> allocator's detection of insane allocation sizes. :)
>>>>
>>>> If we want to make it less noisy, perhaps we could add a global flag
>>>> the allocators could check before doing their WARNs?
>>>>
>>>> -Kees
>>>
>>> I didn't like that global flag idea.  I also don't like the kernel becoming
>>> tainted by this test.
>>
>> Me neither. Can't we pass __GFP_NOWARN from the testcases, perhaps with
>> a module parameter to opt-in to not pass that flag? That way one can
>> make the overflow module built-in (and thus run at boot) without
>> automatically tainting the kernel.
>>
>> The vmalloc cases do not take gfp_t, would they still cause a warning?
> 
> They still warn, but they don't seem to taint. I.e. this patch:
> 
> diff --git a/lib/test_overflow.c b/lib/test_overflow.c
> index fc680562d8b6..c922f0d86181 100644
> --- a/lib/test_overflow.c
> +++ b/lib/test_overflow.c
> @@ -486,11 +486,12 @@ static int __init test_overflow_shift(void)
>   * Deal with the various forms of allocator arguments. See comments above
>   * the DEFINE_TEST_ALLOC() instances for mapping of the "bits".
>   */
> -#define alloc010(alloc, arg, sz) alloc(sz, GFP_KERNEL)
> -#define alloc011(alloc, arg, sz) alloc(sz, GFP_KERNEL, NUMA_NO_NODE)
> +#define alloc_GFP	(GFP_KERNEL | __GFP_NOWARN)
> +#define alloc010(alloc, arg, sz) alloc(sz, alloc_GFP)
> +#define alloc011(alloc, arg, sz) alloc(sz, alloc_GFP, NUMA_NO_NODE)
>  #define alloc000(alloc, arg, sz) alloc(sz)
>  #define alloc001(alloc, arg, sz) alloc(sz, NUMA_NO_NODE)
> -#define alloc110(alloc, arg, sz) alloc(arg, sz, GFP_KERNEL)
> +#define alloc110(alloc, arg, sz) alloc(arg, sz, alloc_GFP | __GFP_NOWARN)
>  #define free0(free, arg, ptr)	 free(ptr)
>  #define free1(free, arg, ptr)	 free(arg, ptr)
>  
> will remove the tainting behavior but is still a bit "noisy". I can't
> find a way to pass __GFP_NOWARN to a vmalloc-based allocation, though.
> 
> Randy, is removing taint sufficient for you?

Yes it is.  Thanks.

>> BTW, I noticed that the 'wrap to 8K' depends on 64 bit and
>> pagesize==4096; for 32 bit the result is 20K, while if the pagesize is
>> 64K one gets 128K and 512K for 32/64 bit size_t, respectively. Don't
>> know if that's a problem, but it's easy enough to make it independent of
>> pagesize (just make it 9*4096 explicitly), and if we use 5 instead of 9
>> it also becomes independent of sizeof(size_t) (wrapping to 16K).
> 
> Ah! Yes, all excellent points. I've adjusted that too now. I'll send
> the result to Andrew.
> 
> Thanks!
> 


-- 
~Randy
