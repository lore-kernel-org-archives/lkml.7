Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7E7C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A352067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dw+SeYbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfGaRpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:45:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44310 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfGaRpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pEAfotcFLsFotBYT9u4zeRqv3NeeQAlDety7JPTf8Pk=; b=dw+SeYbkgl15ByYdw4RBRwGpI5
        OQRbhMYNZQy3bzAx5TIQcL6nZ4sauiIJzRse8yongu5JqPY6aoJalrxRvlk01U/pCwDOw/2pmFJaD
        P1gRHYsrEp+s+iq8YUjI4MGLu//erIQdXrho9cOTBXZKeLz8JFQpS+d+T6SVCRqsaBTceMtiBPAL9
        K6qZqrz0yuqnuZ3oMdNwOb05wHSS4MloOj9+DKViGd5eR1DPhulBDXdM72Qf3YxGHWdhjFCH5PT3m
        ioWvgp3GDSoi8julWf1KoQx7EnwTzV5jyNDyqyWBQzDDbz0lPbNq/vbmvDf5oWMOc7VHyKca5WKls
        QitLDIVA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hssfH-000639-C3; Wed, 31 Jul 2019 17:45:28 +0000
Subject: Re: microblaze HAVE_MEMBLOCK_NODE_MAP dependency (was Re: [PATCH v2
 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA)
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Hoan Tran OS <hoan@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Paul Mackerras <paulus@samba.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "x86@kernel.org" <x86@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "David S . Miller" <davem@davemloft.net>,
        "willy@infradead.org" <willy@infradead.org>,
        Michal Simek <monstr@monstr.eu>
References: <730368c5-1711-89ae-e3ef-65418b17ddc9@os.amperecomputing.com>
 <20190730081415.GN9330@dhcp22.suse.cz> <20190731062420.GC21422@rapoport-lnx>
 <20190731080309.GZ9330@dhcp22.suse.cz> <20190731111422.GA14538@rapoport-lnx>
 <20190731114016.GI9330@dhcp22.suse.cz> <20190731122631.GB14538@rapoport-lnx>
 <20190731130037.GN9330@dhcp22.suse.cz> <20190731142129.GA24998@rapoport-lnx>
 <20190731144114.GY9330@dhcp22.suse.cz> <20190731171510.GB24998@rapoport-lnx>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <57b08afb-d07e-a24f-4cfe-5a633227ed6b@infradead.org>
Date:   Wed, 31 Jul 2019 10:45:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190731171510.GB24998@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 10:15 AM, Mike Rapoport wrote:
> On Wed, Jul 31, 2019 at 04:41:14PM +0200, Michal Hocko wrote:
>> On Wed 31-07-19 17:21:29, Mike Rapoport wrote:
>>> On Wed, Jul 31, 2019 at 03:00:37PM +0200, Michal Hocko wrote:
>>>>
>>>> I am sorry, but I still do not follow. Who is consuming that node id
>>>> information when NUMA=n. In other words why cannot we simply do
>>>  
>>> We can, I think nobody cared to change it.
>>
>> It would be great if somebody with the actual HW could try it out.
>> I can throw a patch but I do not even have a cross compiler in my
>> toolbox.
> 
> Well, it compiles :)

Adding Michal Simek <monstr@monstr.eu>.

It's not clear that the MICROBLAZE maintainer is still supporting MICROBLAZE.

>>>> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
>>>> index a015a951c8b7..3a47e8db8d1c 100644
>>>> --- a/arch/microblaze/mm/init.c
>>>> +++ b/arch/microblaze/mm/init.c
>>>> @@ -175,14 +175,9 @@ void __init setup_memory(void)
>>>>  
>>>>  		start_pfn = memblock_region_memory_base_pfn(reg);
>>>>  		end_pfn = memblock_region_memory_end_pfn(reg);
>>>> -		memblock_set_node(start_pfn << PAGE_SHIFT,
>>>> -				  (end_pfn - start_pfn) << PAGE_SHIFT,
>>>> -				  &memblock.memory, 0);
>>>> +		memory_present(0, start_pfn << PAGE_SHIFT, end_pfn << PAGE_SHIFT);
>>>
>>> memory_present() expects pfns, the shift is not needed.
>>
>> Right.
>>
>> -- 
>> Michal Hocko
>> SUSE Labs


-- 
~Randy
