Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA02AFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32C720865
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XI94blL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKHQqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:46:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43950 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKHQqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:46:42 -0500
Received: by mail-lf1-f67.google.com with SMTP id f24so1946182lfh.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 08:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N1YtJwBdMz8DfJCnnNe85KyIPh5dMFDmxUzXGxWKf0s=;
        b=XI94blL8CWNwIB6SaFlfGIZGpUFIk3NdYg1RBL23lQHZ4JayOudyrItuGmktqxnn6E
         mS0lbOkMBJt28YmpiQeP5tYrmrTW5V04HfYFAclAyy7PSM5G0Bb0jLkfPD2Rmn8z+Ur1
         GdOll4NDlqayun9wQKNvhEbjgR4OQrkpD0Y1fQVG7XUfpowkdMyqP0e39RSt5EbjbgQ9
         NAwxG00MhVELq+CX7/JETTakbOkLTQ4zm8w22KjOgjSXW+l2hrAfXVKwRGwv5FdeG7m6
         mlThYnIjRvni+/7JqAlNFsPozNilaeM2MnbA7Bi1Hmt8i9H6ZRbBbPKePeFO4hXbwIHR
         V9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1YtJwBdMz8DfJCnnNe85KyIPh5dMFDmxUzXGxWKf0s=;
        b=CnUPS+KkRSDGVLMdrL6LsGGs2HQJwj/9Q+qMcyGPES7+UlNagZSle6+F6csUr4v6UA
         B2NPQc0Xd4HJzxQF5mr7zhQ7J/OZhse82jLgrBhOqGpEP77/5fx96eDdQoerFh+vqwMW
         isbh9E7yqo3QWZxeqPtVvYdL2pa0A1IBiX/eHZE81HEJTxqjudfpct/Em4ei1TvXVVN1
         bfCPKw74oZYVi/0EgG9a+8HzJ9G5jQkWdAl1B4BZ/8kk6Z5P+YZksvl++E5GaP2rl4kE
         wc4M4A8Bwfil1Cwa6NYeH3KfcbrUtmiIgr2VNHL/wFadg3pvHUy/ROJgK9cDAHZAMCwS
         N9eQ==
X-Gm-Message-State: APjAAAV7unkTNffTE32783oDPnsXtMwGMFgfR0+gS5HCP2911jj4gswE
        5AGJ8WLpSweFkGc1+jxSZVgn8xsa4hqVDoRpymhZsg==
X-Google-Smtp-Source: APXvYqyrgPD06+zE/pLgVNB1jEJeghnWUheO+58eCNXrXDcwSO6xfujh+eoKn5kJR0qa0sXuzYEo6Exc+LTBN13+rDY=
X-Received: by 2002:ac2:5589:: with SMTP id v9mr2163012lfg.32.1573231599982;
 Fri, 08 Nov 2019 08:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20191108131553.027892369@infradead.org> <20191108131909.603037345@infradead.org>
 <20191108143348.GB123156@google.com>
In-Reply-To: <20191108143348.GB123156@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 Nov 2019 17:46:28 +0100
Message-ID: <CAKfTPtBM_AKD7iMyPo6Wv=FOvG3bBaDvZLyrD=RZHrdUzaQNxg@mail.gmail.com>
Subject: Re: [PATCH 4/7] sched: Optimize pick_next_task()
To:     Quentin Perret <qperret@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, ktkhai@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019 at 15:33, Quentin Perret <qperret@google.com> wrote:
>
> On Friday 08 Nov 2019 at 14:15:57 (+0100), Peter Zijlstra wrote:
> > Ever since we moved the sched_class defenitions into their own files,
>
> s/defenitions/definitions
>
> > the constant expression {fair,idle}_sched_class.pick_next_task() is
> > not in fact a compile time constant anymore and results in an indirect
> > call (barring LTO).
> >
> > Fix that by exposing pick_next_task_{fair,idle}() directly, this gets
> > rid of the indirect call (and RETPOLINE) on the fast path.
> >
> > Also remove the unlikely() from the idle case, it is in fact /the/ way
> > we select idle -- and that is a very common thing to do.
>
> I assumed this was to optimize the case where we did find a cfs task to
> run. That is, we can afford to hit the unlikely case when there is no
> work to do after, but when there is, we shouldn't spend time checking
> the idle case. Makes sense ?

I have the same understanding as Quentin

>
> Thanks,
> Quentin
