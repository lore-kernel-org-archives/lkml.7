Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E24C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8088320659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kaxcDrSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfLDIGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:06:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42266 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfLDIGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:06:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id e28so6935856ljo.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 00:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z35jQ7RUTBYlGTWaAX5Qsptk6KxjQifiDNPSX1mkD6o=;
        b=kaxcDrSjizEWyBFrFOMstWK51gUABgdq683eaSYkDUt7NWqPd2AjUehn8wiV8kbYcm
         qdTi914OZARpw3un8uH66m20bJjJHMEa4FqtbFZ3MLtgCWIV2OTZjDWHa2OWFWgNAgE+
         h1lSexprfgiB4BGXaJJY3R5gIFWhFoVP1e8egUr9TLV6Q7GAnNfS0dJkTZauUtpepy1s
         Xioar33zLVkEmYPnUa5VNgjYNjr5o/YNgFnCHFDBgefllR/HZBaMcKoCg5C3o4p/04tM
         ITBnRb+h62tHOnOTMRg78UMPm0QaY3T0zxrGLovZ3pl1FYF5/xrY+Xah2nO0RJed7Grb
         ANlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z35jQ7RUTBYlGTWaAX5Qsptk6KxjQifiDNPSX1mkD6o=;
        b=uhB2hP+uE4DBtKpLlneYeAwJ/yu88q8zzdWaIImK5G7lD3qH094tBA0u6tSqGx5J70
         IAbBlYouEO6ouWH4v4sqGMD21sravq9J7trHAhWL1bh8a5OMXHMR5/rLnYBQRvhhx8Os
         CZIBzPFv40snIoNjt/FEbOO/0JIu0fJT0xf2LVOYSxDMqevWCOOF/R1/sQvhcydrlOCX
         8eu8kBR1vG0YV7vLEpllZKDzGOveGkJ5S7AIxSRtxsPpuzGnMAgsVmiUJLAWI6XR8+BA
         sfPOrOcGF41QiIAE3eAtgR1ubwWlNwTJTCwkfv+NQX7E3XbO8komT0bPqIoPJbpdy+wQ
         MJDA==
X-Gm-Message-State: APjAAAV/fJTHJ20jTuyoFeH20ihEA/z+ccJ2YP5yjBGkMA7ficcnO4JS
        AEDl9zR86O4SWTzX0vPR9he01PNCcewgjcySrhU9fkAp
X-Google-Smtp-Source: APXvYqzt++sihRdLcnlYHBs7rEtMol78F6WcvpY3PVq57/n+Z5aRq7gNAmiLSSwAcMHJdJyXs80hlyvjz3ccpvVsWeA=
X-Received: by 2002:a2e:9a04:: with SMTP id o4mr1157186lji.214.1575446801534;
 Wed, 04 Dec 2019 00:06:41 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
In-Reply-To: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Dec 2019 09:06:29 +0100
Message-ID: <CAKfTPtAvnLY3brp9iy_aHNu0rMM8nLfgeLc3CXEkMk3bwU1weA@mail.gmail.com>
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

Hi John,

On Tue, 3 Dec 2019 at 20:15, John Stultz <john.stultz@linaro.org> wrote:
>
> With today's linus/master on db845c running android, I'm able to
> fairly easily reproduce the following crash. I've not had a chance to
> bisect it yet, but I'm suspecting its connected to Vincent's recent
> rework.

Does the crash happen randomly or after a specific action ?
I have a db845 so I can try to reproduce it locally.

>
> If you have any suggestions, or need me to test anything, please let me know.
>
> thanks
> -john
>
> [  136.157069] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000010
> [  136.165937] Mem abort info:
> [  136.168765]   ESR = 0x96000005
> [  136.171862]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  136.177229]   SET = 0, FnV = 0
> [  136.180320]   EA = 0, S1PTW = 0
> [  136.183502] Data abort info:
> [  136.186426]   ISV = 0, ISS = 0x00000005
> [  136.190302]   CM = 0, WnR = 0
> [  136.193316] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000175f7e000
> [  136.199814] [0000000000000010] pgd=0000000000000000, pud=0000000000000000
> [  136.206666] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [  136.212295] Modules linked in:
> [  136.215397] CPU: 7 PID: 50 Comm: kauditd Tainted: G        W
>  5.4.0-mainline-11225-g9c5add21ff63 #1252
> [  136.225390] Hardware name: Thundercomm Dragonboard 845c (DT)
> [  136.231111] pstate: 60c00085 (nZCv daIf +PAN +UAO)
> [  136.235971] pc : find_idlest_group.isra.95+0x368/0x690
> [  136.241159] lr : find_idlest_group.isra.95+0x210/0x690
> [  136.246347] sp : ffffffc01036b890
> [  136.249708] x29: ffffffc01036b890 x28: ffffffe7d7450480
> [  136.255077] x27: ffffff80f81f0000 x26: 0000000000000000
> [  136.260445] x25: 0000000000000000 x24: ffffffc01036b998
> [  136.265810] x23: ffffff80f8e40a00 x22: ffffffe7d7719e30
> [  136.271175] x21: ffffff80f8f16520 x20: ffffff80f8f16180
> [  136.276539] x19: ffffffe7d771a610 x18: ffffffe7d71d1ef0
> [  136.281908] x17: 0000000000000000 x16: 0000000000000000
> [  136.287274] x15: 0000000000000001 x14: 6f3a753d74786574
> [  136.292644] x13: 6e6f637420383637 x12: 632c323135633a30
> [  136.298007] x11: 0000000000000070 x10: 0000000000000002
> [  136.303371] x9 : 0000000000000000 x8 : 0000000000000075
> [  136.308737] x7 : ffffff80f8f16000 x6 : ffffffe7d7450000
> [  136.314099] x5 : 0000000000000004 x4 : 0000000000000000
> [  136.319465] x3 : 000000000000025c x2 : ffffff80f8f16780
> [  136.324836] x1 : 0000000000000000 x0 : 0000000000000002
> [  136.330198] Call trace:
> [  136.332680]  find_idlest_group.isra.95+0x368/0x690
> [  136.337528]  select_task_rq_fair+0x4e4/0xd88
> [  136.341848]  try_to_wake_up+0x21c/0x7f8
> [  136.345735]  default_wake_function+0x34/0x48
> [  136.350053]  pollwake+0x98/0xc8
> [  136.353233]  __wake_up_common+0x90/0x158
> [  136.357202]  __wake_up_common_lock+0x88/0xd0
> [  136.361519]  __wake_up_sync_key+0x40/0x50
> [  136.365584]  sock_def_readable+0x44/0x78
> [  136.369560]  __netlink_sendskb+0x44/0x58
> [  136.373525]  netlink_unicast+0x220/0x258
> [  136.377496]  kauditd_send_queue+0xa4/0x158
> [  136.381643]  kauditd_thread+0xf4/0x248
> [  136.385438]  kthread+0x130/0x138
> [  136.388706]  ret_from_fork+0x10/0x1c
> [  136.392332] Code: 54001340 7100081f 540016e1 a9478ba1 (f9400821)
> [  136.398493] ---[ end trace 47d254973801b2c4 ]---
> [  136.403162] Kernel panic - not syncing: Fatal exception
> [  136.408445] SMP: stopping secondary CPUs
> [  136.412440] Kernel Offset: 0x27c6200000 from 0xffffffc010000000
> [  136.418417] PHYS_OFFSET: 0xffffffe140000000
> [  136.422655] CPU features: 0x00002,2a80a218
