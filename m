Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7192EC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F8321871
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfGZMxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:53:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfGZMxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:53:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE5F6300D1CA;
        Fri, 26 Jul 2019 12:53:33 +0000 (UTC)
Received: from [10.72.12.238] (ovpn-12-238.pek2.redhat.com [10.72.12.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F4645DE6F;
        Fri, 26 Jul 2019 12:53:19 +0000 (UTC)
Subject: Re: WARNING in __mmdrop
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     syzbot <syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jglisse@redhat.com,
        keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
References: <20190723051828-mutt-send-email-mst@kernel.org>
 <caff362a-e208-3468-3688-63e1d093a9d3@redhat.com>
 <20190725012149-mutt-send-email-mst@kernel.org>
 <55e8930c-2695-365f-a07b-3ad169654d28@redhat.com>
 <20190725042651-mutt-send-email-mst@kernel.org>
 <84bb2e31-0606-adff-cf2a-e1878225a847@redhat.com>
 <20190725092332-mutt-send-email-mst@kernel.org>
 <11802a8a-ce41-f427-63d5-b6a4cf96bb3f@redhat.com>
 <20190726074644-mutt-send-email-mst@kernel.org>
 <5cc94f15-b229-a290-55f3-8295266edb2b@redhat.com>
 <20190726082837-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ada10dc9-6cab-e189-5289-6f9d3ff8fed2@redhat.com>
Date:   Fri, 26 Jul 2019 20:53:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726082837-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 26 Jul 2019 12:53:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/26 下午8:38, Michael S. Tsirkin wrote:
> On Fri, Jul 26, 2019 at 08:00:58PM +0800, Jason Wang wrote:
>> On 2019/7/26 下午7:49, Michael S. Tsirkin wrote:
>>> On Thu, Jul 25, 2019 at 10:25:25PM +0800, Jason Wang wrote:
>>>> On 2019/7/25 下午9:26, Michael S. Tsirkin wrote:
>>>>>> Exactly, and that's the reason actually I use synchronize_rcu() there.
>>>>>>
>>>>>> So the concern is still the possible synchronize_expedited()?
>>>>> I think synchronize_srcu_expedited.
>>>>>
>>>>> synchronize_expedited sends lots of IPI and is bad for realtime VMs.
>>>>>
>>>>>> Can I do this
>>>>>> on through another series on top of the incoming V2?
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>> The question is this: is this still a gain if we switch to the
>>>>> more expensive srcu? If yes then we can keep the feature on,
>>>> I think we only care about the cost on srcu_read_lock() which looks pretty
>>>> tiny form my point of view. Which is basically a READ_ONCE() + WRITE_ONCE().
>>>>
>>>> Of course I can benchmark to see the difference.
>>>>
>>>>
>>>>> if not we'll put it off until next release and think
>>>>> of better solutions. rcu->srcu is just a find and replace,
>>>>> don't see why we need to defer that. can be a separate patch
>>>>> for sure, but we need to know how well it works.
>>>> I think I get here, let me try to do that in V2 and let's see the numbers.
>>>>
>>>> Thanks
>>
>> It looks to me for tree rcu, its srcu_read_lock() have a mb() which is too
>> expensive for us.
> I will try to ponder using vq lock in some way.
> Maybe with trylock somehow ...


Ok, let me retry if necessary (but I do remember I end up with deadlocks 
last try).


>
>
>> If we just worry about the IPI,
> With synchronize_rcu what I would worry about is that guest is stalled


Can this synchronize_rcu() be triggered by guest? If yes, there are 
several other MMU notifiers that can block. Is vhost something special here?


> because system is busy because of other guests.
> With expedited it's the IPIs...
>

The current synchronize_rcu()  can force a expedited grace period:

void synchronize_rcu(void)
{
         ...
         if (rcu_blocking_is_gp())
return;
         if (rcu_gp_is_expedited())
synchronize_rcu_expedited();
else
wait_rcu_gp(call_rcu);
}
EXPORT_SYMBOL_GPL(synchronize_rcu);


>> can we do something like in
>> vhost_invalidate_vq_start()?
>>
>>          if (map) {
>>                  /* In order to avoid possible IPIs with
>>                   * synchronize_rcu_expedited() we use call_rcu() +
>>                   * completion.
>> */
>> init_completion(&c.completion);
>>                  call_rcu(&c.rcu_head, vhost_finish_vq_invalidation);
>> wait_for_completion(&c.completion);
>>                  vhost_set_map_dirty(vq, map, index);
>> vhost_map_unprefetch(map);
>>          }
>>
>> ?
> Why would that be faster than synchronize_rcu?


No faster but no IPI.


>
>
>>> There's one other thing that bothers me, and that is that
>>> for large rings which are not physically contiguous
>>> we don't implement the optimization.
>>>
>>> For sure, that can wait, but I think eventually we should
>>> vmap large rings.
>>
>> Yes, worth to try. But using direct map has its own advantage: it can use
>> hugepage that vmap can't
>>
>> Thanks
> Sure, so we can do that for small rings.


Yes, that's possible but should be done on top.

Thanks

