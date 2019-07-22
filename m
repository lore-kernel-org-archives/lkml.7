Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECA9C76196
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295AA21F26
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfGVFYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:24:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfGVFYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:24:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 145078535C;
        Mon, 22 Jul 2019 05:24:39 +0000 (UTC)
Received: from [10.72.12.30] (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6EBC1001DE1;
        Mon, 22 Jul 2019 05:24:28 +0000 (UTC)
Subject: Re: WARNING in __mmdrop
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        syzbot <syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com>
Cc:     aarcange@redhat.com, akpm@linux-foundation.org,
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
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
 <20190721081447-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <85dd00e2-37a6-72b7-5d5a-8bf46a3526cf@redhat.com>
Date:   Mon, 22 Jul 2019 13:24:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190721081447-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 22 Jul 2019 05:24:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/21 下午8:18, Michael S. Tsirkin wrote:
> On Sun, Jul 21, 2019 at 06:02:52AM -0400, Michael S. Tsirkin wrote:
>> On Sat, Jul 20, 2019 at 03:08:00AM -0700, syzbot wrote:
>>> syzbot has bisected this bug to:
>>>
>>> commit 7f466032dc9e5a61217f22ea34b2df932786bbfc
>>> Author: Jason Wang<jasowang@redhat.com>
>>> Date:   Fri May 24 08:12:18 2019 +0000
>>>
>>>      vhost: access vq metadata through kernel virtual address
>>>
>>> bisection log:https://syzkaller.appspot.com/x/bisect.txt?x=149a8a20600000
>>> start commit:   6d21a41b Add linux-next specific files for 20190718
>>> git tree:       linux-next
>>> final crash:https://syzkaller.appspot.com/x/report.txt?x=169a8a20600000
>>> console output:https://syzkaller.appspot.com/x/log.txt?x=129a8a20600000
>>> kernel config:https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
>>> dashboard link:https://syzkaller.appspot.com/bug?extid=e58112d71f77113ddb7b
>>> syz repro:https://syzkaller.appspot.com/x/repro.syz?x=10139e68600000
>>>
>>> Reported-by:syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com
>>> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual
>>> address")
>>>
>>> For information about bisection process see:https://goo.gl/tpsmEJ#bisection
>> OK I poked at this for a bit, I see several things that
>> we need to fix, though I'm not yet sure it's the reason for
>> the failures:
>>
>>
>> 1. mmu_notifier_register shouldn't be called from vhost_vring_set_num_addr
>>     That's just a bad hack, in particular I don't think device
>>     mutex is taken and so poking at two VQs will corrupt
>>     memory.
>>     So what to do? How about a per vq notifier?
>>     Of course we also have synchronize_rcu
>>     in the notifier which is slow and is now going to be called twice.
>>     I think call_rcu would be more appropriate here.
>>     We then need rcu_barrier on module unload.
>>     OTOH if we make pages linear with map then we are good
>>     with kfree_rcu which is even nicer.
>>
>> 2. Doesn't map leak after vhost_map_unprefetch?
>>     And why does it poke at contents of the map?
>>     No one should use it right?
>>
>> 3. notifier unregister happens last in vhost_dev_cleanup,
>>     but register happens first. This looks wrong to me.
>>
>> 4. OK so we use the invalidate count to try and detect that
>>     some invalidate is in progress.
>>     I am not 100% sure why do we care.
>>     Assuming we do, uaddr can change between start and end
>>     and then the counter can get negative, or generally
>>     out of sync.
>>
>> So what to do about all this?
>> I am inclined to say let's just drop the uaddr optimization
>> for now. E.g. kvm invalidates unconditionally.
>> 3 should be fixed independently.
> Above implements this but is only build-tested.
> Jason, pls take a look. If you like the approach feel
> free to take it from here.
>
> One thing the below does not have is any kind of rate-limiting.
> Given it's so easy to restart I'm thinking it makes sense
> to add a generic infrastructure for this.
> Can be a separate patch I guess.


I don't get why must use kfree_rcu() instead of synchronize_rcu() here.


>
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>


Let me try to figure out the root cause then decide whether or not to go 
for this way.

Thanks


