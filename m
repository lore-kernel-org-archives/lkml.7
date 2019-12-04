Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAA7C2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB44820656
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vFaMtUKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfLDMIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:08:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33024 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfLDMIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:08:16 -0500
Received: by mail-lj1-f195.google.com with SMTP id 21so7845087ljr.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 04:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n53lGt+YzNiyRiDyZo76uBdQF7IlqBjHXPOJ4vHrqxM=;
        b=vFaMtUKtLpQSTyGB1kwgIGUx3nSPgfGss6k8BSSqjQpqh6HDYV39976MRwkvxutXzZ
         MfwNPyjFY8zn7m1sNwuk6+1NmmYS+MuWaergGtY5QiPgaxvSbjYY70HdBawELXXRgD9n
         mibvueJC6kcfT9egfIx58Z3UROFxYZfprxn5sHYRdPNMcVxePgnyFEc++QO+XMdVr3Wh
         IKXP5p2P6jJou3YHdOtzwnBXAJlBl6Nx4Q36L46YXhw2e+OsMo1EHUJMAOuA9v25an6d
         UMJR79vfy/CaGRLfJBdqATu8wj7d05zJPTSmCH6uZJNcz0O94kFL9dYhzU/zt4KUXefr
         TOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n53lGt+YzNiyRiDyZo76uBdQF7IlqBjHXPOJ4vHrqxM=;
        b=Ak6bAd0Yiie2LsWWLGeoBU/4NG3W32gaIic9oWXBVpc34SnbR2wI4eb8eEI5Xz8Frs
         aIBQ8M0IO8cUaIhJcK0cI/4STZgEUWxuXopm1PZjz5DrdXrMu+YwzN8F5L1anmOi3eEc
         isAFWU4kSqwQPvfmG1dHajXT5tGSJrfI6Sj3zCD619lw5IbTEZiVmnnEYIyhP+1O0moS
         kGqPTzTITxRJpmNfAFxAEjEfMr/kWBq4i1loWlFb+VQstpWZ6/b7bMqcAImUCsVr3Cca
         JHhZ+jtBbn9RKIS0tlTUJT28yzj7vT3fnH80H7dUdwViXYK3NvrIxcHxKNXXkQTMdtQi
         wbWg==
X-Gm-Message-State: APjAAAUXxyUjia8tueaNuTGljyxcxpO8Xl1DJ2Ivyoxi9CNvH5Pc/+rT
        ZRei+IMjc3va4mQcnBpFdnT1Gp7/mXen/1EZUHD3dw==
X-Google-Smtp-Source: APXvYqwYl6M8KJAY3zpIafM4EqB+qy8opvw7tnEAbVEfzA/pmcP4QnqZojgcUzQslA2Rcy3AbjG8nZzR7MwkxaiuJmw=
X-Received: by 2002:a05:651c:208:: with SMTP id y8mr1812145ljn.36.1575461293758;
 Wed, 04 Dec 2019 04:08:13 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
 <CAKfTPtAvnLY3brp9iy_aHNu0rMM8nLfgeLc3CXEkMk3bwU1weA@mail.gmail.com>
 <20191204094216.u7yld5r3zelp22lf@e107158-lin.cambridge.arm.com>
 <20191204100925.GA15727@linaro.org> <629cca09-dde7-5d77-42e1-c68f2c1820d2@arm.com>
In-Reply-To: <629cca09-dde7-5d77-42e1-c68f2c1820d2@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Dec 2019 13:08:02 +0100
Message-ID: <CAKfTPtDZLFn7msw88pTE_wr-BJo2ErqxpOW+ah0Jjcg6vE3SLw@mail.gmail.com>
Subject: Re: Null pointer crash at find_idlest_group on db845c w/ linus/master
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        John Stultz <john.stultz@linaro.org>,
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

On Wed, 4 Dec 2019 at 11:41, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 04/12/2019 10:09, Vincent Guittot wrote:
> > Now, we test that a group has at least one allowed CPU for the task so we
> > could skip the local group with the correct/wrong p->cpus_ptr
> >
> > The path is used for fork/exec ibut also for wakeup path for b.L when the task doesn't fit in the CPUs
> >
> > So we can probably imagine a scenario where we change task affinity while
> > sleeping. If the wakeup happens on a CPU that belongs to the group that is not
> > allowed, we can imagine that we skip the local_group
> >
>
> Shoot, I think you're right. If it is the local group that is NULL, then
> we most likely splat on:
>
>                 if (local->sgc->max_capacity >= idlest->sgc->max_capacity)
>                         return NULL;
>
> We don't splat before because we just use local_sgs, which is uninitialized
> but on the stack.
>
> Also; does it really have to involve an affinity "race"? AFAIU affinity
> could have been changed a while back, but the waking CPU isn't allowed
> so we skip the local_group (in simpler cases where each CPU is a group).

In fact, this will depend of the uninitialized values of local_sgs. I
have been able to reproduce the situation where we skip local group
but not to trigger the crash because the values already in the stack
don't trigger the misfit comparison.

I  wait for John feedback to confirm that this fix his problem and
will send a clean version of the patch
>
>
