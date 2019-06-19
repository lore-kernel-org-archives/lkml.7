Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DB7C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 00:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A0C21479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 00:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bhb1gZZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfFSAlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 20:41:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36988 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfFSAlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 20:41:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id t76so9209544oih.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 17:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hvb16bwt26ZSY/9MTVMzsIdzO3PPNSUm5rw22PlGA5w=;
        b=Bhb1gZZbB9Oukl+AW9mAy9W1Uv/KamKBE6qxGrdZPk5xQFGgEf8MsmH33i+IbYTYgh
         dJWCyqGzcMG8sv63hqXpWfOb6T81RT/Lg0J8zCq2rR9+PVSJuDLShwcZr9BZZhDHz8cA
         1R4DVyBdcMhdyCP5/d0pM2kDH881nCXCzDLfiem9TImrkaSM3MU0n45bArHD0eOMjr0/
         11jZpBfzDlpIriL2qH9Jx1y8BkPztdAOSoQPNrYwQR2XNdUH8WonOap/h5MpQVgtcVBC
         bdSJ94kM48BkBK+H1e1BFJDl7VdwXvF0Fitq0Bf3e7IXCpWe0571wj86bAl6LvGA//Tl
         i7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hvb16bwt26ZSY/9MTVMzsIdzO3PPNSUm5rw22PlGA5w=;
        b=DRGYDJJ8dscvygMnNHNQCaEqwfAoGzeBLesEN2OU8Sac15Pds04/Hd3k5YCNjy5Knp
         sME0X+GhAMZl/UX/SV/skhGQvmHUfHMNyaEpOapZin67qqpcZv1bDeviTRx0+LmhFD5x
         4v4FRlUzilaneoJLBNx271V+bK3QAhO5ViSsxUqk+teVsUbACvvIdbjwbos9FYkj8ZjK
         GRnHpgYZtHWhsYKDB5Bg8VTnu+6QrUedQsyXJRsqzARhQXMSa768+m6GQWYnahriRm5I
         +tvWDc9+Q/OdipTlY5d9Nk8TLJEq/8+Yg2QGqCfvSPFamQG4YbH55czylWE5MGdcqI+R
         oLMw==
X-Gm-Message-State: APjAAAVdfbnBIxEkwCbLnLOskC1U8Vx5KdGDEJpZYas/dSXBJmZb5n9l
        fznP8sHk05ps7bksSVXRE5Szb/FqcesB8BeEIorrnA==
X-Google-Smtp-Source: APXvYqw8jNkakW1UJ89WijX4ik5BkmF1lF2awsusZtwAATQ/z3ml398kEGsWvALBAUZO0y6wvvBH9QiQ7rF31YYgGKQ=
X-Received: by 2002:aca:51ce:: with SMTP id f197mr855473oib.33.1560904863876;
 Tue, 18 Jun 2019 17:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <1560827581-8827-1-git-send-email-wanpengli@tencent.com>
In-Reply-To: <1560827581-8827-1-git-send-email-wanpengli@tencent.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 19 Jun 2019 08:42:19 +0800
Message-ID: <CANRm+Cw6nVOy=SZw1wrh=8+1fzOfaOZcoWBeKTa8n3UXZLik=g@mail.gmail.com>
Subject: Re: [PATCH] sched/nohz: Optimize get nohz timer target
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Frederic,
On Tue, 18 Jun 2019 at 11:13, Wanpeng Li <kernellwp@gmail.com> wrote:
>
> From: Wanpeng Li <wanpengli@tencent.com>
>
> On a machine, cpu 0 is used for housekeeping, other 39 cpus are in
> nohz_full mode. We can observe huge time burn in the loop for seaching
> nearest busy housekeeper cpu by ftrace.
>
>   2)               |                        get_nohz_timer_target() {
>   2)   0.240 us    |                          housekeeping_test_cpu();
>   2)   0.458 us    |                          housekeeping_test_cpu();
>
>   ...
>
>   2)   0.292 us    |                          housekeeping_test_cpu();
>   2)   0.240 us    |                          housekeeping_test_cpu();
>   2)   0.227 us    |                          housekeeping_any_cpu();
>   2) + 43.460 us   |                        }
>
> This patch optimizes the searching logic by finding a nearest housekeeper
> cpu in the housekeeping cpumask, it can minimize the worst searching time
> from ~44us to < 10us in my testing.
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  kernel/sched/core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 83bd6bb..db550cf 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -548,11 +548,12 @@ int get_nohz_timer_target(void)
>
>         rcu_read_lock();
>         for_each_domain(cpu, sd) {
> -               for_each_cpu(i, sched_domain_span(sd)) {
> +               for_each_cpu_and(i, sched_domain_span(sd),
> +                       housekeeping_cpumask(HK_FLAG_TIMER)) {
>                         if (cpu == i)
>                                 continue;
>
> -                       if (!idle_cpu(i) && housekeeping_cpu(i, HK_FLAG_TIMER)) {
> +                       if (!idle_cpu(i)) {
>                                 cpu = i;
>                                 goto unlock;
>                         }
> --
> 2.7.4
>
