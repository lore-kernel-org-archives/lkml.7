Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30895C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 11:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012D82087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 11:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=evidence-eu-com.20150623.gappssmtp.com header.i=@evidence-eu-com.20150623.gappssmtp.com header.b="rlCBOM/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEFLGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 07:06:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45229 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFLGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 07:06:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so16653001wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=evidence-eu-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/WSCEYuhhIZhrdNR3eZzQ9y5FWNDHwa5zFsYG0jxNiI=;
        b=rlCBOM/R+x7A1TwH7u2eH7ftbrxI0jRGxSucYenh5j8cBSOO02xwzogLxxsFR3UtVM
         lQTSUH6HoirCwCpzWZ+MF3XaKYBIgRf5gMhc0f7Z7tbLZ3CmxBsclRm0pGm54yF9oRtT
         ObhlNiUzsm+lemGax0xJ5ZyZIHuHqsDK1Gd9Ihn6xU63A8w5oLn4NsuyxPW3RSXMquD7
         7CwJCkiWufAXUggemXoZC0/riOad+VS1EEMtqsAjNejkwiC1SKEsBR5EQVvGzbzWgS1h
         MsoX60tpXwmEPM4bJt1fe0EA5hyOnXgofJislcdhZr+r2mKhjGNvSWGqfa5ooh+7fIqV
         QTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/WSCEYuhhIZhrdNR3eZzQ9y5FWNDHwa5zFsYG0jxNiI=;
        b=jYF2+vxLbLRgKg83HFsz5+OEr4QUDF8YSMXW7cDE16TfFXqVc6FnayB0WbdS34Y/lx
         O3XcCTUK1sQUTGkZSqymacOzvNJpOHV8ieQSQ5o8esM9+NM+ZVOaH9Z2ccTy0TAZZsYB
         krf12kp6DGve/DhE8s59vKBrElC+TiWcw/jpUXoaovIxbWs7OSlXX/Ky1b7K7y9S1wrD
         ukG0J8vLuRxp5ZtbJ9Bwj4sjgWJ0mPanxiGYAVnj3JGUHQBzHDDG5smTM+AjYpFU6UNg
         4SHsmFLcpFR8HzgVT8Wad2w50Qh4aUFIQE3qLiM28BMvBFT609Jci6DTFc7mTgpDrfS4
         0jbA==
X-Gm-Message-State: APjAAAUKiVLsl5JSX9t3AtG93EeDvHPiVUu1zqtwrIoyr3xYiiNCh2VS
        4uHJX5P4lMvq+rxgJ9EGBOFZIQ==
X-Google-Smtp-Source: APXvYqwIktXi/WewNIG8TzLvHW3qhRUbKBSX8nOz90drrwSLvtYSW34WOiC2qK6P6DTRh0Pd4F0tDQ==
X-Received: by 2002:a5d:5041:: with SMTP id h1mr10039967wrt.181.1557140799720;
        Mon, 06 May 2019 04:06:39 -0700 (PDT)
Received: from erbrow (93-47-161-30.ip113.fastwebnet.it. [93.47.161.30])
        by smtp.gmail.com with ESMTPSA id h123sm12751081wme.6.2019.05.06.04.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 04:06:38 -0700 (PDT)
Date:   Mon, 6 May 2019 13:06:29 +0200
From:   Claudio Scordino <claudio@evidence.eu.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 4/8] sched: Split scheduler execution context
Message-ID: <20190506110628.GA5016@erbrow>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181009092434.26221-5-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009092434.26221-5-juri.lelli@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Juri,

just a small comment for the next round of patches (I guess after
OSPM)...


On 091018, 11:24, Juri Lelli wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Lets define the scheduling context as all the scheduler state in
> task_struct and the execution context as all state required to run the
> task.
> 
> Currently both are intertwined in task_struct. We want to logically
> split these such that we can run the execution context of one task
> with the scheduling context of another.
> 
> To this purpose introduce rq::proxy to point to the task_struct used
> for scheduler state and preserve rq::curr to denote the execution
> context.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [added lot of comments/questions - identifiable by XXX]
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>  kernel/sched/core.c  | 62 ++++++++++++++++++++++++++++++++++----------
>  kernel/sched/fair.c  |  4 +++
>  kernel/sched/sched.h | 30 ++++++++++++++++++++-
>  3 files changed, 82 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fe0223121883..d3c481b734dd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -224,12 +224,13 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
>  {
>  	struct rq *rq = container_of(timer, struct rq, hrtick_timer);
>  	struct rq_flags rf;
> +	struct task_struct *curr = rq->proxy;

You may want to use a different naming for these local variables (e.g.
"proxy") to help the reader in not confusing curr (i.e. scheduling ctx)
with rq::curr (i.e. execution ctx).

Best regards,

               Claudio
