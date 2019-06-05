Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC48C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8206D20872
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLDsRwOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfFEVWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:22:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45145 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEVWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:22:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id f20so7716484edt.12;
        Wed, 05 Jun 2019 14:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XYR0qJWfd1D1ufm9G1S7XwxRI+/pUaRAjNUa1IxBLC8=;
        b=eLDsRwOhaZ0avYP5JbU/qyfKGB5DOL//jHeF0QIsj1xnkLpW3HfER5+1gHsFmyizdC
         TuPwJNXIJpeJwU2upcFzFr2gEM64wh1+94uumBqpRcHFkWQutwdt26Yv9sREHRvruvlk
         znKdHE2O7dSxq57NCvmgeA8foqkPAvf6tdKk+a+LkY6ICiZeCziK45J+jM2lAsYvL8tU
         +Q8RJK0GedIjFeQ+8FmqES5ccIjWGHSdcUNJ5Cq529NwrtvIRUY0YNg79G4IDKPEHmSd
         H8/CXuU0qTWRFEgsEUaYHo7abpCchUSLqryQVVOJdl4FKhHRIozaUGG29SyMvtoYQjn2
         iqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XYR0qJWfd1D1ufm9G1S7XwxRI+/pUaRAjNUa1IxBLC8=;
        b=S1i0HOiIBOkXsYyWcGZTlfEpvfnWnw5ZkIuFgK4ydso6Nc1PaUAv8S/ny2vKg+IL9c
         XKpL4NLQGGgPSf/hpxLJ5dksjp4pWeWXuohs0rcCk9Rd7mdZkiGik7NgIAoBaxOmC4vy
         PSh6utzsD3nKNYEkMUQ8o72pEjkyt0KZcrEuTzpEAXyxIfcI/HXOGsulannRMh1kWCwa
         x+fuYCPF8wqZm6JVt1OqgceF3e3yFaoOtwpliLBYXo40Q8PAEKVMiRDcWrfPeDVJq34H
         wbJ8JKPDTUiHDCtBdPu9WQM8LHWDbYJ1yK4LLsU12mvIil4cxEErUqQ9ja1T4YRIIY/1
         PtrQ==
X-Gm-Message-State: APjAAAU7W9FDZ4hW0dr07o4Smpur+nQrTl+aYv3Syz1uKbbhhuj5rCMq
        NaEzII/1ZaMU2Uus3v1/egw=
X-Google-Smtp-Source: APXvYqzyKS0phZCywdwPXToHaq30FkGf9zmLn9+DGARhqy7Cp0rjLbRZrzlUzgkPZspLLdcqpnQe5Q==
X-Received: by 2002:a50:927d:: with SMTP id j58mr11330969eda.230.1559769770516;
        Wed, 05 Jun 2019 14:22:50 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c7sm3853751ejz.71.2019.06.05.14.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 14:22:49 -0700 (PDT)
Date:   Wed, 5 Jun 2019 21:22:49 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>,
        Igor Mammedov <imammedo@redhat.com>,
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
Subject: Re: [PATCH v3 07/11] mm/memory_hotplug: Create memory block devices
 after arch_add_memory()
Message-ID: <20190605212249.s7knac6vimealdmx@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-8-david@redhat.com>
 <20190604214234.ltwtkcdoju2gxisx@master>
 <f6523d67-cac9-1189-884a-67b6829320ba@redhat.com>
 <9a1d282f-8dd9-a48b-cc96-f9afaa435c62@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a1d282f-8dd9-a48b-cc96-f9afaa435c62@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 12:58:46PM +0200, David Hildenbrand wrote:
>On 05.06.19 10:58, David Hildenbrand wrote:
>>>> /*
>>>>  * For now, we have a linear search to go find the appropriate
>>>>  * memory_block corresponding to a particular phys_index. If
>>>> @@ -658,6 +670,11 @@ static int init_memory_block(struct memory_block **memory, int block_id,
>>>> 	unsigned long start_pfn;
>>>> 	int ret = 0;
>>>>
>>>> +	mem = find_memory_block_by_id(block_id, NULL);
>>>> +	if (mem) {
>>>> +		put_device(&mem->dev);
>>>> +		return -EEXIST;
>>>> +	}
>>>
>>> find_memory_block_by_id() is not that close to the main idea in this patch.
>>> Would it be better to split this part?
>> 
>> I played with that but didn't like the temporary results (e.g. having to
>> export find_memory_block_by_id()). I'll stick to this for now.
>> 
>>>
>>>> 	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
>>>> 	if (!mem)
>>>> 		return -ENOMEM;
>>>> @@ -699,44 +716,53 @@ static int add_memory_block(int base_section_nr)
>>>> 	return 0;
>>>> }
>>>>
>>>> +static void unregister_memory(struct memory_block *memory)
>>>> +{
>>>> +	if (WARN_ON_ONCE(memory->dev.bus != &memory_subsys))
>>>> +		return;
>>>> +
>>>> +	/* drop the ref. we got via find_memory_block() */
>>>> +	put_device(&memory->dev);
>>>> +	device_unregister(&memory->dev);
>>>> +}
>>>> +
>>>> /*
>>>> - * need an interface for the VM to add new memory regions,
>>>> - * but without onlining it.
>>>> + * Create memory block devices for the given memory area. Start and size
>>>> + * have to be aligned to memory block granularity. Memory block devices
>>>> + * will be initialized as offline.
>>>>  */
>>>> -int hotplug_memory_register(int nid, struct mem_section *section)
>>>> +int create_memory_block_devices(unsigned long start, unsigned long size)
>>>> {
>>>> -	int block_id = base_memory_block_id(__section_nr(section));
>>>> -	int ret = 0;
>>>> +	const int start_block_id = pfn_to_block_id(PFN_DOWN(start));
>>>> +	int end_block_id = pfn_to_block_id(PFN_DOWN(start + size));
>>>> 	struct memory_block *mem;
>>>> +	unsigned long block_id;
>>>> +	int ret = 0;
>>>>
>>>> -	mutex_lock(&mem_sysfs_mutex);
>>>> +	if (WARN_ON_ONCE(!IS_ALIGNED(start, memory_block_size_bytes()) ||
>>>> +			 !IS_ALIGNED(size, memory_block_size_bytes())))
>>>> +		return -EINVAL;
>>>>
>>>> -	mem = find_memory_block(section);
>>>> -	if (mem) {
>>>> -		mem->section_count++;
>>>> -		put_device(&mem->dev);
>>>> -	} else {
>>>> +	mutex_lock(&mem_sysfs_mutex);
>>>> +	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
>>>> 		ret = init_memory_block(&mem, block_id, MEM_OFFLINE);
>>>> 		if (ret)
>>>> -			goto out;
>>>> -		mem->section_count++;
>>>> +			break;
>>>> +		mem->section_count = sections_per_block;
>>>> +	}
>>>> +	if (ret) {
>>>> +		end_block_id = block_id;
>>>> +		for (block_id = start_block_id; block_id != end_block_id;
>>>> +		     block_id++) {
>>>> +			mem = find_memory_block_by_id(block_id, NULL);
>>>> +			mem->section_count = 0;
>>>> +			unregister_memory(mem);
>>>> +		}
>>>> 	}
>>>
>>> Would it be better to do this in reverse order?
>>>
>>> And unregister_memory() would free mem, so it is still necessary to set
>>> section_count to 0?
>> 
>> 1. I kept the existing behavior (setting it to 0) for now. I am planning
>> to eventually remove the section count completely (it could be
>> beneficial to detect removing of partially populated memory blocks).
>
>Correction: We already use it to block offlining of partially populated
>memory blocks \o/

Would you mind letting me know where we leverage this?

>
>> 
>> 2. Reverse order: We would have to start with "block_id - 1", I don't
>> like that better.
>> 
>> Thanks for having a look!
>> 
>
>
>-- 
>
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
