Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F840C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 01:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F5A24249
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 01:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Brpl0pHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfK3BmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 20:42:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39576 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfK3BmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 20:42:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so10153075wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 17:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vOLjKVo8ueA2YbXi3fZ4PuqiyQNm4BjfA1BtTT0sKxw=;
        b=Brpl0pHW0spKzBZZ9YRMJmC1tYZua+wog5q2An1I0VUbCrzAyaKLHQogB3AlwOHN8M
         dRvmqZySU+MaM6xoljs1rCemUpz/dxN8XcwqHhrlA+Yfms7/w9fP2Y+Cu2zi9sRb8wmh
         I9kO4vDDhseKBKFReWzZbNIKZPn1aWNciLL3cE6jHeD8btmErITAqqqBx/mlvRw+CQ7l
         +VFOIVg5MMcTOoRwuwkWgaNcjABeaB1X+snB2soTF4zk6W5QtFITqDGmoRsHv/Fpj55x
         +DkLAlAgjBwx+BdY/k/sNPZyEvgEnSoUe4JyVIavOhtKCMIZIs/o/HJyt0JxoXMjy0NT
         pIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vOLjKVo8ueA2YbXi3fZ4PuqiyQNm4BjfA1BtTT0sKxw=;
        b=WjAn0v6J2tgVDGZFoRi/AkqWKr3Z/8Kf/Kmm/Geaxr954W4RWCChWyBa1jR0wLQRZ0
         ow1dvJG7VTC6E4NgfwhH5oBXd4Qo7F+75Ca3XBQ9v0XSmV4NskJghpyxLdmO9EZpH54x
         CJLGoqq96W7k0ckVLGtJPA5PQIgOC4J+jtfcWsOAUerm6Z7zX+MAoZfK/RHqyD+6+xUd
         xFFibYL8qkdhqbqTntblWZ5BpEvIaBYE0G4SuRewr7rOUvmCJkchur5O4G/NW+gciIbi
         CacbYu92tS7NF5dQiuMuh96rymr7wiYxVyysm5qD/glm7PaAAqSty65Po7nou8vGzY4g
         4wgA==
X-Gm-Message-State: APjAAAUkBqV+t7wydrbMM22ihk8nC5REK0DzAPLtfhZfZoqTgXuDaA1r
        vZiCRYsV6KYGM1ge97Z3cUpKE3Wejk+YuaIQM2FYSA==
X-Google-Smtp-Source: APXvYqzcpopDJdLGG8FgUi6/mXwnfqe5AJBHmEvXYEknULRy5xwtP7ZS0unjEbN8IsoaehV3V40XOdF9y/6TIHs1mE4=
X-Received: by 2002:a7b:c303:: with SMTP id k3mr17656620wmj.102.1575078126014;
 Fri, 29 Nov 2019 17:42:06 -0800 (PST)
MIME-Version: 1.0
References: <C377A5F1-F86F-4A27-966F-0285EC6EA934@linux.alibaba.com>
 <20191112154144.GC168812@cmpxchg.org> <20191112154844.GD168812@cmpxchg.org>
 <20191112160821.GE168812@cmpxchg.org> <D25F9D3F-AA65-4BC1-B2CE-EECD2F49AE03@linux.alibaba.com>
In-Reply-To: <D25F9D3F-AA65-4BC1-B2CE-EECD2F49AE03@linux.alibaba.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 29 Nov 2019 17:41:55 -0800
Message-ID: <CAJuCfpGFDEMDhy-YQQMmrCeVtqH1hj3J1DZ497K3Ttw0U7osJw@mail.gmail.com>
Subject: Re: [PATCH] psi:fix divide by zero in psi_update_stats
To:     Jingfeng Xie <xiejingfeng@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        =?UTF-8?B?6b2Q5rGfKOeqhem7mCk=?= <qijiang.qj@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 10:37 PM Jingfeng Xie
<xiejingfeng@linux.alibaba.com> wrote:
>
> Weiner,
> The crash does not happen right after boot, in my case,  it happens in 58=
914 ~ 815463 seconds range since boot
>
> With my coredump=EF=BC=8Csome values are extracted as below=EF=BC=9A
>
> period =3D 001df2dc00000000
> now =3D 001df2dc00000000=EF=BC=8C same as period
> expires =3D group->next_update =3D rdi =3D 00003594f700648e
> group->avg_last_update  could not be known
> missed_periods =3D 0
>
Considering that "period =3D now - (group->avg_last_update +
(missed_periods * psi_period))" and the above values (period=3D=3Dnow and
missed_periods=3D=3D0), group->avg_last_update must be 0 and that would
mean this is indeed the first update_averages() call.
I think this can happen if a cgroup is created long after the boot.
The following call chain would happen:
cgroup_create->psi_cgroup_alloc->group_init->INIT_DELAYED_WORK->psi_avgs_wo=
rk->update_averages.
If this cgroup creation is timed so that psi_avgs_work is called when
sched_clock returns a value with LSBs of 0 then we get this problem.
The patch Johannes posted earlier which sets group->avg_last_update to
sched_clock in group_init should have fixed this problem. Tim, did you
capture this coredump after applying that patch? If not please try
applying it and see if it still happens.


> =EF=BB=BF=E5=9C=A8 2019/11/13 =E4=B8=8A=E5=8D=8812:08=EF=BC=8C=E2=80=9CJo=
hannes Weiner=E2=80=9D<hannes@cmpxchg.org> =E5=86=99=E5=85=A5:
>
>     On Tue, Nov 12, 2019 at 10:48:46AM -0500, Johannes Weiner wrote:
>     > On Tue, Nov 12, 2019 at 10:41:46AM -0500, Johannes Weiner wrote:
>     > > On Fri, Nov 08, 2019 at 03:33:24PM +0800, tim wrote:
>     > > > In psi_update_stats, it is possible that period has value like
>     > > > 0xXXXXXXXX00000000 where the lower 32 bit is 0, then it calls d=
iv_u64 which
>     > > > truncates u64 period to u32, results in zero divisor.
>     > > > Use div64_u64() instead of div_u64()  if the divisor is u64 to =
avoid
>     > > > truncation to 32-bit on 64-bit platforms.
>     > > >
>     > > > Signed-off-by: xiejingfeng <xiejingfeng@linux.alibaba.com>
>     > >
>     > > This is legit. When we stop the periodic averaging worker due to =
an
>     > > idle CPU, the period after restart can be much longer than the ~4=
 sec
>     > > in the lower 32 bits. See the missed_periods logic in update_aver=
ages.
>     >
>     > Argh, that's not right. Of course I notice right after hitting send=
.
>     >
>     > missed_periods are subtracted out of the difference between now and
>     > the last update, so period should be not much bigger than 2s.
>     >
>     > Something else is going on here.
>
>     Tim, does this happen right after boot? I wonder if it's because we'r=
e
>     not initializing avg_last_update, and the initial delta between the
>     last update (0) and the first scheduled update (sched_clock() + 2s)
>     ends up bigger than 4 seconds somehow. Later on, the delta between th=
e
>     last and the scheduled update should always be ~2s. But for that to
>     happen, it would require a pretty slow boot, or a sched_clock() that
>     does not start at 0.
>
>     Tim, if you have a coredump, can you extract the value of the other
>     variables printed in the following patch?
>
>     diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>     index 84af7aa158bf..1b6836d23091 100644
>     --- a/kernel/sched/psi.c
>     +++ b/kernel/sched/psi.c
>     @@ -374,6 +374,10 @@ static u64 update_averages(struct psi_group *gro=
up, u64 now)
>          */
>         avg_next_update =3D expires + ((1 + missed_periods) * psi_period)=
;
>         period =3D now - (group->avg_last_update + (missed_periods * psi_=
period));
>     +
>     +   WARN(period >> 32, "period=3D%ld now=3D%ld expires=3D%ld last=3D%=
ld missed=3D%ld\n",
>     +        period, now, expires, group->avg_last_update, missed_periods=
);
>     +
>         group->avg_last_update =3D now;
>
>         for (s =3D 0; s < NR_PSI_STATES - 1; s++) {
>
>     And we may need something like this to make the tick initialization
>     more robust regardless of the reported bug here:
>
>     diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>     index 84af7aa158bf..ce8f6748678a 100644
>     --- a/kernel/sched/psi.c
>     +++ b/kernel/sched/psi.c
>     @@ -185,7 +185,8 @@ static void group_init(struct psi_group *group)
>
>         for_each_possible_cpu(cpu)
>                 seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
>     -   group->avg_next_update =3D sched_clock() + psi_period;
>     +   group->avg_last_update =3D sched_clock();
>     +   group->avg_next_update =3D group->avg_last_update + psi_period;
>         INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
>         mutex_init(&group->avgs_lock);
>         /* Init trigger-related members */
>
>
>
>
