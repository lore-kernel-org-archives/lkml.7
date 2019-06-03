Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34189C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BB023EAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SxRXTAPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfFCSc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:32:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39733 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFCScZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:32:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id a10so13965753ljf.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t54X/Fzcqzl0rbwLC0aNC65O4bdybHEbE+a1rfg9Liw=;
        b=SxRXTAPJ1R5lRYBBqnU/IRLFTdiBzyLV4t8P118DSL5bBOq7bxmmEqc/yqQNPbPOWl
         xRQFKWh0J0znBPNVBbWYiqWISLFcI6UlrAF14zFYAeyylvaINraOt4f1VP4gVfvS8PRz
         HEfEKCYeh0/FCrSjXrB61x4D6zIDB//skFhFuGCa8xtHkhQSpImZCIY33l64HXYFKuIb
         y2XopOv11jjTM43TwK8nEFNw2b370gpv448jVqhlOkwKFHRabfBOjDbxA+dAgO/SnSnW
         xVFXGJfzKQEvUTw+UXVlLMZckKp3yvdS2k3ciy9snP8bESZRMM3Fkjp6eaLjFSz9S8rQ
         CoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t54X/Fzcqzl0rbwLC0aNC65O4bdybHEbE+a1rfg9Liw=;
        b=qTdVwolm0P34w1Wpnf3Ymfnnk6U7JbkImuK24W8XKA16msYBzKVtqXeRpy82LXxd/R
         Rdp7zhBhgIyR2q23Mzs+a3zrO6JsfOrPFDqudill7Ks4MGDmvCBs2l0sxMbSnSv7ZV9e
         fI8loQ9+ZYsAUjN8TX9NJW/0UHWI7PmDWxbf3iWR4WiE5D/q2sJUK06ibxMD72fbEHqD
         TyTQ4wMg7PCzW1U/MBRpHxqmsCguoLMbKksmGjZpdo+hy6PthOneLAtfIIg/qsfYuDMs
         Dv6gc+oc+I1SJykf1dQLqF4dq/d0JYMJM3a3F52rfPtL5aFUC1P9S2PYG8fZJ+oiwFhl
         P96g==
X-Gm-Message-State: APjAAAVH92IKOmhhNncTZ7PugVtjYU7q91H2yk7J8oqGDCSCaYNkGSll
        xrZ3fkscv62u41yg3YFaTd691qv1c0P5vpl8R3O/2Q==
X-Google-Smtp-Source: APXvYqyKq7TdviCr529yCsvAFqqt1xFyKjJAFjmswoe3UEhw/0hjfhP/np1OZii2cg0byhOz0GYyhsifHL4Oa8vKlKA=
X-Received: by 2002:a2e:7001:: with SMTP id l1mr14746563ljc.11.1559586743799;
 Mon, 03 Jun 2019 11:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <1559571064-28087-1-git-send-email-vincent.guitto@linaro.org>
 <1559571436-29091-1-git-send-email-vincent.guittot@linaro.org> <7280a3b0-0727-f365-4453-8b4b01a64559@arm.com>
In-Reply-To: <7280a3b0-0727-f365-4453-8b4b01a64559@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 3 Jun 2019 20:32:12 +0200
Message-ID: <CAKfTPtCU_+YJgMVpk-CKhetqTbOcNWVOmbUOD_xuTJqSD64J=w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: clean up asym packing
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2019 at 20:15, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Hi,
>
> On 03/06/2019 15:17, Vincent Guittot wrote:
> > Clean up asym packing to follow the default load balance behavior:
> > - classify the group by creating a group_asym_capacity field.
>
> Being nitpicky here, this doesn't classify the group in the usual way
> - it doesn't get a specific group_type value (group_classify()). So maybe
> "classify" isn't the best term here.

My original goal was to add a group type to classify the group but
this would have broken the current behavior whereas I only want to
move code

>
> Also, why tag this group in update_sd_pick_busiest()? It would make more
> sense to do so in update_sg_lb_stats() like with the other sg_lb_stats fields:

With your proposal below, the test is called for every groups'
statistic update whereas it is only done lastly after checking other
rules in the current code and I don't want to modify the current
behavior but only move code to set imbalance in calculate imbalance.

A bigger cleanup will come in next steps

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 93c24473c8a0..537710026c3a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8298,6 +8298,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                 }
>         }
>
> +       if (sgs->sum_nr_running &&
> +           sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu))
> +               sgs->group_asym_capacity = 1;
> +
>         /* Adjust by relative CPU capacity of the group */
>         sgs->group_capacity = group->sgc->capacity;
>         sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
> @@ -8391,9 +8395,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>          * perform better since they share less core resources.  Hence when we
>          * have idle threads, we want them to be the higher ones.
>          */
> -       if (sgs->sum_nr_running &&
> -           sched_asym_prefer(env->dst_cpu, sg->asym_prefer_cpu)) {
> -               sgs->group_asym_capacity = 1;
> +       if (sgs->group_asym_capacity) {
>                 if (!sds->busiest)
>                         return true;
>
