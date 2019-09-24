Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A934AC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A38214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504132AbfIXJNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:13:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfIXJNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:13:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 822988A1C95;
        Tue, 24 Sep 2019 09:13:34 +0000 (UTC)
Received: from [10.36.116.87] (ovpn-116-87.ams2.redhat.com [10.36.116.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E198F10013D9;
        Tue, 24 Sep 2019 09:13:31 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] memory_hotplug: Add a bounds check to
 check_hotplug_memory_range()
To:     Michal Hocko <mhocko@kernel.org>,
        Alastair D'Silva <alastair@d-silva.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190917010752.28395-1-alastair@au1.ibm.com>
 <20190917010752.28395-2-alastair@au1.ibm.com>
 <20190923122513.GO6016@dhcp22.suse.cz>
 <25e0af4cb24a41466032d704b89d25559e7ad968.camel@d-silva.org>
 <20190924090934.GF23050@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <32531671-77dd-7857-f34f-f73ea45f7e22@redhat.com>
Date:   Tue, 24 Sep 2019 11:13:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924090934.GF23050@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Tue, 24 Sep 2019 09:13:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.09.19 11:09, Michal Hocko wrote:
> On Tue 24-09-19 11:31:05, Alastair D'Silva wrote:
>> On Mon, 2019-09-23 at 14:25 +0200, Michal Hocko wrote:
>>> On Tue 17-09-19 11:07:47, Alastair D'Silva wrote:
>>>> From: Alastair D'Silva <alastair@d-silva.org>
>>>>
>>>> On PowerPC, the address ranges allocated to OpenCAPI LPC memory
>>>> are allocated from firmware. These address ranges may be higher
>>>> than what older kernels permit, as we increased the maximum
>>>> permissable address in commit 4ffe713b7587
>>>> ("powerpc/mm: Increase the max addressable memory to 2PB"). It is
>>>> possible that the addressable range may change again in the
>>>> future.
>>>>
>>>> In this scenario, we end up with a bogus section returned from
>>>> __section_nr (see the discussion on the thread "mm: Trigger bug on
>>>> if a section is not found in __section_nr").
>>>>
>>>> Adding a check here means that we fail early and have an
>>>> opportunity to handle the error gracefully, rather than rumbling
>>>> on and potentially accessing an incorrect section.
>>>>
>>>> Further discussion is also on the thread ("powerpc: Perform a
>>>> bounds
>>>> check in arch_add_memory").
>>>
>>> It would be nicer to refer to this by a message-id based url.
>>> E.g. 
>>> http://lkml.kernel.org/r/20190827052047.31547-1-alastair@au1.ibm.com
>>>
>>
>> Ok.
>>
>>>> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
>>>> ---
>>>>  include/linux/memory_hotplug.h |  1 +
>>>>  mm/memory_hotplug.c            | 13 ++++++++++++-
>>>>  2 files changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/memory_hotplug.h
>>>> b/include/linux/memory_hotplug.h
>>>> index f46ea71b4ffd..bc477e98a310 100644
>>>> --- a/include/linux/memory_hotplug.h
>>>> +++ b/include/linux/memory_hotplug.h
>>>> @@ -110,6 +110,7 @@ extern void
>>>> __online_page_increment_counters(struct page *page);
>>>>  extern void __online_page_free(struct page *page);
>>>>  
>>>>  extern int try_online_node(int nid);
>>>> +int check_hotplug_memory_addressable(u64 start, u64 size);
>>>>  
>>>>  extern int arch_add_memory(int nid, u64 start, u64 size,
>>>>  			struct mhp_restrictions *restrictions);
>>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>>> index c73f09913165..02cb9a74f561 100644
>>>> --- a/mm/memory_hotplug.c
>>>> +++ b/mm/memory_hotplug.c
>>>> @@ -1030,6 +1030,17 @@ int try_online_node(int nid)
>>>>  	return ret;
>>>>  }
>>>>  
>>>> +int check_hotplug_memory_addressable(u64 start, u64 size)
>>>> +{
>>>> +#ifdef MAX_PHYSMEM_BITS
>>>> +	if ((start + size - 1) >> MAX_PHYSMEM_BITS)
>>>> +		return -E2BIG;
>>>> +#endif
>>>
>>> Is there any arch which doesn't define this? We seemed to be using
>>> this
>>> in sparsemem code without any ifdefs.
>>
>> A few, but none of them would be enabling hotplug (which depends on
>> sparsemem), so you're right, the ifdef could be removed.
>>
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(check_hotplug_memory_addressable);
>>>
>>> If you squashed the patch 2 then it would become clear why this needs
>>> to
>>> be exported because you would have a driver user. I find it a bit
>>> unfortunate to expect that any driver which uses the hotplug code is
>>> expected to know that this check should be called. This sounds too
>>> error
>>> prone. Why hasn't been this done at __add_pages layer?
>>>
>>
>> It seemed that is should be a peer of check_hotplug_memory_range(), as
>> it gives similar feedback (whether the provided range is suitable).
> 
> Well, that one seems to do a similar yet a different kind of check. It
> imposes a constrain to the alignment of the memory that is hotplugable
> via add_memory_resource - aka memory with user visible sysfs interface
> and that really has some restrictions on the memory block sizes now.
>  
>> If we did the check in __add_pages, wouldn't we potentially lose bits
>> from the LSBs of start & size, or is there some other requirement that
>> already ensures start & size are always page aligned?
> 
> I do not really think we have to care about page unaligned addresses.
> Callers down the road usually work with pfns. 
> 
>> It appears this patch has been accepted - if we were to make this
>> change, does it go as another spin on this series or a new series?
> 
> yes, the patch has been rushed to Linus unfortunatelly. Although I do
> not really see any reason why. Sigh...
> Anyway, now that it is in Linus' tree then we can only do a follow up on
> top.
> 
>>>> +
>>>>  static int check_hotplug_memory_range(u64 start, u64 size)
>>>>  {
>>>>  	/* memory range must be block size aligned */
>>>> @@ -1040,7 +1051,7 @@ static int check_hotplug_memory_range(u64
>>>> start, u64 size)
>>>>  		return -EINVAL;
>>>>  	}
>>>>  
>>>> -	return 0;
>>>> +	return check_hotplug_memory_addressable(start, size);
>>>
>>> This will result in a silent failure (unlike misaligned case). Is
>>> this
>>> what we want?
>>
>> Good point - I guess it comes down to, is there anything we expect an
>> end user to do about it? I'm not sure there is, in which case the bad
>> RC, which is reported up every call chain that I can see, should be
>> sufficient.
> 
> It seems like a clear HW/platform bug to me. And that should better be
> reported loudly to the log to make sure people do complain to their FW
> friends and have it fixed.
> 

I don't agree in virtual environment. On s390x, MAX_PHYSMEM_BITS is
configurable. For example, if you have paravirtualized memory hotplug
(e.g., virtio-mem), you could add memory to the system that violates
this constraint.

virtio-mem, however, does properly check for MAX_PHYSMEM_BITS itself -
at least in the current RFC v3.

-- 

Thanks,

David / dhildenb
