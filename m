Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCEBC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C0B2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2mElOj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfKYMlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:41:03 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40568 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfKYMlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:41:03 -0500
Received: by mail-oi1-f193.google.com with SMTP id d22so12924889oic.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 04:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=yi2z8MulKKg3is1oE34O5NTP83H9Pk1H8b622Xd5hD0=;
        b=H2mElOj/zhYVzy7nOwSnWEkrNbzNSn49vIhRHwC7t5ZeE5jSbe9kbPdE28SJ9JDCls
         o/K1atpoNs2Ty1SX8yNjD4QaYOvU/JF4GN7EJSmQDITOiJWvmJIQHW1nfmjySU/D0W0k
         Jr+F8/+j/TwdcEdkon4JvtN8YRVLDXiMqMbA7AvkMNG6O9DTje7G0umGyBhPDT1WQ75o
         OKGZeJXX1OynqewNZG360Cmwun4fYpTO4nHm+mAOgAvTKwbraNGWqC+FnjW72JddiMmJ
         T64bVzgHBviKPknM9+cncZwJvgPtj82ZFjcxk/mNWHkr7twZ1EYmwU0ZJchHBegDUQR0
         +JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=yi2z8MulKKg3is1oE34O5NTP83H9Pk1H8b622Xd5hD0=;
        b=HZgAIbyYP/nmBbtAD2Jk6f43zNaoNwicWfg5/gesMnRwHfXPQp9x9b70Viw9eBT+Xp
         sGxW83OT6kcMsy1bylEuOCrEVG8Kk0x9FP5jyWdUk3BgwCMSyOqyzOHLzvobjXVTL/2F
         pvAquLymJ2S8xG9utdklUU4wkt9p/PfytJwAb5ZbptUW6vDXyJXNgdeqjv8cK2okUSzd
         D8GwZJqQewTWCg/tjOa3xEzssJw9vo0YotKU5S/stvrJud1pfzXNytkMejMNd6CtaOUm
         c7uKyCa1766OQg7SgKBWsj4G4LcU87e1FkVd5P+Nqn77QEu4wMMq4v6nq8EQBbR5806e
         0x8w==
X-Gm-Message-State: APjAAAXIG3vxZtAxutQIyORGFpjr8Of0JmF74chZ7A4BXGxLrogg3rKh
        DuoIzVTWzSw8ZmDB1RRjzh3ctd2BCvnnezayB6Y=
X-Google-Smtp-Source: APXvYqzkVhRqQgarhH7clyfRNj41dPtHOGFCvBMgJE/ydXY1U2PAjL9Md/FIq8btEfLsbAfmvY9n4vtB1YpR2Y9eqew=
X-Received: by 2002:aca:450:: with SMTP id 77mr22970906oie.113.1574685662038;
 Mon, 25 Nov 2019 04:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20191112191724.13818-1-rfried.dev@gmail.com>
In-Reply-To: <20191112191724.13818-1-rfried.dev@gmail.com>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Mon, 25 Nov 2019 14:40:50 +0200
Message-ID: <CAGi-RU+8gFy4gjziB6EaWK4E0dgMWBwa4y7JzZCHox149hqT8Q@mail.gmail.com>
Subject: Re: [PATCH] random: switch pr_notice with pr_info
To:     tytso@mit.edu, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Touching base.

On Tue, Nov 12, 2019 at 9:18 PM Ramon Fried <rfried.dev@gmail.com> wrote:
>
> Because there's no need to shout that loud.
> In a lot of systems pr_notice ends up also on the console
> especially in embedded systems, where it just annoying
> to get the "fast init done" just when you type a command
> in the terminal.
>
> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> ---
>  drivers/char/random.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index de434feb873a..a619002f96af 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -885,7 +885,7 @@ static void crng_initialize(struct crng_state *crng)
>                 invalidate_batched_entropy();
>                 numa_crng_init();
>                 crng_init = 2;
> -               pr_notice("random: crng done (trusting CPU's manufacturer)\n");
> +               pr_info("random: crng done (trusting CPU's manufacturer)\n");
>         }
>         crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
>  }
> @@ -948,7 +948,7 @@ static int crng_fast_load(const char *cp, size_t len)
>                 invalidate_batched_entropy();
>                 crng_init = 1;
>                 wake_up_interruptible(&crng_init_wait);
> -               pr_notice("random: fast init done\n");
> +               pr_info("random: fast init done\n");
>         }
>         return 1;
>  }
> @@ -1033,15 +1033,15 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
>                 crng_init = 2;
>                 process_random_ready_list();
>                 wake_up_interruptible(&crng_init_wait);
> -               pr_notice("random: crng init done\n");
> +               pr_info("random: crng init done\n");
>                 if (unseeded_warning.missed) {
> -                       pr_notice("random: %d get_random_xx warning(s) missed "
> +                       pr_info("random: %d get_random_xx warning(s) missed "
>                                   "due to ratelimiting\n",
>                                   unseeded_warning.missed);
>                         unseeded_warning.missed = 0;
>                 }
>                 if (urandom_warning.missed) {
> -                       pr_notice("random: %d urandom warning(s) missed "
> +                       pr_info("random: %d urandom warning(s) missed "
>                                   "due to ratelimiting\n",
>                                   urandom_warning.missed);
>                         urandom_warning.missed = 0;
> --
> 2.23.0
>
