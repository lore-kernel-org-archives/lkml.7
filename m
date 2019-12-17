Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8F1C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5544020CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCJVMt1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfLQBIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 20:08:37 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41791 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLQBIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 20:08:37 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so4837441oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 17:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YyJkwouu9RSE47M+yfsZJ8PNOfGB08WYfNp0ketBqVg=;
        b=cCJVMt1jq9fH/UR15P7MH7JzO8+xJaYU8d4QbKLu7A2kNB19e/Sf5mMHA5zHYjyB+z
         trbQH55bFAjcj99d4aV4JJtwWIUKtbwq9QAdRo6ZFF27rieeqPjGAOy0i/CGTKD9egKz
         BS/f09F5WphJju6WlCvqleeHLn8p9il1g3KN6Hx6h4HiSf7hga8ROvqfw9zpQyNF3t/L
         PN2BIdZ9eZCd2SIpN53NkSNW7fWIwwgzmx4lHR/iwVM37ZKG+nHXDSAxmbTjYpSzJ4Ej
         6Zju9x525MRNRNOVmbS5R57lvq+R44PWJrvxWu/zSj+zChqJmayPHQ9dmCi+iOFnJxqf
         sEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YyJkwouu9RSE47M+yfsZJ8PNOfGB08WYfNp0ketBqVg=;
        b=anioUg+eragybtsXYopJ/Z3iRdbAWqmP2Lmke4qsPJKMvZHyKd0yTjVH+bMvZ5lEuO
         dvgLrLoz8qvgt/Wuuc/mYt4jHjsCn7FfxRAyxOy+jrldplrjp3Rzc5wc7Zrykh4kyopb
         HeFEP7KjFosSuC7bk0IXqw3BX1MqGWGqsP0X6RapdMVZA7W2iTmoCP/mfwbM025f1jw4
         fp0kzxfUXWPtKnHZxKjBwTLWAuFec88cj9FxufZaa3AXZKHH2Yese0A1vogMXaQXksF0
         ps2pr+tRhKQX/0JlSIhA3TuZA49236njLhen4RDimr6jrqLnv4Znqlpb5t4XtnXvuUKV
         pLqw==
X-Gm-Message-State: APjAAAWLLl4ypUm+wQk9MXHxpDd+vWbAfRwYbG1GCU0UyJ9VOjWiBCFA
        tqQVM9Jk8POIBIMEGvFMDvM0momPk+trSkMrk9GpQvss
X-Google-Smtp-Source: APXvYqx5ujUJfxUQ0LoYehL9Cvx+BBetWa88h4Ofzlrg+C3knklrqmlkYwG6HsBUrD6tpYf+aVGVB+JCmZP8L2tUtgM=
X-Received: by 2002:aca:4cc7:: with SMTP id z190mr1135206oia.10.1576544916265;
 Mon, 16 Dec 2019 17:08:36 -0800 (PST)
MIME-Version: 1.0
References: <1575483700-22153-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1575483700-22153-1-git-send-email-vincent.guittot@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 16 Dec 2019 17:08:25 -0800
Message-ID: <CALAqxLXt25qVC+fqdx3rpRMkYwinVKO-Kqw_5B0v=xa01b_AUQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix find_idlest_group() to handle CPU affinity
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com,
        "mgorman@suse.de" <mgorman@suse.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 10:21 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Because of CPU affinity, the local group can be skipped which breaks the
> assumption that statistics are always collected for local group. With
> uninitialized local_sgs, the comparison is meaningless and the behavior
> unpredictable. This can even end up to use local pointer which is to
> NULL in this case.
>
> If the local group has been skipped because of CPU affinity, we return
> the idlest group.
>
> Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: John Stultz <john.stultz@linaro.org>

Just wanted to follow up on this, as its seemed to have missed -rc2?

thanks
-john
