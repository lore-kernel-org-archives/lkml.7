Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C89C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858B42804D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pyw6dm6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfFCJyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:54:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33421 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfFCJyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:54:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id v29so4259521ljv.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hCxA5vB/c/pzwdts2a6moWvCGrO8tOU/wQe11MaYRwc=;
        b=Pyw6dm6ZKlpZx7pcASBV47fIz0PSuXicgG0XZl2M8aohj/rAwbJg8MSESrxiMwt7Uj
         9Is8ANJ0b44zmFMkq38sLzxI3jWOJqcYbJs8hXH6E8xgtJO5uCxzrIpx0Kt6IJqHTWVf
         0FepKtuO4i6sm+HIJVcKpPCkqacNHr+Zyxa1/UF9dcyvYKw/SXe4Y5+DHa8MJZUmKEaC
         ntumfYzROBPd/ZeQyzdzhtDYJOHLXS3Zx0/nbVFQ9kB1H4ia9DwIbax9r6UH7UZ5pCqJ
         BYKhTfFPvpZfcFYNRetBKBiI1moWcU9lKVzt3Z6w43Ha+psWODngGdmLlAF99e9+pYyG
         isBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hCxA5vB/c/pzwdts2a6moWvCGrO8tOU/wQe11MaYRwc=;
        b=j68NWpkPi+AW5UGwUMSzI0DDqFgW9UVIlcgdcB452hrleh35bN4cEuf5SyDD2VDl4B
         vDl6769wdem5ssYctp8Rt5Lv+rjXgdfO+9SrS7ES6Z5NPcWqQ2PrYsgKqmCvSakG9GGB
         dfOIbPDOSC2OBjZDHT7AqjdaNrTPG81M3U7wWmldiE0FVt7PD0PlzMta+1a2qzSVYvqr
         r01Kk2L+vjz7wOgjwIxgbELkqCXSP1AWadMyf4r5bTmkHqruhsmZGWvWogZcCJYxH7rt
         9K55+rjNUCPnz2F0J2V6xy59shO2Ude2XtZknddQC7TDbRmgLiZanQnTAoM5heEgHQD9
         rw3A==
X-Gm-Message-State: APjAAAUd2XFHC1BNJjddL8IW35zbkyZK2KM9VkRp1YIvl5773hSWJyAg
        7V8W6qMpJ1oIUuLnFisIhXgFVU5DKRFejMVfQWI7xQ==
X-Google-Smtp-Source: APXvYqwvCdjHL+d+E5xMgzeDGQJorgzgtZdMtdMNEnVHCqRzHhg0jmvKrs86ttAqcy/LhjbgrMh1c2zbwqVeAmdk9gc=
X-Received: by 2002:a2e:b0ee:: with SMTP id h14mr10495752ljl.171.1559555641942;
 Mon, 03 Jun 2019 02:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <090C3AE4-55E4-45F3-AEAB-3E7F26FB7D6D@lca.pw> <20190602164110.23231-1-valentin.schneider@arm.com>
 <20190603093835.GF3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190603093835.GF3436@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 3 Jun 2019 11:53:50 +0200
Message-ID: <CAKfTPtCq_TrG=rNoH=_H_KveWNV-k_bcSQVo2FcDUGhp3Pr--g@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Cleanup definition of NOHZ blocked load functions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2019 at 11:38, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Jun 02, 2019 at 05:41:10PM +0100, Valentin Schneider wrote:
> > cfs_rq_has_blocked() and others_have_blocked() are only used within
> > update_blocked_averages(). The !CONFIG_FAIR_GROUP_SCHED version of the
> > latter calls them within a #define CONFIG_NO_HZ_COMMON block, whereas
> > the CONFIG_FAIR_GROUP_SCHED one calls them unconditionnally.
> >
> > As reported by Qian, the above leads to this warning in
> > !CONFIG_NO_HZ_COMMON configs:
> >
> >   kernel/sched/fair.c: In function 'update_blocked_averages':
> >   kernel/sched/fair.c:7750:7: warning: variable 'done' set but not used
> >   [-Wunused-but-set-variable]
> >
> > It wouldn't be wrong to keep cfs_rq_has_blocked() and
> > others_have_blocked() as they are, but since their only current use is
> > to figure out when we can stop calling update_blocked_averages() on
> > fully decayed NOHZ idle CPUs, we can give them a new definition for
> > !CONFIG_NO_HZ_COMMON.
> >
> > Change the definition of cfs_rq_has_blocked() and
> > others_have_blocked() for !CONFIG_NO_HZ_COMMON so that the
> > NOHZ-specific blocks of update_blocked_averages() become no-ops and
> > the 'done' variable gets optimised out.
> >
> > No change in functionality intended.
> >
> > Reported-by: Qian Cai <cai@lca.pw>
> > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>
> I'm thinking the below can go on top to further clean up?

For both patches
Acked-by: Vincent Guittot <vincent.guitto@linaro.org>

>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7722,9 +7722,18 @@ static inline bool others_have_blocked(s
>
>         return false;
>  }
> +
> +static inline void update_blocked_load_status(struct rq *rq, bool has_blocked)
> +{
> +       rq->last_blocked_load_update_tick = jiffies;
> +
> +       if (!has_blocked)
> +               rq->has_blocked_load = 0;
> +}
>  #else
>  static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq) { return false; }
>  static inline bool others_have_blocked(struct rq *rq) { return false; }
> +static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {}
>  #endif
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> @@ -7746,18 +7755,6 @@ static inline bool cfs_rq_is_decayed(str
>         return true;
>  }
>
> -#ifdef CONFIG_NO_HZ_COMMON
> -static inline void update_blocked_load_status(struct rq *rq, bool has_blocked)
> -{
> -       rq->last_blocked_load_update_tick = jiffies;
> -
> -       if (!has_blocked)
> -               rq->has_blocked_load = 0;
> -}
> -#else
> -static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {}
> -#endif
> -
>  static void update_blocked_averages(int cpu)
>  {
>         struct rq *rq = cpu_rq(cpu);
> @@ -7870,11 +7867,7 @@ static inline void update_blocked_averag
>         update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
>         update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
>         update_irq_load_avg(rq, 0);
> -#ifdef CONFIG_NO_HZ_COMMON
> -       rq->last_blocked_load_update_tick = jiffies;
> -       if (!cfs_rq_has_blocked(cfs_rq) && !others_have_blocked(rq))
> -               rq->has_blocked_load = 0;
> -#endif
> +       update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
>         rq_unlock_irqrestore(rq, &rf);
>  }
>
