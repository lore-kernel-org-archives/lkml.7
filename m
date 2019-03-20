Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2D8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDEB21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOlC7stz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfCTTIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:08:55 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50692 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfCTTIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:08:53 -0400
Received: by mail-it1-f195.google.com with SMTP id m137so619280ita.0;
        Wed, 20 Mar 2019 12:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/uck7qBW7esb8M3Ub1B+tfHUb7YezDyqwUpjCka7i8=;
        b=oOlC7stzgfLiWXLzeqv4z4HGe+FreL9IFiGgqsuVHOe0sDmioQgHCNlZG9kodfLtMS
         vKOiDSgW88ZlI9pb9odDQB1SMMTl0ypdkQeajHYyDPDQyP4q8c5wzf0BEM7zQoZAuZks
         wj6qUpNAje83kAF/Z6qnxKRRcYj5vOJ+yp5Q7SWlPW6n4HsB4LqpjvCIN3NNq/z448Bl
         9G3O8FSbb0uXHG99oVAtZx/FKhA9sjYnevN/OcgQefnX/OEMm30ZUC0+ixucisF4BMr6
         iFCWqNfZcCJ6ce3L5EdZsUFdxZVSRZvUpRpbORRLlpZe2+2H4HYtTyTrZIjK77mdfLFk
         KHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/uck7qBW7esb8M3Ub1B+tfHUb7YezDyqwUpjCka7i8=;
        b=LwuXNtH0suuZvDQUCXtOwu4iNtULaYT/MNFToYKMXFFW8FDDW6V6+0APYMGttoq2MW
         5mmvAYX8SYjqSa/L/gwammrNoeu0m+46alGwV0yppHegmhvt6ylXu7WR5DIwJZnmUIi/
         hi75tVi4RNcy0d9fWa02cB3oLKhvlzoWZmpyUGlXsbHCK0D122370j8Lq3TVO7/3oB42
         rLuHiFFgZI1U0K0i8V4C4k57p+k6lGyKWitvjkbygeLCLDyw4misp6A7m6W8vv7IVqVE
         v8t3u0j8gxhdV66pm8ITeyIbUyrRHH46j5AQjbBCTj/3+D6rF96o0n7nkZ6SmQlCfGOB
         VnNQ==
X-Gm-Message-State: APjAAAUoUirPuUwS2S8+bvB8JZGiDcNMDHuh7wl5FYHZw8M2GZ94LEY7
        jHpG2Wa0UOW6Unor0d9NyO/Ldw6LgqKxqmnh0Tw=
X-Google-Smtp-Source: APXvYqyC+i9QmZHG86HHpFG62O6AD18BfYJK+btdsvgcLbcCXL5SIK8xS1WoVQUimSnk+Vop5k6/GNgpMZGax6wUX9w=
X-Received: by 2002:a02:1ac3:: with SMTP id 186mr6330120jai.96.1553108931404;
 Wed, 20 Mar 2019 12:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000dbe73a057cd65da2@google.com> <00000000000010f4270584595484@google.com>
 <BL0PR1501MB20039998B662DCC11E2B38D79A410@BL0PR1501MB2003.namprd15.prod.outlook.com>
 <CACT4Y+anbSEh89LaFeT2Bi4qVM1Maf_0x11ynrfCk9PNvg9UXw@mail.gmail.com> <BL0PR1501MB200362E55B2A1570CF9909529A410@BL0PR1501MB2003.namprd15.prod.outlook.com>
In-Reply-To: <BL0PR1501MB200362E55B2A1570CF9909529A410@BL0PR1501MB2003.namprd15.prod.outlook.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Thu, 21 Mar 2019 03:08:39 +0800
Message-ID: <CADvbK_eHRy6jerprBd0uVmWyL9dWtkhJ2K-EWWDG88HEPP23UA@mail.gmail.com>
Subject: Re: general protection fault in fib6_purge_rt
To:     Jon Maloy <jon.maloy@ericsson.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 12:54 AM Jon Maloy <jon.maloy@ericsson.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Dmitry Vyukov <dvyukov@google.com>
> > Sent: 20-Mar-19 17:41
> > To: Jon Maloy <jon.maloy@ericsson.com>
> > Cc: syzbot <syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com>;
> > davem@davemloft.net; kuznet@ms2.inr.ac.ru; linux-
> > kernel@vger.kernel.org; netdev@vger.kernel.org; syzkaller-
> > bugs@googlegroups.com; tipc-discussion@lists.sourceforge.net;
> > ying.xue@windriver.com; yoshfuji@linux-ipv6.org
> > Subject: Re: general protection fault in fib6_purge_rt
> >
> > On Wed, Mar 20, 2019 at 4:59 PM Jon Maloy <jon.maloy@ericsson.com>
> > wrote:
> > >
> > > This one identifies the same culprit as
> > syzbot+9d4c12bfd45a58738d0a@syzkaller.appspotmail.com, but points to a
> > different bug.
> > > That bug has also been fixed, in commit adba75be0d23  ("tipc: fix lockdep
> > warning when reinitilaizing sockets"), applied in 4.20 but not present in 4.16, -
> > the source of the dump.
> > > Once again, a dump from 4.20/5.0 might be a help.
Hi, Jon,

I was running the reproducer against the net.git kernel which includes
commit adba75be0d23.

Another panic showed up:

[  156.086487] ==================================================================
[  156.088228] BUG: KASAN: use-after-free in
tipc_disc_timeout+0x9c9/0xb20 [tipc]
[  156.089740] Read of size 8 at addr ffff88802fdb1be8 by task swapper/1/0
[  156.091120]
[  156.091471] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.0.0.test.syz #257
[  156.092873] Hardware name: Red Hat KVM, BIOS seabios-1.7.5-8.el7 04/01/2014
[  156.094315] Call Trace:
[  156.094844]  <IRQ>
[  156.095306]  dump_stack+0x7c/0xc0
[  156.096040]  ? tipc_disc_timeout+0x9c9/0xb20 [tipc]
[  156.097346]  print_address_description+0x65/0x22e
[  156.098360]  ? tipc_disc_timeout+0x9c9/0xb20 [tipc]
[  156.099408]  ? tipc_disc_timeout+0x9c9/0xb20 [tipc]
[  156.100445]  kasan_report.cold.3+0x37/0x7a
[  156.101348]  ? tipc_disc_timeout+0x9c9/0xb20 [tipc]
[  156.102402]  tipc_disc_timeout+0x9c9/0xb20 [tipc]
[  156.103641]  ? tipc_disc_msg_xmit.isra.19+0x180/0x180 [tipc]
[  156.104830]  ? __lock_is_held+0xb4/0x140
[  156.105669]  ? call_timer_fn+0xd1/0x610
[  156.106517]  call_timer_fn+0x19a/0x610
[  156.107342]  ? tipc_disc_msg_xmit.isra.19+0x180/0x180 [tipc]
[  156.108538]  ? timer_fixup_init+0x30/0x30
[  156.109411]  ? _raw_spin_unlock_irq+0x29/0x40
[  156.110343]  ? tipc_disc_msg_xmit.isra.19+0x180/0x180 [tipc]
[  156.111545]  ? tipc_disc_msg_xmit.isra.19+0x180/0x180 [tipc]
[  156.112749]  run_timer_softirq+0xb51/0x1090
[  156.113656]  ? add_timer+0x8d0/0x8d0
[  156.114433]  ? kvm_sched_clock_read+0x14/0x30
[  156.115355]  ? sched_clock+0x5/0x10
[  156.116124]  __do_softirq+0x236/0xa1c
[  156.116943]  irq_exit+0x281/0x2d0
[  156.117657]  smp_apic_timer_interrupt+0x172/0x5d0
[  156.118658]  apic_timer_interrupt+0xf/0x20


I think it's caused by that d->timer wasn't deleted after the netns has been
destroyed, and tipc_disc_timeout() still used d->net that has been freed.

I looked at the __net_exit path, it should have been done by:
tipc_exit_net() ->
tipc_net_stop()->
tipc_bearer_stop()->
bearer_disable()->
tipc_disc_delete()->
del_timer_sync(&d->timer)

but because of if (!self), it returned in tipc_net_stop().

It seems to me that whether to do tipc_bearer/node_stop() for netns or not
shouldn't depend on tipc_net(net)->node_addr.
Can we just remove that if(!self) from tipc_net_stop() to fix it?
and also seems tipc_nametbl_stop() will do the clean job for nametbl,
should tipc_nametbl_withdraw() also be removed from tipc_net_stop()?

diff --git a/net/tipc/net.c b/net/tipc/net.c
index f076edb..3647984 100644
--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -163,12 +163,6 @@ void tipc_sched_net_finalize(struct net *net, u32 addr)

 void tipc_net_stop(struct net *net)
 {
-       u32 self = tipc_own_addr(net);
-
-       if (!self)
-               return;
-
-       tipc_nametbl_withdraw(net, TIPC_CFG_SRV, self, self, self);
        rtnl_lock();
        tipc_bearer_stop(net);
        tipc_node_stop(net);

> >
> >
> > Looking at the bisection log maybe this reproducer triggers multiple kernel
> > bugs.
>
> I think so.
>
> > All crashes including the latest ones and other info are always available on
> > the dashboard.
>
> Looking at the latest dashboard reports, I don't see anything that points to TIPC.
>
> ///jon
>
>
> >
> >
> > > ///jon
> > >
> > >
> > > > -----Original Message-----
> > > > From: syzbot
> > <syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com>
> > > > Sent: 18-Mar-19 08:28
> > > > To: davem@davemloft.net; Jon Maloy <jon.maloy@ericsson.com>;
> > > > kuznet@ms2.inr.ac.ru; linux-kernel@vger.kernel.org;
> > > > netdev@vger.kernel.org; syzkaller-bugs@googlegroups.com; tipc-
> > > > discussion@lists.sourceforge.net; ying.xue@windriver.com;
> > > > yoshfuji@linux- ipv6.org
> > > > Subject: Re: general protection fault in fib6_purge_rt
> > > >
> > > > syzbot has bisected this bug to:
> > > >
> > > > commit 52dfae5c85a4c1078e9f1d5e8947d4a25f73dd81
> > > > Author: Jon Maloy <jon.maloy@ericsson.com>
> > > > Date:   Thu Mar 22 19:42:52 2018 +0000
> > > >
> > > >      tipc: obtain node identity from interface by default
> > > >
> > > > bisection log:
> > https://syzkaller.appspot.com/x/bisect.txt?x=1116d2a3200000
> > > > start commit:   52dfae5c tipc: obtain node identity from interface by
> > defa..
> > > > git tree:       linux-next
> > > > final crash:
> > https://syzkaller.appspot.com/x/report.txt?x=1316d2a3200000
> > > > console output:
> > > > https://syzkaller.appspot.com/x/log.txt?x=1516d2a3200000
> > > > kernel config:
> > > > https://syzkaller.appspot.com/x/.config?x=c8b6073d992e8217
> > > > dashboard link:
> > > > https://syzkaller.appspot.com/bug?extid=a25307ad099309f1c2b9
> > > > syz repro:
> > https://syzkaller.appspot.com/x/repro.syz?x=16b2c56f200000
> > > > C reproducer:
> > https://syzkaller.appspot.com/x/repro.c?x=13b8890b200000
> > > >
> > > > Reported-by: syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com
> > > > Fixes: 52dfae5c ("tipc: obtain node identity from interface by
> > > > default")
> > >
> > > --
> > > You received this message because you are subscribed to the Google
> > Groups "syzkaller-bugs" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an
> > email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit
> > https://groups.google.com/d/msgid/syzkaller-
> > bugs/BL0PR1501MB20039998B662DCC11E2B38D79A410%40BL0PR1501MB200
> > 3.namprd15.prod.outlook.com.
> > > For more options, visit https://groups.google.com/d/optout.
