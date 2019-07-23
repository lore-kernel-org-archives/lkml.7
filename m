Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE20C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EE022543
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390252AbfGWNbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:31:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfGWNbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:31:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B85FF2CD801;
        Tue, 23 Jul 2019 13:31:47 +0000 (UTC)
Received: from [10.72.12.26] (ovpn-12-26.pek2.redhat.com [10.72.12.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BBD55C22D;
        Tue, 23 Jul 2019 13:31:33 +0000 (UTC)
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
References: <20190721081447-mutt-send-email-mst@kernel.org>
 <85dd00e2-37a6-72b7-5d5a-8bf46a3526cf@redhat.com>
 <20190722040230-mutt-send-email-mst@kernel.org>
 <4bd2ff78-6871-55f2-44dc-0982ffef3337@redhat.com>
 <20190723010019-mutt-send-email-mst@kernel.org>
 <b4696f2e-678a-bdb2-4b7c-fb4ce040ec2a@redhat.com>
 <20190723032024-mutt-send-email-mst@kernel.org>
 <1d14de4d-0133-1614-9f64-3ded381de04e@redhat.com>
 <20190723035725-mutt-send-email-mst@kernel.org>
 <3f4178f1-0d71-e032-0f1f-802428ceca59@redhat.com>
 <20190723051828-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <caff362a-e208-3468-3688-63e1d093a9d3@redhat.com>
Date:   Tue, 23 Jul 2019 21:31:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723051828-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 23 Jul 2019 13:31:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/23 下午5:26, Michael S. Tsirkin wrote:
> On Tue, Jul 23, 2019 at 04:49:01PM +0800, Jason Wang wrote:
>> On 2019/7/23 下午4:10, Michael S. Tsirkin wrote:
>>> On Tue, Jul 23, 2019 at 03:53:06PM +0800, Jason Wang wrote:
>>>> On 2019/7/23 下午3:23, Michael S. Tsirkin wrote:
>>>>>>> Really let's just use kfree_rcu. It's way cleaner: fire and forget.
>>>>>> Looks not, you need rate limit the fire as you've figured out?
>>>>> See the discussion that followed. Basically no, it's good enough
>>>>> already and is only going to be better.
>>>>>
>>>>>> And in fact,
>>>>>> the synchronization is not even needed, does it help if I leave a comment to
>>>>>> explain?
>>>>> Let's try to figure it out in the mail first. I'm pretty sure the
>>>>> current logic is wrong.
>>>> Here is what the code what to achieve:
>>>>
>>>> - The map was protected by RCU
>>>>
>>>> - Writers are: MMU notifier invalidation callbacks, file operations (ioctls
>>>> etc), meta_prefetch (datapath)
>>>>
>>>> - Readers are: memory accessor
>>>>
>>>> Writer are synchronized through mmu_lock. RCU is used to synchronized
>>>> between writers and readers.
>>>>
>>>> The synchronize_rcu() in vhost_reset_vq_maps() was used to synchronized it
>>>> with readers (memory accessors) in the path of file operations. But in this
>>>> case, vq->mutex was already held, this means it has been serialized with
>>>> memory accessor. That's why I think it could be removed safely.
>>>>
>>>> Anything I miss here?
>>>>
>>> So invalidate callbacks need to reset the map, and they do
>>> not have vq mutex. How can they do this and free
>>> the map safely? They need synchronize_rcu or kfree_rcu right?
>> Invalidation callbacks need but file operations (e.g ioctl) not.
>>
>>
>>> And I worry somewhat that synchronize_rcu in an MMU notifier
>>> is a problem, MMU notifiers are supposed to be quick:
>> Looks not, since it can allow to be blocked and lots of driver depends on
>> this. (E.g mmu_notifier_range_blockable()).
> Right, they can block. So why don't we take a VQ mutex and be
> done with it then? No RCU tricks.


This is how I want to go with RFC and V1. But I end up with deadlock 
between vq locks and some MM internal locks. So I decide to use RCU 
which is 100% under the control of vhost.

Thanks

