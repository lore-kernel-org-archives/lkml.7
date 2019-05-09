Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AE0C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0CD217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGl7wg2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfEIVuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:50:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33840 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfEIVuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:50:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id p27so3381267eda.1;
        Thu, 09 May 2019 14:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BMlSqCqK74ztHAZfTWbqmYSf5DVD6ofjZO6Gjzp7WWI=;
        b=NGl7wg2cGVpKyD9cpJHljZftn+LLkSh0SgfYuUD7pOjyCs9Ci6mgnsJnI/5YX2u2sA
         N00ub+BHjZPR67iWK7zGrSKdc2FIKgprC22Vnd+8DssY7k0hLeRClyrdM+litkTcYs5z
         wn30Qa8o0THNaD/XsPLrjqCpWhF62kj/AuENHYy+QRCEAH6uviiC55pbVSOOb7LbHdGw
         b43TyiAMIlgHR0fXTDmkpRK1aekheRqQsoO5nwvkE4LFcuDJ1jZjKz5V1h8l0HDavI8L
         LGaLQ402+MxxhMuG/j6qecZBHC9qJ7cHkd3zoNCrkpuydFRs/uCvLnQVkbwD/RSUNA0G
         Zriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BMlSqCqK74ztHAZfTWbqmYSf5DVD6ofjZO6Gjzp7WWI=;
        b=I+W5WEYUud8UU38P30M4kThIuoKLltm0GAxZ0GTIOxpgZtL4zcY5zIbY9DtxotcF6g
         rwNgApDExsO7svkXg0MhR0Oh4PlJnA2u83fL5I5hBUEymrR7pqdX/zvx5ZzxjyBgqOLF
         fwXZTBwevD9idFvaP7tPuCL8uDIXLtLheu8UrOaNRmwgyp7Tymevg/XP8wg9Yuc9oi6p
         SU/HrvamTJqN5OhKzRWULMnFm2EsSm4fE5M7V2AXrMGNlY3jRi+Ixa9AGrGERMMTuI5u
         WgIQMkmAs0zqYY7A/hi10jkv21BowhLphsn70heMfJbG0fwk/ad0VHwvTL7d/naSmobw
         BLig==
X-Gm-Message-State: APjAAAVPfVkkTRyCNFT3NdCUdS7C+f8uwUETTG6NRorJij8KjOwYL2rC
        utXtsY4A6sSu+/OYK4Yq010=
X-Google-Smtp-Source: APXvYqymBHLkj8Y+oaiwW9YuwNj6GLPLzc74NUHJXE/g8FqI3LUNlHjOkXv2ihOrqJ30gkhHPU8rNA==
X-Received: by 2002:a17:906:45c3:: with SMTP id z3mr5444210ejq.134.1557438636558;
        Thu, 09 May 2019 14:50:36 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v35sm890246edc.4.2019.05.09.14.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 14:50:35 -0700 (PDT)
Date:   Thu, 9 May 2019 21:50:34 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, akpm@linux-foundation.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Banman <andrew.banman@hpe.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Qian Cai <cai@lca.pw>, Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH v2 4/8] mm/memory_hotplug: Create memory block devices
 after arch_add_memory()
Message-ID: <20190509215034.jl2qejw3pzqtbu5d@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190507183804.5512-1-david@redhat.com>
 <20190507183804.5512-5-david@redhat.com>
 <20190509143151.zexjmwu3ikkmye7i@master>
 <28071389-372c-14eb-1209-02464726b4f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28071389-372c-14eb-1209-02464726b4f0@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 04:58:56PM +0200, David Hildenbrand wrote:
>On 09.05.19 16:31, Wei Yang wrote:
>> On Tue, May 07, 2019 at 08:38:00PM +0200, David Hildenbrand wrote:
>>> Only memory to be added to the buddy and to be onlined/offlined by
>>> user space using memory block devices needs (and should have!) memory
>>> block devices.
>>>
>>> Factor out creation of memory block devices Create all devices after
>>> arch_add_memory() succeeded. We can later drop the want_memblock parameter,
>>> because it is now effectively stale.
>>>
>>> Only after memory block devices have been added, memory can be onlined
>>> by user space. This implies, that memory is not visible to user space at
>>> all before arch_add_memory() succeeded.
>>>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Ingo Molnar <mingo@kernel.org>
>>> Cc: Andrew Banman <andrew.banman@hpe.com>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>>> Cc: Qian Cai <cai@lca.pw>
>>> Cc: Wei Yang <richard.weiyang@gmail.com>
>>> Cc: Arun KS <arunks@codeaurora.org>
>>> Cc: Mathieu Malaterre <malat@debian.org>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>> drivers/base/memory.c  | 70 ++++++++++++++++++++++++++----------------
>>> include/linux/memory.h |  2 +-
>>> mm/memory_hotplug.c    | 15 ++++-----
>>> 3 files changed, 53 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>>> index 6e0cb4fda179..862c202a18ca 100644
>>> --- a/drivers/base/memory.c
>>> +++ b/drivers/base/memory.c
>>> @@ -701,44 +701,62 @@ static int add_memory_block(int base_section_nr)
>>> 	return 0;
>>> }
>>>
>>> +static void unregister_memory(struct memory_block *memory)
>>> +{
>>> +	BUG_ON(memory->dev.bus != &memory_subsys);
>>> +
>>> +	/* drop the ref. we got via find_memory_block() */
>>> +	put_device(&memory->dev);
>>> +	device_unregister(&memory->dev);
>>> +}
>>> +
>>> /*
>>> - * need an interface for the VM to add new memory regions,
>>> - * but without onlining it.
>>> + * Create memory block devices for the given memory area. Start and size
>>> + * have to be aligned to memory block granularity. Memory block devices
>>> + * will be initialized as offline.
>>>  */
>>> -int hotplug_memory_register(int nid, struct mem_section *section)
>>> +int hotplug_memory_register(unsigned long start, unsigned long size)
>> 
>> One trivial suggestion about the function name.
>> 
>> For memory_block device, sometimes we use the full name
>> 
>>     find_memory_block
>>     init_memory_block
>>     add_memory_block
>> 
>> But sometimes we use *nick* name
>> 
>>     hotplug_memory_register
>>     register_memory
>>     unregister_memory
>> 
>> This is a little bit confusion.
>> 
>> Can we use one name convention here?
>
>We can just go for
>
>crate_memory_blocks() and free_memory_blocks(). Or do
>you have better suggestions?

s/crate/create/

Looks good to me.

>
>(I would actually even prefer "memory_block_devices", because memory
>blocks have different meanins)
>

Agree with you, this comes to my mind sometime ago :-)

>> 
>> [...]
>> 
>>> /*
>>> @@ -1106,6 +1100,13 @@ int __ref add_memory_resource(int nid, struct resource *res)
>>> 	if (ret < 0)
>>> 		goto error;
>>>
>>> +	/* create memory block devices after memory was added */
>>> +	ret = hotplug_memory_register(start, size);
>>> +	if (ret) {
>>> +		arch_remove_memory(nid, start, size, NULL);
>> 
>> Functionally, it works I think.
>> 
>> But arch_remove_memory() would remove pages from zone. At this point, we just
>> allocate section/mmap for pages, the zones are empty and pages are not
>> connected to zone.
>> 
>> Function  zone = page_zone(page); always gets zone #0, since pages->flags is 0
>> at  this point. This is not exact.
>> 
>> Would we add some comment to mention this? Or we need to clean up
>> arch_remove_memory() to take out __remove_zone()?
>
>That is precisely what is on my list next (see cover letter).This is
>already broken when memory that was never onlined is removed again.
>So I am planning to fix that independently.
>

Sounds great :-)

Hope you would cc me in the following series.

>
>-- 
>
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
