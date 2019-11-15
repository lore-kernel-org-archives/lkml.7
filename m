Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAB5C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB042072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y2uFXds9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfKOIC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:02:26 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46935 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOIC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:02:26 -0500
Received: by mail-lf1-f67.google.com with SMTP id o65so7270054lff.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 00:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NkI2txsxwbtlqaQrndweVOHL4hsJVxJJfIj4w7nA03s=;
        b=Y2uFXds9tT3DS9fRaiy1e+sqff8E/w/n40//i9BE7YJRtY4a/zxnt4prChj6HmDkZe
         53kNuZ7RKOe6R9belOvO02dJuDETkseyb4lR5MnM5sSJrn8JJzQPjkLVWd3zWK32Xgex
         vLYldw29HcDkjBpGoTCurV3FTByh7Hfi1jzvLMJuHOLLN3gR4gfoVAzCeuWy79FWdIuU
         edddQl5YgpNtBGxWAlwQ5yK2KuZ96XSbkqXxVthZYaof0TJPF1HC37Yn+c5uizjcvZ6m
         Dmh41Yz6uO8GrOrV2i5KVcXeC0wAO9R9apJRXOQ9+Xp9XJmuDh4z3h/9ooGBDYYIFs0r
         WSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NkI2txsxwbtlqaQrndweVOHL4hsJVxJJfIj4w7nA03s=;
        b=KdsmAOh3P7n7ZAqkzB+8jh/OXz1NQRBBhlZYn+Kncy/zWfqkNdoQlg2US4T2O5wamT
         oVpk8OkwtLIgWa2wTFa7zOaiL3WYbGKWhFvGQ5BVzluuLIG6iHFDUTtkp3aiHK/j1OB3
         GwNbs4W3Bo/zvQkfjc4WBacfc9YqIPBG6UNHIHtm8RClei2mDy2j/INkleuNrI8a2sMu
         m6g8S1C8G/CJa74d2relrtt6OXBpNIzsAnkU67WZL9foYISPeEwTnXStrmmcfeiL/Cua
         u72yXZ7J6HzbFFkDgmDU/jbKnBMdNi2lkyD/WEQ8WYp4bYt2TJui0+rDnnAoa1M5uy39
         7IhQ==
X-Gm-Message-State: APjAAAWHk0cx2fFIlXWqYBq2J4HUo6P0fgAIFD/KYk6e3zfmm9x+2oOq
        BD8UTz7sPX4rupTU9bEYenbBEQregEzQood6EZ0s+Q==
X-Google-Smtp-Source: APXvYqxoyLA9L2nsrx30EhpG1wDYkl+1HTSe1fWACWVrL4zBIhsGcISf5t6YmvT9WT6QGotTkg561hIqfTEeli8je0E=
X-Received: by 2002:ac2:5589:: with SMTP id v9mr10812739lfg.32.1573804944102;
 Fri, 15 Nov 2019 00:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20191114211052.15116-1-qais.yousef@arm.com>
In-Reply-To: <20191114211052.15116-1-qais.yousef@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 09:02:12 +0100
Message-ID: <CAKfTPtCNjT8FKUF3=vAR6sa7pagvgHS5997KbUs9fGzr77unWA@mail.gmail.com>
Subject: Re: [PATCH] sched/core: uclamp: fix wrong condition
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 at 22:10, Qais Yousef <qais.yousef@arm.com> wrote:
>
> uclamp_update_active() should perform the update when
> p->uclamp[clamp_id].active is true. But when the logic was inverted in
> [1], the if condition wasn't inverted correctly too.
>
> [1] https://lore.kernel.org/lkml/20190902073836.GO2369@hirez.programming.kicks-ass.net/
>
> Fixes: babbe170e053 ("sched/uclamp: Update CPU's refcount on TG's clamp changes")
> Reported-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> CC: Juri Lelli <juri.lelli@redhat.com>
> CC: Vincent Guittot <vincent.guittot@linaro.org>
> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ben Segall <bsegall@google.com>
> CC: Mel Gorman <mgorman@suse.de>
> CC: Patrick Bellasi <patrick.bellasi@matbug.net>
> CC: linux-kernel@vger.kernel.org

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0f2eb3629070..2de53489c909 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1065,7 +1065,7 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
>          * affecting a valid clamp bucket, the next time it's enqueued,
>          * it will already see the updated clamp bucket value.
>          */
> -       if (!p->uclamp[clamp_id].active) {
> +       if (p->uclamp[clamp_id].active) {
>                 uclamp_rq_dec_id(rq, p, clamp_id);
>                 uclamp_rq_inc_id(rq, p, clamp_id);
>         }
> --
> 2.17.1
>
