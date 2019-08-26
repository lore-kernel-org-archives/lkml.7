Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32421C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0479120874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kVhS7eBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfHZPqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:46:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39423 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfHZPqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:46:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id x3so12645633lfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUtEkSG5kTsp7YmVa7FAJXb4NP4nolqiwqp/5TmmW1o=;
        b=kVhS7eBYbwJl2W+rs3K5lxwHETdSIbREf93+C7I/bFgaHC2ZAcLeenp8Hp/jgZ1XOE
         Li6yMP4VViQQj90iHFUBWNN5yIFr/GIvQy/sdzb9ZjESIeoWa9khQKepNPhSG+a/YJIU
         xyyyYFNj9pRJV0eMdfjZAgD5c+i45QQkJw0wRU7qE7uTaUH4Zp4coOM55Bmi8U5SBVj6
         HpjYfpV0ubPA70psLYuGuPrzTL1WH0Sb+15IeQOiSM70JoHIAX7WH+N5GQwZxthhTlUt
         fXbUbJY+bOdTwNA40/706RfheGMTMmUUSX46up1T9HAR4soVa/MZmhhdEXaNvg7D8qsK
         Umdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUtEkSG5kTsp7YmVa7FAJXb4NP4nolqiwqp/5TmmW1o=;
        b=IJ5296NgdTsdfgAwlwLHs4f4BH0RoyWJshBTsX0xo1DJ2F4IUlrB3tg1KK5wm1+97a
         kSpgRdz5IAIazJ6O+UXFVIEUiNjnUTnsjofu9YtmRx1cqQGv3fM/AFqgzvK2M4177VIp
         pkh9w4iIegpNPkMPacJJVR/BqK4OsvEJreoVHi/9cPk4AMz1SEGCGyCPnVFontk08xer
         xh6DbGOiXcjols69B8XjCQiDYJnCEGdbf2rZKU5vhDqwMFXqCdBeMtk4w9IIZIHtkyrF
         NuBUvt/c0e7+U+j93/TfG0SKNj0+H+uNLWCBKdo3wtWP+ni+N43AnWdGH1Hq1qhacTPd
         s3Qg==
X-Gm-Message-State: APjAAAVDsiMJ0oNdw7Kn5uPa4/UwmOP/wpL5hHn2o/tgTmdlS8guAPcZ
        iWPq4NfeyjkVO00UR4oYZNeMTQ4iBoGPJGC7qYhp8g==
X-Google-Smtp-Source: APXvYqyQWc/RQAKI+R+gDKTzw8gV75oM0Rebwd3aJSKMRhRtu5WiZJEN5VTPwqeFhnT94uCkFiLDJAhffWsxIa3lkN0=
X-Received: by 2002:ac2:546c:: with SMTP id e12mr10986869lfn.133.1566834365030;
 Mon, 26 Aug 2019 08:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
 <1564670424-26023-7-git-send-email-vincent.guittot@linaro.org> <20190806160743.GW2332@hirez.programming.kicks-ass.net>
In-Reply-To: <20190806160743.GW2332@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 26 Aug 2019 17:45:53 +0200
Message-ID: <CAKfTPtCVqGZUyu7Xj33jcypJfZbn-4aHuTyN3YNKDL+p-zhq6A@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] sched/fair: use load instead of runnable load
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019 at 18:07, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Aug 01, 2019 at 04:40:22PM +0200, Vincent Guittot wrote:
> > runnable load has been introduced to take into account the case
> > where blocked load biases the load balance decision which was selecting
> > underutilized group with huge blocked load whereas other groups were
> > overloaded.
> >
> > The load is now only used when groups are overloaded. In this case,
> > it's worth being conservative and taking into account the sleeping
> > tasks that might wakeup on the cpu.
>
> This one scares me a little. I have the feeling I'm missing/forgetting
> something.
>
> Also; while the regular load-balance (find-busiest) stuff is now all
> aware of idle, this change also impacts wake_affine and find_idlest, and
> they've not changed.

Yes. I thought about this a bit before applying this changes to all
cpu_runnable_load.
-For wake_affine, it starts by looking at an idle cpu with
wake_affine_idle which is similar in some way to the new load balance
approach even if it might need more changes to align more closely both
paths.
-For find_idlest, it looks at the group with most spare capacity in
priority and fall back to load. That being said I have overlooked that
 both load and runnable load are already used and cpu.load is saved
twice instead of one.

I can't remember detailed results but this patch is responsible of
part of perf improvements described in the cover letter

Also, I haven't touch the numa stats which still use runnable_load.
But this should be addressed too
