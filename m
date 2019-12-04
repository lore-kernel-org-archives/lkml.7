Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14761C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D5420637
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGCwoAUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfLDIXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:23:11 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36352 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfLDIXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:23:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id n12so240247lfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 00:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iNLZ5EFhyGYEYKe0bk/S6N+Rizxb+dV+RJ9rOKhS1WI=;
        b=XGCwoAUNRn+Bpd6Gdzt+F3qbHh9k8woADTDuQCNJSaVAJgqN05uxvOtaCczux0Dt6R
         A3nCmkkrxzzlrmOl6s9Dywby+QM4jCNREGoSpNfVVXskyq6eKlpDn8Htaj7VS3eTUTWT
         qJ5sFn59lnN/+5irZ4OhJ+eSkH7e9Y218PfCshGZAQcdhAuo9TksX/LXC/zB1aXAI6uV
         ejjXVHArlFuRhPaJeoWmCFyv1NTtT8JqstfEHmlMPZLnDkhnCsM2xA+9038lsTt5/cDD
         Zv1eOXFYcGU4kwnFpDVHF23aI0yKQ+46isfviA08sXOjzO1bfjysrC+i2lyAkxJ4bNjR
         CiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNLZ5EFhyGYEYKe0bk/S6N+Rizxb+dV+RJ9rOKhS1WI=;
        b=IwCY9fQ29crPo5giqpC6fCJZiR3sfPVKCd+yTvCFfSNxPXi3xETXeEh7iaTsEp+cDN
         wL2ari/M1dtgDd/XZdq69J92l97CYjkScr1yIrAQ/CY3dBadRzgotpvnAdJ+6vxGS+to
         cqYcwqUu90uJg70mDW5UNCew/qrItGR9ZT+U0mmWebo9g+5/ysKRb6SqwB7ZWeEhhF7d
         YY11Cf/bzxhp9LZ/jayKHgzgDFQQYNMGtPOJPPabEaYlzCChJEkNu12XJMN9VpuxTDrM
         sHx8Sj2mirT4QD1nAFSynTEREq7hr0gvM0s2LW5NbJt27dDNWj3yWrhggypxFfRqHDdO
         Aqlw==
X-Gm-Message-State: APjAAAU/k+phwyl1A8yjq2HwaE8595lSCg+Y1JOYKImUgeUr41YL4imS
        LmxEQnp/7aue0i5UAsfun94VCABnz2sppjRP9SXPhvM4vFU=
X-Google-Smtp-Source: APXvYqxxAErQTB0mbJc+tPLhqPmL9gLF4ofCWmYAkDTiPj+zfYCerH+It3g2PIVwb/vbx6/J4hCEuke3bZKCzIMe+bU=
X-Received: by 2002:a19:f701:: with SMTP id z1mr1272434lfe.133.1575447788424;
 Wed, 04 Dec 2019 00:23:08 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
 <CAKfTPtAvnLY3brp9iy_aHNu0rMM8nLfgeLc3CXEkMk3bwU1weA@mail.gmail.com>
In-Reply-To: <CAKfTPtAvnLY3brp9iy_aHNu0rMM8nLfgeLc3CXEkMk3bwU1weA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Dec 2019 09:22:56 +0100
Message-ID: <CAKfTPtCvckhXQ97RR5X+QW49RRa0EK8gZV-Ajy8FzVeaw3PccQ@mail.gmail.com>
Subject: Re: Null pointer crash at find_idlest_group on db845c w/ linus/master
To:     John Stultz <john.stultz@linaro.org>
Cc:     Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019 at 09:06, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> Hi John,
>
> On Tue, 3 Dec 2019 at 20:15, John Stultz <john.stultz@linaro.org> wrote:
> >
> > With today's linus/master on db845c running android, I'm able to
> > fairly easily reproduce the following crash. I've not had a chance to
> > bisect it yet, but I'm suspecting its connected to Vincent's recent
> > rework.
>
> Does the crash happen randomly or after a specific action ?
> I have a db845 so I can try to reproduce it locally.
>
> >
> > If you have any suggestions, or need me to test anything, please let me know.
> >
> > thanks
> > -john
> >
> > [  136.157069] Unable to handle kernel NULL pointer dereference at
> > virtual address 0000000000000010
> > [  136.165937] Mem abort info:
> > [  136.168765]   ESR = 0x96000005
> > [  136.171862]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [  136.177229]   SET = 0, FnV = 0
> > [  136.180320]   EA = 0, S1PTW = 0
> > [  136.183502] Data abort info:
> > [  136.186426]   ISV = 0, ISS = 0x00000005
> > [  136.190302]   CM = 0, WnR = 0
> > [  136.193316] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000175f7e000
> > [  136.199814] [0000000000000010] pgd=0000000000000000, pud=0000000000000000
> > [  136.206666] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> > [  136.212295] Modules linked in:
> > [  136.215397] CPU: 7 PID: 50 Comm: kauditd Tainted: G        W
> >  5.4.0-mainline-11225-g9c5add21ff63 #1252

Do you have the sha1 that you use for your test ?
The one above doesn't seem to point on a valid commit in linus/master

> > [  136.225390] Hardware name: Thundercomm Dragonboard 845c (DT)
> > [  136.231111] pstate: 60c00085 (nZCv daIf +PAN +UAO)
> > [  136.235971] pc : find_idlest_group.isra.95+0x368/0x690
> > [  136.241159] lr : find_idlest_group.isra.95+0x210/0x690
> > [  136.246347] sp : ffffffc01036b890
> > [  136.249708] x29: ffffffc01036b890 x28: ffffffe7d7450480
> > [  136.255077] x27: ffffff80f81f0000 x26: 0000000000000000
> > [  136.260445] x25: 0000000000000000 x24: ffffffc01036b998
> > [  136.265810] x23: ffffff80f8e40a00 x22: ffffffe7d7719e30
> > [  136.271175] x21: ffffff80f8f16520 x20: ffffff80f8f16180
> > [  136.276539] x19: ffffffe7d771a610 x18: ffffffe7d71d1ef0
> > [  136.281908] x17: 0000000000000000 x16: 0000000000000000
> > [  136.287274] x15: 0000000000000001 x14: 6f3a753d74786574
> > [  136.292644] x13: 6e6f637420383637 x12: 632c323135633a30
> > [  136.298007] x11: 0000000000000070 x10: 0000000000000002
> > [  136.303371] x9 : 0000000000000000 x8 : 0000000000000075
> > [  136.308737] x7 : ffffff80f8f16000 x6 : ffffffe7d7450000
> > [  136.314099] x5 : 0000000000000004 x4 : 0000000000000000
> > [  136.319465] x3 : 000000000000025c x2 : ffffff80f8f16780
> > [  136.324836] x1 : 0000000000000000 x0 : 0000000000000002
> > [  136.330198] Call trace:
> > [  136.332680]  find_idlest_group.isra.95+0x368/0x690
> > [  136.337528]  select_task_rq_fair+0x4e4/0xd88
> > [  136.341848]  try_to_wake_up+0x21c/0x7f8
> > [  136.345735]  default_wake_function+0x34/0x48
> > [  136.350053]  pollwake+0x98/0xc8
> > [  136.353233]  __wake_up_common+0x90/0x158
> > [  136.357202]  __wake_up_common_lock+0x88/0xd0
> > [  136.361519]  __wake_up_sync_key+0x40/0x50
> > [  136.365584]  sock_def_readable+0x44/0x78
> > [  136.369560]  __netlink_sendskb+0x44/0x58
> > [  136.373525]  netlink_unicast+0x220/0x258
> > [  136.377496]  kauditd_send_queue+0xa4/0x158
> > [  136.381643]  kauditd_thread+0xf4/0x248
> > [  136.385438]  kthread+0x130/0x138
> > [  136.388706]  ret_from_fork+0x10/0x1c
> > [  136.392332] Code: 54001340 7100081f 540016e1 a9478ba1 (f9400821)
> > [  136.398493] ---[ end trace 47d254973801b2c4 ]---
> > [  136.403162] Kernel panic - not syncing: Fatal exception
> > [  136.408445] SMP: stopping secondary CPUs
> > [  136.412440] Kernel Offset: 0x27c6200000 from 0xffffffc010000000
> > [  136.418417] PHYS_OFFSET: 0xffffffe140000000
> > [  136.422655] CPU features: 0x00002,2a80a218
