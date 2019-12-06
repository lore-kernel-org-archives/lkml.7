Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BC8C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AA121835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wuxu/Iji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfLFQsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:48:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37393 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfLFQsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:48:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id u17so8365893lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 08:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l9922XS0/5sK6Mm8Gladx+NVvR7YZ06ZYEgYIIhOikA=;
        b=wuxu/IjiI4CspPyI4emB5DdDqtCtf8x8fa7Kzumq3lLI1rTb0HriuzVQfkDYMxrsZL
         rdZE+ixNwWojqxBEb5cC+G2OlRxOBrz2wws7JpyjXg5+4W6c3tNFNLBZLGDXjy292e3Z
         orsuHXrVlcEcqcwf9MdyDqHbIU6OiI9mC1N/sCp86jK9nGQDc+A0743A4dtW3Vsv68Ix
         MfTKbFvMH5R6SlKAXKXYQ2wVlsnHGmQFYkAy5YL1148QtACPan4RSe3NMCDbPB7R7I+2
         ylrjK/5DuXwS36ZNRqLTauKswANvlyLqhBy1BZar8K1IJ5E8H42KyLWPV0OqCPWLuLQa
         HAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9922XS0/5sK6Mm8Gladx+NVvR7YZ06ZYEgYIIhOikA=;
        b=NcQ50+YfvRECJBh0Vij+Lho+W5d4+x6ChlXO9RJc7AxIntCmWpn5KBbS5uWyCQJBuE
         LAzJhBXBVfFhNPnhnr4muzIGH4+xgvfKxXHfZE6Rlb0Z5zH+DlQCl1ENWfg+ndeFxcNm
         Hy2dR0lcFa0DV+MSa8jOHNzCuLwjOBRJpwK1pAZrndxxwu/s1AX3GzpR5SAZ2og0lsM1
         hVGd8j2emxbr01QQssz54l2qBG/lXsq0oZeboUnSVMRejzO6rDvEqX4lAbjPBMzJxXvp
         WqiDZmZzq/WwfTB0+jYi9080afy5J4iXCtaOmXfCARCZvyfMYRnzW7xDc1XAt/4hlfcV
         TgEw==
X-Gm-Message-State: APjAAAXhTgclWPZoSnISU4B29rpaDk6bLMsv6eJm5zWeD/5PSZsU/zNd
        0AmCwIv0UIEuDTh7tyy7vDW85PeQ3KPhZjWDb0XpAw==
X-Google-Smtp-Source: APXvYqyY1CrFojie90huUD1HXu26vXWdn2iuf91QfB3mWejnhxE0nW9UP66OKdFkv+gLks+ENBGb/iKa9QXVpS8Q7JI=
X-Received: by 2002:a2e:6a14:: with SMTP id f20mr9651643ljc.87.1575650909672;
 Fri, 06 Dec 2019 08:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20191205172316.8198-1-srikar@linux.vnet.ibm.com>
 <CAKfTPtBH9ff=efTeJbM4UdzrHCXZs7wwn=pdE4As8pB859e++Q@mail.gmail.com>
 <20191205175153.GA14172@linux.vnet.ibm.com> <CAKfTPtDp097ww0war7H1THtRxDWzA3CDuokDQSUoqzRDcD1d3g@mail.gmail.com>
 <20191206081654.GA22330@linux.vnet.ibm.com> <CAKfTPtBOVe+-fMBd+oHxZ51q5GtaxR6uyYep+a+NWJArbV9EcQ@mail.gmail.com>
 <20191206133930.GA25024@linux.vnet.ibm.com>
In-Reply-To: <20191206133930.GA25024@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Dec 2019 17:48:16 +0100
Message-ID: <CAKfTPtBgosOpf-8SEkWxGtcLUypjYz8uspM0+fe57t3AjsS-Yw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Optimize select_idle_core
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2019 at 14:39, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> Hi Vincent,
>
> > >
> > > Collecting ticks on a Power 9 SMT 8 system around select_idle_core
> > > while running schbench shows us that
> > >
> > > (units are in ticks, hence lesser is better)
> > > Without patch
> > >     N           Min           Max        Median           Avg        Stddev
> > > x 130           151          1083           284     322.72308     144.41494
> > >
> > >
> > > With patch
> > >     N           Min           Max        Median           Avg        Stddev   Improvement
> > > x 164            88           610           201     225.79268     106.78943        30.03%
> >
> > Thanks for the figures. Might be good to include them in the commit message
> >
>
> Since I needed a debug/hack patch on top of upstream/my-patch to get these
> numbers, I wasn't sure if this would be ideal to be included in a commit
> message. But if you still think it's good to have, I can re-spin the patch
> with these numbers included.

IMHO, it's interesting to add figures even if you have instrumented
the code to get them

>
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> >
>
> Thanks.
>
> --
> Thanks and Regards
> Srikar Dronamraju
>
