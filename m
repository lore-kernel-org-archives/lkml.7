Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665C5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFBE21019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552556422;
	bh=8fa2zne+UV7qY0l/S+IjoJMk2R+Me5nMtvIhphw4GbE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v5fyKFkTtxSRqLToc7jsa2CeFHjUeaGX9uuH7fJV8CbBBtfn2u+1Ph1beQVqqcuHj
	 31/yy91giLqc5Lu9/VdlzcW5+i5zevXUuXrMr0e+4MPUqLKXMXLLH97RE6qBS3HDoE
	 dm8DMnKsBreZN5ftEmuRnHtT58EKodeH8YjPgtec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfCNJkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:40:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34052 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfCNJkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:40:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id r19so4521791otn.1;
        Thu, 14 Mar 2019 02:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yn7up47bAdS3ENDS1BSCK25JfVBUlC+P2MRJAxNjlsc=;
        b=MiQN79ad92ZPZagURLS8YYA/AtK/QvC2uReqNjt2ua50T13AmLBZIxodAUAeX7cT6o
         cpIrxo2VGgoUgHENiyf98uK6kFiUGHX7EK/dQNPTR9zju/H5xeihBKaPFPs9xcvENy+A
         zcdivvBLf06qtVoe6mzqiRZKBzjCXeMjmnsGQVSY5XHgXKgHkEqs0vzu8BHVIu0644bC
         94TkdAoB81WnIYOeWzv99h1PEegHIS3nVYi4pOCoaWku4AU3UWtRzeRqSemY+VYVqEgC
         9S8H3VcAGFJyVZgGLOcIWJ105lKxYz7xthQeDLkOC+LdcPQ0n2Aczny9oN4H4oISnxBU
         EL7w==
X-Gm-Message-State: APjAAAXICJYRExst3Uy+MNeempyeas3qDHNuFoGW4ppI6kwjZzYpq3rn
        FVcrul/3zMtggpo8tmoGebIV2svOKNnfvdsOLjQ=
X-Google-Smtp-Source: APXvYqwL09mJxoDB1He39nKXjoXUuJ8YuRxwu4Hw0xMji4vvHyVAB0TWmVYi0CGXhJrB26LNFy20ajw1UfO8ae4N2YE=
X-Received: by 2002:a9d:7a58:: with SMTP id z24mr2270885otm.244.1552556419146;
 Thu, 14 Mar 2019 02:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552545525.git.viresh.kumar@linaro.org> <CAJZ5v0gER+aJaQmk89VSVBtHgQ+WPDdAxUW6eJ4JCB=emC85dg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gER+aJaQmk89VSVBtHgQ+WPDdAxUW6eJ4JCB=emC85dg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Mar 2019 10:40:08 +0100
Message-ID: <CAJZ5v0izRO4zmc-TovmZBjWa+Or0oN89Ny8rdxf=81ogMJM4oQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] cpufreq: Call transition notifier only once for each policy
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>,
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

On Thu, Mar 14, 2019 at 10:28 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Mar 14, 2019 at 7:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Currently we call the cpufreq transition notifiers once for each CPU of
> > the policy->cpus cpumask, which isn't that efficient.
>
> Why isn't it efficient?
>
> Transitions are per-policy anyway, so if something needs to be done
> for each CPU in the policy, it doesn't matter too much which part of
> the code carries out the iteration.
>
> I guess some notifiers need to know what other CPUs there are in the
> policy?  If so, then why?
>
> > This patchset tries to simplify that by adding another field in struct cpufreq_freqs,
> > cpus, so the callback has all the information available with a single
> > call for each policy.
>
> Well, you can argue that the core is simplified by it somewhat, but
> the notifiers aren't.  They actually get more complex, conceptually
> too, because they now need to worry about offline vs online CPUs etc.
>
> Also I wonder why you decided to pass a cpumask in freqs instead of
> just passing a policy pointer.  If you change things from per-CPU to
> per-policy, passing the whole policy seems more natural.

It also looks to me like all that needs to be one patch, or you have
the ugly transition situation in which notifiers are still invoked for
each CPU, but they assume to be invoked once per policy.
