Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A57C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6717D214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfCLHRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:17:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbfCLHRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:17:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B71B307D84D;
        Tue, 12 Mar 2019 07:17:12 +0000 (UTC)
Received: from [10.72.12.17] (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 074E9600C5;
        Tue, 12 Mar 2019 07:17:01 +0000 (UTC)
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Miller <davem@davemloft.net>, hch@infradead.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, linux-mm@kvack.org, aarcange@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
References: <20190308141220.GA21082@infradead.org>
 <56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
 <20190311095405-mutt-send-email-mst@kernel.org>
 <20190311.111413.1140896328197448401.davem@davemloft.net>
 <6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
 <20190311235140-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
Date:   Tue, 12 Mar 2019 15:17:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311235140-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 12 Mar 2019 07:17:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/12 上午11:52, Michael S. Tsirkin wrote:
> On Tue, Mar 12, 2019 at 10:59:09AM +0800, Jason Wang wrote:
>> On 2019/3/12 上午2:14, David Miller wrote:
>>> From: "Michael S. Tsirkin" <mst@redhat.com>
>>> Date: Mon, 11 Mar 2019 09:59:28 -0400
>>>
>>>> On Mon, Mar 11, 2019 at 03:13:17PM +0800, Jason Wang wrote:
>>>>> On 2019/3/8 下午10:12, Christoph Hellwig wrote:
>>>>>> On Wed, Mar 06, 2019 at 02:18:07AM -0500, Jason Wang wrote:
>>>>>>> This series tries to access virtqueue metadata through kernel virtual
>>>>>>> address instead of copy_user() friends since they had too much
>>>>>>> overheads like checks, spec barriers or even hardware feature
>>>>>>> toggling. This is done through setup kernel address through vmap() and
>>>>>>> resigter MMU notifier for invalidation.
>>>>>>>
>>>>>>> Test shows about 24% improvement on TX PPS. TCP_STREAM doesn't see
>>>>>>> obvious improvement.
>>>>>> How is this going to work for CPUs with virtually tagged caches?
>>>>> Anything different that you worry?
>>>> If caches have virtual tags then kernel and userspace view of memory
>>>> might not be automatically in sync if they access memory
>>>> through different virtual addresses. You need to do things like
>>>> flush_cache_page, probably multiple times.
>>> "flush_dcache_page()"
>>
>> I get this. Then I think the current set_bit_to_user() is suspicious, we
>> probably miss a flush_dcache_page() there:
>>
>>
>> static int set_bit_to_user(int nr, void __user *addr)
>> {
>>          unsigned long log = (unsigned long)addr;
>>          struct page *page;
>>          void *base;
>>          int bit = nr + (log % PAGE_SIZE) * 8;
>>          int r;
>>
>>          r = get_user_pages_fast(log, 1, 1, &page);
>>          if (r < 0)
>>                  return r;
>>          BUG_ON(r != 1);
>>          base = kmap_atomic(page);
>>          set_bit(bit, base);
>>          kunmap_atomic(base);
>>          set_page_dirty_lock(page);
>>          put_page(page);
>>          return 0;
>> }
>>
>> Thanks
> I think you are right. The correct fix though is to re-implement
> it using asm and handling pagefault, not gup.


I agree but it needs to introduce new helpers in asm  for all archs 
which is not trivial. At least for -stable, we need the flush?


> Three atomic ops per bit is way to expensive.


Yes.

Thanks

