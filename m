Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E552BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB13E2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQopIIl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfCSVuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:50:35 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37189 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfCSVue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:50:34 -0400
Received: by mail-vs1-f65.google.com with SMTP id w13so247134vsc.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 14:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3sx61kJLbntnOqF9bCfkbVbyId2Nm32y0C4Si3xxSKM=;
        b=QQopIIl/qvrsO12gXsZj9K33bVboR+U/AppaAP4QzKnQHUHsx64ePy0Sfmy9e7F8Jn
         1r6KAuoeNCaLS+M/uA6Yro7Yv/w8vX3n8snhT06gGTd7jxVPWeu4k8QzKgPK2O4jwjyI
         A/0CKVZabZhVpRvOI6yUwFCnPy8ZYZpldxOdVjnxcohtYNszqkv8CFIR6Xb5QVqDLFEo
         LGFPgFrWM77/RC8KMdrzKvPnaliii2y8A5KK8nQRcqRQH29j8ejO1TcR4PW+obMX/Z/s
         Sx0MRJZwYvUTj0j1vWmen+Enz72Eq8ozgl1eRyHB1+tLlBjtzyLM+ocLTikQb/+fiaGr
         XxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3sx61kJLbntnOqF9bCfkbVbyId2Nm32y0C4Si3xxSKM=;
        b=d8yxUVvJ1v91SNlfmrMGAmQudwURVsUkTNoDRGH5Oo+9pxsSfewJYKVBjlEkaXcAIn
         t/mEyisAJLckph4nxnMWtokcNLPkV/9yz6IS67V3YaeQg6AHEo3wPWGlmQmBgN2QB/by
         SzXUKlDtyG6u8lLnyxcL5nG64QKi+or/ENOUfI9A78K4nrinnnfU+NfGa1A/GGo6sB49
         eTIm0zyKPwy/lrJB1DcchtpfjCJe51STfSDpe783+10wv0RRSQG+4FKsAdvG4wQcaxvy
         P2uCdZuVeQB6+O47oUg6YyI64h5uqYxqKOQUWnxzgTVZ46KGUXNS93pxUUtJ0w4U3Hp+
         ma7Q==
X-Gm-Message-State: APjAAAUSW21w3yDwTqczq/dJOEIAoMxxcYJMtpjZIlGlHN1TJFOo40B4
        TtCAwtMnAQP8NcwCPF9J7O2eD8y4h1Q0gpbmsIMFWg==
X-Google-Smtp-Source: APXvYqzSWRJOTURbF7eui/7MX9Bbf2qwA02XNHX7VbUnYSECKLfoHQNYL9R1TVX5Yf9Dy1vGt/0WC/D4weKL7Aq0UiY=
X-Received: by 2002:a67:e9cc:: with SMTP id q12mr1098400vso.208.1553032233572;
 Tue, 19 Mar 2019 14:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190314130113.919278615@infradead.org> <20190314130705.956098225@infradead.org>
In-Reply-To: <20190314130705.956098225@infradead.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 19 Mar 2019 14:50:21 -0700
Message-ID: <CABPqkBReEzMKUDJVAUArwbzxtL5KTNRot2coW4MUOvy0qzgC-w@mail.gmail.com>
Subject: Re: [RFC][PATCH 6/8] perf/x86: Clear ->event_constraint[] on put
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 6:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> The current code unconditionally clears cpuc->event_constraint[i]
> before calling get_event_constraints(.idx=i). The only site that cares
> is intel_get_event_constraints() where the c1 load will always be
> NULL.
>
> However, always calling get_event_constraints() on all events is
> wastefull, most times it will return the exact same result. Therefore
> retain the logic in intel_get_event_constraints() and change the
> generic code to only clear the constraint on put.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I thought there was caching of the constraint in case it was static
(or unconstrained)
to avoid walking the constraint table each time between invocations
on the same group_sched_in() call. But the way the c1 vs. c2 logic
is written I don't see it. In which case, this could be another opportunity.

Looks good to me.

Reviewed-by: Stephane Eranian <eranian@google.com>

> ---
>  arch/x86/events/core.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -858,7 +858,6 @@ int x86_schedule_events(struct cpu_hw_ev
>                 x86_pmu.start_scheduling(cpuc);
>
>         for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
> -               cpuc->event_constraint[i] = NULL;
>                 c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
>                 cpuc->event_constraint[i] = c;
>
> @@ -941,6 +940,8 @@ int x86_schedule_events(struct cpu_hw_ev
>                          */
>                         if (x86_pmu.put_event_constraints)
>                                 x86_pmu.put_event_constraints(cpuc, e);
> +
> +                       cpuc->event_constraint[i] = NULL;
>                 }
>         }
>
> @@ -1404,6 +1405,7 @@ static void x86_pmu_del(struct perf_even
>                 cpuc->event_list[i-1] = cpuc->event_list[i];
>                 cpuc->event_constraint[i-1] = cpuc->event_constraint[i];
>         }
> +       cpuc->event_constraint[i-1] = NULL;
>         --cpuc->n_events;
>
>         perf_event_update_userpage(event);
>
>
