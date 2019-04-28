Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB364C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 07:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE9D206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 07:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tezBQwkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfD1HBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 03:01:04 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41899 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfD1HBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 03:01:03 -0400
Received: by mail-oi1-f196.google.com with SMTP id v23so5901029oif.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 00:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmImGZtkfnl+9FwSUFUpPhx23vdpYvm27KSz2RV8xh8=;
        b=tezBQwkG958wl9qV6VPis1TYiM1DCy5YhiJ78oksmp6EcTCzjlIIozspHQfXkW3tLj
         ObDJREHDH9G4c8naro80jAFDRqfE+KVBOjsnhc+h1tJsiNtueCJY6Mc/akTKHjH//FsS
         EqWn+fPp/31zRP8+1Hy3Y0NAm9HNL/C9+EGl1OuHTcLkzFASbxwbRGy9u1WXA36Dv55t
         6wikCf+mmzH1msOGZay5D6ksJKucOxJ04GfwHrts9n26yuAeDtoQY6czS1ZsupZgS6fZ
         1mPeJ0fsf/DkO9SaE6YvYdHpumCLUqlsCpo30+lz9iwlLyWaGgbPeh8tdNLFvC07onmv
         /HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmImGZtkfnl+9FwSUFUpPhx23vdpYvm27KSz2RV8xh8=;
        b=q8oK9bYmhLUK9jDTmpIqGCe/0Q4MgV96miSr8VYWci2qD/3M/JsfdZgUkrXajkzo1M
         2JbGqKueGyE6J3v6JgmZvbUSmt8iX77bPb1mA49WajX7+Ed1wmIqAzchdvrgS4dBUBNa
         j9VqNnIYRfl5ihh/8zMc4/325fILCXBrObZEnzkPXHA0h8SEzYsZHaL0sulMlBOBgAUB
         o124b47RjK1sMt5p4O5I3SzBVvsmR27VpP+0/EYD0Q7s4ZCIQA4ae+8AJps2Md6RglZV
         ++fZJIP5RBF9K4IQ9I6O++xq3w8yUtx65oiPdYwicrkX3RxZUwmoaVP8MsPKwgMQHvdy
         xaZA==
X-Gm-Message-State: APjAAAXGJUHSxorsf0IB8K4GAn6muDtri03+mXCVXOMY+T7KiTziL3UI
        1f73uYeZ/fT3bn3mtweajAGdFfZEbGPAuqx01Zw=
X-Google-Smtp-Source: APXvYqw6wsknBjFHO+Owb98M7yeKcbW6R+41VawMZpdLBmatFZcBfJ3gpNDFu65RM1LXC4hKoo/l/ZK3RXVckn+xMj0=
X-Received: by 2002:aca:4942:: with SMTP id w63mr3208606oia.33.1556434863080;
 Sun, 28 Apr 2019 00:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190412042613.28930-1-npiggin@gmail.com>
In-Reply-To: <20190412042613.28930-1-npiggin@gmail.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Sun, 28 Apr 2019 15:01:18 +0800
Message-ID: <CANRm+CzLmRHtpAawBSknXyznw25ym_otnYJYYxAho-E46K3BZg@mail.gmail.com>
Subject: Re: [PATCH] kernel/sched: run nohz idle load balancer on HK_FLAG_MISC CPUs
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 at 12:27, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The nohz idle balancer runs on the lowest idle CPU. This can
> interfere with isolated CPUs, so confine it to HK_FLAG_MISC
> housekeeping CPUs.
>
> HK_FLAG_SCHED is not used for this because it is not set anywhere
> at the moment. This could be folded into HK_FLAG_SCHED once that
> option is fixed.
>
> The problem was observed with increased jitter on an application
> running on CPU0, caused by nohz idle load balancing being run on
> CPU1 (an SMT sibling).
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  kernel/sched/fair.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fdab7eb6f351..d29ca323214d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9522,22 +9522,26 @@ static inline int on_null_domain(struct rq *rq)
>   * - When one of the busy CPUs notice that there may be an idle rebalancing
>   *   needed, they will kick the idle load balancer, which then does idle
>   *   load balancing for all the idle CPUs.
> + * - HK_FLAG_MISC CPUs are used for this task, because HK_FLAG_SCHED not set
> + *   anywhere yet.
>   */
>
>  static inline int find_new_ilb(void)
>  {
> -       int ilb = cpumask_first(nohz.idle_cpus_mask);
> +       int ilb;
>
> -       if (ilb < nr_cpu_ids && idle_cpu(ilb))
> -               return ilb;
> +       for_each_cpu_and(ilb, nohz.idle_cpus_mask,
> +                             housekeeping_cpumask(HK_FLAG_MISC)) {
> +               if (idle_cpu(ilb))
> +                       return ilb;
> +       }

What will happen if cpu1 is still idle currently && housekeeping?

Regards,
Wanpeng Li

>
>         return nr_cpu_ids;
>  }
>
>  /*
> - * Kick a CPU to do the nohz balancing, if it is time for it. We pick the
> - * nohz_load_balancer CPU (if there is one) otherwise fallback to any idle
> - * CPU (if there is one).
> + * Kick a CPU to do the nohz balancing, if it is time for it. We pick any
> + * idle CPU in the HK_FLAG_MISC housekeeping set (if there is one).
>   */
>  static void kick_ilb(unsigned int flags)
>  {
> --
> 2.20.1
>
