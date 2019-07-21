Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34F2C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A60204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfGUKDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 06:03:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfGUKDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 06:03:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30E3F4E908;
        Sun, 21 Jul 2019 10:03:03 +0000 (UTC)
Received: from redhat.com (ovpn-120-23.rdu2.redhat.com [10.10.120.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id 69DA95F7C0;
        Sun, 21 Jul 2019 10:02:54 +0000 (UTC)
Date:   Sun, 21 Jul 2019 06:02:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     syzbot <syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com>
Cc:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jasowang@redhat.com,
        jglisse@redhat.com, keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Subject: Re: WARNING in __mmdrop
Message-ID: <20190721044615-mutt-send-email-mst@kernel.org>
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000964b0d058e1a0483@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 21 Jul 2019 10:03:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 03:08:00AM -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 7f466032dc9e5a61217f22ea34b2df932786bbfc
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Fri May 24 08:12:18 2019 +0000
> 
>     vhost: access vq metadata through kernel virtual address
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149a8a20600000
> start commit:   6d21a41b Add linux-next specific files for 20190718
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=169a8a20600000
> console output: https://syzkaller.appspot.com/x/log.txt?x=129a8a20600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
> dashboard link: https://syzkaller.appspot.com/bug?extid=e58112d71f77113ddb7b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10139e68600000
> 
> Reported-by: syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com
> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual
> address")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


OK I poked at this for a bit, I see several things that
we need to fix, though I'm not yet sure it's the reason for
the failures:


1. mmu_notifier_register shouldn't be called from vhost_vring_set_num_addr
   That's just a bad hack, in particular I don't think device
   mutex is taken and so poking at two VQs will corrupt
   memory.
   So what to do? How about a per vq notifier?
   Of course we also have synchronize_rcu
   in the notifier which is slow and is now going to be called twice.
   I think call_rcu would be more appropriate here.
   We then need rcu_barrier on module unload.
   OTOH if we make pages linear with map then we are good
   with kfree_rcu which is even nicer.

2. Doesn't map leak after vhost_map_unprefetch?
   And why does it poke at contents of the map?
   No one should use it right?

3. notifier unregister happens last in vhost_dev_cleanup,
   but register happens first. This looks wrong to me.

4. OK so we use the invalidate count to try and detect that
   some invalidate is in progress.
   I am not 100% sure why do we care.
   Assuming we do, uaddr can change between start and end
   and then the counter can get negative, or generally
   out of sync.

So what to do about all this?
I am inclined to say let's just drop the uaddr optimization
for now. E.g. kvm invalidates unconditionally.
3 should be fixed independently.


-- 
MST
