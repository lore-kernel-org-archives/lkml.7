Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15801C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DD720652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCGJQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:16:26 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34424 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGJQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:16:26 -0500
Received: from [IPv6:2a00:5f00:102:0:6dae:eb08:2e0f:5281] (unknown [IPv6:2a00:5f00:102:0:6dae:eb08:2e0f:5281])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B6FCC27F136;
        Thu,  7 Mar 2019 09:16:23 +0000 (GMT)
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Matt Hart <matthew.hart@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, khilman@baylibre.com,
        enric.balletbo@collabora.com, Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, info@kernelci.org
References: <20190215185151.GG7897@sirena.org.uk>
 <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
 <CAPcyv4ivjC8fNkfjdFyaYCAjGh7wtvFQnoPpOcR=VNZ=c6d6Rg@mail.gmail.com>
 <20190228151438.fc44921e66f2f5d393c8d7b4@linux-foundation.org>
 <CAPcyv4hDmmK-L=0txw7L9O8YgvAQxZfVFiSoB4LARRnGQ3UC7Q@mail.gmail.com>
 <026b5082-32f2-e813-5396-e4a148c813ea@collabora.com>
 <20190301124100.62a02e2f622ff6b5f178a7c3@linux-foundation.org>
 <3fafb552-ae75-6f63-453c-0d0e57d818f3@collabora.com>
 <CAPcyv4hMNiiM11ULjbOnOf=9N=yCABCRsAYLpjXs+98bRoRpCA@mail.gmail.com>
 <36faea07-139c-b97d-3585-f7d6d362abc3@collabora.com>
 <20190306140529.GG3549@rapoport-lnx>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <21d138a5-13e4-9e83-d7fe-e0639a8d180a@collabora.com>
Date:   Thu, 7 Mar 2019 09:16:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306140529.GG3549@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2019 14:05, Mike Rapoport wrote:
> On Wed, Mar 06, 2019 at 10:14:47AM +0000, Guillaume Tucker wrote:
>> On 01/03/2019 23:23, Dan Williams wrote:
>>> On Fri, Mar 1, 2019 at 1:05 PM Guillaume Tucker
>>> <guillaume.tucker@collabora.com> wrote:
>>>
>>> Is there an early-printk facility that can be turned on to see how far
>>> we get in the boot?
>>
>> Yes, I've done that now by enabling CONFIG_DEBUG_AM33XXUART1 and
>> earlyprintk in the command line.  Here's the result, with the
>> commit cherry picked on top of next-20190304:
>>
>>   https://lava.collabora.co.uk/scheduler/job/1526326
>>
>> [    1.379522] ti-sysc 4804a000.target-module: sysc_flags 00000222 != 00000022
>> [    1.396718] Unable to handle kernel paging request at virtual address 77bb4003
>> [    1.404203] pgd = (ptrval)
>> [    1.406971] [77bb4003] *pgd=00000000
>> [    1.410650] Internal error: Oops: 5 [#1] ARM
>> [...]
>> [    1.672310] [<c07051a0>] (clk_hw_create_clk.part.21) from [<c06fea34>] (devm_clk_get+0x4c/0x80)
>> [    1.681232] [<c06fea34>] (devm_clk_get) from [<c064253c>] (sysc_probe+0x28c/0xde4)
>>
>> It's always failing at that point in the code.  Also when
>> enabling "debug" on the kernel command line, the issue goes
>> away (exact same binaries etc..):
>>
>>   https://lava.collabora.co.uk/scheduler/job/1526327
>>
>> For the record, here's the branch I've been using:
>>
>>   https://gitlab.collabora.com/gtucker/linux/tree/beaglebone-black-next-20190304-debug
>>
>> The board otherwise boots fine with next-20190304 (SMP=n), and
>> also with the patch applied but the shuffle configs set to n.
>>
>>> Were there any boot *successes* on ARM with shuffling enabled? I.e.
>>> clues about what's different about the specific memory setup for
>>> beagle-bone-black.
>>
>> Looking at the KernelCI results from next-20190215, it looks like
>> only the BeagleBone Black with SMP=n failed to boot:
>>
>>   https://kernelci.org/boot/all/job/next/branch/master/kernel/next-20190215/
>>
>> Of course that's not all the ARM boards that exist out there, but
>> it's a fairly large coverage already.
>>
>> As the kernel panic always seems to originate in ti-sysc.c,
>> there's a chance it's only visible on that platform...  I'm doing
>> a KernelCI run now with my test branch to double check that,
>> it'll take a few hours so I'll send an update later if I get
>> anything useful out of it.

Here's the result, there were a couple of failures but some were
due to infrastructure errors (nyan-big) and I'm not sure about
what was the problem with the meson boards:

  https://staging.kernelci.org/boot/all/job/gtucker/branch/kernelci-local/kernel/next-20190304-1-g4f0b547b03da/

So there's no clear indicator that the shuffle config is causing
any issue on any other platform than the BeagleBone Black.

>> In the meantime, I'm happy to try out other things with more
>> debug configs turned on or any potential fixes someone might
>> have.
> 
> ARM is the only arch that sets ARCH_HAS_HOLES_MEMORYMODEL to 'y'. Maybe the
> failure has something to do with it...
> 
> Guillaume, can you try this patch:

Sure, it doesn't seem to be fixing the problem though:

  https://lava.collabora.co.uk/scheduler/job/1527471

I've added the patch to the same branch based on next-20190304.

I guess this needs to be debugged a little further to see what
the panic really is about.  I'll see if I can spend a bit more
time on it this week, unless there's any BeagleBone expert
available to help or if someone has another fix to try out.

Guillaume

> diff --git a/mm/shuffle.c b/mm/shuffle.c
> index 3ce1248..4a04aac 100644
> --- a/mm/shuffle.c
> +++ b/mm/shuffle.c
> @@ -58,7 +58,8 @@ module_param_call(shuffle, shuffle_store, shuffle_show, &shuffle_param, 0400);
>   * For two pages to be swapped in the shuffle, they must be free (on a
>   * 'free_area' lru), have the same order, and have the same migratetype.
>   */
> -static struct page * __meminit shuffle_valid_page(unsigned long pfn, int order)
> +static struct page * __meminit shuffle_valid_page(unsigned long pfn, int order,
> +						  struct zone *z)
>  {
>  	struct page *page;
>  
> @@ -80,6 +81,9 @@ static struct page * __meminit shuffle_valid_page(unsigned long pfn, int order)
>  	if (!PageBuddy(page))
>  		return NULL;
>  
> +	if (!memmap_valid_within(pfn, page, z))
> +		return NULL;
> +
>  	/*
>  	 * ...is the page on the same list as the page we will
>  	 * shuffle it with?
> @@ -123,7 +127,7 @@ void __meminit __shuffle_zone(struct zone *z)
>  		 * page_j randomly selected in the span @zone_start_pfn to
>  		 * @spanned_pages.
>  		 */
> -		page_i = shuffle_valid_page(i, order);
> +		page_i = shuffle_valid_page(i, order, z);
>  		if (!page_i)
>  			continue;
>  
> @@ -137,7 +141,7 @@ void __meminit __shuffle_zone(struct zone *z)
>  			j = z->zone_start_pfn +
>  				ALIGN_DOWN(get_random_long() % z->spanned_pages,
>  						order_pages);
> -			page_j = shuffle_valid_page(j, order);
> +			page_j = shuffle_valid_page(j, order, z);
>  			if (page_j && page_j != page_i)
>  				break;
>  		}
>  
> 

