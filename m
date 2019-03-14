Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A640AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF422085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552555743;
	bh=OJrIe9UnNobVZw+ff5HQMkQyWui/ix/sYJxKaEV31qY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hBAB0AC+eks2Z4E/oOl3JrBWa71UG5rcNdjhQkLWIw/Vn6yFc3g2XIapCRucMDOTP
	 d+ssJskxo+/W+IqPWX7GuDlf1mcTCSrMnxrpVC/hnhTBKqTu8cJFR1ROQz/2TLzqIC
	 9WeB5pcDJ428jUBTPoQ4TnAyWdie1LEz1DbGH84s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfCNJ3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:29:02 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43945 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfCNJ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:29:01 -0400
Received: by mail-oi1-f196.google.com with SMTP id 67so3823589oif.10;
        Thu, 14 Mar 2019 02:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ra89Rc2bhS4KvB6nPCTjBd0qnjvMDrq0xwg/HqeHC1Y=;
        b=O9PsSZdK2RFEkQVxUNnGUjFM1kGj1ECROwJawMj3R68FiXPm3QIu1yUSCcv8kScsnP
         iInBCZZ/QbSr59eHzAdKnQfKAgClrEh7AOsnbh/TrbdAhME6HBP4/m8tBDbLdrFxKgD/
         dVLKzfZ1XnnwLG0cSMz/gGvQ/tnk5OijiOST8H0kxb7zm6HcTqmNPtriPikA/GdLRQ8m
         vFvr8VDxBkiFpd2DtA9hbtSO/asTxcKUivS375Jjbss119JWjPm6cfz8tRc5OSAeMVLh
         i0pFckGxI/1gTRVbJrP8a4EAmMFJXmkhVqjIeC2KAD1X4fflgVCHxjyQTcxi//sp25PY
         1/9A==
X-Gm-Message-State: APjAAAUguqGBHJuhWqPCpEIma6tVsFsV1PJuqy0H4SIyXJ/T10ydWsUS
        8Pb8umRPgvb7ZSe3/50zYdmgBfMeZGjOoRy3Nbk=
X-Google-Smtp-Source: APXvYqwzCHb12W7IeeZCYywpsCzILAmwGsNH7V6Ha1PajA7DAfRkJ2q7/VVQHBJ9CHAaYEjVOb1fFiiqAORLQVQ/AMA=
X-Received: by 2002:aca:355:: with SMTP id 82mr1538080oid.30.1552555740709;
 Thu, 14 Mar 2019 02:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552545525.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1552545525.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Mar 2019 10:28:49 +0100
Message-ID: <CAJZ5v0gER+aJaQmk89VSVBtHgQ+WPDdAxUW6eJ4JCB=emC85dg@mail.gmail.com>
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

On Thu, Mar 14, 2019 at 7:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Currently we call the cpufreq transition notifiers once for each CPU of
> the policy->cpus cpumask, which isn't that efficient.

Why isn't it efficient?

Transitions are per-policy anyway, so if something needs to be done
for each CPU in the policy, it doesn't matter too much which part of
the code carries out the iteration.

I guess some notifiers need to know what other CPUs there are in the
policy?  If so, then why?

> This patchset tries to simplify that by adding another field in struct cpufreq_freqs,
> cpus, so the callback has all the information available with a single
> call for each policy.

Well, you can argue that the core is simplified by it somewhat, but
the notifiers aren't.  They actually get more complex, conceptually
too, because they now need to worry about offline vs online CPUs etc.

Also I wonder why you decided to pass a cpumask in freqs instead of
just passing a policy pointer.  If you change things from per-CPU to
per-policy, passing the whole policy seems more natural.
