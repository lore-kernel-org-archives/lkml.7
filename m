Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECDEC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B28A206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfG2OZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:25:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbfG2OY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:24:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 81BE3C049E12;
        Mon, 29 Jul 2019 14:24:58 +0000 (UTC)
Received: from [10.72.12.68] (ovpn-12-68.pek2.redhat.com [10.72.12.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14E8E5D6A0;
        Mon, 29 Jul 2019 14:24:44 +0000 (UTC)
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
References: <84bb2e31-0606-adff-cf2a-e1878225a847@redhat.com>
 <20190725092332-mutt-send-email-mst@kernel.org>
 <11802a8a-ce41-f427-63d5-b6a4cf96bb3f@redhat.com>
 <20190726074644-mutt-send-email-mst@kernel.org>
 <5cc94f15-b229-a290-55f3-8295266edb2b@redhat.com>
 <20190726082837-mutt-send-email-mst@kernel.org>
 <ada10dc9-6cab-e189-5289-6f9d3ff8fed2@redhat.com>
 <aaefa93e-a0de-1c55-feb0-509c87aae1f3@redhat.com>
 <20190726094756-mutt-send-email-mst@kernel.org>
 <0792ee09-b4b7-673c-2251-e5e0ce0fbe32@redhat.com>
 <20190729045127-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <4d43c094-44ed-dbac-b863-48fc3d754378@redhat.com>
Date:   Mon, 29 Jul 2019 22:24:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729045127-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 29 Jul 2019 14:24:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/29 下午4:59, Michael S. Tsirkin wrote:
> On Mon, Jul 29, 2019 at 01:54:49PM +0800, Jason Wang wrote:
>> On 2019/7/26 下午9:49, Michael S. Tsirkin wrote:
>>>>> Ok, let me retry if necessary (but I do remember I end up with deadlocks
>>>>> last try).
>>>> Ok, I play a little with this. And it works so far. Will do more testing
>>>> tomorrow.
>>>>
>>>> One reason could be I switch to use get_user_pages_fast() to
>>>> __get_user_pages_fast() which doesn't need mmap_sem.
>>>>
>>>> Thanks
>>> OK that sounds good. If we also set a flag to make
>>> vhost_exceeds_weight exit, then I think it will be all good.
>>
>> After some experiments, I came up two methods:
>>
>> 1) switch to use vq->mutex, then we must take the vq lock during range
>> checking (but I don't see obvious slowdown for 16vcpus + 16queues). Setting
>> flags during weight check should work but it still can't address the worst
>> case: wait for the page to be swapped in. Is this acceptable?
>>
>> 2) using current RCU but replace synchronize_rcu() with vhost_work_flush().
>> The worst case is the same as 1) but we can check range without holding any
>> locks.
>>
>> Which one did you prefer?
>>
>> Thanks
> I would rather we start with 1 and switch to 2 after we
> can show some gain.
>
> But the worst case needs to be addressed.


Yes.


> How about sending a signal to
> the vhost thread?  We will need to fix up error handling (I think that
> at the moment it will error out in that case, handling this as EFAULT -
> and we don't want to drop packets if we can help it, and surely not
> enter any error states.  In particular it might be especially tricky if
> we wrote into userspace memory and are now trying to log the write.
> I guess we can disable the optimization if log is enabled?).


This may work but requires a lot of changes. And actually it's the price 
of using vq mutex. Actually, the critical section should be rather 
small, e.g just inside memory accessors.

I wonder whether or not just do synchronize our self like:

static void inline vhost_inc_vq_ref(struct vhost_virtqueue *vq)
{
         int ref = READ_ONCE(vq->ref);

         WRITE_ONCE(vq->ref, ref + 1);
smp_rmb();
}

static void inline vhost_dec_vq_ref(struct vhost_virtqueue *vq)
{
         int ref = READ_ONCE(vq->ref);

smp_wmb();
         WRITE_ONCE(vq->ref, ref - 1);
}

static void inline vhost_wait_for_ref(struct vhost_virtqueue *vq)
{
         while (READ_ONCE(vq->ref));
mb();
}


Or using smp_load_acquire()/smp_store_release() instead?

Thanks

>
