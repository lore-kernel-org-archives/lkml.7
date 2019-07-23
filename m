Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2C4C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C0D2229A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbfGWFB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 01:01:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35795 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfGWFB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 01:01:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so37193136wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 22:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+GkhoIBN4zKH4Fj0ifhxLJj0Z5XtAt4wUMTn1vnNHYo=;
        b=FOoD2pnwnkahDvAMejQ7tBEHlNO+VNnjVDf/rUJijEKGheXyVDWO3LnTmDScNaRH6z
         TaeW+A05G22H1qrSoS9/RG3UlOZBo0AwBHAQCiCydPtI+rJj/tWluihAX2Tfn7c6u+RW
         eFiNXz2H6Rr3p4cxPfsKQtbcPBNTgwSq9bAeGFhhqVx8FZxoUisd94pEd13XW8XStwCk
         Ph2BuDWcapjtuxUdM2RqBoIPgQu8BndZVuLArHTaItPtmRnGHIsRjZ1lmORmjl1Kwqqu
         PVrlaSSJfXyDVDWVRwGPhsTHbSs09yjhOBjljDStky1bkCw/WsQTsIh8ZpkgwdSC3Rn5
         4yTw==
X-Gm-Message-State: APjAAAWB2WJqwA47wLdT1GK9g6nfToS3encfoXXWwLZbvLf1Vmx6OPDU
        9wOlG817NY3ffaCAxFS807yOKA==
X-Google-Smtp-Source: APXvYqzMrWrj9NjXakyiVzcyJ6rRsEcFXFH6p99kaIf0uv2Ksm8d9SHaEyv3pZRViZQZ/4k36hbViQ==
X-Received: by 2002:a05:600c:224d:: with SMTP id a13mr23179912wmm.62.1563858114502;
        Mon, 22 Jul 2019 22:01:54 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id r5sm44467914wmh.35.2019.07.22.22.01.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 22:01:53 -0700 (PDT)
Date:   Tue, 23 Jul 2019 01:01:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
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
Subject: Re: WARNING in __mmdrop
Message-ID: <20190723010019-mutt-send-email-mst@kernel.org>
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
 <20190721081447-mutt-send-email-mst@kernel.org>
 <85dd00e2-37a6-72b7-5d5a-8bf46a3526cf@redhat.com>
 <20190722040230-mutt-send-email-mst@kernel.org>
 <4bd2ff78-6871-55f2-44dc-0982ffef3337@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bd2ff78-6871-55f2-44dc-0982ffef3337@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 12:01:40PM +0800, Jason Wang wrote:
> 
> On 2019/7/22 下午4:08, Michael S. Tsirkin wrote:
> > On Mon, Jul 22, 2019 at 01:24:24PM +0800, Jason Wang wrote:
> > > On 2019/7/21 下午8:18, Michael S. Tsirkin wrote:
> > > > On Sun, Jul 21, 2019 at 06:02:52AM -0400, Michael S. Tsirkin wrote:
> > > > > On Sat, Jul 20, 2019 at 03:08:00AM -0700, syzbot wrote:
> > > > > > syzbot has bisected this bug to:
> > > > > > 
> > > > > > commit 7f466032dc9e5a61217f22ea34b2df932786bbfc
> > > > > > Author: Jason Wang<jasowang@redhat.com>
> > > > > > Date:   Fri May 24 08:12:18 2019 +0000
> > > > > > 
> > > > > >       vhost: access vq metadata through kernel virtual address
> > > > > > 
> > > > > > bisection log:https://syzkaller.appspot.com/x/bisect.txt?x=149a8a20600000
> > > > > > start commit:   6d21a41b Add linux-next specific files for 20190718
> > > > > > git tree:       linux-next
> > > > > > final crash:https://syzkaller.appspot.com/x/report.txt?x=169a8a20600000
> > > > > > console output:https://syzkaller.appspot.com/x/log.txt?x=129a8a20600000
> > > > > > kernel config:https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
> > > > > > dashboard link:https://syzkaller.appspot.com/bug?extid=e58112d71f77113ddb7b
> > > > > > syz repro:https://syzkaller.appspot.com/x/repro.syz?x=10139e68600000
> > > > > > 
> > > > > > Reported-by:syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com
> > > > > > Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual
> > > > > > address")
> > > > > > 
> > > > > > For information about bisection process see:https://goo.gl/tpsmEJ#bisection
> > > > > OK I poked at this for a bit, I see several things that
> > > > > we need to fix, though I'm not yet sure it's the reason for
> > > > > the failures:
> > > > > 
> > > > > 
> > > > > 1. mmu_notifier_register shouldn't be called from vhost_vring_set_num_addr
> > > > >      That's just a bad hack, in particular I don't think device
> > > > >      mutex is taken and so poking at two VQs will corrupt
> > > > >      memory.
> > > > >      So what to do? How about a per vq notifier?
> > > > >      Of course we also have synchronize_rcu
> > > > >      in the notifier which is slow and is now going to be called twice.
> > > > >      I think call_rcu would be more appropriate here.
> > > > >      We then need rcu_barrier on module unload.
> > > > >      OTOH if we make pages linear with map then we are good
> > > > >      with kfree_rcu which is even nicer.
> > > > > 
> > > > > 2. Doesn't map leak after vhost_map_unprefetch?
> > > > >      And why does it poke at contents of the map?
> > > > >      No one should use it right?
> > > > > 
> > > > > 3. notifier unregister happens last in vhost_dev_cleanup,
> > > > >      but register happens first. This looks wrong to me.
> > > > > 
> > > > > 4. OK so we use the invalidate count to try and detect that
> > > > >      some invalidate is in progress.
> > > > >      I am not 100% sure why do we care.
> > > > >      Assuming we do, uaddr can change between start and end
> > > > >      and then the counter can get negative, or generally
> > > > >      out of sync.
> > > > > 
> > > > > So what to do about all this?
> > > > > I am inclined to say let's just drop the uaddr optimization
> > > > > for now. E.g. kvm invalidates unconditionally.
> > > > > 3 should be fixed independently.
> > > > Above implements this but is only build-tested.
> > > > Jason, pls take a look. If you like the approach feel
> > > > free to take it from here.
> > > > 
> > > > One thing the below does not have is any kind of rate-limiting.
> > > > Given it's so easy to restart I'm thinking it makes sense
> > > > to add a generic infrastructure for this.
> > > > Can be a separate patch I guess.
> > > 
> > > I don't get why must use kfree_rcu() instead of synchronize_rcu() here.
> > synchronize_rcu has very high latency on busy systems.
> > It is not something that should be used on a syscall path.
> > KVM had to switch to SRCU to keep it sane.
> > Otherwise one guest can trivially slow down another one.
> 
> 
> I think you mean the synchronize_rcu_expedited()? Rethink of the code, the
> synchronize_rcu() in ioctl() could be removed, since it was serialized with
> memory accessor.


Really let's just use kfree_rcu. It's way cleaner: fire and forget.

> 
> Btw, for kvm ioctl it still uses synchronize_rcu() in kvm_vcpu_ioctl(),
> (just a little bit more hard to trigger):


AFAIK these never run in response to guest events.
So they can take very long and guests still won't crash.


> 
>     case KVM_RUN: {
> ...
>         if (unlikely(oldpid != task_pid(current))) {
>             /* The thread running this VCPU changed. */
>             struct pid *newpid;
> 
>             r = kvm_arch_vcpu_run_pid_change(vcpu);
>             if (r)
>                 break;
> 
>             newpid = get_task_pid(current, PIDTYPE_PID);
>             rcu_assign_pointer(vcpu->pid, newpid);
>             if (oldpid)
>                 synchronize_rcu();
>             put_pid(oldpid);
>         }
> ...
>         break;
> 
> 
> > 
> > > > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> > > 
> > > Let me try to figure out the root cause then decide whether or not to go for
> > > this way.
> > > 
> > > Thanks
> > The root cause of the crash is relevant, but we still need
> > to fix issues 1-4.
> > 
> > More issues (my patch tries to fix them too):
> > 
> > 5. page not dirtied when mappings are torn down outside
> >     of invalidate callback
> 
> 
> Yes.
> 
> 
> > 
> > 6. potential cross-VM DOS by one guest keeping system busy
> >     and increasing synchronize_rcu latency to the point where
> >     another guest stars timing out and crashes
> > 
> > 
> > 
> 
> This will be addressed after I remove the synchronize_rcu() from ioctl path.
> 
> Thanks
