Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D256C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470C1214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfCLHwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:52:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfCLHwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:52:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FA493082200;
        Tue, 12 Mar 2019 07:52:07 +0000 (UTC)
Received: from [10.72.12.17] (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07EDA5DD74;
        Tue, 12 Mar 2019 07:51:55 +0000 (UTC)
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        David Miller <davem@davemloft.net>, mst@redhat.com
Cc:     hch@infradead.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, aarcange@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
References: <20190308141220.GA21082@infradead.org>
 <56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
 <20190311095405-mutt-send-email-mst@kernel.org>
 <20190311.111413.1140896328197448401.davem@davemloft.net>
 <6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
 <1552367685.23859.22.camel@HansenPartnership.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f9e52313-0a06-22b6-140c-ded75eecde20@redhat.com>
Date:   Tue, 12 Mar 2019 15:51:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552367685.23859.22.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 12 Mar 2019 07:52:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/12 下午1:14, James Bottomley wrote:
> On Tue, 2019-03-12 at 10:59 +0800, Jason Wang wrote:
>> On 2019/3/12 上午2:14, David Miller wrote:
>>> From: "Michael S. Tsirkin" <mst@redhat.com>
>>> Date: Mon, 11 Mar 2019 09:59:28 -0400
>>>
>>>> On Mon, Mar 11, 2019 at 03:13:17PM +0800, Jason Wang wrote:
>>>>> On 2019/3/8 下午10:12, Christoph Hellwig wrote:
>>>>>> On Wed, Mar 06, 2019 at 02:18:07AM -0500, Jason Wang wrote:
>>>>>>> This series tries to access virtqueue metadata through
>>>>>>> kernel virtual
>>>>>>> address instead of copy_user() friends since they had too
>>>>>>> much
>>>>>>> overheads like checks, spec barriers or even hardware
>>>>>>> feature
>>>>>>> toggling. This is done through setup kernel address through
>>>>>>> vmap() and
>>>>>>> resigter MMU notifier for invalidation.
>>>>>>>
>>>>>>> Test shows about 24% improvement on TX PPS. TCP_STREAM
>>>>>>> doesn't see
>>>>>>> obvious improvement.
>>>>>> How is this going to work for CPUs with virtually tagged
>>>>>> caches?
>>>>> Anything different that you worry?
>>>> If caches have virtual tags then kernel and userspace view of
>>>> memory
>>>> might not be automatically in sync if they access memory
>>>> through different virtual addresses. You need to do things like
>>>> flush_cache_page, probably multiple times.
>>> "flush_dcache_page()"
>>
>> I get this. Then I think the current set_bit_to_user() is suspicious,
>> we
>> probably miss a flush_dcache_page() there:
>>
>>
>> static int set_bit_to_user(int nr, void __user *addr)
>> {
>>           unsigned long log = (unsigned long)addr;
>>           struct page *page;
>>           void *base;
>>           int bit = nr + (log % PAGE_SIZE) * 8;
>>           int r;
>>
>>           r = get_user_pages_fast(log, 1, 1, &page);
>>           if (r < 0)
>>                   return r;
>>           BUG_ON(r != 1);
>>           base = kmap_atomic(page);
>>           set_bit(bit, base);
>>           kunmap_atomic(base);
> This sequence should be OK.  get_user_pages() contains a flush which
> clears the cache above the user virtual address, so on kmap, the page
> is coherent at the new alias.  On parisc at least, kunmap embodies a
> flush_dcache_page() which pushes any changes in the cache above the
> kernel virtual address back to main memory and makes it coherent again
> for the user alias to pick it up.


It would be good if kmap()/kunmap() can do this but looks like we can 
not assume this? For example, sparc's flush_dcache_page() doesn't do 
flush_dcache_page(). And bio_copy_data_iter() do flush_dcache_page() 
after kunmap_atomic().

Thanks


>
> James
>
