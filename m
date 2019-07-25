Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2E4C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65B822BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfGYNV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:21:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfGYNV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:21:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3513730860BE;
        Thu, 25 Jul 2019 13:21:57 +0000 (UTC)
Received: from [10.72.12.18] (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A59BD19723;
        Thu, 25 Jul 2019 13:21:44 +0000 (UTC)
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
References: <20190723010019-mutt-send-email-mst@kernel.org>
 <b4696f2e-678a-bdb2-4b7c-fb4ce040ec2a@redhat.com>
 <20190723032024-mutt-send-email-mst@kernel.org>
 <1d14de4d-0133-1614-9f64-3ded381de04e@redhat.com>
 <20190723035725-mutt-send-email-mst@kernel.org>
 <3f4178f1-0d71-e032-0f1f-802428ceca59@redhat.com>
 <20190723051828-mutt-send-email-mst@kernel.org>
 <caff362a-e208-3468-3688-63e1d093a9d3@redhat.com>
 <20190725012149-mutt-send-email-mst@kernel.org>
 <55e8930c-2695-365f-a07b-3ad169654d28@redhat.com>
 <20190725042651-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <84bb2e31-0606-adff-cf2a-e1878225a847@redhat.com>
Date:   Thu, 25 Jul 2019 21:21:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725042651-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 25 Jul 2019 13:21:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/25 下午4:28, Michael S. Tsirkin wrote:
> On Thu, Jul 25, 2019 at 03:43:41PM +0800, Jason Wang wrote:
>> On 2019/7/25 下午1:52, Michael S. Tsirkin wrote:
>>> On Tue, Jul 23, 2019 at 09:31:35PM +0800, Jason Wang wrote:
>>>> On 2019/7/23 下午5:26, Michael S. Tsirkin wrote:
>>>>> On Tue, Jul 23, 2019 at 04:49:01PM +0800, Jason Wang wrote:
>>>>>> On 2019/7/23 下午4:10, Michael S. Tsirkin wrote:
>>>>>>> On Tue, Jul 23, 2019 at 03:53:06PM +0800, Jason Wang wrote:
>>>>>>>> On 2019/7/23 下午3:23, Michael S. Tsirkin wrote:
>>>>>>>>>>> Really let's just use kfree_rcu. It's way cleaner: fire and forget.
>>>>>>>>>> Looks not, you need rate limit the fire as you've figured out?
>>>>>>>>> See the discussion that followed. Basically no, it's good enough
>>>>>>>>> already and is only going to be better.
>>>>>>>>>
>>>>>>>>>> And in fact,
>>>>>>>>>> the synchronization is not even needed, does it help if I leave a comment to
>>>>>>>>>> explain?
>>>>>>>>> Let's try to figure it out in the mail first. I'm pretty sure the
>>>>>>>>> current logic is wrong.
>>>>>>>> Here is what the code what to achieve:
>>>>>>>>
>>>>>>>> - The map was protected by RCU
>>>>>>>>
>>>>>>>> - Writers are: MMU notifier invalidation callbacks, file operations (ioctls
>>>>>>>> etc), meta_prefetch (datapath)
>>>>>>>>
>>>>>>>> - Readers are: memory accessor
>>>>>>>>
>>>>>>>> Writer are synchronized through mmu_lock. RCU is used to synchronized
>>>>>>>> between writers and readers.
>>>>>>>>
>>>>>>>> The synchronize_rcu() in vhost_reset_vq_maps() was used to synchronized it
>>>>>>>> with readers (memory accessors) in the path of file operations. But in this
>>>>>>>> case, vq->mutex was already held, this means it has been serialized with
>>>>>>>> memory accessor. That's why I think it could be removed safely.
>>>>>>>>
>>>>>>>> Anything I miss here?
>>>>>>>>
>>>>>>> So invalidate callbacks need to reset the map, and they do
>>>>>>> not have vq mutex. How can they do this and free
>>>>>>> the map safely? They need synchronize_rcu or kfree_rcu right?
>>>>>> Invalidation callbacks need but file operations (e.g ioctl) not.
>>>>>>
>>>>>>
>>>>>>> And I worry somewhat that synchronize_rcu in an MMU notifier
>>>>>>> is a problem, MMU notifiers are supposed to be quick:
>>>>>> Looks not, since it can allow to be blocked and lots of driver depends on
>>>>>> this. (E.g mmu_notifier_range_blockable()).
>>>>> Right, they can block. So why don't we take a VQ mutex and be
>>>>> done with it then? No RCU tricks.
>>>> This is how I want to go with RFC and V1. But I end up with deadlock between
>>>> vq locks and some MM internal locks. So I decide to use RCU which is 100%
>>>> under the control of vhost.
>>>>
>>>> Thanks
>>> And I guess the deadlock is because GUP is taking mmu locks which are
>>> taken on mmu notifier path, right?
>>
>> Yes, but it's not the only lock. I don't remember the details, but I can
>> confirm I meet issues with one or two other locks.
>>
>>
>>>     How about we add a seqlock and take
>>> that in invalidate callbacks?  We can then drop the VQ lock before GUP,
>>> and take it again immediately after.
>>>
>>> something like
>>> 	if (!vq_meta_mapped(vq)) {
>>> 		vq_meta_setup(&uaddrs);
>>> 		mutex_unlock(vq->mutex)
>>> 		vq_meta_map(&uaddrs);
>>
>> The problem is the vq address could be changed at this time.
>>
>>
>>> 		mutex_lock(vq->mutex)
>>>
>>> 		/* recheck both sock->private_data and seqlock count. */
>>> 		if changed - bail out
>>> 	}
>>>
>>> And also requires that VQ uaddrs is defined like this:
>>> - writers must have both vq mutex and dev mutex
>>> - readers must have either vq mutex or dev mutex
>>>
>>>
>>> That's a big change though. For now, how about switching to a per-vq SRCU?
>>> That is only a little bit more expensive than RCU, and we
>>> can use synchronize_srcu_expedited.
>>>
>> Consider we switch to use kfree_rcu(), what's the advantage of per-vq SRCU?
>>
>> Thanks
>
> I thought we established that notifiers must wait for
> all readers to finish before they mark page dirty, to
> prevent page from becoming dirty after address
> has been invalidated.
> Right?


Exactly, and that's the reason actually I use synchronize_rcu() there.

So the concern is still the possible synchronize_expedited()? Can I do 
this on through another series on top of the incoming V2?

Thanks


