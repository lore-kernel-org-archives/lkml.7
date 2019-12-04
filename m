Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2DAC2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FE92084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="a3Sxiu0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfLDPgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:36:46 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:45634 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbfLDPgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:36:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 31F713F390;
        Wed,  4 Dec 2019 16:36:43 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=a3Sxiu0a;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JTceQxKzietN; Wed,  4 Dec 2019 16:36:42 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 0740A3F413;
        Wed,  4 Dec 2019 16:36:36 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 11D4D360608;
        Wed,  4 Dec 2019 16:36:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1575473796; bh=+P2lL4Bk8IOmIyYiEAJEi2EHSZtLBY0TVxFIVaQgcJw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a3Sxiu0aBnFV7FZPZMCsRIPHG0lgkyWS4ulmn+2AkMNL2HcwAlL+eOHXKZKWy4AYc
         sHYuIN8rny3O1VEDgLtSXHJBMKEBr+DeLhRYl6yjuij2krolQhyGaEn4QJbQK1P56/
         7blMjZ0b3gt5051zqvAUhaJajkzQP/WLvvJ0XMbc=
Subject: Re: [PATCH 6/8] drm: Add a drm_get_unmapped_area() helper
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191203132239.5910-1-thomas_os@shipmail.org>
 <20191203132239.5910-7-thomas_os@shipmail.org>
 <e091063c-2c4a-866e-acdb-9efb1e20d737@amd.com>
 <98af5b11-1034-91fa-aa38-5730f116d1cd@shipmail.org>
 <3cc5b796-20c6-9f4c-3f62-d844f34d81b7@amd.com>
 <90a8d09a-b3ab-cd00-0cfb-1a4c72e91836@shipmail.org>
 <016a9187-1703-2d7d-0114-7fc0cbf1d121@amd.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <14f319fd-e2ca-8f13-7bb8-4452f58c6c7e@shipmail.org>
Date:   Wed, 4 Dec 2019 16:36:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <016a9187-1703-2d7d-0114-7fc0cbf1d121@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/19 3:40 PM, Christian König wrote:
> Am 04.12.19 um 13:32 schrieb Thomas Hellström (VMware):
>> On 12/4/19 1:08 PM, Christian König wrote:
>>> Am 04.12.19 um 12:36 schrieb Thomas Hellström (VMware):
>>>> On 12/4/19 12:11 PM, Christian König wrote:
>>>>> Am 03.12.19 um 14:22 schrieb Thomas Hellström (VMware):
>>>>>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>>>>>
>>>>>> This helper is used to align user-space buffer object addresses to
>>>>>> huge page boundaries, minimizing the chance of alignment mismatch
>>>>>> between user-space addresses and physical addresses.
>>>>>
>>>>> Mhm, I'm wondering if that is really such a good idea.
>>>>
>>>> Could you elaborate? What drawbacks do you see?
>>>
>>> Main problem for me seems to be that I don't fully understand what 
>>> the get_unmapped_area callback is doing.
>>
>> It makes sure that, if there is a chance that we could use huge 
>> page-table entries, virtual address huge page boundaries are 
>> perfectly aligned to physical address huge page boundaries, which is 
>> if not a CPU hardware requirement, at least a kernel requirement 
>> currently.
>>
>>
>>>
>>> For example why do we need to use drm_vma_offset_lookup_locked() to 
>>> adjust the pgoff?
>>>
>>> The mapped offset should be completely irrelevant for finding some 
>>> piece of userspace address space or am I totally off here?
>>
>>
>> Because the unmodified pgoff assumes that physical address boundaries 
>> are perfectly aligned with file offset boundaries, which is typical 
>> for all other subsystems.
>>
>> That's not true for TTM, however, where a buffer object start 
>> physical address may be huge page aligned, but the file offset is 
>> always page aligned. We could of course change that to align also 
>> file offsets to huge page size boundaries, but with the above 
>> adjustment, that's not needed. I opted for the adjustment.
>
> I would opt for aligning the file offsets instead.

Yes but that adds additional complexity and considerations which made me 
think that lookup was the by far simplest choice:

- We need to modify the vma manager to care about alignments.
- Fragmentation issues. Do we want to align > 1G BOs
- For which drivers do we want to do this, how do we handle drivers that 
want to opt out in TTM mmap()?
- Non TTM drivers. Could they still reuse the same get_unmapped_area.

>
> Now that you explained it that the rest of the kernel enforces this 
> actually makes sense.

So is that an ack?


Thanks,

Thomas



>
> Regards,
> Christian.
>
>>
>> Thanks,
>>
>> Thomas
>>
>>

