Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF75ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238A020873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+OAQ9IK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbfJNO6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:58:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41625 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732606AbfJNO6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:58:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id r2so12019672lfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkMPQ0LrWyijz11NY5m0dmZYPiuXzrUEUbYC0qMqHT0=;
        b=C+OAQ9IKKfx8e2rgas2AZ/0OGtlN4cljS5G/pxMlqfJVHoV9hGaOFEZXBC6WZgyz5g
         6bQfXmBG1AwfT8bPzH56YybQxmcQ/ojzp4XFbBO2fgPtl2211m1hUna+mID/Ts6vRoNV
         fP5dmjjtLtkd/JWDSlrMUZM0Gb2CExkVb8loj4Uoej2q98lBhBLnsG0Sgeg2xRyUD5JI
         CZxxPfWamLz/Jp3UwnStL0Na13rkuarQ2VlpFIHgP7zCvejyFaymFXbasLe54gwTOjl0
         UFheRmi8QXQ4TIodN4AkDokdrprbIfbZPgj84p8Ao0G8PONXh5YoGl5LUuJg6T8dFJnm
         6Fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkMPQ0LrWyijz11NY5m0dmZYPiuXzrUEUbYC0qMqHT0=;
        b=M445rda1cpw1OzO+BnpcZk1EAgqoPo52Zl744vAE46m/9uyz1f3SnZu3HCOncAxZL0
         cCaSjQmpR004wOYkQPsRiq8urAfENrzXdZ0s6B8TXb8hAmpvdeQm6MBXI1G8taCG6SNP
         WVXfFUZ+4e4LHRsEGT7PHW4IeikwCotniO8ENdWlpA86TlwbfHa4FWUIW2Mb1FF60jvi
         66d+TYJo/z6OItwzCJg2uGFO3wfuUtbepyEuQLBEI63RsJeU1DS1KOSfV2ca/Ur+nf96
         MwvvHLjaeOFx5L8oL6pv2NcvXVxa4E5t2stJMLq/BQjU+wAtRIIvzZH6/mFB+Z1qr2L4
         FhMA==
X-Gm-Message-State: APjAAAWOnMW1TScwVBggvqpDQqDLY11USdqobdvQNbFs4WNDRN39WFzp
        cxjjWOJkvkDitheqI3VCUkYZb4LM8ig64CGCpmORCA==
X-Google-Smtp-Source: APXvYqyver79gBl47T+XusZQVNebkHis2dYvxUgZLilvocoQWhgpFd2wvwu3K2QPqmBF3HGmydaXZADiOqjHGU+7srw=
X-Received: by 2002:a19:7409:: with SMTP id v9mr16419666lfe.125.1571065084369;
 Mon, 14 Oct 2019 07:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150555.15717-1-patrick.bellasi@arm.com>
 <CAKfTPtDTfyBvfwE6_gtjxJoPNS6YGQ7rrLcjg_M-jr=YSc+FNA@mail.gmail.com>
 <20190628100751.lpcwsouacsi2swkm@e110439-lin> <20190628123800.GS3419@hirez.programming.kicks-ass.net>
 <20190628140057.7aujh2wsk7wtqib3@e110439-lin> <20190802094725.ploqfarz7fj7vrtp@e110439-lin>
 <20191014145218.GI2328@hirez.programming.kicks-ass.net>
In-Reply-To: <20191014145218.GI2328@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Oct 2019 16:57:52 +0200
Message-ID: <CAKfTPtDK-KSVz6HSr185yEj2TzZrNRx5FG_pUpp0-rxHWsXurQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: util_est: fast ramp-up EWMA on utilization increases
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Douglas Raillard <douglas.raillard@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019 at 16:52, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> The energy aware schedutil patches remimded me this was still pending.
>
> On Fri, Aug 02, 2019 at 10:47:25AM +0100, Patrick Bellasi wrote:
> > Hi Peter, Vincent,
> > is there anything different I can do on this?
>
> I think both Vincent and me are basically fine with the patch, it was
> the Changelog/explanation for it that sat uneasy.

I agree

>
> Specifically I think the 'confusion' around the PELT invariance stuff
> doesn't help.
>
> I think that if you present it simply as making util_est directly follow
> upward motion and only decay on downward -- and the rationale for it --
> then it should be fine.
>
>
