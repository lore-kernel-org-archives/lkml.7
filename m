Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488F3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1069C2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUrqM3zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfCNKQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:16:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34159 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfCNKQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:16:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id v64so3515921pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IE7gKqALKVovcAplaEYWF9pUytsOieRBeWbz7YoQE2s=;
        b=PUrqM3zu/J1MF38v7jIiGt7yTa1aGnHvhM2bDea8AgrKw1A4FzJ2zQb4oE4CWHLAqK
         iBb8P1f3njZjB1SDbjgUg/xv4ZmvRsMcsj7CpXv2s7M+RcPB5FSLmjoPagbrwAQnrVb2
         0XegU2qPubvblb6fMd4WWtBVV25I44yh1F6AjK5tbVrd0eiNiapmh6zSbfMtc/RS55Xt
         MYQq46L1oylJZ5k/LlUe4/PFZX5SUNz3SXaCIQTIU1/Nuzwg3EmZCftLVqwLASPg09O1
         zkE3NHrUU9rZhB0O3Gw+INa39JOekIadsPTde6KXDAkpkW3HNXyPDygQRlo6i8xNWErl
         aHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IE7gKqALKVovcAplaEYWF9pUytsOieRBeWbz7YoQE2s=;
        b=JwR5JnTQxnqOvUG7bxygYy9XXBqBdsZT+GUCbF3RveeINtbEwgJ87CxnbX1C0N1Qu/
         ZkZgWwzVhT4b+UtuJcwbc4Tgb1+rJoj5fe1P8OIlhjx8yVM5boWt3BUElxZh3KqoxM2t
         C6a81HnoUIFxrx0hPk+AJK/xAS+ARWCAMJ2/0OZBfhEan8tgn+mSa5N/170CFuCM+l46
         8CpheTpDijB39P1Zw8oeRZfq7Ks40DN1sxRu1UrsaSDU4asqBj6FbLsXg6dTBkHZy5i+
         4VUGXJHlyeZfhnrgLBaMVCS0+9yCdUUN4ehRdxp9cWcaEauHWnNHC7Bo7kK/a1U54rwD
         z7CQ==
X-Gm-Message-State: APjAAAVpPksusZDwLOn1vhg3fRq1r2OA9pEubB2Z/8FeUIl5yuwxYJst
        KlC5YbZM9yZEZMuvdvk8KidF+w==
X-Google-Smtp-Source: APXvYqxWtg3T3Cjj0T4wcj/2FfDeE2Ns56oyDRJiJluwCh8bigL8zPPFajehlErm7tFN+ZfJXHDaXg==
X-Received: by 2002:a63:f113:: with SMTP id f19mr13604771pgi.141.1552558570132;
        Thu, 14 Mar 2019 03:16:10 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id a1sm20493224pfn.26.2019.03.14.03.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 03:16:08 -0700 (PDT)
Date:   Thu, 14 Mar 2019 15:46:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kvm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/7] cpufreq: Call transition notifier only once for each
 policy
Message-ID: <20190314101606.2aodwz5mzvstau6c@vireshk-i7>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
 <CAJZ5v0gER+aJaQmk89VSVBtHgQ+WPDdAxUW6eJ4JCB=emC85dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gER+aJaQmk89VSVBtHgQ+WPDdAxUW6eJ4JCB=emC85dg@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-03-19, 10:28, Rafael J. Wysocki wrote:
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

Even if per-cpu iteration has to be done at some place, we are
avoiding function calls here and the code/locking in the notifier
layer as well. Will get more such info into changelog.

> I guess some notifiers need to know what other CPUs there are in the
> policy?  If so, then why?

You mean about the offline CPUs? I mentioned the rationale in 1/7. It
is to avoid bugs where we may end up using a stale value if the CPUs
are offlined/onlined regularly.

> > This patchset tries to simplify that by adding another field in struct cpufreq_freqs,
> > cpus, so the callback has all the information available with a single
> > call for each policy.
> 
> Well, you can argue that the core is simplified by it somewhat, but
> the notifiers aren't.  They actually get more complex, conceptually
> too, because they now need to worry about offline vs online CPUs etc.

24 different parts of the kernel register for transition notifiers and
only 5 required update here, the other 19 don't need to do per-cpu
stuff and they also get benefited by this work. Those routines will
get called only once now, instead of once per every CPU of the policy.

> Also I wonder why you decided to pass a cpumask in freqs instead of
> just passing a policy pointer.  If you change things from per-CPU to
> per-policy, passing the whole policy seems more natural.

I did that because they don't need to use the other fields of the
policy today and that doesn't look likely in near future as well.

I can do that if you want, but not sure why more information should be
provided than required.

-- 
viresh
