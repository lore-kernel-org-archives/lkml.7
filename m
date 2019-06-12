Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39356C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121E320B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392018AbfFLOBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:01:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38155 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389885AbfFLOBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:01:23 -0400
Received: by mail-qk1-f195.google.com with SMTP id a27so10276102qkk.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1swvZXHALFzo5B0B5qOatWzKoRBzeWa4TX1TTtEgsXk=;
        b=czY+BBQ5W/klt7EaR46IQcTifLqUeV/H5Zq6JZmHlgxdSmtQlt35olXZsMENKX8TEM
         u0+vN09Gx+n8vl5nWE64ba+ZGkQ3qGmU6U7QsdJaBz4Czp3MULBJPpHPu6ORS+ttxXX2
         27Rd94/ZHM3OIhPMNW5OpVF6/gv9jqwtOQ+opW3KdNXsX6+9VVWzF/6TB+CHXH+6JT55
         dpkly07V9A4CYNatuPGZ5dkWhGnaPVcy0864qoY409BjFpXbnIshHOBTvVp4YFrJX7jP
         HY7LCBYvqBS9h3UYMiRyPGaxgYc7U/aDqkilRz+JqszKNZNZFg+cv7j1+2Qnx8foOqUS
         tCpw==
X-Gm-Message-State: APjAAAU6oAgcLZX5CD54klI5j1tN8eBp3HGPlZih/sa150jv0JiCOaca
        g8VzYs4/xGuzoNa1DDsNPj7ziZTKOeYnYB6PRsQ=
X-Google-Smtp-Source: APXvYqzbvgtvFbqZUuKDRi0jv3yrRi2Q/SNQBnsYqrQZCCDBQYbZ+fVsnRCSrfxRCPbz9y4EAFToxFSIGn4jvsj7hrw=
X-Received: by 2002:a37:a4d3:: with SMTP id n202mr64562583qke.84.1560348081942;
 Wed, 12 Jun 2019 07:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
 <20190612090257.GF3436@hirez.programming.kicks-ass.net> <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
In-Reply-To: <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Jun 2019 16:01:04 +0200
Message-ID: <CAK8P3a15NTV=njOjz-ccYL8=_q_MdEru0A+jeE=f7ufUTOOTgw@mail.gmail.com>
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:46 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Wed, Jun 12, 2019 at 11:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > How quasi? Do the comments in kernel/sched/clock.c look like something
> > you could use?
> >
> > As already mentioned in the other tasks, anything ktime will be
> > horrifically crap when it ends up using the HPET, the code in
> > kernel/sched/clock.c is a best effort to keep using TSC even when it is
> > deemed unusable for timekeeping.
>
> Thanks for pointing that out. Indeed the HPET path is a bummer and I'd
> like to just escape using ktime all together.
>
> In fact, my accuracy requirements are very lax. I could probably even
> deal with an inaccuracy as huge as ~200 milliseconds. But what I do
> need is 64-bit, so that it doesn't wrap, allowing me to compare two
> stamps taken a long time apart, and for it to take into account sleep
> time, like CLOCK_BOOTTIME does, which means get_jiffies_64() doesn't
> fit the bill. I was under the impression that I could only get this
> with ktime_get_boot & co, because those add the sleep offset.

Documentation/core-api/timekeeping.rst describes the timekeeping
interfaces. I think what you want here is ktime_get_coarse_boottime().

Note that "coarse" means "don't access the hardware clocksource"
here, which is faster than "fast", but less accurate.

This is updated as often as "jiffies_64", but is in nanosecond resolution
and takes suspended time into account.

      Arnd
