Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FE9C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0AE206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389002AbfFMPkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:40:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44143 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731898AbfFMPkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:40:33 -0400
Received: by mail-qt1-f196.google.com with SMTP id x47so23036851qtk.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 08:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9Bh0y6llVHLrmkzGyw8fJ40ri5A3xFgDIXdEH8E2Z8=;
        b=Tl0ceeHn9Kzch5IQDtL0Doau9m7lFaO55OIzbcJpIlaW6UB5jd12518l9bWuwfBstE
         5MobdrQOZYPP1BS4hpuFQ+GhTm6NiMeOTJZyms4dPpDfYzsR+rmr5OB3gJ71Ne2cG7yz
         Z+9WcF/6qdRxQr6NNjgeFftgR0RTEPHtU9JHb2PJbIer/Sz+Ur/WFOb0hyMsb6rQboQr
         I4rwNBdDGK0ikbt+n7ruXMH6ZMk+5r1QvA/JbN4UKB6fNwVYRz0cBOjNigMXzU05vRd0
         0/kV4XmaofKZl2aIDeYGbb/USZgRRtahoLhpw48ie6ZA5OUNltZPUw41DMvaWDVFT0Ur
         SVbQ==
X-Gm-Message-State: APjAAAVjzN+J+BN5GO9/ueyIyW+mwzuDkULKN6A9WIB0CoqTObrF5TN1
        j+CIoucLBA9saXKxDw2tE7JgeZPMK7O6Mj3ISWZwLzFm
X-Google-Smtp-Source: APXvYqzHVbN7QKEMWI4A194SnnVJaJ5iY1kJRDrkzrQNhViPOGlAqJxxo8BOjj26vsE1B9ojiXfPEZqw/pH3pBxhNf0=
X-Received: by 2002:ac8:8dd:: with SMTP id y29mr10876958qth.304.1560440432692;
 Thu, 13 Jun 2019 08:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
 <20190612090257.GF3436@hirez.programming.kicks-ass.net> <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
 <CAK8P3a15NTV=njOjz-ccYL8=_q_MdEru0A+jeE=f7ufUTOOTgw@mail.gmail.com> <CAHmME9pOWk_ZteUZc_PT19rMn1kfYcXtmLcyAy5sncdV1tNuiQ@mail.gmail.com>
In-Reply-To: <CAHmME9pOWk_ZteUZc_PT19rMn1kfYcXtmLcyAy5sncdV1tNuiQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Jun 2019 17:40:15 +0200
Message-ID: <CAK8P3a3DpRvk1Mw_MKs8wAbRJbMUQoY2UTgK1CF8UOiBQg=btw@mail.gmail.com>
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

On Thu, Jun 13, 2019 at 5:19 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hey Arnd, Peter,
>
> On Wed, Jun 12, 2019 at 4:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > Documentation/core-api/timekeeping.rst describes the timekeeping
> > interfaces. I think what you want here is ktime_get_coarse_boottime().
> >
> > Note that "coarse" means "don't access the hardware clocksource"
> > here, which is faster than "fast", but less accurate.
> >
> > This is updated as often as "jiffies_64", but is in nanosecond resolution
> > and takes suspended time into account.
>
> Oh, thanks. Indeed ktime_get_coarse_boottime seems even better. It's
> perhaps a bit slower, in that it has that seqlock, but that might give
> better synchronization between CPUs as well.

A seqlock is a very cheap synchronization primitive, I would actually
guess that this is faster than most implementations of sched_clock()
that access a hardware register for reading the time.

       Arnd
