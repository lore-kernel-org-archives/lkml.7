Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C31C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE5C208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="rZfz3Ws0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439207AbfFLM6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:58:37 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:54631 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbfFLM6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:58:36 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 241e037c
        for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jun 2019 12:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=z0n+sxRpIf7toDKbvJMw8AJpd8s=; b=rZfz3W
        s0wV8z7obHvdNmy4GYJD1FEHfbX/1Oc2jDaKZHip6/0ve+wsYsbD+9j3MsB3sszx
        a4UgUCa84LJ7e6jGDMFa72msxxNpg+k8Kfq3aj2ovN3Awnt/Toi2O+E6URN4Um4m
        83tmV0E2tgNxZxDpUmo6c21cd9SXYYbRG069NWvmQuOvc0VmmsAJeIUJUjRWSG9x
        BYkfZYU7h+/az7yyYKyn0ec5KPpOILU+VOMTyB4AF8bY7UY3FkAaLL06yjeN1WQN
        CqjqGaqN8lkcHz59XTDblmkMUaWh23O5ZBQWK5ACVbAFd2qLZOIlo0DA2EZpblzf
        y02qW8irCNsTs++A==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9b600d85 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jun 2019 12:26:19 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id z24so15310813oto.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 05:58:33 -0700 (PDT)
X-Gm-Message-State: APjAAAUOtwKXjihEaYSqmeITuJKUy+Ptwp1gSxAb93vTQlQexyGIDq66
        y4jgs5sx+IU6BZ+zg19ndX5YSYazknPcStxXZ3s=
X-Google-Smtp-Source: APXvYqxNjJ2DZVb7Fs7GXTkFPheq9RxHqK8JsZRshRHIVG3v3qEfwMh1nEWCiMr0BEmNZAC6c+yGxHqZVSDZZOICcBM=
X-Received: by 2002:a9d:67d5:: with SMTP id c21mr20695015otn.243.1560344313122;
 Wed, 12 Jun 2019 05:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
 <20190612090257.GF3436@hirez.programming.kicks-ass.net> <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
 <20190612122843.GJ3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190612122843.GJ3436@hirez.programming.kicks-ass.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 12 Jun 2019 14:58:21 +0200
X-Gmail-Original-Message-ID: <CAHmME9oWhWi=Gp2RpM0AOO+_1_24znUxDkz6CyJTc2qRgRRivw@mail.gmail.com>
Message-ID: <CAHmME9oWhWi=Gp2RpM0AOO+_1_24znUxDkz6CyJTc2qRgRRivw@mail.gmail.com>
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, clemens@ladisch.de,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for the explanation.

On Wed, Jun 12, 2019 at 2:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
> Either local_clock() or cpu_clock(cpu). The sleep hooks are not
> something the consumer has to worry about.

Alright. Just so long as it *is* tracking sleep, then that's fine. If
it isn't some important aspects of the protocol will be violated.

> If an architecture doesn't provide a sched_clock(), you're on a
> seriously handicapped arch. It wraps in ~500 days, and aside from
> changing jiffies_lock to a latch, I don't think we can do much about it.

Are you sure? The base definition I'm looking at uses jiffies:

unsigned long long __weak sched_clock(void)
{
        return (unsigned long long)(jiffies - INITIAL_JIFFIES)
                                        * (NSEC_PER_SEC / HZ);
}

On a CONFIG_HZ_1000 machine, jiffies wraps in ~49.7 days:
>>> ((1<<32)-1)/1000/(60*60*24)
49.710269618055555

Why not just use get_jiffies_64()? The lock is too costly on 32bit?

> (the scheduler too expects sched_clock() to not wrap short of the u64
> and so having those machines online for 500 days will get you 'funny'
> results)

Ahh. So if, on the other hand, the whole machine explodes at the wrap
mark, I guess my silly protocol is the least of concerns, and so this
shouldn't matter?

Jason
