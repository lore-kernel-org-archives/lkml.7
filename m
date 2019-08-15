Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFE3C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD3C2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lX/+/pbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbfHORWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:22:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36564 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729931AbfHORWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:22:48 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so656660iom.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPHDIOljV5hQaERK4FC6PgOmZFfQHVVab+DpiSEe62s=;
        b=lX/+/pbPgVYuikGECsCt+M8bkwOrFQVZRfUmqOQPaMX1z9CL2Yc1cjJHNpNYU4Sbrn
         bz3T9KHyos41p1xP12MdWHQX26nF9Y3GlGKfhpewxe2Rc3ijwD8hHHyukD99wq6Q2x6v
         PgL5MVdMZXWnZDtH/3OHfqd9z9BqsKmkGgd2jnQsyqV4EciddEOt4ubAYIPB/hUmpsTg
         KO3sU3cRyCNUpTzwGC0S7Hi46ohz4Vv3cJJoKy0STcxJwuDqx7wiQVo7bxAxKtLhDDnW
         3APvUEGu/YYpyL2u8P1u9hln1OTcnmmvcAsICdmLl598yRShpj6b5MVHjQoVglmpk2rD
         2b3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPHDIOljV5hQaERK4FC6PgOmZFfQHVVab+DpiSEe62s=;
        b=SfDBStyJrnLlRzHG4JOzm52V1KqYPZN3Ffyx5gTEJTQIIXGreeiysKxFa/9ggbAHA6
         Sxtu7MKjxrq2KuoNpPzDsW8Du8EdlOPpQ0m/K5S5+YbnMwr0oJe5go/mgzAn0CyNgxhq
         /bA6kwigeoUPN3QNK08pAgi3vmYYDOhqmJ/9WTcwAkcj2B4V1hWqqNmNx7FLQEdSwswh
         orTgRFO3FxAFX/0XaUeWduh8kkC+JYoJdjnBAeSdDIKLRElZANlnDO7FMWPyACRFQq68
         LyS3CmQ68FDl6z14yHgco1/0uJ6NYlAMMXEV2+iR/UHReJisZ9hSapm4b4+YG67j6kY4
         Kb2A==
X-Gm-Message-State: APjAAAUNluyHCp5KYWeEWIGpYQyh3fq3t3jXWG2lBmceeBAnauhQqHh/
        Y0cM/VuPCtLZ8FnTtAyF2hIlVc6A9Z4h3DdR5du6GZCN
X-Google-Smtp-Source: APXvYqyM8y6XV3ud8k+ti2yuhyZmBt2wQ3LZoMTRTv3ex/apV+hFyTyTpYDw/Dstjey1CnvaQ1AzxIqk9gDnK49wd9Y=
X-Received: by 2002:a5e:c601:: with SMTP id f1mr6364484iok.57.1565889767438;
 Thu, 15 Aug 2019 10:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <CANLsYkz3_bzRCQEVb00Tbf3Rdww13mePN-woncctOu7OanF00A@mail.gmail.com>
 <20190814235058.184204-1-yabinc@google.com>
In-Reply-To: <20190814235058.184204-1-yabinc@google.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 15 Aug 2019 11:22:36 -0600
Message-ID: <CANLsYkwG-nCzomcr2n8T5NaFp-y_Efft+4mbH0Fb1yNE=Lgepg@mail.gmail.com>
Subject: Re: [PATCH v2] coresight: tmc-etr: Fix perf_data check.
To:     Yabin Cui <yabinc@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 at 17:51, Yabin Cui <yabinc@google.com> wrote:
>
> > Did you actually see the check fail or is this a theoretical thing?
> > I'm really perplex here has I have tested this scenario many times
> > without issues.
> >
> I have seen this warning in dmesg output, that's how I find the problem.
>
> > In CPU wide scenarios each perf event (one per CPU) is associated with
> > an event_data during the setup process.  The event_data is the
> > etr_perf holding a reference to the perf ring buffer for that specific
> > event along with the etr_buf, regardless of who created the latter.
>
> Agree.
>
> > From there, when the event is installed on a CPU, the csdev for that
> > CPU is given a reference to the event_data of that event[1].  Before
> > going further notice how there is a per CPU csdev and event handle to
> > keep track of event specifics[2]. As such both (per CPU) csdev and
> > event handle carry the exact same reference to the etr_perf.
> >
> On my test device (Pixel 3), there is an ETM device on each cpu, but only
> one ETR device for the whole device. So there is only one instance of etr
> csdev in the kernel. If multiple cpus are scheduling on etm perf events at
> the same time, all of them are trying to set their event_data to the same
> etr csdev. And different perf events have different event_data. A warning
> situation is as below:
>
>    cpu 0
>    schedule on event A (set etr csdev->perf_data to event_a.etr_perf)
>
>    cpu 1
>    schedule on event B (set etr csdev->perf_data to event_b.etr_perf)
>

You are 100% right and looking at it again this morning it just jumped
at me.  I simply can't understand how it did not manifest itself
during all the hammering I did on it.

Please see details in my other (and upcoming) email.

Thanks,
Mathieu

>    cpu 1
>    schedule off event B (update buffer, does nothing since csdev->refcnt != 1)
>
>    cpu 0
>    schedule off event A (update buffer, but etr csdev->perf_data check fail)
