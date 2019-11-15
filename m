Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E537C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 11:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED92E206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 11:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="arpWgUiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKOLDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 06:03:46 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45999 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKOLDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:03:45 -0500
Received: by mail-lf1-f67.google.com with SMTP id v8so7671280lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 03:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0F7zdvisCztvSZbyo1EvoXH0ott3e3tl9NiIJpij2a0=;
        b=arpWgUiut+0/FjbZ8f+UHt/t9t/VsAL1xks15UgJS+fxN5uCi/d5bMxdGb0F+RAqFH
         mv63ONrV0cYmcbsb+SZ7V+T7RhMf0HcSbAmmVrFz3ueL04aX0W7STXZI3fSXqO8RvnOX
         MDPmic+3lTLCfE3shgRQ05TJSK5qKNVaUDLvaUL8ck32gy3hLD0O2twOfGw/up57lB0I
         b+Cuik8yv8xvZzfyatAyyHso23WhPKm6OH7JAHaffVoNkErBhO1Kp2/GOJmzYm3OFOyv
         QqjSvhGT+yfdrPYw+k/yDwf7ttguAbzfGvGjZYswEY/RXYdao8PbhRV+qrg0y+uX5og6
         W3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0F7zdvisCztvSZbyo1EvoXH0ott3e3tl9NiIJpij2a0=;
        b=YU+tMdlUdQ8o11zpuUx4OuvWxp5aM6Lh+LCTJxNjj4i3zwXlEz9VHEPbm2Q0SFQnic
         Mza67JygPGzcR1E1LqwAzyJ6tlta+jq6cHuwkkRIduTZhNK+D/RMoKGtQLMlNkcAn8yh
         9u1zodeUqRclJtlxW3a45vtQzszadvCjkGoXXTd7R2J0tmC5vS7y9OEMBwPVeOcNutrp
         9g4CYB+/LleZNL5eGWvN4d/7FmpzEmv1ZOZOXIfgzh2h4UYm6ArorOdo0qNNnGr9y19Z
         n2qTFr73hQ0M/z7xjeKyBYp+XTFxzbZ1uWASva0IieBxTIifZ1D7YxqBtjo1ea8vvUST
         vENg==
X-Gm-Message-State: APjAAAWfPW8ONA5BEmaBfyTjujon+d/M38pQ10WWV5RDQf7rJWMHAEOB
        LEtmzOe3KlVnIqGhOtRMBW5GycFlgA0unsJQonFXSw==
X-Google-Smtp-Source: APXvYqzNFr0pVMd/dd6uUBcaV2TCKX6w6VTIRDrMGjPTmj4/XSZ1U72gqjsmZn8F1xWAA67T8qUuhi8cacRdkAOdWlE=
X-Received: by 2002:a19:ed12:: with SMTP id y18mr10424378lfy.151.1573815823472;
 Fri, 15 Nov 2019 03:03:43 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115095447.GU4114@hirez.programming.kicks-ass.net> <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com>
 <20191115103735.GE4131@hirez.programming.kicks-ass.net> <CAKfTPtDi_-h6g+rhV04XXjqpWprC2vT6hgLZSrTW5rdD54PrQA@mail.gmail.com>
 <20191115105110.GG4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191115105110.GG4131@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 12:03:31 +0100
Message-ID: <CAKfTPtC3g4iCxvAJo9Km9fZ0fPSw5Jt9TY2+xF7kxGmOZ66gxw@mail.gmail.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 at 11:51, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 15, 2019 at 11:46:01AM +0100, Vincent Guittot wrote:
> > On Fri, 15 Nov 2019 at 11:37, Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > Sure, but then it can still remember the value passed in last and use
> > > that state later.
> > >
> > > It doesn't _have_ to completely discard values.
> >
> > yes but it means that we run at the "wrong" frequency during this
> > period and also that the cpufreq must in this case set a kind of timer
> > to resubmit a new frequency change out of scheduler event
>
> But if, as you say, we're completely shutting down the event stream
> when everything has decayed, that's still true, right?

But It doesn't because there is nothing else to do.

This patch does 2 things:
- fix the spurious call to cpufreq just before attaching a task
- make sure cpufreq is still called when cfs is 0 but not irq/rt or dl

There are somehow related but not fully
