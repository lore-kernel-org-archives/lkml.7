Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9467C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828212133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtDoZWYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfJDUxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:53:21 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39853 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDUxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:53:21 -0400
Received: by mail-ot1-f65.google.com with SMTP id s22so6404333otr.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 13:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAjnuPHw3tO3uVocMnkpXK9WavD6g0ytImUkTHWoads=;
        b=AtDoZWYM8rsG9RE3VueQA0mbi5yWVltfodn/kWBNidSY+z8TqakvLRpOrSosSonS66
         b0PwaFX95OwS6MrWaLpLwAzf+Va2wLM5rS+0aRS76egxt+M49Fj3sbGbWuVXit593HT9
         GbG7Ju1cKAlI6VD/Zf1sv7kWmZuKy7EPPAdGUtWFKHflNUzMRqfufwAqc6bnWlikrtts
         FlYMP7BL8PHiF0/0+dK5/ugxC/WPTguO3bcodiO9Sx+tJsVqjUnSV7KbwtPL9mSEBwM0
         PW0qx5bmpFx1b6j6irBs3ItUrUOjmPtKP43bRgQnAgxwYGlX3QdU8b3qPcDT+W56cfKV
         MOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAjnuPHw3tO3uVocMnkpXK9WavD6g0ytImUkTHWoads=;
        b=ArOBIiJKGyCjW2Q3bqUJeJvnY1XbDd2TCdwzdFrV7J0Q4dEwwB4QGpVmF7h5uFWWyR
         OrZLXLjUNvNGDQa6szRjW9qNTVDR7t15WdoW56x8YluQdIUyMxNdKSOpi7nR+ItRJZwQ
         kokr6+vISRhEEaEjg06jEekbb3VJJ178X4eon83LzRGLEABVY2QyUtR/hd+06dwhi/m3
         g2ql9BqmWFDi8BEkjdmurmNG1WWbBfTxCNJ48ommCPEzMWgyy0fu69ayVy+Q8yuSI00j
         bYXwwFS/UmvUsYp0wCu7bMH4L1/ZCJKbRK/f5iX33At+jOx4/D1QksEqbjvZs8xok7HA
         DfrQ==
X-Gm-Message-State: APjAAAXocchY3uF7zS3bXNA4ALfVoj3p3ZodNPVVHTi22Nu90ruqj96X
        pyAHCcNpKxkrCyEm7K+bEK0XvpNfTHeHYkSyJ28iUA==
X-Google-Smtp-Source: APXvYqzO6x90iT0W5MMs7J07MRh0s1yRHTSoEYZjIKxU8+L9kOrJWzZNsKE9rvwjF395L+RglCQBpKFxk0vi3yIZWPg=
X-Received: by 2002:a9d:7842:: with SMTP id c2mr9087845otm.171.1570222399879;
 Fri, 04 Oct 2019 13:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191004180920.105572-1-harshadshirwadkar@gmail.com>
In-Reply-To: <20191004180920.105572-1-harshadshirwadkar@gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 4 Oct 2019 13:53:08 -0700
Message-ID: <CAD+ocby9=Xyy=0cENHw2ndmnvKk-Eti3XFzJ6WzAE4tbqC7-hg@mail.gmail.com>
Subject: Re: [PATCH] blk-wbt: fix performance regression in wbt scale_up/scale_down
To:     linux-kernel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>, vaibhavrustagi@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 11:09 AM Harshad Shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> scale_up wakes up waiters after scaling up. But after scaling max, it
> should not wake up more waiters as waiters will not have anything to
> do. This patch fixes this by making scale_up (and also scale_down)
> return when threshold is reached.
>
> This bug causes increased fdatasync latency when fdatasync and dd
> conv=sync are performed in parallel on 4.19 compared to 4.14. This
> bug was introduced during refactoring of blk-wbt code.
>
> Fixes: a79050434b45 ("blk-rq-qos: refactor out common elements of blk-wbt")
> Cc: Josef Bacik <jbacik@fb.com>
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>  block/blk-rq-qos.c | 14 +++++++++-----
>  block/blk-rq-qos.h |  4 ++--
>  block/blk-wbt.c    |  6 ++++--
>  3 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index 3954c0dc1443..d92abb43000c 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -142,24 +142,27 @@ bool rq_depth_calc_max_depth(struct rq_depth *rqd)
>         return ret;
>  }
>
> -void rq_depth_scale_up(struct rq_depth *rqd)
> +/* Returns true on success and false if scaling up wasn't possible */
> +bool rq_depth_scale_up(struct rq_depth *rqd)
>  {
>         /*
>          * Hit max in previous round, stop here
>          */
>         if (rqd->scaled_max)
> -               return;
> +               return false;
>
>         rqd->scale_step--;
>
>         rqd->scaled_max = rq_depth_calc_max_depth(rqd);
> +       return true;
>  }
>
>  /*
>   * Scale rwb down. If 'hard_throttle' is set, do it quicker, since we
> - * had a latency violation.
> + * had a latency violation. Returns true on success and returns false if
> + * scaling down wasn't possible.
>   */
> -void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
> +bool rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
>  {
>         /*
>          * Stop scaling down when we've hit the limit. This also prevents
> @@ -167,7 +170,7 @@ void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
>          * keep up.
>          */
>         if (rqd->max_depth == 1)
> -               return;
> +               return false;
>
>         if (rqd->scale_step < 0 && hard_throttle)
>                 rqd->scale_step = 0;
> @@ -176,6 +179,7 @@ void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
>
>         rqd->scaled_max = false;
>         rq_depth_calc_max_depth(rqd);
> +       return 0;
Oops, I meant return true here, thanks Vaibhav (+cc) for pointing this
out. I'll fix this in V2.

>  }
>
>  struct rq_qos_wait_data {
> diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
> index 2300e038b9fa..c0f0778d5396 100644
> --- a/block/blk-rq-qos.h
> +++ b/block/blk-rq-qos.h
> @@ -125,8 +125,8 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
>                  acquire_inflight_cb_t *acquire_inflight_cb,
>                  cleanup_cb_t *cleanup_cb);
>  bool rq_wait_inc_below(struct rq_wait *rq_wait, unsigned int limit);
> -void rq_depth_scale_up(struct rq_depth *rqd);
> -void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle);
> +bool rq_depth_scale_up(struct rq_depth *rqd);
> +bool rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle);
>  bool rq_depth_calc_max_depth(struct rq_depth *rqd);
>
>  void __rq_qos_cleanup(struct rq_qos *rqos, struct bio *bio);
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 313f45a37e9d..5a96881e7a52 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -308,7 +308,8 @@ static void calc_wb_limits(struct rq_wb *rwb)
>
>  static void scale_up(struct rq_wb *rwb)
>  {
> -       rq_depth_scale_up(&rwb->rq_depth);
> +       if (!rq_depth_scale_up(&rwb->rq_depth))
> +               return;
>         calc_wb_limits(rwb);
>         rwb->unknown_cnt = 0;
>         rwb_wake_all(rwb);
> @@ -317,7 +318,8 @@ static void scale_up(struct rq_wb *rwb)
>
>  static void scale_down(struct rq_wb *rwb, bool hard_throttle)
>  {
> -       rq_depth_scale_down(&rwb->rq_depth, hard_throttle);
> +       if (!rq_depth_scale_down(&rwb->rq_depth, hard_throttle))
> +               return;
>         calc_wb_limits(rwb);
>         rwb->unknown_cnt = 0;
>         rwb_trace_step(rwb, "scale down");
> --
> 2.23.0.581.g78d2f28ef7-goog
>
