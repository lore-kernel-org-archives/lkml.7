Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8F6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAD92173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgZIIaAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfCMFzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 01:55:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40356 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfCMFzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 01:55:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id u68so506133lff.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 22:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d40KNppMaBT/g708zVY+qcTWAJj1qLsNUSyVeEhBo2g=;
        b=RgZIIaAgsduYxLuS+2f09gmj0Xy4p6i4G4iAx3RCFLu+zaRV8uiKnozx5TaH8zIgM9
         MZGLDakp0Uu6p8ZSrd8tcF7pgfsYFF+30DB31QmuJWzX083r7plab4FJ06I9R1aXz7dz
         E8wSaW7TiTetYvUfwf60IprcBjUMUcX+PNQmfXWkSXZZF3UpRsLRVLb9Uch2lNcubwWL
         YNuT0h70v18ZTwWGjMswN2tUA/WTpHfx3ftAD5Q97gk2w1CiG7l0PuE+Jda9a99l09qW
         t8DhNDU6L9sPOmUdu1DV89IXhN0OiBksHmfKuH3oSYSz2e3tvBXcDveo1jxIX5FdVb0n
         IZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d40KNppMaBT/g708zVY+qcTWAJj1qLsNUSyVeEhBo2g=;
        b=MqpUBii5Ff7/cJ/uQ5m5WNNiM+7YvFTTEI+K1Qp0vyBdxKy7mAPWX+UeXJ5TvRP5oh
         CGW/Pnd69rN7RgG0D+SDWEBE/L6GMfjMEL5MrgZ3OQjd+6WB88h4MPPUIr6/eHFlHrNG
         w/zDu2W8EOmo9x8Nn5J7zMgMSuf3Rjsk6p/Qz/AGZZzoy/jKLNvQZPp8H+gatGZ4qUoR
         nc7UcbxYSh0RzpttBDAFpJ24+zwsoXXj7P+vR/+69bO5ZDYcAVgLIBMhdTD8vQJdR/Da
         Grpu0rouUUM+DfJGwa6x95WnNPRJdFvvGhfBtj5xFo0L8WewuA3N/eqiunLJQv6TN9In
         aOkw==
X-Gm-Message-State: APjAAAW4dMpV1u44j0hHg6x7JjC4G/kVJftvG9AQV17yJYYOrDpfCxxQ
        6M2HScejon3R+jn+u2j3Fpf6sBGdnYJ570KDJ0Y=
X-Google-Smtp-Source: APXvYqx7taVzSMy+rLW0caZFJB3Ey0GXHzwn7b2Zc7yUI9rAz5SUgfUuL99qb2wuqGVWnLyIXUVrjX+qaWz8zU9kJwc=
X-Received: by 2002:ac2:53ab:: with SMTP id j11mr1113089lfh.49.1552456536117;
 Tue, 12 Mar 2019 22:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190218165620.383905466@infradead.org> <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190222124544.GY9565@techsingularity.net> <14a9adf7-9b50-1dfa-0c35-d04e976081c2@oracle.com>
 <CAERHkru9DzvszvdGHWp8PhEAqeUc-wVR1Gey-KtQ6aMRLx68bQ@mail.gmail.com>
 <19d5d492-a4c1-b3c8-cae4-da2fdfcb872b@oracle.com> <ac10b8fd-da1a-2cc2-afee-4e2b9b4278ee@oracle.com>
 <CAERHkrvjOfVz9xGWZOTGvcUcMETyBdQ2NPj-0USQNU1QTDXR3Q@mail.gmail.com>
In-Reply-To: <CAERHkrvjOfVz9xGWZOTGvcUcMETyBdQ2NPj-0USQNU1QTDXR3Q@mail.gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Wed, 13 Mar 2019 13:55:24 +0800
Message-ID: <CAERHkrvgMNf2rmQ_pF5S7Wq64fnkW4HzP_VYPL4vQWyKgHPgxA@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Fr?d?ric Weisbecker" <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 3:45 PM Aubrey Li <aubrey.intel@gmail.com> wrote:
>
> On Tue, Mar 12, 2019 at 7:36 AM Subhra Mazumdar
> <subhra.mazumdar@oracle.com> wrote:
> >
> >
> > On 3/11/19 11:34 AM, Subhra Mazumdar wrote:
> > >
> > > On 3/10/19 9:23 PM, Aubrey Li wrote:
> > >> On Sat, Mar 9, 2019 at 3:50 AM Subhra Mazumdar
> > >> <subhra.mazumdar@oracle.com> wrote:
> > >>> expected. Most of the performance recovery happens in patch 15 which,
> > >>> unfortunately, is also the one that introduces the hard lockup.
> > >>>
> > >> After applied Subhra's patch, the following is triggered by enabling
> > >> core sched when a cgroup is
> > >> under heavy load.
> > >>
> > > It seems you are facing some other deadlock where printk is involved.
> > > Can you
> > > drop the last patch (patch 16 sched: Debug bits...) and try?
> > >
> > > Thanks,
> > > Subhra
> > >
> > Never Mind, I am seeing the same lockdep deadlock output even w/o patch
> > 16. Btw
> > the NULL fix had something missing,
>
> One more NULL pointer dereference:
>
> Mar 12 02:24:46 aubrey-ivb kernel: [  201.916741] core sched enabled
> [  201.950203] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000008
> [  201.950254] ------------[ cut here ]------------
> [  201.959045] #PF error: [normal kernel read fault]
> [  201.964272] !se->on_rq
> [  201.964287] WARNING: CPU: 22 PID: 2965 at kernel/sched/fair.c:6849
> set_next_buddy+0x52/0x70

A quick workaround below:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d0dac4fd94f..ef6acfe2cf7d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6834,7 +6834,7 @@ static void set_last_buddy(struct sched_entity *se)
                return;

        for_each_sched_entity(se) {
-               if (SCHED_WARN_ON(!se->on_rq))
+               if (SCHED_WARN_ON(!(se && se->on_rq))
                        return;
                cfs_rq_of(se)->last = se;
        }
@@ -6846,7 +6846,7 @@ static void set_next_buddy(struct sched_entity *se)
                return;

        for_each_sched_entity(se) {
-               if (SCHED_WARN_ON(!se->on_rq))
+               if (SCHED_WARN_ON(!(se && se->on_rq))
                        return;
                cfs_rq_of(se)->next = se;
        }

And now I'm running into a hard LOCKUP:

[  326.336279] NMI watchdog: Watchdog detected hard LOCKUP on cpu 31
[  326.336280] Modules linked in: ipt_MASQUERADE xfrm_user xfrm_algo
iptable_nat nf_nat_ipv4 xt_addrtype iptable_filter ip_tables
xt_conntrack x_tables nf_nat nf_conntracki
[  326.336311] irq event stamp: 164460
[  326.336312] hardirqs last  enabled at (164459):
[<ffffffff810c7a97>] sched_core_balance+0x247/0x470
[  326.336312] hardirqs last disabled at (164460):
[<ffffffff810c7963>] sched_core_balance+0x113/0x470
[  326.336313] softirqs last  enabled at (164250):
[<ffffffff81e00359>] __do_softirq+0x359/0x40a
[  326.336314] softirqs last disabled at (164213):
[<ffffffff81095be1>] irq_exit+0xc1/0xd0
[  326.336315] CPU: 31 PID: 0 Comm: swapper/31 Tainted: G          I
    5.0.0-rc8-00542-gd697415be692-dirty #15
[  326.336316] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
SE5C600.86B.99.99.x058.082120120902 08/21/2012
[  326.336317] RIP: 0010:native_queued_spin_lock_slowpath+0x18f/0x1c0
[  326.336318] Code: c1 ee 12 83 e0 03 83 ee 01 48 c1 e0 05 48 63 f6
48 05 80 51 1e 00 48 03 04 f5 40 58 39 82 48 89 10 8b 42 08 85 c0 75
09 f3 90 <8b> 42 08 85 c0 74 f7 4b
[  326.336318] RSP: 0000:ffffc9000643bd58 EFLAGS: 00000046
[  326.336319] RAX: 0000000000000000 RBX: ffff888c0ade4400 RCX: 0000000000800000
[  326.336320] RDX: ffff88980bbe5180 RSI: 0000000000000019 RDI: ffff888c0ade4400
[  326.336321] RBP: ffff888c0ade4400 R08: 0000000000800000 R09: 00000000001e3a80
[  326.336321] R10: ffffc9000643bd08 R11: 0000000000000000 R12: 0000000000000000
[  326.336322] R13: 0000000000000000 R14: ffff88980bbe4400 R15: 000000000000001f
[  326.336323] FS:  0000000000000000(0000) GS:ffff88980ba00000(0000)
knlGS:0000000000000000
[  326.336323] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  326.336324] CR2: 00007fdcd7fd7728 CR3: 00000017e821a001 CR4: 00000000000606e0
[  326.336325] Call Trace:
[  326.336325]  do_raw_spin_lock+0xab/0xb0
[  326.336326]  _raw_spin_lock+0x4b/0x60
[  326.336326]  double_rq_lock+0x99/0x140
[  326.336327]  sched_core_balance+0x11e/0x470
[  326.336327]  __balance_callback+0x49/0xa0
[  326.336328]  __schedule+0x1113/0x1570
[  326.336328]  schedule_idle+0x1e/0x40
[  326.336329]  do_idle+0x16b/0x2a0
[  326.336329]  cpu_startup_entry+0x19/0x20
[  326.336330]  start_secondary+0x17f/0x1d0
[  326.336331]  secondary_startup_64+0xa4/0xb0
[  330.959367] ---[ end Kernel panic - not syncing: Hard LOCKUP ]---
