Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D916C04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB9921479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfEUCIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 22:08:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55934 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfEUCIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 22:08:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC1BB341;
        Mon, 20 May 2019 19:08:43 -0700 (PDT)
Received: from [10.162.42.136] (p8cg001049571a15.blr.arm.com [10.162.42.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B102A3F718;
        Mon, 20 May 2019 19:08:41 -0700 (PDT)
Subject: Re: [PATCH] mm/dev_pfn: Exclude MEMORY_DEVICE_PRIVATE while computing
 virtual address
To:     Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
References: <1558089514-25067-1-git-send-email-anshuman.khandual@arm.com>
 <20190517145050.2b6b0afdaab5c3c69a4b153e@linux-foundation.org>
 <cb8cbd57-9220-aba9-7579-dbcf35f02672@arm.com>
 <20190520192721.GA4049@redhat.com>
 <CAPcyv4gN0Pz66a_dEMxkS5xvCyPoboGEkyxZFHQU3L2DDj8fAg@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <502ec91a-4019-39c7-537d-f86a7348ca40@arm.com>
Date:   Tue, 21 May 2019 07:38:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gN0Pz66a_dEMxkS5xvCyPoboGEkyxZFHQU3L2DDj8fAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/21/2019 01:03 AM, Dan Williams wrote:
> On Mon, May 20, 2019 at 12:27 PM Jerome Glisse <jglisse@redhat.com> wrote:
>>
>> On Mon, May 20, 2019 at 11:07:38AM +0530, Anshuman Khandual wrote:
>>> On 05/18/2019 03:20 AM, Andrew Morton wrote:
>>>> On Fri, 17 May 2019 16:08:34 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>>>
>>>>> The presence of struct page does not guarantee linear mapping for the pfn
>>>>> physical range. Device private memory which is non-coherent is excluded
>>>>> from linear mapping during devm_memremap_pages() though they will still
>>>>> have struct page coverage. Just check for device private memory before
>>>>> giving out virtual address for a given pfn.
>>>>
>>>> I was going to give my standard "what are the user-visible runtime
>>>> effects of this change?", but...
>>>>
>>>>> All these helper functions are all pfn_t related but could not figure out
>>>>> another way of determining a private pfn without looking into it's struct
>>>>> page. pfn_t_to_virt() is not getting used any where in mainline kernel.Is
>>>>> it used by out of tree drivers ? Should we then drop it completely ?
>>>>
>>>> Yeah, let's kill it.
>>>>
>>>> But first, let's fix it so that if someone brings it back, they bring
>>>> back a non-buggy version.
>>>
>>> Makes sense.
>>>
>>>>
>>>> So...  what (would be) the user-visible runtime effects of this change?
>>>
>>> I am not very well aware about the user interaction with the drivers which
>>> hotplug and manage ZONE_DEVICE memory in general. Hence will not be able to
>>> comment on it's user visible runtime impact. I just figured this out from
>>> code audit while testing ZONE_DEVICE on arm64 platform. But the fix makes
>>> the function bit more expensive as it now involve some additional memory
>>> references.
>>
>> A device private pfn can never leak outside code that does not understand it
>> So this change is useless for any existing users and i would like to keep the
>> existing behavior ie never leak device private pfn.
> 
> The issue is that only an HMM expert might know that such a pfn can
> never leak, in other words the pfn concept from a code perspective is
> already leaked / widespread. Ideally any developer familiar with a pfn
> and the core-mm pfn helpers need only worry about pfn semantics
> without being required to go audit HMM users.

Agreed.
