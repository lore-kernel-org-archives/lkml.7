Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7ECC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B128720706
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1obTVWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfLNWyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:54:53 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:42250 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLNWyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:54:52 -0500
Received: by mail-il1-f194.google.com with SMTP id a6so2471689ili.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 14:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3MujR8FfbJzHtT+aBckUizKYtCSDNNUeyrMJ7cLcF5U=;
        b=M1obTVWLaQDE6qtaco9B3b7mlHrimuMdflFH1CAL1a6RectKuMgw8HiNA7WaLix/lx
         UBVrv/WdxsMLlnJx0c4xccy4KjEN0TVcucv8KFHjsffaO+0K9YA9oHEcjHiJ8flQ2KaM
         Avqcg2++AQTgdQhe+ZPZ6c5feEf5Bs4pDMmFCHgfZ335S3yBvctKeOh+P27RMVs4QwhG
         80mN2+cwDk4+J4Y0KhMrtobb0S7vx9brbN7swucxU+TyrUkHnqrkWiwXniHuPst0mgC9
         JuV1zYVSVfNnOmw9QKtQyhNdUpx5//F7TM4U+I44mfGebMnsHB9CP9LIh7bKdmsGMqbZ
         TXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3MujR8FfbJzHtT+aBckUizKYtCSDNNUeyrMJ7cLcF5U=;
        b=cQHO+UNh0y8yaZFTElMXwk05BA/GIN9RnROsFq8lPSAsXyI12f3CGqGpOoXhMAcInX
         qSaPhwxZr3OigjGn1TJOPBYGDmCyNBmavn2QiPCzms17UEltoRyKTZQeeLOdmU50EdTv
         aRvA8qiEagp0fYHb7KwiKYaPU/VEuyGQfFs4hbKh3WtTszCN4TsH4CpfLSTI64zEwYpe
         tGLJLpEeEsAVtFYVKhuomvyG8vxw0ALK5aj4zX/b0kpmbjViOoMQRVTyqxawoBPyrDCk
         Srhf2Xub0DxdMYj7dzzwHjyUY0HGJQJrQoPz2MFdF2jrYbzHpHE9OspfNKP8py95tZyK
         bYZg==
X-Gm-Message-State: APjAAAWKRmpraQQzDDItpvu0KLgb24cx6DRtyEkXZikivK/zvbkygGtR
        RoERnsMo6HEzgOYJvZwrt5vZ+Xmawp8b12NTCaU=
X-Google-Smtp-Source: APXvYqyW8kYXeXlRGN9OHdYtxcpfDE0pcapG0w46G+fIMkP1J0/wLckoqSm53Hj4MIITyQybvnyeyKXeW+uyTDZEkVs=
X-Received: by 2002:a92:89c2:: with SMTP id w63mr6011279ilk.252.1576364091887;
 Sat, 14 Dec 2019 14:54:51 -0800 (PST)
MIME-Version: 1.0
References: <2a6cdb63-397b-280a-7379-740e8f43ddf6@xilinx.com> <20191023044737.2824-1-navid.emamdoost@gmail.com>
In-Reply-To: <20191023044737.2824-1-navid.emamdoost@gmail.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Sat, 14 Dec 2019 16:54:41 -0600
Message-ID: <CAEkB2ETvi=Zryh+3UnSddrprnB+MzSObAbsms+6LHHLuiRwZjw@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers: Fix error handling in ttc_setup_clocksource
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would you review this patch, please?

On Tue, Oct 22, 2019 at 11:47 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> In the implementation of ttc_setup_clocksource() when
> clk_notifier_register() fails the execution should go to error handling.
> Additionally, to avoid memory leak the allocated memory for ttccs should
> be released, too. So, goto error handling to release the memory and
> return.
>
> Fixes: e932900a3279 ("arm: zynq: Use standard timer binding")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/clocksource/timer-cadence-ttc.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
> index 88fe2e9ba9a3..035e16bc17d3 100644
> --- a/drivers/clocksource/timer-cadence-ttc.c
> +++ b/drivers/clocksource/timer-cadence-ttc.c
> @@ -328,10 +328,8 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
>         ttccs->ttc.clk = clk;
>
>         err = clk_prepare_enable(ttccs->ttc.clk);
> -       if (err) {
> -               kfree(ttccs);
> -               return err;
> -       }
> +       if (err)
> +               goto release_ttccs;
>
>         ttccs->ttc.freq = clk_get_rate(ttccs->ttc.clk);
>
> @@ -341,8 +339,10 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
>
>         err = clk_notifier_register(ttccs->ttc.clk,
>                                     &ttccs->ttc.clk_rate_change_nb);
> -       if (err)
> +       if (err) {
>                 pr_warn("Unable to register clock notifier.\n");
> +               goto release_ttccs;
> +       }
>
>         ttccs->ttc.base_addr = base;
>         ttccs->cs.name = "ttc_clocksource";
> @@ -363,16 +363,18 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
>                      ttccs->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
>
>         err = clocksource_register_hz(&ttccs->cs, ttccs->ttc.freq / PRESCALE);
> -       if (err) {
> -               kfree(ttccs);
> -               return err;
> -       }
> +       if (err)
> +               goto release_ttccs;
>
>         ttc_sched_clock_val_reg = base + TTC_COUNT_VAL_OFFSET;
>         sched_clock_register(ttc_sched_clock_read, timer_width,
>                              ttccs->ttc.freq / PRESCALE);
>
>         return 0;
> +
> +release_ttccs:
> +       kfree(ttccs);
> +       return err;
>  }
>
>  static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
> --
> 2.17.1
>


-- 
Navid.
