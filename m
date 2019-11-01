Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75093CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 05:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4036B208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 05:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJkmaEPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfKAFLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 01:11:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36020 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726803AbfKAFLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 01:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572585082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QoPYr3BtDVZxJtjAG+3SlB5DbgXGCYeEtbYOyopjcv4=;
        b=YJkmaEPEItwER3EI4BN25MHcvRQXTT3hQgFMtyeGqv66DvaVtb4oAR7t0oX20zbZyFfc2s
        FM8cnGtXq5g7k3ar+Qa3bFSzA0KH6ximqwARI9vv2W6i8dN0ULDWsh6t6MNYPZqFbVtulz
        Uy7kKxZ+Kgj4+gWvPKeDtLchEVmXS9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-Ome_-3f8PtqeSXL0RudgwQ-1; Fri, 01 Nov 2019 01:11:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A48D107ACC0;
        Fri,  1 Nov 2019 05:11:10 +0000 (UTC)
Received: from ovpn-116-229.phx2.redhat.com (ovpn-116-229.phx2.redhat.com [10.3.116.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A98CD60852;
        Fri,  1 Nov 2019 05:11:09 +0000 (UTC)
Message-ID: <813ed21938aa47b15f35f8834ffd98ad4dd27771.camel@redhat.com>
Subject: Re: [PATCH] timers/nohz: Update nohz load even if tick already
 stopped
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 01 Nov 2019 00:11:09 -0500
In-Reply-To: <20191030133130.GY4097@hirez.programming.kicks-ass.net>
References: <20191028150716.22890-1-frederic@kernel.org>
         <20191029100506.GJ4114@hirez.programming.kicks-ass.net>
         <52d963553deda810113accd8d69b6dffdb37144f.camel@redhat.com>
         <20191030133130.GY4097@hirez.programming.kicks-ass.net>
Organization: Red Hat
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Ome_-3f8PtqeSXL0RudgwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-30 at 14:31 +0100, Peter Zijlstra wrote:
> On Wed, Oct 30, 2019 at 03:48:26AM -0500, Scott Wood wrote:
> > On Tue, 2019-10-29 at 11:05 +0100, Peter Zijlstra wrote:
> > > @@ -3686,6 +3688,7 @@ static void sched_tick_remote(struct work_struc=
t
> > > *work)
> > >  =09curr->sched_class->task_tick(rq, curr, 0);
> > > =20
> > >  out_unlock:
> > > +=09calc_load_nohz_remote(cpu);
> > >  =09rq_unlock_irq(rq, &rf);
> >=20
> > This gets skipped when the cpu is idle, so it still misses the update.
>=20
> Oh argh! that's a bit radical of the remote tick. The normal tick runs
> just fine on idle CPUs, so lets mirror that.
>=20
> How's this then?
>=20
> ---
> diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
> index 1abe91ff6e4a..6d67e9a5af6b 100644
> --- a/include/linux/sched/nohz.h
> +++ b/include/linux/sched/nohz.h
> @@ -15,9 +15,11 @@ static inline void nohz_balance_enter_idle(int cpu) { =
}
> =20
>  #ifdef CONFIG_NO_HZ_COMMON
>  void calc_load_nohz_start(void);
> +void calc_load_nohz_remote(struct rq *rq);
>  void calc_load_nohz_stop(void);
>  #else
>  static inline void calc_load_nohz_start(void) { }
> +static inline void calc_load_nohz_remote(struct rq *rq) { }
>  static inline void calc_load_nohz_stop(void) { }
>  #endif /* CONFIG_NO_HZ_COMMON */
> =20
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index eb42b71faab9..d02d1b8f40af 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3660,21 +3660,17 @@ static void sched_tick_remote(struct work_struct
> *work)
>  =09u64 delta;
>  =09int os;
> =20
> -=09/*
> -=09 * Handle the tick only if it appears the remote CPU is running in
> full
> -=09 * dynticks mode. The check is racy by nature, but missing a tick or
> -=09 * having one too much is no big deal because the scheduler tick
> updates
> -=09 * statistics and checks timeslices in a time-independent way,
> regardless
> -=09 * of when exactly it is running.
> -=09 */
> -=09if (idle_cpu(cpu) || !tick_nohz_tick_stopped_cpu(cpu))
> +=09if (!tick_nohz_tick_stopped_cpu(cpu))
>  =09=09goto out_requeue;
> =20
>  =09rq_lock_irq(rq, &rf);
> -=09curr =3D rq->curr;
> -=09if (is_idle_task(curr) || cpu_is_offline(cpu))
> +=09/*
> +=09 * We must not call calc_load_nohz_remote() when not in NOHZ mode.
> +=09 */
> +=09if (cpu_is_offline(cpu) || !tick_nohz_tick_stopped(cpu))
>  =09=09goto out_unlock;

Needs to be tick_nohz_tick_stopped_cpu(cpu)

After fixing that, I get:

[    7.439068] WARNING: CPU: 20 PID: 7 at /home/root/linux/kernel/sched/cor=
e.c:3681 sched_tick_remote+0x132/0x150
[    7.439068] Modules linked in:
[    7.439068] CPU: 20 PID: 7 Comm: kworker/u209:0 Not tainted 5.4.0-rc5.st=
d+ #15
[    7.439068] Hardware name: Intel Corporation S2600BT/S2600BT, BIOS SE5C6=
20.86B.01.00.0763.022420181017 02/24/2018
[    7.439068] Workqueue: events_unbound sched_tick_remote
[    7.446308] pci_bus 0000:9f: resource 1 [mem 0xe6a00000-0xe6bfffff]
[    7.455068] RIP: 0010:sched_tick_remote+0x132/0x150
[    7.455068] Code: 00 e9 b2 fd fe ff 0f 0b e9 46 ff ff ff 83 f8 02 89 c2 =
74 d3 8d 4a ff 89 d0 f0 0f b1 0e 0f 94 c1 84 c9 0f 85 23 ff ff ff eb e3 <0f=
> 0b eb 9a 80 3d 9c d6 2c 01 00 0f 1f 00 0f 85 71 ff ff ff e8 05
[    7.455068] RSP: 0000:ffffc9000c683e58 EFLAGS: 00010002
[    7.455068] RAX: 00000000e7061da1 RBX: ffff8897e026e688 RCX: 0000000181f=
93295
[    7.455068] RDX: 00000000b2d05e00 RSI: ffff8897e0269e50 RDI: 00000000000=
00004
[    7.455068] RBP: ffff8881004c0000 R08: ffff8e8191a2b423 R09: 00000000000=
00000
[    7.455068] R10: 0000000000000010 R11: 0000000000000018 R12: ffff8897e02=
69240
[    7.455068] R13: ffff8897e0240000 R14: 0000000000000000 R15: ffff888107e=
dc2e8
[    7.455068] FS:  0000000000000000(0000) GS:ffff8897e0700000(0000) knlGS:=
0000000000000000
[    7.455068] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.455068] CR2: 0000000000000000 CR3: 000000303e60a001 CR4: 00000000007=
606e0
[    7.455068] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[    7.459338] pci_bus 0000:9f: resource 2 [mem 0x3a0000000000-0x3a00001fff=
ff 64bit pref]
[    7.465068] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[    7.465068] PKRU: 55555554
[    7.465068] Call Trace:
[    7.465068]  process_one_work+0x165/0x3c0
[    7.465068]  worker_thread+0x46/0x3d0
[    7.465068]  kthread+0xf8/0x130
[    7.465068]  ? process_one_work+0x3c0/0x3c0
[    7.476788] pci_bus 0000:a0: resource 1 [mem 0xe6c00000-0xe6dfffff]
[    7.465068]  ? kthread_bind+0x10/0x10
[    7.465068]  ret_from_fork+0x35/0x40

-Scott

