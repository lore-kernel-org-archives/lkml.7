Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A33C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3FF206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLIV12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:27:28 -0500
Received: from ale.deltatee.com ([207.54.116.67]:60534 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfLIV11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:27:27 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ieQYj-0005SY-26; Mon, 09 Dec 2019 14:27:14 -0700
To:     Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20191209191346.5197-1-logang@deltatee.com>
 <20191209191346.5197-6-logang@deltatee.com>
 <ce50d9da-c60e-05a1-a86b-3bb3629de502@redhat.com>
 <f34a4c52-cc95-15ed-8a72-c05ab4fd6d33@deltatee.com>
 <20191209204128.GC7658@dhcp22.suse.cz>
 <CAPcyv4iKKw8cuFyDrY2VLN2ecd-qAbDCfYa7SufuhUb59e89Rw@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <05e82397-4d89-a54d-5334-2ddca6c94f19@deltatee.com>
Date:   Mon, 9 Dec 2019 14:27:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iKKw8cuFyDrY2VLN2ecd-qAbDCfYa7SufuhUb59e89Rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: peterz@infradead.org, luto@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, benh@kernel.crashing.org, will@kernel.org, catalin.marinas@arm.com, akpm@linux-foundation.org, hch@lst.de, linux-mm@kvack.org, platform-driver-x86@vger.kernel.org, linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, david@redhat.com, mhocko@kernel.org, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 5/6] mm, memory_hotplug: Provide argument for the pgprot_t
 in arch_add_memory()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-12-09 2:00 p.m., Dan Williams wrote:
>>>> Can we fiddle that into "struct mhp_restrictions" instead?
>>>
>>> Yes, if that's what people want, it's pretty trivial to do. I chose not
>>> to do it that way because it doesn't get passed down to add_pages() and
>>> it's not really a "restriction". If I don't hear any objections, I will
>>> do that for v2.
>>
>> I do agree that restriction is not the best fit. But I consider prot
>> argument to complicate the API to all users even though it is not really
>> clear whether we are going to have many users really benefiting from it.
>> Look at the vmalloc API and try to find how many users of __vmalloc do
>> not use PAGE_KERNEL.
> 
> At least for this I can foresee at least one more user in the
> pipeline, encrypted memory support for persistent memory mappings that
> will store the key-id in the ptes.
> 
>>
>> So I can see two options. One of them is to add arch_add_memory_prot
>> that would allow to have give and extra prot argument or simply call
>> an arch independent API to change the protection after arch_add_memory.
>> The later sounds like much less code. The memory shouldn't be in use by
>> anybody at that stage yet AFAIU. Maybe there even is an API like that.
> 
> I'm ok with passing it the same way as altmap or a new
> arch_add_memory_prot() my only hangup with after the fact changes is
> the wasted effort it inflicts in the init path for potentially large
> address ranges.

Yes, I'll change the way it's passed in for v2 as that seems to be
generally agreed upon. I can also add a patch to make the name change.

And, yes, given our testing, the wasted effort is quite significant so
I'm against changing the prots after the fact.

Logan

