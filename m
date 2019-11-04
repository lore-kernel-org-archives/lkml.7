Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DE5CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE81C20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8BFTOIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfKDRep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:34:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46249 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbfKDReo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:34:44 -0500
Received: by mail-lj1-f195.google.com with SMTP id e9so5276532ljp.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 09:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MWcQLucKakVRcVWjMHhLsE/d2P0WRzHGP12bGvdrWzk=;
        b=H8BFTOILGKhU7JUZq40IbMXCMx96p38TVrJa3csSxbWEJEfMj8lUOqG7acNKWOmRlt
         fpUiGtjy6HkSjpVT7qUvOlVcrXLsOYkT87iTUyz0PzFN6kHeJ/TxFUcqdw6vlMmvf6Y9
         dTQpoKzpJVYqhIETrBqi+1cRYeti+/Ddnniy6XbIiVNT19INjmlU20nMk7BRAirrxhdQ
         DCEHMOz1QFtKlrxmQnAvXPSI/C8e+7rpSwiRgr6UjYYOA+b2+aYjsQMJqvhSHj0jzzFj
         nJYJCvaraI5JnpAnGSgflrf2COmGwMenTz9wACgdbQ1VoqQItr8hhgpvSDrNWyQUrFXj
         ybzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MWcQLucKakVRcVWjMHhLsE/d2P0WRzHGP12bGvdrWzk=;
        b=ZC3R5IoE6eSu62tN+su/cfNeo74U2IqkDR4l3YqEMrFQZ8RWDgW/0J7zC3mwovF4z8
         0MD026/R3463aDvjESe1wunziIQOG40Ir+F4fQTyzRkkB4f33kbyjihPgPMP0winlKpx
         jPlanplT7T/LtKzvT4ur/Ac9pKyvKSsxRxSiS/q4vSsHTNhEk+c/qSkC5HUhHE6+z8Kx
         7TLgcp7bZeNX9CZIPAXT390+NQeXDydfLGYy1NMpcQ0inuCwS2OAo6ob4MKX/zR9cYtK
         laZQ8XZ8mlZbnHPEkJcLlfQLBkYafNpWSyNtzfM1S3f6/LfWJfoNTLO21RWb7fWviOt+
         C2Og==
X-Gm-Message-State: APjAAAUQ2SzpUR32RS1cJJ27LtVDMBnBc30hg2Xo0ND0GiGmkw0Nb2lg
        6kFSDPgB3ZnATJ8kbOuGwtJd09rW19ufvOeS0no7ag==
X-Google-Smtp-Source: APXvYqxbfDbIrUU5hQprKjByJI/EwhDz0aDdFHLdza6ImgVFUxKnX4HuiSIIOjNg1xngr27Lm35h4RIXJDsrt7Ucj5o=
X-Received: by 2002:a2e:7811:: with SMTP id t17mr6036253ljc.225.1572888882759;
 Mon, 04 Nov 2019 09:34:42 -0800 (PST)
MIME-Version: 1.0
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-3-git-send-email-thara.gopinath@linaro.org>
 <379d23e5-79a5-9d90-0fb6-125d9be85e99@arm.com> <5DBC9C57.3040504@linaro.org> <dc30ed89-6581-d99d-03bb-58ea40b74a3d@arm.com>
In-Reply-To: <dc30ed89-6581-d99d-03bb-58ea40b74a3d@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 4 Nov 2019 18:34:30 +0100
Message-ID: <CAKfTPtBQ1_7ApBkAQrEBy7twohSiM3WcYa-JiHekbedR8C3EKg@mail.gmail.com>
Subject: Re: [Patch v4 2/6] sched: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2019 at 18:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 01/11/2019 21:57, Thara Gopinath wrote:
> > On 11/01/2019 08:17 AM, Dietmar Eggemann wrote:
> >> On 22.10.19 22:34, Thara Gopinath wrote:
> >>
> >> [...]
> >>
> >>> +/**
> >>> + * trigger_thermal_pressure_average: Trigger the thermal pressure accumulate
> >>> + *                              and average algorithm
> >>> + */
> >>> +void trigger_thermal_pressure_average(struct rq *rq)
> >>> +{
> >>> +   update_thermal_load_avg(rq_clock_task(rq), rq,
> >>> +                           per_cpu(delta_capacity, cpu_of(rq)));
> >>> +}
> >>
> >> Why not call update_thermal_load_avg() directly in fair.c? We do this for all
> >> the other update_foo_load_avg() functions (foo eq. irq, rt_rq, dl_rq ...)
> > thermal.c is going away in next version and I am moving everything to
> > fair.c. So this is taken care of
> >
> >>
> >> You don't have to pass 'u64 now', so you can hide it plus the
> >
> > You still need now.All the update_*_avg apis take now as a parameter.
>
> You do need it for the ___update_load_sum() call inside the
> foo_load_avg() functions. But that doesn't mean you have to pass it into
> foo_load_avg(). Look at update_irq_load_avg() for example. We don't pass
> rq->clock as now in there.

update_irq_load_avg is the exception but having now as a parameter is
the default behavior that update_thermal_load_avg have to follow

>
> -int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +extern int sched_thermal_decay_coeff;
> +
> +int update_thermal_load_avg(struct rq *rq, u64 capacity)
>  {
> +       u64 now = rq_clock_task(rq) >> sched_thermal_decay_coeff;
> +
>         if (___update_load_sum(now, &rq->avg_thermal,
>                                capacity,
>                                capacity,
