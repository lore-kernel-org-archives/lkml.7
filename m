Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC00C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E8E214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfCLCw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:52:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfCLCw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:52:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6559C049E23;
        Tue, 12 Mar 2019 02:52:26 +0000 (UTC)
Received: from [10.72.12.17] (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C3EB5DA27;
        Tue, 12 Mar 2019 02:52:16 +0000 (UTC)
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190307103503-mutt-send-email-mst@kernel.org>
 <20190307124700-mutt-send-email-mst@kernel.org>
 <20190307191622.GP23850@redhat.com>
 <e2fad6ed-9257-b53c-394b-bc913fc444c0@redhat.com>
 <20190308194845.GC26923@redhat.com>
 <8b68a2a0-907a-15f5-a07f-fc5b53d7ea19@redhat.com>
 <20190311084525-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ff45ea43-1145-5ea6-767c-1a99d55a9c61@redhat.com>
Date:   Tue, 12 Mar 2019 10:52:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311084525-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 12 Mar 2019 02:52:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/11 下午8:48, Michael S. Tsirkin wrote:
> On Mon, Mar 11, 2019 at 03:40:31PM +0800, Jason Wang wrote:
>> On 2019/3/9 上午3:48, Andrea Arcangeli wrote:
>>> Hello Jeson,
>>>
>>> On Fri, Mar 08, 2019 at 04:50:36PM +0800, Jason Wang wrote:
>>>> Just to make sure I understand here. For boosting through huge TLB, do
>>>> you mean we can do that in the future (e.g by mapping more userspace
>>>> pages to kenrel) or it can be done by this series (only about three 4K
>>>> pages were vmapped per virtqueue)?
>>> When I answered about the advantages of mmu notifier and I mentioned
>>> guaranteed 2m/gigapages where available, I overlooked the detail you
>>> were using vmap instead of kmap. So with vmap you're actually doing
>>> the opposite, it slows down the access because it will always use a 4k
>>> TLB even if QEMU runs on THP or gigapages hugetlbfs.
>>>
>>> If there's just one page (or a few pages) in each vmap there's no need
>>> of vmap, the linearity vmap provides doesn't pay off in such
>>> case.
>>>
>>> So likely there's further room for improvement here that you can
>>> achieve in the current series by just dropping vmap/vunmap.
>>>
>>> You can just use kmap (or kmap_atomic if you're in preemptible
>>> section, should work from bh/irq).
>>>
>>> In short the mmu notifier to invalidate only sets a "struct page *
>>> userringpage" pointer to NULL without calls to vunmap.
>>>
>>> In all cases immediately after gup_fast returns you can always call
>>> put_page immediately (which explains why I'd like an option to drop
>>> FOLL_GET from gup_fast to speed it up).
>>>
>>> Then you can check the sequence_counter and inc/dec counter increased
>>> by _start/_end. That will tell you if the page you got and you called
>>> put_page to immediately unpin it or even to free it, cannot go away
>>> under you until the invalidate is called.
>>>
>>> If sequence counters and counter tells that gup_fast raced with anyt
>>> mmu notifier invalidate you can just repeat gup_fast. Otherwise you're
>>> done, the page cannot go away under you, the host virtual to host
>>> physical mapping cannot change either. And the page is not pinned
>>> either. So you can just set the "struct page * userringpage = page"
>>> where "page" was the one setup by gup_fast.
>>>
>>> When later the invalidate runs, you can just call set_page_dirty if
>>> gup_fast was called with "write = 1" and then you clear the pointer
>>> "userringpage = NULL".
>>>
>>> When you need to read/write to the memory
>>> kmap/kmap_atomic(userringpage) should work.
>> Yes, I've considered kmap() from the start. The reason I don't do that is
>> large virtqueue may need more than one page so VA might not be contiguous.
>> But this is probably not a big issue which just need more tricks in the
>> vhost memory accessors.
>>
>>
>>> In short because there's no hardware involvement here, the established
>>> mapping is just the pointer to the page, there is no need of setting
>>> up any pagetables or to do any TLB flushes (except on 32bit archs if
>>> the page is above the direct mapping but it never happens on 64bit
>>> archs).
>> I see, I believe we don't care much about the performance of 32bit archs (or
>> we can just fallback to copy_to_user() friends).
> Using copyXuser is better I guess.


Ok.


>
>> Using direct mapping (I
>> guess kernel will always try hugepage for that?) should be better and we can
>> even use it for the data transfer not only for the metadata.
>>
>> Thanks
> We can't really. The big issue is get user pages. Doing that on data
> path will be slower than copyXuser.


I meant if we can find a way to avoid doing gup in datapath. E.g vhost 
maintain a range tree and add or remove ranges through MMU notifier. 
Then in datapath, if we find the range, then use direct mapping 
otherwise copy_to_user().

Thanks


>   Or maybe it won't with the
> amount of mitigations spread around. Go ahead and try.
>
>
