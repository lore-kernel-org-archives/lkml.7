Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C5CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A95A20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552560943;
	bh=aWfJmGwmDmcrj84qG0zn3+6GutZKRnXxn+KRE+8Tjt4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=08kDG8MCIwl8t8gNYfhLp72n1vxaVY9h1dLwksQ3C+P7bP61Mz2xArqjXABi0f3ln
	 grg5ilTV0fOiPKbU84QSdWjI6g/AH18VljWWUdt4XRTO1cQ0um+M2O/VrEknyqtX7P
	 N95exlNyQbc/qM5H3sCjlqZKfwLpemk8qxas6kcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfCNKzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:55:42 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33298 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfCNKzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:55:41 -0400
Received: by mail-ot1-f67.google.com with SMTP id q24so4689477otk.0;
        Thu, 14 Mar 2019 03:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nX1T/FlbdNZP1lNa7iOqbLevcgmWhoM+e1Fuc9sivtI=;
        b=H8WDX/JzTTUpY+iiQ+Gktg8+SsG5pk+LKHH78q6aKUKh9Y/DDiPKPkTytAAoemVxeM
         6fgBCVclR6212BIGG4YtSOp7zlshRq5s1EwEvPBAmgkPtoTPdX+vC9uRNfiMkNiRv1gd
         tPuOT8QSwuHdAS4jhL/XU66mHqtc9dPT7I52I17oRXvCooqqE+NTpVBR7UyohtzgcWrs
         oTOHByOrB+EFWvNhgrqZ5j0yB18gq1qO0L6z8wS0BTiGn4wRxYymAWRpnsbtH1akmneQ
         MJqwSyioM4s+KEQ/nwOCAG1Kn9ggrxROLk6FUNowctj6hKn4+EcFBtAwVL8Jp9bhYnek
         V6AQ==
X-Gm-Message-State: APjAAAUKNsiikQMDlQm5IkeolE929KZ7jDqsBkK2jibmYbvowNJEUl/j
        EK1Crd65RHU/SIkvjdHvN5jSZFLTZbHdtVtSNaY=
X-Google-Smtp-Source: APXvYqwOeUIjiYiqxBu7JlZTdfrAmfafnY6yrLSJgfSZWxtEtMqldV3OT7J/B88EGMo0a/IdRO231KN1WjO0fLhUShc=
X-Received: by 2002:a9d:7a58:: with SMTP id z24mr2439316otm.244.1552560940456;
 Thu, 14 Mar 2019 03:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552545525.git.viresh.kumar@linaro.org> <CAJZ5v0gER+aJaQmk89VSVBtHgQ+WPDdAxUW6eJ4JCB=emC85dg@mail.gmail.com>
 <20190314101606.2aodwz5mzvstau6c@vireshk-i7>
In-Reply-To: <20190314101606.2aodwz5mzvstau6c@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Mar 2019 11:55:29 +0100
Message-ID: <CAJZ5v0jiumt_nvhc3Bv_b94Xq22h5vTwDPeM1qo+6bzChn58FQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] cpufreq: Call transition notifier only once for each policy
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kvm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 11:16 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-03-19, 10:28, Rafael J. Wysocki wrote:
> > On Thu, Mar 14, 2019 at 7:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > Currently we call the cpufreq transition notifiers once for each CPU of
> > > the policy->cpus cpumask, which isn't that efficient.
> >
> > Why isn't it efficient?
> >
> > Transitions are per-policy anyway, so if something needs to be done
> > for each CPU in the policy, it doesn't matter too much which part of
> > the code carries out the iteration.
>
> Even if per-cpu iteration has to be done at some place, we are
> avoiding function calls here and the code/locking in the notifier
> layer as well. Will get more such info into changelog.
>
> > I guess some notifiers need to know what other CPUs there are in the
> > policy?  If so, then why?
>
> You mean about the offline CPUs? I mentioned the rationale in 1/7. It
> is to avoid bugs where we may end up using a stale value if the CPUs
> are offlined/onlined regularly.

I'm not really convinced about this.  CPU online really should take
care of updating everything anyway.

> > > This patchset tries to simplify that by adding another field in struct cpufreq_freqs,
> > > cpus, so the callback has all the information available with a single
> > > call for each policy.
> >
> > Well, you can argue that the core is simplified by it somewhat, but
> > the notifiers aren't.  They actually get more complex, conceptually
> > too, because they now need to worry about offline vs online CPUs etc.
>
> 24 different parts of the kernel register for transition notifiers and
> only 5 required update here, the other 19 don't need to do per-cpu
> stuff and they also get benefited by this work. Those routines will
> get called only once now, instead of once per every CPU of the policy.

This is a much better rationale for the change than the one given
originally IMO. :-)

> > Also I wonder why you decided to pass a cpumask in freqs instead of
> > just passing a policy pointer.  If you change things from per-CPU to
> > per-policy, passing the whole policy seems more natural.
>
> I did that because they don't need to use the other fields of the
> policy today and that doesn't look likely in near future as well.

But some of them need to combine the new cpumask with
cpu_online_mask() to get what would be policy->cpus effectively.  That
would be avoidable if you passed the policy pointer to them.
