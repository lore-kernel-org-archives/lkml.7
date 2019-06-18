Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81F5C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8B52080A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KoP3nBVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfFRJqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:46:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39021 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbfFRJqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:46:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so12430301ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 02:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFNO/LKvYXvmFansFhyqwV2emff3osiWobNFjm+LOZY=;
        b=KoP3nBVtEN46bstqiMPFdsUTbbPqY93iN7frcTYWr8sCkKcBebn35gCjj5jqcvfKhd
         fAuG3oSUIsxzueLCci8XKFWf5vyJEcjs8vc/tenn/7tedfBJnIjkrUS2emDtyh1XcVKN
         oJDo3aSm0I9kNs8kSqe8S7BpxGPY/S1XIGyrpqJwXiVoAjJ21EkDkul6gD/j+g2k7chV
         1q8IYd1jAabrLTjzTFW+sNKXtfxKxoVVe4Tv2xbq9ilJGzSX2Xwu1c6FkoVxQK/B9d7O
         5xswsVa1q7duPRYnUKJhxEn70tEaolrLmQiQYoN4UFh8A5Cuug+J++VyRPd/hcvZEWkl
         4ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFNO/LKvYXvmFansFhyqwV2emff3osiWobNFjm+LOZY=;
        b=tuM3mcKIBdRsj0oyb+jA4LHjPpp/lR0KLIfPcMpq+VzeAhmQzAPOpooQs96TStF9KC
         4dt10SoXtzHUT46Ju5ApFu0wyCuXqqmcGwkBnHOZLTWQgp1UD7GUjPtQCKgZ8hi4QMor
         cWPVXTAhnAKw/Sb/5jL+Mrg9o94J3Tj2Y3bCRv6jHsfqnUqTKOqrVBwtcdeal1/T/57j
         Zy0xPO1m/DZ46X0FHzKgnF6DAJyipy7OkP4LVRaMy4xldXCUTCto9lV4O5dhNmBAbJVM
         CC8UALTI+Ca08D1ZPygZvFjwD1yCDKKDxj32PINVUG+Q3VaLyPj1Uv7X8FR5eI3xYJHW
         e6Vw==
X-Gm-Message-State: APjAAAUGtQ4ywyiwVch66Cee0WUnEWhQxs+aatQQS3cnj7r+iSr5Cax7
        Q6p5WYsqN8a3TkrTAPCehckXkRLu/9XM2JTxzLg73Q==
X-Google-Smtp-Source: APXvYqwLdmo7/UQzJICTwX7MmW1II8rP/12ROJHu2fbSKBjfNIwSirb55B1kWr5B7bMLEWjTiNO044PrL3t15XUYJ7U=
X-Received: by 2002:a2e:1290:: with SMTP id 16mr43089752ljs.88.1560851163194;
 Tue, 18 Jun 2019 02:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <1560783617-5827-1-git-send-email-vincent.guittot@linaro.org>
 <c8030f30-0899-070b-df3c-3839ec7e1909@arm.com> <20190618093453.GN3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190618093453.GN3436@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 Jun 2019 11:45:52 +0200
Message-ID: <CAKfTPtAcV-CS_6hibJa0N6U925KASw1Eg7OSDcBt-Hw_frQkXw@mail.gmail.com>
Subject: Re: [PATCH] sched/topology: remove unused sd param from arch_scale_cpu_capacity()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Quentin Perret <quentin.perret@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 at 11:34, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jun 17, 2019 at 06:07:29PM +0100, Valentin Schneider wrote:
> > Hi,
> >
> > On 17/06/2019 16:00, Vincent Guittot wrote:
> > > struct sched_domain *sd parameter is not used anymore in
> > > arch_scale_cpu_capacity() so we can remove it.
> > >
> >
> > I think it can't hurt to give a bit of background. The *sd parameter used
> > to be there for smt_gain, which got snipped out by:
> >
> >   765d0af19f5f ("sched/topology: Remove the ::smt_gain field from 'struct sched_domain'")
> >
> > I'd appreciate having that commit mentioned in the log.
> >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >
> > Other than that, the changes look fine to me.
> >
> > Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>
> The commit log now reads:
>
> ---
> The 'struct sched_domain *sd' argument to arch_scale_cpu_capacity() is
> unused since commit:
>
>   765d0af19f5f ("sched/topology: Remove the ::smt_gain field from 'struct sched_domain'")
>
> remove it.
> ---

Thanks
