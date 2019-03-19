Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF148C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9637720850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1o4o6aZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfCSVVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:21:41 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39232 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfCSVVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:21:40 -0400
Received: by mail-ua1-f67.google.com with SMTP id m11so95965uad.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 14:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8X4If+XrUrlsJ/IOI5q5Oxt/qaREbG7iUitlsrmNxnU=;
        b=L1o4o6aZk/QtIHVsYa5ztTi+OIwY/WfiHto/NYjjFszF8DCB3s1/1eXUPCtitb9Ggc
         vN59/FT9GfghbAyjIGL8QZTnupcvX70F7nYJxLiMLAJz+eArw1fz+DpqolrHZ501k3N/
         ykNA3GiJnreu4aTRbwzBCO5ZFdXXqV1NuW42huyRhWuQ5Co72wZAdT61TbQyLqKL1DGd
         Lp2QhyXYyOAOzBkjxzZh/TBeWRhYeTwMPx46gNncirQT0/UhM3n6kJHiABYoq9icTLL6
         JyBeRjjkbEBXiw3PjJ95g8k+f+Ms0GyvcC0aAKt/Y7ja395R87SYBeY5Ca02hT6ajf5Y
         TSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8X4If+XrUrlsJ/IOI5q5Oxt/qaREbG7iUitlsrmNxnU=;
        b=jaLtJ/AMSUZFWFUBcodMS+SYQZjry6cRKMNYvriYZlu9JyzwygrnKeCyGbxl4lDTHe
         NVVNzHv8ZjparrSaYE/eZhRbwp8zWBaXIJQTLBQasK+y6tiZS85ievCoPNiIaO4W+w69
         brKaDKWmEvNFrOa1lb51uCQ8sAQJX1grAy15M2IMSZpIdCTnUFMsaWPSobC+Ht0f4UZA
         L4xmyimXJwwIdUg1KkFyXPx62Kcy6fxafwppwrwcpwm4DuYTB1d+Uc2lsCjIMurgsIK0
         Ihcqtwzb8gqhLPu+LZW67pssgHIqn3FXT6Mwtbmhq8jx2GLNWNZeWItWUxmCsy25R4zt
         ggyQ==
X-Gm-Message-State: APjAAAVsMyMGs7ju3C7d8lBG+29GKS/I9q/+fRusYu4B6k0Gqu9RCvI1
        pWQFqY0/Yhxv+hmo4hPnfhhiTkW2x9s1niSncOi6xQ==
X-Google-Smtp-Source: APXvYqy+fOxaS9espvUOKS2SlGQt7Pmje5SBG2AXWcekI/q0QWdd4MaYP9lBvEjf9dyU4uUnTN5WCoDVvkOaHppr9iI=
X-Received: by 2002:ab0:6294:: with SMTP id z20mr2515021uao.134.1553030498986;
 Tue, 19 Mar 2019 14:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190314130113.919278615@infradead.org> <20190314130705.651247561@infradead.org>
In-Reply-To: <20190314130705.651247561@infradead.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 19 Mar 2019 14:21:27 -0700
Message-ID: <CABPqkBSBPONzm02vxaM1NsSJR_aGX4cC6F6xkDUAXS=F3whRZQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/8] perf/x86: Simplify x86_pmu.get_constraints() interface
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
> There is a special case for validate_events() where we'll call
> x86_pmu.get_constraints(.idx=-1). It's purpose, up until recent, seems
> to be to avoid taking a previous constraint from
> cpuc->event_constraint[] in intel_get_event_constraints().
>
> (I could not find any other get_event_constraints() implementation
> using @idx)
>
> However, since that cpuc is freshly allocated, that array will in fact
> be initialized with NULL pointers, achieving the very same effect.
>
> Therefore remove this exception.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks good to me.
Reviewed-by: Stephane Eranian <eranian@google.com>

> ---
>  arch/x86/events/core.c       |    2 +-
>  arch/x86/events/intel/core.c |    8 +++-----
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2031,7 +2031,7 @@ static int validate_event(struct perf_ev
>         if (IS_ERR(fake_cpuc))
>                 return PTR_ERR(fake_cpuc);
>
> -       c = x86_pmu.get_event_constraints(fake_cpuc, -1, event);
> +       c = x86_pmu.get_event_constraints(fake_cpuc, 0, event);
>
>         if (!c || !c->weight)
>                 ret = -EINVAL;
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2931,11 +2931,9 @@ static struct event_constraint *
>  intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>                             struct perf_event *event)
>  {
> -       struct event_constraint *c1 = NULL;
> -       struct event_constraint *c2;
> +       struct event_constraint *c1, *c2;
>
> -       if (idx >= 0) /* fake does < 0 */
> -               c1 = cpuc->event_constraint[idx];
> +       c1 = cpuc->event_constraint[idx];
>
>         /*
>          * first time only
> @@ -3410,7 +3408,7 @@ tfa_get_event_constraints(struct cpu_hw_
>         /*
>          * Without TFA we must not use PMC3.
>          */
> -       if (!allow_tsx_force_abort && test_bit(3, c->idxmsk) && idx >= 0) {
> +       if (!allow_tsx_force_abort && test_bit(3, c->idxmsk)) {
>                 c = dyn_constraint(cpuc, c, idx);
>                 c->idxmsk64 &= ~(1ULL << 3);
>                 c->weight--;
>
>
