Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD7BC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 11:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BD5206C1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 11:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKecNiZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfD1L6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 07:58:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35315 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfD1L6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 07:58:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so3761192plp.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 04:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=IeOnONrtver1MD2WPVtA6mysSKyj7q95Wk8MLKHWD3E=;
        b=TKecNiZBRAsU2vwtdrDGGXFS5IYV9z9Nx2DEIriiBRdFcnvSgqQ9z1ilkKagCQG3rT
         o4Qf92I/2I8wNDWhuTsEeF4kzgOyD+UVNu/iW3Nm1+Jlu7Pnve7o0x3MomNC3y55kKjM
         vHq861ogUlbJ5Nmddt1YZMt2L2MpyB8ReoiFKGCihjcOAFeYCQi3OXwBD125TTv5AmNg
         9/c0VL17bSoIhjHh1CjjD40rO0Xur9Vd9OUmKUujJXfkxENJx6n6reH9HhTr7snHP+Bz
         GqI1pZrpDGs34FZKKuV0AjJe9pXo4ij1dQcd85Xr8moz2zGfdRFegsdbiTv9AjIGJznK
         bk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=IeOnONrtver1MD2WPVtA6mysSKyj7q95Wk8MLKHWD3E=;
        b=RVygv0E5IVXC51iCKimV83EuZEGyEyFIdPjTCJe+SRwQhLXQnunBmGZSIdPv4bl0+u
         VHwjpLaI9VzsXNf+/kjdgJkrqZ3QdqEx0UcAPf5XEP4HBT7LKZpYq8lwzgaxHvKac+9B
         46oJiwZFCOz6Ox/xXlrhqHAJYHTktrgHEop1brYTgpgzhhaMm3nNVWFHvEz5dnyffs1K
         FGnRcQ9wm/IlPJWUQnJ9a0lEuJZdqhqpoaJ5KsmtVweKJtgkDqilSXC6zz4bndRBFNgh
         Cxb6kMZF00H6TuWxv0u7ZFVIvmZMrFnA35I9Y52QCXbj+MdyruzKt0U4Uv5hAGlHqMfw
         h7GQ==
X-Gm-Message-State: APjAAAVlv07TvujGyOWsEvE+aP2IBcm1JilCiRCeQHGBC3UxXm+F+Wkd
        WURG3FFa993Wf8x3J3O8pRA=
X-Google-Smtp-Source: APXvYqymAAnPCNEs4k8vMwMn5XwErd+v4erWrIwuDCP/RdW5JCN2YvWyzaJWvaIcXvuIkJc7rSwtmw==
X-Received: by 2002:a17:902:8f88:: with SMTP id z8mr49815048plo.54.1556452721493;
        Sun, 28 Apr 2019 04:58:41 -0700 (PDT)
Received: from localhost ([203.63.161.26])
        by smtp.gmail.com with ESMTPSA id q80sm56446627pfa.66.2019.04.28.04.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 04:58:40 -0700 (PDT)
Date:   Sun, 28 Apr 2019 21:58:34 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] kernel/sched: run nohz idle load balancer on HK_FLAG_MISC
 CPUs
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190412042613.28930-1-npiggin@gmail.com>
        <CANRm+CzLmRHtpAawBSknXyznw25ym_otnYJYYxAho-E46K3BZg@mail.gmail.com>
In-Reply-To: <CANRm+CzLmRHtpAawBSknXyznw25ym_otnYJYYxAho-E46K3BZg@mail.gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1556452479.a2f15ax2p1.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li's on April 28, 2019 5:01 pm:
> On Fri, 12 Apr 2019 at 12:27, Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> The nohz idle balancer runs on the lowest idle CPU. This can
>> interfere with isolated CPUs, so confine it to HK_FLAG_MISC
>> housekeeping CPUs.
>>
>> HK_FLAG_SCHED is not used for this because it is not set anywhere
>> at the moment. This could be folded into HK_FLAG_SCHED once that
>> option is fixed.
>>
>> The problem was observed with increased jitter on an application
>> running on CPU0, caused by nohz idle load balancing being run on
>> CPU1 (an SMT sibling).
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  kernel/sched/fair.c | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index fdab7eb6f351..d29ca323214d 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9522,22 +9522,26 @@ static inline int on_null_domain(struct rq *rq)
>>   * - When one of the busy CPUs notice that there may be an idle rebalan=
cing
>>   *   needed, they will kick the idle load balancer, which then does idl=
e
>>   *   load balancing for all the idle CPUs.
>> + * - HK_FLAG_MISC CPUs are used for this task, because HK_FLAG_SCHED no=
t set
>> + *   anywhere yet.
>>   */
>>
>>  static inline int find_new_ilb(void)
>>  {
>> -       int ilb =3D cpumask_first(nohz.idle_cpus_mask);
>> +       int ilb;
>>
>> -       if (ilb < nr_cpu_ids && idle_cpu(ilb))
>> -               return ilb;
>> +       for_each_cpu_and(ilb, nohz.idle_cpus_mask,
>> +                             housekeeping_cpumask(HK_FLAG_MISC)) {
>> +               if (idle_cpu(ilb))
>> +                       return ilb;
>> +       }
>=20
> What will happen if cpu1 is still idle currently && housekeeping?

Then it will run the ilb.

In the customer scenario, cpu1 will not be in the housekeeping mask.

Thanks,
Nick

=
