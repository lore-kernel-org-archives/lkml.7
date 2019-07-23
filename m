Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A93C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CE8223A1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733182AbfGWItM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:49:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbfGWItL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:49:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 85FD183F4C;
        Tue, 23 Jul 2019 08:49:10 +0000 (UTC)
Received: from [10.72.12.26] (ovpn-12-26.pek2.redhat.com [10.72.12.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1353600CD;
        Tue, 23 Jul 2019 08:49:00 +0000 (UTC)
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
References: <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
 <20190721081447-mutt-send-email-mst@kernel.org>
 <85dd00e2-37a6-72b7-5d5a-8bf46a3526cf@redhat.com>
 <20190722040230-mutt-send-email-mst@kernel.org>
 <4bd2ff78-6871-55f2-44dc-0982ffef3337@redhat.com>
 <20190723010019-mutt-send-email-mst@kernel.org>
 <b4696f2e-678a-bdb2-4b7c-fb4ce040ec2a@redhat.com>
 <20190723032024-mutt-send-email-mst@kernel.org>
 <1d14de4d-0133-1614-9f64-3ded381de04e@redhat.com>
 <20190723035725-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <3f4178f1-0d71-e032-0f1f-802428ceca59@redhat.com>
Date:   Tue, 23 Jul 2019 16:49:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723035725-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 23 Jul 2019 08:49:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/23 下午4:10, Michael S. Tsirkin wrote:
> On Tue, Jul 23, 2019 at 03:53:06PM +0800, Jason Wang wrote:
>> On 2019/7/23 下午3:23, Michael S. Tsirkin wrote:
>>>>> Really let's just use kfree_rcu. It's way cleaner: fire and forget.
>>>> Looks not, you need rate limit the fire as you've figured out?
>>> See the discussion that followed. Basically no, it's good enough
>>> already and is only going to be better.
>>>
>>>> And in fact,
>>>> the synchronization is not even needed, does it help if I leave a comment to
>>>> explain?
>>> Let's try to figure it out in the mail first. I'm pretty sure the
>>> current logic is wrong.
>>
>> Here is what the code what to achieve:
>>
>> - The map was protected by RCU
>>
>> - Writers are: MMU notifier invalidation callbacks, file operations (ioctls
>> etc), meta_prefetch (datapath)
>>
>> - Readers are: memory accessor
>>
>> Writer are synchronized through mmu_lock. RCU is used to synchronized
>> between writers and readers.
>>
>> The synchronize_rcu() in vhost_reset_vq_maps() was used to synchronized it
>> with readers (memory accessors) in the path of file operations. But in this
>> case, vq->mutex was already held, this means it has been serialized with
>> memory accessor. That's why I think it could be removed safely.
>>
>> Anything I miss here?
>>
> So invalidate callbacks need to reset the map, and they do
> not have vq mutex. How can they do this and free
> the map safely? They need synchronize_rcu or kfree_rcu right?


Invalidation callbacks need but file operations (e.g ioctl) not.


>
> And I worry somewhat that synchronize_rcu in an MMU notifier
> is a problem, MMU notifiers are supposed to be quick:


Looks not, since it can allow to be blocked and lots of driver depends 
on this. (E.g mmu_notifier_range_blockable()).


> they are on a read side critical section of SRCU.
>
> If we could get rid of RCU that would be even better.
>
> But now I wonder:
> 	invalidate_start has to mark page as dirty
> 	(this is what my patch added, current code misses this).


Nope, current code did this but not the case when map need to be 
invalidated in the vhost control path (ioctl etc).


>
> 	at that point kernel can come and make the page clean again.
>
> 	At that point VQ handlers can keep a copy of the map
> 	and change the page again.


We will increase invalidate_count which prevent the page being used by map.

Thanks


>
>
> At this point I don't understand how we can mark page dirty
> safely.
>
>>>>>> Btw, for kvm ioctl it still uses synchronize_rcu() in kvm_vcpu_ioctl(),
>>>>>> (just a little bit more hard to trigger):
>>>>> AFAIK these never run in response to guest events.
>>>>> So they can take very long and guests still won't crash.
>>>> What if guest manages to escape to qemu?
>>>>
>>>> Thanks
>>> Then it's going to be slow. Why do we care?
>>> What we do not want is synchronize_rcu that guest is blocked on.
>>>
>> Ok, this looks like that I have some misunderstanding here of the reason why
>> synchronize_rcu() is not preferable in the path of ioctl. But in kvm case,
>> if rcu_expedited is set, it can triggers IPIs AFAIK.
>>
>> Thanks
>>
> Yes, expedited is not good for something guest can trigger.
> Let's just use kfree_rcu if we can. Paul said even though
> documentation still says it needs to be rate-limited, that
> part is basically stale and will get updated.
>
