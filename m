Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790A1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461D92184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfCNNtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:49:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfCNNtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:49:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E057307B494;
        Thu, 14 Mar 2019 13:49:15 +0000 (UTC)
Received: from [10.72.12.71] (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABC525D73D;
        Thu, 14 Mar 2019 13:49:05 +0000 (UTC)
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Miller <davem@davemloft.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
References: <20190311.111413.1140896328197448401.davem@davemloft.net>
 <6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
 <20190311235140-mutt-send-email-mst@kernel.org>
 <76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
 <20190312075033-mutt-send-email-mst@kernel.org>
 <1552405610.3083.17.camel@HansenPartnership.com>
 <20190312200450.GA25147@redhat.com>
 <1552424017.14432.11.camel@HansenPartnership.com>
 <20190313160529.GB15134@infradead.org>
 <1552495028.3022.37.camel@HansenPartnership.com>
 <20190314064004-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <74015196-2e18-4fe0-50ac-0c9d497315c7@redhat.com>
Date:   Thu, 14 Mar 2019 21:49:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190314064004-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 14 Mar 2019 13:49:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/14 下午6:42, Michael S. Tsirkin wrote:
>>>>> Which means after we fix vhost to add the flush_dcache_page after
>>>>> kunmap, Parisc will get a double hit (but it also means Parisc
>>>>> was the only one of those archs needed explicit cache flushes,
>>>>> where vhost worked correctly so far.. so it kinds of proofs your
>>>>> point of giving up being the safe choice).
>>>> What double hit?  If there's no cache to flush then cache flush is
>>>> a no-op.  It's also a highly piplineable no-op because the CPU has
>>>> the L1 cache within easy reach.  The only event when flush takes a
>>>> large amount time is if we actually have dirty data to write back
>>>> to main memory.
>>> I've heard people complaining that on some microarchitectures even
>>> no-op cache flushes are relatively expensive.  Don't ask me why,
>>> but if we can easily avoid double flushes we should do that.
>> It's still not entirely free for us.  Our internal cache line is around
>> 32 bytes (some have 16 and some have 64) but that means we need 128
>> flushes for a page ... we definitely can't pipeline them all.  So I
>> agree duplicate flush elimination would be a small improvement.
>>
>> James
> I suspect we'll keep the copyXuser path around for 32 bit anyway -
> right Jason?


Yes since we don't want to slow down 32bit.

Thanks


> So we can also keep using that on parisc...
>
> -- 
