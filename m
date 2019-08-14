Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F99DC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C792208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JVminWy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfHNXfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 19:35:00 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16343 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbfHNXfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 19:35:00 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d549aa50001>; Wed, 14 Aug 2019 16:35:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 14 Aug 2019 16:34:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 14 Aug 2019 16:34:59 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 14 Aug
 2019 23:34:58 +0000
Subject: Re: [PATCH 1/5] mm: Check if mmu notifier callbacks are allowed to
 fail
To:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-2-daniel.vetter@ffwll.ch>
 <20190814151447.e9ab74f4c7ed4297e39321d1@linux-foundation.org>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <e917a6f3-463b-0abf-66b7-d4934dbb3af9@nvidia.com>
Date:   Wed, 14 Aug 2019 16:34:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190814151447.e9ab74f4c7ed4297e39321d1@linux-foundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565825701; bh=e+e/OQAXN7GkasI6yC/EXJqM8IXP7fwTmNiXqJvaCJE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JVminWy3F1xcDKxguw/IFHSOu8yhmVpbFza3GaG0mcfwG4ZfLiV+j+Y1GInVll+lG
         zOHBACB2xataDHAY+fhoLTpXwvhpiAh8BOZRzHl8PQNjmb9XVXAJ6UhqcfmUWMkc1H
         s74P3+VufRz//nqshg6mlRajAdOp+1vAhWQ3HkNiMU08Pq4yh431tX72STl+3t5R08
         2P0QHNrM//MIYUOmV/X/lEbCQgf8fXWN/WgAQy4ub4cbO3X3SQd3OPEX37pSR74BaI
         4AAwMUxOrZgCYLjOGKv8LKXCsKj6qQpYdOhjKvEkLAoCFplAqwo5b1MAIqg/BjouNM
         h3xNFgkHpm/EA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/14/19 3:14 PM, Andrew Morton wrote:
> On Wed, 14 Aug 2019 22:20:23 +0200 Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> 
>> Just a bit of paranoia, since if we start pushing this deep into
>> callchains it's hard to spot all places where an mmu notifier
>> implementation might fail when it's not allowed to.
>>
>> Inspired by some confusion we had discussing i915 mmu notifiers and
>> whether we could use the newly-introduced return value to handle some
>> corner cases. Until we realized that these are only for when a task
>> has been killed by the oom reaper.
>>
>> An alternative approach would be to split the callback into two
>> versions, one with the int return value, and the other with void
>> return value like in older kernels. But that's a lot more churn for
>> fairly little gain I think.
>>
>> Summary from the m-l discussion on why we want something at warning
>> level: This allows automated tooling in CI to catch bugs without
>> humans having to look at everything. If we just upgrade the existing
>> pr_info to a pr_warn, then we'll have false positives. And as-is, no
>> one will ever spot the problem since it's lost in the massive amounts
>> of overall dmesg noise.
>>
>> ...
>>
>> --- a/mm/mmu_notifier.c
>> +++ b/mm/mmu_notifier.c
>> @@ -179,6 +179,8 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
>>   				pr_info("%pS callback failed with %d in %sblockable context.\n",
>>   					mn->ops->invalidate_range_start, _ret,
>>   					!mmu_notifier_range_blockable(range) ? "non-" : "");
>> +				WARN_ON(mmu_notifier_range_blockable(range) ||
>> +					ret != -EAGAIN);
>>   				ret = _ret;
>>   			}
>>   		}
> 
> A problem with WARN_ON(a || b) is that if it triggers, we don't know
> whether it was because of a or because of b.  Or both.  So I'd suggest
> 
> 	WARN_ON(a);
> 	WARN_ON(b);
> 

This won't quite work. It is OK to have 
mmu_notifier_range_blockable(range) be true or false.
sync_cpu_device_pagetables() shouldn't return
-EAGAIN unless blockable is true.
