Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895DCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668982087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfCLRkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:40:00 -0400
Received: from foss.arm.com ([217.140.101.70]:46732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbfCLRj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:39:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2EDDA78;
        Tue, 12 Mar 2019 10:39:56 -0700 (PDT)
Received: from [10.37.10.23] (unknown [10.37.10.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C7C93F59C;
        Tue, 12 Mar 2019 10:39:52 -0700 (PDT)
Subject: Re: xen: Can't insert balloon page into VM userspace (WAS Re:
 [Xen-devel] [linux-linus bisection] complete test-arm64-arm64-xl-xsm)
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     osstest service owner <osstest-admin@xenproject.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, k.khlebnikov@samsung.com,
        Julien Freche <jfreche@vmware.com>,
        Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>, linux-mm@kvack.org
References: <E1h3Uiq-0002L6-Ij@osstest.test-lab.xenproject.org>
 <80211e70-5f54-9421-8e8f-2a4fc758ce39@arm.com>
 <46118631-61d4-adb6-6ffc-4e7c62ea3da9@arm.com>
 <20190312171421.GJ19508@bombadil.infradead.org>
 <e0b64793-260d-5e70-0544-e7290509b605@redhat.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <180a9edf-855e-6a29-5724-cc0f929de71c@arm.com>
Date:   Tue, 12 Mar 2019 17:39:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <e0b64793-260d-5e70-0544-e7290509b605@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 3/12/19 5:18 PM, David Hildenbrand wrote:
> On 12.03.19 18:14, Matthew Wilcox wrote:
>> On Tue, Mar 12, 2019 at 05:05:39PM +0000, Julien Grall wrote:
>>> On 3/12/19 3:59 PM, Julien Grall wrote:
>>>> It looks like all the arm test for linus [1] and next [2] tree
>>>> are now failing. x86 seems to be mostly ok.
>>>>
>>>> The bisector fingered the following commit:
>>>>
>>>> commit 0ee930e6cafa048c1925893d0ca89918b2814f2c
>>>> Author: Matthew Wilcox <willy@infradead.org>
>>>> Date:   Tue Mar 5 15:46:06 2019 -0800
>>>>
>>>>       mm/memory.c: prevent mapping typed pages to userspace
>>>>       Pages which use page_type must never be mapped to userspace as it would
>>>>       destroy their page type.  Add an explicit check for this instead of
>>>>       assuming that kernel drivers always get this right.
>>
>> Oh good, it found a real problem.
>>
>>> It turns out the problem is because the balloon driver will call
>>> __SetPageOffline() on allocated page. Therefore the page has a type and
>>> vm_insert_pages will deny the insertion.
>>>
>>> My knowledge is quite limited in this area. So I am not sure how we can
>>> solve the problem.
>>>
>>> I would appreciate if someone could provide input of to fix the mapping.
>>
>> I don't know the balloon driver, so I don't know why it was doing this,
>> but what it was doing was Wrong and has been since 2014 with:
>>
>> commit d6d86c0a7f8ddc5b38cf089222cb1d9540762dc2
>> Author: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
>> Date:   Thu Oct 9 15:29:27 2014 -0700
>>
>>      mm/balloon_compaction: redesign ballooned pages management
>>
>> If ballooned pages are supposed to be mapped into userspace, you can't mark
>> them as ballooned pages using the mapcount field.
>>
> 
> Asking myself why anybody would want to map balloon inflated pages into
> user space (this just sounds plain wrong but my understanding to what
> XEN balloon driver does might be limited), but I assume the easy fix
> would be to revert

Balloon pages are used to map foreign guest pages. As backend PV drivers 
may live in userspace (e.g QEMU, Xenconsoled...) we need to be able to
to insert balloon pages in the VM.

> 
> 
> commit 2f085ff37d08ecbc7849d5abb9424bd7927dda1d

I guess you meant 77c4adf6a6df6f8f39807eaed48eb73d0eb4261e?

I have reverted the patch and can now access the guest console. Is there 
a way to keep this patch and at the same time mapping the page in the 
userspace?


> Author: David Hildenbrand <david@redhat.com>
> Date:   Wed Mar 6 11:42:24 2019 +1100
> 
>      xen/balloon: mark inflated pages PG_offline
> 
>      Mark inflated and never onlined pages PG_offline, to tell the world that
>      the content is stale and should not be dumped.
> 
> 

Cheers,

-- 
Julien Grall
