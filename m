Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1123EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE9F20637
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3xgqyeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfKVKmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:42:40 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37869 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbfKVKmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:42:37 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so3180222qtk.4;
        Fri, 22 Nov 2019 02:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDn7FS4SAgH0QhCylJqZk4OImBfIGahmhNJNYk8fboQ=;
        b=W3xgqyeqzc1g9z9cGNgL/1zxvxktUS9d9JPTPlMBZww93GLOp5eBujm6EDWu4BzAAP
         vGShsGNSes8Am4A8yrCqLsmLrgEdY66dPtktpk835tVCZfO77xAfu/4+tlv44C5NyjxO
         fijv8NfTQSyl7gIpYAqNAF5RdULH53Y3Wko8jfVjNSFysMD5saKotamHvLN94pp5Dulq
         mpauleZ1TnO2tj/atrJQmSY9m1d6bhFCAOLT/SEqpHWvhG2DYt6UM9jQJAzQEveZ3/5L
         kXW0UZdwAgi66qKpNep70cwgPfvxI8nWHrtwLDJYdA/dkbXDi4St1wzGu/68ys+QByrD
         OnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDn7FS4SAgH0QhCylJqZk4OImBfIGahmhNJNYk8fboQ=;
        b=DTFlE81Ub5ucCAJjEDy6c8pDX3uRzK/MCneiQtvClV23/aFA94NkUXTHP7oY4EQ6V/
         LEioJNSRjDT50pWUOHtvfdi8gUgU70qWuplUfBcvQcFdUJmojvL+ezPOwhC/yvE1d6m2
         kMos2bBTs+yNkvU9LbJ7Ae7DB6Ti211g693+ukQDTU2M7AGT9+RrgtBN4rKFvA5Cm9iT
         wNbrFrVJ8Jy0X+RuoCvJpo8tcu/hbhNNARUHnFzKz4svEzM+DJb7jTEGjeORQZL9YJIa
         chz3LivAUEQXnv/HI6xzBvnwtC68hF//mQcay+ipNq10hIt6oJFq3cK24uAXVbajKebZ
         9XwA==
X-Gm-Message-State: APjAAAVFGNFcYwG0qJk61DQ1UpnDIN3d3YZNum+djYB+Kxl8uQSYbXih
        AsdBanY60Haq6BFj/IHcybiXAuQeqMj/uQtycww=
X-Google-Smtp-Source: APXvYqw30MASIwXblRUj1dC6Gt3Qk76pcbnxlOxwl1bC9SrAwzyZZdFoMraU/vhrgWhGTS9lZb1VMcHVAMMULSFHc+8=
X-Received: by 2002:ac8:3f5d:: with SMTP id w29mr13600844qtk.3.1574419355678;
 Fri, 22 Nov 2019 02:42:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574073572.git.baolin.wang7@gmail.com> <81d66ceaa2763cfc1e5ccb605bb3a4194b947f0d.1574073572.git.baolin.wang7@gmail.com>
 <CAK8P3a1bUt+HERWtGEKmhdD9ctX0GRQQbXHxtUnJ8KNu=v87aw@mail.gmail.com>
In-Reply-To: <CAK8P3a1bUt+HERWtGEKmhdD9ctX0GRQQbXHxtUnJ8KNu=v87aw@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 22 Nov 2019 18:42:22 +0800
Message-ID: <CADBw62qW46KyEuj-YOw21sKxLB_uWxxWa_0-0JOXi-6Y48g0hw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] mmc: Add MMC host software queue support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Nov 22, 2019 at 6:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Nov 18, 2019 at 11:43 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > From: Baolin Wang <baolin.wang@linaro.org>
> >
> > Now the MMC read/write stack will always wait for previous request is
> > completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> > or queue a work to complete request, that will bring context switching
> > overhead, especially for high I/O per second rates, to affect the IO
> > performance.
> >
> > Thus this patch introduces MMC software queue interface based on the
> > hardware command queue engine's interfaces, which is similar with the
> > hardware command queue engine's idea, that can remove the context
> > switching. Moreover we set the default queue depth as 32 for software
> > queue, which allows more requests to be prepared, merged and inserted
> > into IO scheduler to improve performance, but we only allow 2 requests
> > in flight, that is enough to let the irq handler always trigger the
> > next request without a context switch, as well as avoiding a long latency.
> >
> > From the fio testing data in cover letter, we can see the software
> > queue can improve some performance with 4K block size, increasing
> > about 16% for random read, increasing about 90% for random write,
> > though no obvious improvement for sequential read and write.
> >
> > Moreover we can expand the software queue interface to support MMC
> > packed request or packed command in future.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
>
> Overall, this looks like enough of a win that I think we should just
> use the current version for the moment, while still working on all the
> other improvements.
>
> My biggest concern is the naming of "software queue", which is
> a concept that runs against the idea of doing all the heavy lifting,
> in particular the queueing in bfq.
>
> Then again, it does not /actually/ do much queuing at all, beyond
> preparing a single request so it can fire it off early. Even with the
> packed command support added in, there is not really any queuing
> beyond what it has to do anyway.

Yes. But can not find any better name until now and 'software queue'
was suggested by Adrian.

>
> Using the infrastructure that was added for cqe seems like a good
> compromise, as this already has a way to hand down multiple
> requests to the hardware and is overall more modern than the
> existing support.
>
> I still think we should do all the other things I mentioned in my
> earlier reply today, but they can be done as add-ons:
>
> - remove all blocking calls from the queue_rq() function:
>   partition-change, retune, etc should become non-blocking
>   operations that return busy in the queue_rq function.
>
> - get bfq to send down multiple requests all the way into
>   the device driver, so we don't have to actually queue them
>   here at all to do packed commands
>
> - add packed command support
>
> - submit cmds from hardirq context if this is advantageous,
>   and move everything else in the irq handler into irqthread
>   context in order to remove all other workqueue and softirq
>   processing from the request processing path.
>
> If we can agree on this as the rough plan for the future,
> feel free to add my

Yes, I agree with your plan. Thast's what we should do in future.

>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your reviewing and good suggestion.

Ulf,

I am not sure if there is any chance to merge this patch set into
V5.5, I've tested for a long time and did not find any resession.
Thanks.
