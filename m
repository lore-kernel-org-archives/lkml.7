Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA30CC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7ED62173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxCBLiES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfIBHvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:51:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34900 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbfIBHvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:51:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id w6so4323628lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 00:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgQIfkhFcrFGU5hMZoKL+RDRewdU3HBJ150KAlIl9RE=;
        b=XxCBLiESv5LTqYDnHsjj28/D7tDo2aPlte3WvuR2bUg+VyNOqKBnq+Oas8a4M42jrv
         pkPKe1aSDyBRoqxe3dmUUBmK8h/ASQM1JeaG7yoL9BGMV4lb+d43Q6mrevN6BZnIRgee
         ylL9eUOaEqLJeq4eeu0sHBYVsZYFr8uB9gLadyxCtIm72cWA8UzcuDW8fpj7CT792Yi8
         JKSV9ZJZ0mujq35inN0rhsRDhDDtPjO0vIcFl+CjPmxBNSPGdWNQ2tpgOsmQ0uPjx0Kp
         x5QiGSC1xWBbw9YKBqjv/g2hBUUX/utcVecK1i2GnTDo7I70CIqFPRYJ167raw8/7zr1
         TXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgQIfkhFcrFGU5hMZoKL+RDRewdU3HBJ150KAlIl9RE=;
        b=lYJ9R6BzzjDS/khjVySrF3aPNQaOz5AvuokuSNEyUws743PzswYKMKLRMgkUjVA3hj
         9e0MlJPQzBc6sa9hekaDK6Y668nKZuovf2KsQjvCPc+uRhPjNpE/mzw8Vc6FRxAcG9fT
         lOCGQCku5yqd9mo11Qt5CQsiQmS9mFX7GDQZKGVZ5mSte5RJyyW5m2YkfuJaV4XqjMBm
         LFNTzjJXUyR3hGJMTtedfgl45lZIQJCjkEF/u0irRbaeuanjbWw3iJOhMzs4vuA6pguV
         8Db2ohxHHT1KmTU5VJf2wMwnwaRBgg9j1Vs7DVtUxNXBD4sTomYHW/1XSQ5gwNgivUIo
         jiwQ==
X-Gm-Message-State: APjAAAW2o+zbH8rwKrjM0QsJyXuJT2py0/K62MfZcR8Zz4BPj0cWuU/X
        lVASorMkzjjaa4iZllOxGJRU1VEZ4d+K5j+uX2T6gw==
X-Google-Smtp-Source: APXvYqxfu67qXvFpunVKfTvhu1poEtXHICrITav0HQKiECKU4fUtEw4VFRsf+uJLW/zxPIArRoPyj6RERMVQ2r0iXm8=
X-Received: by 2002:ac2:5a07:: with SMTP id q7mr7221938lfn.177.1567410681442;
 Mon, 02 Sep 2019 00:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190822021740.15554-1-riel@surriel.com> <20190822021740.15554-9-riel@surriel.com>
 <CAKfTPtDxHijR3PCOFfxA-r02rf2hVP4LpB=y-9emHS7znTPxTA@mail.gmail.com>
 <d703071084dadb477b8248b041d0d1aa730d65cd.camel@surriel.com>
 <CAKfTPtDX+keNfNxf78yMoF3QaXSG_fZHJ_nqCFKYDMYGa84A6Q@mail.gmail.com>
 <2a87463e8a51c34733e9c1fcf63380f9caa7afc4.camel@surriel.com>
 <CAKfTPtCAU7bT3sJ_FPexqKrfFzd8Yk0hVTEB5Da=+VbqPViXpA@mail.gmail.com> <2d3af2a8b6a433ea44a4605fc8b43bd0758102eb.camel@surriel.com>
In-Reply-To: <2d3af2a8b6a433ea44a4605fc8b43bd0758102eb.camel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 2 Sep 2019 09:51:10 +0200
Message-ID: <CAKfTPtBddg=_cDU7YDnk19uUjtSP+82fE7Yb28KPrSctimGNdQ@mail.gmail.com>
Subject: Re: [PATCH 08/15] sched,fair: simplify timeslice length code
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 at 17:02, Rik van Riel <riel@surriel.com> wrote:
>
> On Fri, 2019-08-30 at 08:41 +0200, Vincent Guittot wrote:
>
> > > When tasks get their timeslice rounded up, that will increase
> > > the total sched period in a similar way the old code did by
> > > returning a longer period from __sched_period.
> >
> > sched_slice is not a strict value and scheduler will not schedule out
> > the task after the sched_slice (unless you enable HRTICK which is
> > disable by default). Instead it will wait for next tick to change the
> > running task
> >
> > sched_slice is mainly use to ensure a minimum running time in a row.
> > With this change, the running time of the high priority task will
> > most
> > probably be split in several slice instead of one
>
> I would be more than happy to drop this patch if you
> prefer. Just let me know.

If i'm  not wrong, this change is not mandatory to flatten the
runqueue and because of the possible impact if you would prefer to
drop it from this serie

Regards,
Vincent

>
> --
> All Rights Reversed.
