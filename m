Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4373C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFF020872
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihX0YGql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfKYSW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:22:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45478 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727269AbfKYSW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574706176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Yd5GxP+0CCVjaRgpdNisjbKFd9aciCBAsBVmKzXIqxA=;
        b=ihX0YGqlWl8pJXuHJb8IGRg0q9MAeb5x3KZ7Y4KEvVghEgdy86laF0wfCRWfTk1DdOuGOl
        YDW7bX+SBAwgqSZS/5rdolfhfGObSIAdkLTXUqukQqHcsKwaXH0jjsj8/Qi/rElCzLPQJf
        s7PfXAAy4kejoEBeySX2zTunsNL1jHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-DCO4p2IWPsuDW8zpQ67Y5g-1; Mon, 25 Nov 2019 13:22:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13B588E9360;
        Mon, 25 Nov 2019 18:22:51 +0000 (UTC)
Received: from [10.36.118.6] (unknown [10.36.118.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A8605C1D8;
        Mon, 25 Nov 2019 18:22:48 +0000 (UTC)
Subject: Re: [PATCH v2] mm/memory_hotplug: Don't allow to online/offline
 memory blocks with holes
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20191119115237.6662-1-david@redhat.com>
 <20191125174034.GA41469@freebsd.familie-tometzki.de>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <ed417e39-7d61-8b47-1ad8-ff0e279b07aa@redhat.com>
Date:   Mon, 25 Nov 2019 19:22:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191125174034.GA41469@freebsd.familie-tometzki.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: DCO4p2IWPsuDW8zpQ67Y5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.19 18:40, Damian Tometzki wrote:
> On Tue, 19. Nov 12:52, David Hildenbrand wrote:
>> Our onlining/offlining code is unnecessarily complicated. Only memory
>> blocks added during boot can have holes (a range that is not
>> IORESOURCE_SYSTEM_RAM). Hotplugged memory never has holes (e.g., see
>> add_memory_resource()). All memory blocks that belong to boot memory are
>> already online.
>>
>> Note that boot memory can have holes and the memmap of the holes is marked
>> PG_reserved. However, also memory allocated early during boot is
>> PG_reserved - basically every page of boot memory that is not given to the
>> buddy is PG_reserved.
>>
>> Therefore, when we stop allowing to offline memory blocks with holes, we
>> implicitly no longer have to deal with onlining memory blocks with holes.
>> E.g., online_pages() will do a
>> walk_system_ram_range(..., online_pages_range), whereby
>> online_pages_range() will effectively only free the memory holes not
>> falling into a hole to the buddy. The other pages (holes) are kept
>> PG_reserved (via move_pfn_range_to_zone()->memmap_init_zone()).
>>
>> This allows to simplify the code. For example, we no longer have to
>> worry about marking pages that fall into memory holes PG_reserved when
>> onlining memory. We can stop setting pages PG_reserved completely in
>> memmap_init_zone().
>>
>> Offlining memory blocks added during boot is usually not guaranteed to work
>> either way (unmovable data might have easily ended up on that memory during
>> boot). So stopping to do that should not really hurt. Also, people are not
>> even aware of a setup where onlining/offlining of memory blocks with
>> holes used to work reliably (see [1] and [2] especially regarding the
>> hotplug path) - I doubt it worked reliably.
>>
>> For the use case of offlining memory to unplug DIMMs, we should see no
>> change. (holes on DIMMs would be weird).
>>
>> Please note that hardware errors (PG_hwpoison) are not memory holes and
>> are not affected by this change when offlining.
>>
>> [1] https://lkml.org/lkml/2019/10/22/135
>> [2] https://lkml.org/lkml/2019/8/14/1365
>>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> This patch was part of:
>> 	[PATCH v1 00/10] mm: Don't mark hotplugged pages PG_reserved
>> 	(including ZONE_DEVICE)
>> 	-> https://www.spinics.net/lists/linux-driver-devel/msg130042.html
>>
>> However, before we can perform the PG_reserved changes, we have to fix
>> pfn_to_online_page() in special scenarios first (bootmem and devmem falling
>> into a single section). Dan is working on that.
>>
>> I propose to give this patch a churn in -next so we can identify if this
>> change would break any existing setup. I will then follow up with cleanups
>> and the PG_reserved changes later.
>>
>> ---
>>  mm/memory_hotplug.c | 28 ++++++++++++++++++++++++++--
>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 46b2e056a43f..fc617ad6f035 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1455,10 +1455,19 @@ static void node_states_clear_node(int node, struct memory_notify *arg)
>>  		node_clear_state(node, N_MEMORY);
>>  }
>>  
>> +static int count_system_ram_pages_cb(unsigned long start_pfn,
>> +				     unsigned long nr_pages, void *data)
>> +{
>> +	unsigned long *nr_system_ram_pages = data;
>> +
>> +	*nr_system_ram_pages += nr_pages;
>> +	return 0;
>> +}
>> +
> Hello David,
> 
> what is the meaning of the function ? The return is every time 0. 
> 
> I dont understand it ?
> 

Hi Damian,

please see how these callbacks are used within walk_system_ram_range().
A return value of 0 only means "don't stop iterating", the actual values
are returned via the "void *data" parameter in this instance.

Cheers!

-- 

Thanks,

David / dhildenb

