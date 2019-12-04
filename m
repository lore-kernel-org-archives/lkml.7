Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D907C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700E32081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="BIzth5pm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfLDPTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:19:34 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:44264 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfLDPTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:19:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 77FAC3F418;
        Wed,  4 Dec 2019 16:19:32 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=BIzth5pm;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GMt9AI3aLq8w; Wed,  4 Dec 2019 16:19:31 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 58EA03F413;
        Wed,  4 Dec 2019 16:19:27 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 8C0DC360608;
        Wed,  4 Dec 2019 16:19:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1575472767; bh=YgSZucqCNwJPIVx9FkQL9howdBrm5GEYzP1TK7lj8f4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BIzth5pmvF4LmI9Ct05xwXwGYvq1ClqzfKX6OlROHfo+dfi3odLmEnYt7wOSE4MBk
         rzIsPiJ9OxjHKRqUaQbG/9n9uqAIq5sBub4hHmylLYR/UmHlWjKXc7ld9jzNkIqwC7
         RhQQzxPlcJxlNKlI4pKtwb3bHoRKJN+FyWGmQBFg=
Subject: Re: [PATCH v2 2/2] drm/ttm: Fix vm page protection handling
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20191203104853.4378-1-thomas_os@shipmail.org>
 <20191203104853.4378-3-thomas_os@shipmail.org>
 <20191204135219.GH25242@dhcp22.suse.cz>
 <b29b166c-e9fe-f829-f533-b39f98b334a9@shipmail.org>
 <20191204143521.GJ25242@dhcp22.suse.cz>
 <5c2658b6-b5ec-5747-c360-fada54d759ed@shipmail.org>
 <20191204144248.GK25242@dhcp22.suse.cz>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <b7b3ba5a-f625-36bc-d9cf-d537ec60e592@shipmail.org>
Date:   Wed, 4 Dec 2019 16:19:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191204144248.GK25242@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/19 3:42 PM, Michal Hocko wrote:
> On Wed 04-12-19 15:36:58, Thomas Hellström (VMware) wrote:
>> On 12/4/19 3:35 PM, Michal Hocko wrote:
>>> On Wed 04-12-19 15:16:09, Thomas Hellström (VMware) wrote:
>>>> On 12/4/19 2:52 PM, Michal Hocko wrote:
>>>>> On Tue 03-12-19 11:48:53, Thomas Hellström (VMware) wrote:
>>>>>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>>>>>
>>>>>> TTM graphics buffer objects may, transparently to user-space,  move
>>>>>> between IO and system memory. When that happens, all PTEs pointing to the
>>>>>> old location are zapped before the move and then faulted in again if
>>>>>> needed. When that happens, the page protection caching mode- and
>>>>>> encryption bits may change and be different from those of
>>>>>> struct vm_area_struct::vm_page_prot.
>>>>>>
>>>>>> We were using an ugly hack to set the page protection correctly.
>>>>>> Fix that and instead use vmf_insert_mixed_prot() and / or
>>>>>> vmf_insert_pfn_prot().
>>>>>> Also get the default page protection from
>>>>>> struct vm_area_struct::vm_page_prot rather than using vm_get_page_prot().
>>>>>> This way we catch modifications done by the vm system for drivers that
>>>>>> want write-notification.
>>>>> So essentially this should have any new side effect on functionality it
>>>>> is just making a hacky/ugly code less so?
>>>> Functionality is unchanged. The use of a on-stack vma copy was severely
>>>> frowned upon in an earlier thread, which also points to another similar
>>>> example using vmf_insert_pfn_prot().
>>>>
>>>> https://lore.kernel.org/lkml/20190905103541.4161-2-thomas_os@shipmail.org/
>>>>
>>>>> In other words what are the
>>>>> consequences of having page protection inconsistent from vma's?
>>>> During the years, it looks like the caching- and encryption flags of
>>>> vma::vm_page_prot have been largely removed from usage. From what I can
>>>> tell, there are no more places left that can affect TTM. We discussed
>>>> __split_huge_pmd_locked() towards the end of that thread, but that doesn't
>>>> affect TTM even with huge page-table entries.
>>> Please state all those details/assumptions you are operating on in the
>>> changelog.
>> Thanks. I'll update the patchset and add that.
> And thinking about that this also begs for a comment in the code to
> explain that some (which?) mappings might have a mismatch and the
> generic code have to be careful. Because as things stand now this seems
> to be really subtle and happen to work _now_ and might break in the future.
> Or what does prevent a generic code to stumble over this discrepancy?

Yes we had that discussion in the thread I pointed to. I initially 
suggested and argued for updating the vma::vm_page_prot using a 
WRITE_ONCE() (we only have the mmap_sem in read mode), there seems to be 
other places in generic code that does the same.

But I was convinced by Andy that this was the right way and also was 
used elsewhere.

(See also 
https://elixir.bootlin.com/linux/latest/source/arch/x86/entry/vdso/vma.c#L116)

I guess to have this properly formulated, what's required is that 
generic code doesn't build page-table entries using vma::vm_page_prot 
for VM_PFNMAP and VM_MIXEDMAP outside of driver control.

/Thomas



