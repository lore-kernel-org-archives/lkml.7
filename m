Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECFFC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565D5207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iEyNa/9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437628AbfFLJou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:44:50 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:39201 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfFLJou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:44:50 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 3aa1f9dc
        for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jun 2019 09:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=jw7eJKusxhfbRUg0PWGjDLuQjpo=; b=iEyNa/
        9vFkSoUFem/4Pu/awjoeqashzIFJISiTCNPKdUzn7hQx4KqPvqPCcgFNdMxH5Yq5
        V4Fy+qpEabD3yVdgI5EgZGzWLu4XBukH577+njg1J9WlJJe7IHFQAcdS+PRHFu3d
        TYZamduokgTVFNsfZz6AXwLR6BF/8/Drhb6GifEQa54hN8S1lYLrqV246QOTDFcT
        /aM49qA9GYd2u85tCkTcI9L4sVP+nzuj65OE7GRa3q0QcUEo096xehr4bIbXE1Wa
        QJ0ADw2gsYuGVMOSj21jDoFSQ+EdAnyG31LasHFqojL7im7Xvg+BSpGNP+nmpPyI
        kU3o8F6B29879ssQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b4eda302 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jun 2019 09:12:33 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id l15so14776547otn.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 02:44:47 -0700 (PDT)
X-Gm-Message-State: APjAAAVMJn56Jsd37topsGQLIfJcL8H6isZf+/RZbVg9YrdTBomWlvAV
        ZwxF6dCRC6Z/gCkacS0LFC+WqaFDmKdB0xfeP3Y=
X-Google-Smtp-Source: APXvYqxKNF3YLrcFFKzHs347TJ70NrRaLOtWW6xv0Tv28ctD0qheDzojT1OXtZFdzGZJyU7SFW1HE/ancmk34KcQSgg=
X-Received: by 2002:a9d:4f0f:: with SMTP id d15mr38574597otl.52.1560332686615;
 Wed, 12 Jun 2019 02:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de> <20190612090257.GF3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190612090257.GF3436@hirez.programming.kicks-ass.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 12 Jun 2019 11:44:35 +0200
X-Gmail-Original-Message-ID: <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
Message-ID: <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
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

Hey Peter,

On Wed, Jun 12, 2019 at 11:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
> How quasi? Do the comments in kernel/sched/clock.c look like something
> you could use?
>
> As already mentioned in the other tasks, anything ktime will be
> horrifically crap when it ends up using the HPET, the code in
> kernel/sched/clock.c is a best effort to keep using TSC even when it is
> deemed unusable for timekeeping.

Thanks for pointing that out. Indeed the HPET path is a bummer and I'd
like to just escape using ktime all together.

In fact, my accuracy requirements are very lax. I could probably even
deal with an inaccuracy as huge as ~200 milliseconds. But what I do
need is 64-bit, so that it doesn't wrap, allowing me to compare two
stamps taken a long time apart, and for it to take into account sleep
time, like CLOCK_BOOTTIME does, which means get_jiffies_64() doesn't
fit the bill. I was under the impression that I could only get this
with ktime_get_boot & co, because those add the sleep offset.

It looks like, though, kernel/sched/clock.c keeps track of some
offsets too -- __sched_clock_offset and __gtod_offset, and the comment
at the top mentions explicit sleep hooks. I wasn't sure which function
to use from here, though. sched_clock() seems based on jiffies, which
has the 32-bit wraparound issue, and the base implementation doesn't
seem to take into account sleeptime. The x86 implementation seems use
rdtsc and then adds cyc2ns_offset which looks to be based on
cyc2ns_suspend, which I assume is what I want. But there's still the
issue of the 32-bit wraparound on the base implementation.

I guess you know this code better than my quick perusal. Is there some
clock in here that doesn't have a wrap around issue and takes into
account sleeptime, without being super slow like ktime/hpet?

Jason
