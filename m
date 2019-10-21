Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A88CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2800220873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwmNb7cX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfJUPl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:41:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41443 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbfJUPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:41:58 -0400
Received: by mail-io1-f68.google.com with SMTP id r144so4605993iod.8;
        Mon, 21 Oct 2019 08:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrezMpUPTuyBffQXpwXrXBC3vhqskF147L+22Fn98BU=;
        b=EwmNb7cXzst/x89vU6zX83MOOZymhv4R7vncUF7z1tLKjEQC3olmiUnfQla3diTAaY
         CwxGnWNj4NsBN6ZUzZjBq3ozYbikY1usGQPjjJNT2B6tGiIVTS7QPbyrtamOV8SKH2B6
         XvM4vy8QY6L3spvc+y6BPseinBCXbXoxo5IezrWm6zw8bIpeoh87tqkE9cj1BEs2gGVs
         aZGDKqPxfiP4VYqbsGB8dgHSbhD5NDYAIF8tT+X3o3dPr7iF4gr6lCXXFCR5y2eOOMi6
         BlypA8VwHZxFc8HlZYhZEycLpi+Ml42Mz2S9+ief8wwwPHOzEt3YT9lVze8zUoiUqG2P
         PGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrezMpUPTuyBffQXpwXrXBC3vhqskF147L+22Fn98BU=;
        b=ZCGEwIH74dAJ8s2mYvJFciE/Q6pKYJwDZY0s/APbgfPAnlYdb5X1aJG6U/YF7uplko
         L913PkEyk7TUF2mW1dVWE5zegOb+FlwLkWv2D0b6ISSE8XUxf10rdDAbtllHXwpusJyG
         CUWrdcp7hAAF+h6AIExWb2zRG3kygGKIvhwCSeYyjaU/dem8VkYyoOEx7CeJdZDLGPLY
         FZFqf1BNWB8tAfmRcCedTarpDrBEogCOACBGMoGynD0Ne9Y7IeYBl3wY2myq+nrO5tzK
         UcGJIzGF2sz2falQtRqPhfghisjusJP3sbaKpi8v/GM6qYyLDYco4rMEfYw6fww1nbJA
         zE0Q==
X-Gm-Message-State: APjAAAUljxGL95LmGz3AE61khV27J9biz6kt/8qeRiHk2+cestMpJSWx
        PSxnXhAA7eq1BNRB4S33Hepy++dhagr09ClXGlw=
X-Google-Smtp-Source: APXvYqzSsz0JCUb9Vzflc4VEP6hwCRnJcMI8hMtnlwZ2QZkCnUzhMTr7V+XY5wal8xMfpEGVzAt4PglUUBLaMwmHu0g=
X-Received: by 2002:a6b:7417:: with SMTP id s23mr17364283iog.221.1571672516254;
 Mon, 21 Oct 2019 08:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191007131649.1768-1-linux.amoon@gmail.com> <20191007131649.1768-6-linux.amoon@gmail.com>
 <CAFBinCAoJLZj9Kh+SfF4Q+0OCzac2+huon_BU=Q3yE7Fu38U3w@mail.gmail.com>
 <7hsgo4cgeg.fsf@baylibre.com> <CANAwSgRfcFa6uBNtpqz6y=9Uwsa4gcp_4tDD+Chhg4SynJCq0Q@mail.gmail.com>
 <CAFBinCA6ZoeR4m4bhj08HF1DqxY1qB5mygpaQCGbo3d8M+Wr9Q@mail.gmail.com>
 <CANAwSgSeYTnUkLnjw-RORw76Fyj3_WT0cdM9D0vFsY8g=9L94Q@mail.gmail.com>
 <1jwode9lba.fsf@starbuckisacylon.baylibre.com> <CANAwSgSoK4X3_QbO3YpZRXNTpPJ+zVeid=w93f14Eyk8Dd32EQ@mail.gmail.com>
 <CAFBinCBdwqxA2kLMAA9gtOcXevYK-J4x12odHwpQOAWakgWiEg@mail.gmail.com>
 <CANAwSgRs2DUXwvhJD5qpXg04qEdP_Nt-wQqRbD2FpY2SWnHpAA@mail.gmail.com> <1a98c5f0-de8a-53bc-cfb7-c9b3255667c6@baylibre.com>
In-Reply-To: <1a98c5f0-de8a-53bc-cfb7-c9b3255667c6@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 21 Oct 2019 21:11:45 +0530
Message-ID: <CANAwSgRD-Vd-D1H5cDYMyTLRMfzdkrFuiy4KfXYt6S+0goF-2w@mail.gmail.com>
Subject: Re: [RFCv1 5/5] arm64/ARM: configs: Change CONFIG_PWM_MESON from m to y
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, 21 Oct 2019 at 19:55, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Anand,
>
> On 21/10/2019 16:11, Anand Moon wrote:
> > Hi Martin,
> >
> > On Fri, 18 Oct 2019 at 23:40, Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> >>
> >> Hi Anand,
> >>
> >> On Fri, Oct 18, 2019 at 4:04 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >> [...]
> >>>> Next step it to try narrow down the clock causing the issue.
> >>>> Remove clk_ignore_unused from the command line and add CLK_INGORE_UNUSED
> >>>> to the flag of some clocks your clock controller (g12a I think) until
> >>>>
> >>>> The peripheral clock gates already have this flag (something we should
> >>>> fix someday) so don't bother looking there.
> >>>>
> >>>> Most likely the source of the pwm is getting disabled between the
> >>>> late_init call and the probe of the PWM module. Since the pwm is already
> >>>> active (w/o a driver), gating the clock source shuts dowm the power to
> >>>> the cores.
> >>>>
> >>>> Looking a the possible inputs in pwm driver, I'd bet on fdiv4.
> >>>>
> >>>
> >>> I had give this above steps a try but with little success.
> >>> I am still looking into this much close.
> >> it's not clear to me if you have only tested with the PWM and/or
> >> FCLK_DIV4 clocks. can you please describe what you have tested so far?
> >>
> > Sorry for delayed response.
> >
> > I had just looked into clk related to SD_EMMC_A/B/C,
> > with adding CLK_IGNORE/CRITICAL.
> > Also looked into clk_summary for eMMC and microSD card,
> > to identify the root cause, but I failed to move ahead.
> >
> >> for reference - my way of debugging this in the past was:
> >> 1. add some printks to clk_disable_unused_subtree (right after the
> >> clk_core_is_enabled check) to see which clocks are being disabled
> >> 2. add CLK_IGNORE_UNUSED or CLK_IS_CRITICAL to the clocks which are
> >> being disabled based on the information from step #1
> >> 3. (at some point I had a working kernel with lots of clocks with
> >> CLK_IGNORE_UNUSED/CLK_IS_CRITICAL)
> >> 4. start dropping the CLK_IGNORE_UNUSED/CLK_IS_CRITICAL flags again
> >> until you have traced it down to the clocks that are the actual issue
> >> (so far I always had only one clock which caused issues, but it may be
> >> multiple)
> >> 5. investigate (and/or ask on the mailing list, Amlogic developers are
> >> reading the mails here as well) for the few clocks from step #4
> >>
> >
> > Thanks for you valuable suggestion. I have your patch to debug this
> > [0]  https://patchwork.kernel.org/patch/9725921/mbox/
> >
> > So from the fist step I could identify that all the clk were getting closed
> > after some core cpu clk was failing. Here is the log.
> >
> > step1: [1] https://pastebin.com/p13F9HGG
> >
> > so I marked these clk as CLK_IGNORE_UNUSED and finally
> > I made it to boot using microSD card.
> >
> > After this just I converted these CLK to CLK_IS_CRITICAL
> > as mostly these are used the CPU clk for now.
> > Here is boot log successful for as of now.
> >
> > Finally: [2]  https://pastebin.com/qB6pMyGQ
> >
> > I know clk maintainer are against marking flags as *CLK_IS_CRITICAL*
> > But this is just the step to move ahead.
>
> Thanks for the extensive debug.
>
> >
> > Attach is my local clk and dts patch.Just for testing.
> > [3] clk_critical.patch
>
>
> Could you test with only the following changes:
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index ea4c791f106d..f49f5463363e 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -298,6 +298,7 @@ static struct clk_regmap g12a_fclk_div2 = {
>                         &g12a_fclk_div2_div.hw
>                 },
>                 .num_parents = 1,
> +               .flags = CLK_IS_CRITICAL,
>         },
>  };
>
> @@ -672,7 +673,7 @@ static struct clk_regmap g12b_cpub_clk = {
>                         &g12a_sys_pll.hw
>                 },
>                 .num_parents = 2,
> -               .flags = CLK_SET_RATE_PARENT,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>         },
>  };
>

Yes these changes work at my end,
I want to narrow down my changes, this looks pretty good.

Best Regards
-Anand
