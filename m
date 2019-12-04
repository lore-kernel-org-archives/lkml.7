Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEF3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 03:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B083F2073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 03:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYG5iTO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfLDDqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 22:46:25 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45108 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfLDDqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 22:46:25 -0500
Received: by mail-oi1-f195.google.com with SMTP id v10so3495488oiv.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 19:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCC0P6sewyoGc9ajO655j+2un+o+YPosg6IwylBf0ig=;
        b=oYG5iTO2umQI4lTtVN3JCvwMMgGXrMOi+Uvkw++7E14mlCpl8AY7x1+8ObCOBsxDIJ
         CbyVrqz1AKkICa32ERW4Q0Qh1EHjt0vijU4iLoaNwNJ83P+fUWZjQtLtBGJ/iKiqgstd
         O9rgW+zUQrLmcVs4cJ1V40fwoE+KGyn1E16E58w/ZplkNDYl3cV+9D0EM+g0lY4KwWgL
         YdQXzmSOkqUlBxG5rNdIQLRk3wpLWVwJNPk5ukBR3F30rIRuvyCvM1LV2UFicNcFzvbH
         KFsvNcthTFWFXdj9Pga+w4LyHvpCKlTjD9xqfNQ5pndA89pYlDhPvu/ZCdsB9dRDLXUI
         AdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCC0P6sewyoGc9ajO655j+2un+o+YPosg6IwylBf0ig=;
        b=HAAsANAifFAZVSXD5Jequp4neaO1i4v7FkACl7CwlAPrxbZe1lv/tWkQt4BvAQix4A
         +Pfk27SzOZ+M9fjJPJCILXt8wWY0NcMKxaTja1cH/TMqLLuxfFJUPRqcSG/EWMdJ6WO6
         lMJuPF90kyKTa5wHGqg6xkMjc+kzKltcu+k7wTumKpRs9D/rhLE13DBGbOPyFmf+4oCD
         1+CHUGjs+/xOtrwNbxJfHqBYF505hBvKTaWF7iEtgur5ul+BvLpRzsjuaQhiJQSPWDBx
         aArPo3iSS/0CiquaugxK/jyDdG1ca2QCojgyM1Cs715lYXN0llJ+tVAvrJ2UOoICZoYl
         Ni9Q==
X-Gm-Message-State: APjAAAWmu3JXwOYb27QPYcpIEH/Z8e+EUlTD/C+mY0RtqrS1HBMf1ISU
        3uPci3eMp63hfOFyJlPBYztXLSXIkXXoEEBpD3IWBg==
X-Google-Smtp-Source: APXvYqzVBcm0/ioRNXWoP9xvCyOHRPmgECgeMJZZA53BLvAeGcSs4XlRj9Lq/YQg0xmv6W3J9tAT4H3tgVFZAzd1ywE=
X-Received: by 2002:aca:ab95:: with SMTP id u143mr965585oie.128.1575431183889;
 Tue, 03 Dec 2019 19:46:23 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
 <c61cf647-ecb6-b9fa-51f2-8efa36134757@arm.com> <14a8e456-1f89-0dff-ae89-61e8b6d5593b@arm.com>
 <7548a890-d32b-7e7d-4f84-4ebf635c3e8a@arm.com>
In-Reply-To: <7548a890-d32b-7e7d-4f84-4ebf635c3e8a@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 3 Dec 2019 19:46:12 -0800
Message-ID: <CALAqxLVDaiJWd7W5+FBKs=Mq8AHw52fApPc_Xu2gTq9DTn0vgQ@mail.gmail.com>
Subject: Re: Null pointer crash at find_idlest_group on db845c w/ linus/master
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 4:13 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 03/12/2019 23:49, Valentin Schneider wrote:
> > On 03/12/2019 23:20, Valentin Schneider wrote:
> >> Looking at the code, I think I got it. In find_idlest_group() we do
> >> initialize 'idlest_sgs' (just like busiest_stat in LB) but 'idlest' is just
> >> NULL. The latter is dereferenced in update_pick_idlest() just for the misfit
> >> case, which goes boom. And I reviewed the damn thing... Bleh.
> >>
> >> Fixup looks easy enough, lemme write one up.
> >>
> >
> > Wait no, that can't be right. We can only get in there if both 'group' and
> > 'idlest' have the same group_type, which can't be true on the first pass.
> > So if we go through the misfit stuff, idlest *has* to be set to something.
> > Bah.
> >
>
> So I think the thing really is dying on a sched_group->sgc deref (pahole says
> sgc is at offset #16), which means we have a NULL sched_group somewhere, but
> I don't see how. That can either be 'local' (can't be, first group we visit
> and doesn't go through update_pick_idlest()) or 'idlest' (see previous email).
>
> Now, it's bedtime for me, if you get the chance in the meantime can you give
> this a shot? I was about to send it out but realized it didn't really make
> sense, but you never know...
>
> Also, if it is indeed misfit related, I'm surprised we (Arm folks) haven't
> hit it sooner. We've had our scheduler tests running on the LB rework for at
> least a month, so we should've hit it.
>
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e97a01..e19ab7bff0f3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8348,7 +8348,14 @@ static bool update_pick_idlest(struct sched_group *idlest,
>                 return false;
>
>         case group_misfit_task:
> -               /* Select group with the highest max capacity */
> +               /*
> +                * Select group with the highest max capacity. First group we
> +                * visit gets picked as idlest to allow later capacity
> +                * comparisons.
> +                */
> +               if (!idlest)
> +                       return true;
> +
>                 if (idlest->sgc->max_capacity >= group->sgc->max_capacity)
>                         return false;
>                 break;

Thanks for the quick patch! Unfortunately I still managed to trip it
with this patch :(

thanks
-john

[  191.807900] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000010
[  191.814822] audit: audit_lost=284 audit_rate_limit=5 audit_backlog_limit=64
[  191.816779] Mem abort info:
[  191.816782]   ESR = 0x96000005
[  191.816786]   EC = 0x25: DABT (current EL), IL = 32 bits
[  191.816789]   SET = 0, FnV = 0
[  191.816791]   EA = 0, S1PTW = 0
[  191.816793] Data abort info:
[  191.816797]   ISV = 0, ISS = 0x00000005
[  191.816799]   CM = 0, WnR = 0
[  191.816804] user pgtable: 4k pages, 39-bit VAs, pgdp=00000001719fc000
[  191.816809] [0000000000000010] pgd=0000000000000000, pud=0000000000000000
[  191.823849] audit: rate limit exceeded
[  191.826660] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[  191.873941] Modules linked in:
[  191.877043] CPU: 7 PID: 50 Comm: kauditd Tainted: G        W
 5.4.0-mainline-11226-g81d7081fb03e #1276
[  191.887039] Hardware name: Thundercomm Dragonboard 845c (DT)
[  191.892751] pstate: 60c00085 (nZCv daIf +PAN +UAO)
[  191.897612] pc : find_idlest_group.isra.95+0x368/0x690
[  191.902809] lr : find_idlest_group.isra.95+0x104/0x690
[  191.908002] sp : ffffffc01036b890
[  191.911356] x29: ffffffc01036b890 x28: ffffffe471250480
[  191.916720] x27: ffffff80f1828000 x26: 0000000000000001
[  191.922082] x25: 0000000000000000 x24: ffffffc01036b998
[  191.927447] x23: ffffff80f8e41a00 x22: ffffffe471519e30
[  191.932811] x21: ffffff80f8f16aa0 x20: ffffff80f8f16e80
[  191.938173] x19: ffffffe47151a610 x18: ffffffe470fd1ef0
[  191.943543] x17: 0000000000000000 x16: 0000000000000000
[  191.948912] x15: 0000000000000001 x14: 632c323135633a30
[  191.954275] x13: 733a656c69665f61 x12: 7461645f7070613a
[  191.959636] x11: 0000000000000730 x10: 000000000000025d
[  191.964998] x9 : 0000000000003b15 x8 : 0000000000000075
[  191.970361] x7 : ffffff80f8f16200 x6 : ffffffe471250000
[  191.975728] x5 : 0000000000000000 x4 : 0000000000000008
[  191.981090] x3 : ffffff80f8f16100 x2 : ffffff80f8f16d00
[  191.986452] x1 : 0000000000000000 x0 : 0000000000000002
[  191.991815] Call trace:
[  191.994309]  find_idlest_group.isra.95+0x368/0x690
[  191.999155]  select_task_rq_fair+0x4e4/0xd88
[  192.003476]  try_to_wake_up+0x21c/0x7f8
[  192.007353]  default_wake_function+0x34/0x48
[  192.011675]  pollwake+0x98/0xc8
[  192.014863]  __wake_up_common+0x90/0x158
[  192.018838]  __wake_up_common_lock+0x88/0xd0
[  192.023163]  __wake_up_sync_key+0x40/0x50
[  192.027228]  sock_def_readable+0x44/0x78
[  192.031197]  __netlink_sendskb+0x44/0x58
[  192.035170]  netlink_unicast+0x220/0x258
[  192.039143]  kauditd_send_queue+0xa4/0x158
[  192.043292]  kauditd_thread+0xf4/0x248
[  192.047085]  kthread+0x130/0x138
[  192.050355]  ret_from_fork+0x10/0x1c
[  192.053984] Code: 54001260 7100081f 54001601 a9478ba1 (f9400821)
[  192.060141] ---[ end trace c650b8d609e54a39 ]---
[  192.064812] Kernel panic - not syncing: Fatal exception
