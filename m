Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6866ACA9EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 18:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A1D21655
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 18:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiNuPZq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfJZS4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 14:56:15 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38391 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfJZS4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 14:56:15 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so6140872iom.5;
        Sat, 26 Oct 2019 11:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7cDLkomUpCufb0t+qyZB5k3lTMumkzgQK5hQePCbK8=;
        b=IiNuPZq9yOuXf1VfOCRxN3XTRjVfgIswJpmackxKJ+RenfnfpCjtW1Ud7cxLQ/lBxr
         VpI6Sb4Mno24tjICFANt0nuXewNbHbnxYmwxMWhhsOiRrWBVY9I4wIjxsxiBXNaWV5rk
         rCmzNvFfcIjLRR0ErYIbxMxsIKnNvawWFgc8sqXzEpAW9K0uIk0tfs+JvvFt3eXIx8NT
         2BAUYTL7CuoU/KGV9bFCRpbr3RnjDJrVUvgeQreLI35JhfXU7sujKcKOtsNqCzmqtIC6
         FV9QzTmoR8FXyR2d8s22Xy/UmGjxuB5FXFsPqdi+GmlVA3BtgHrnhrw4wjOdHOuXCU0W
         JALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7cDLkomUpCufb0t+qyZB5k3lTMumkzgQK5hQePCbK8=;
        b=JR9uF8kvDIVI5grA/93LgioO3br0eyr1VWKO5tu/cue0CUJNisg7/uioQTHBGmbc6R
         Ky7ejw7dJYccCi0YJLIkDUHhESlJ1z/9wzdvq6ylftav7WonC6Q2iAvz/D8SDmUruevX
         ueKwIxoXpGxderAnSN66A0INJhZD3oslPgCoPoo/MmA4K5/5LXEWzhkHquMyDkNWMPkT
         UWG14VnXlpEQ9OZ2wwIh0ouff1pWwmHVlUMeleJrJkNtDmud+XXRV+6FF+o8NmVwGG8n
         5XqQMBb37Sl4XZpLhN7D4+ynEL2cQwmZtuciEVx0HivA+dL2hxqdwpzx7Zxs+nJ/Ku4T
         KTKw==
X-Gm-Message-State: APjAAAXyTxVNd8wVWKQUNPc+aOG6SeVkBpZCRHbuFFfkRV/+S3x+lPY4
        uAtVOEV4g7LWXW+2ROVVOUYwfbqsSGkN79UfHEQ=
X-Google-Smtp-Source: APXvYqzEzHENdTMD+ax5PmTOJZRJGHZ3jBXmGRZx4Ns2ZkiyQpg1AuGK59Jx4vizK/5iI3mJBXN8JFdlL94rgqOd9ag=
X-Received: by 2002:a05:6602:2428:: with SMTP id g8mr10205784iob.246.1572116174047;
 Sat, 26 Oct 2019 11:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191007131649.1768-1-linux.amoon@gmail.com> <20191007131649.1768-6-linux.amoon@gmail.com>
 <CAFBinCAoJLZj9Kh+SfF4Q+0OCzac2+huon_BU=Q3yE7Fu38U3w@mail.gmail.com>
 <7hsgo4cgeg.fsf@baylibre.com> <CANAwSgRfcFa6uBNtpqz6y=9Uwsa4gcp_4tDD+Chhg4SynJCq0Q@mail.gmail.com>
 <CAFBinCA6ZoeR4m4bhj08HF1DqxY1qB5mygpaQCGbo3d8M+Wr9Q@mail.gmail.com>
 <CANAwSgSeYTnUkLnjw-RORw76Fyj3_WT0cdM9D0vFsY8g=9L94Q@mail.gmail.com>
 <1jwode9lba.fsf@starbuckisacylon.baylibre.com> <CANAwSgSoK4X3_QbO3YpZRXNTpPJ+zVeid=w93f14Eyk8Dd32EQ@mail.gmail.com>
 <CAFBinCBdwqxA2kLMAA9gtOcXevYK-J4x12odHwpQOAWakgWiEg@mail.gmail.com>
 <CANAwSgRs2DUXwvhJD5qpXg04qEdP_Nt-wQqRbD2FpY2SWnHpAA@mail.gmail.com>
 <1a98c5f0-de8a-53bc-cfb7-c9b3255667c6@baylibre.com> <CANAwSgRD-Vd-D1H5cDYMyTLRMfzdkrFuiy4KfXYt6S+0goF-2w@mail.gmail.com>
In-Reply-To: <CANAwSgRD-Vd-D1H5cDYMyTLRMfzdkrFuiy4KfXYt6S+0goF-2w@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sun, 27 Oct 2019 00:26:03 +0530
Message-ID: <CANAwSgRKO2trabH635HhNR34mbL3n+4cs+Gg4GO_Zc6vuYW5JA@mail.gmail.com>
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

On Mon, 21 Oct 2019 at 21:11, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Neil,
>
> On Mon, 21 Oct 2019 at 19:55, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >
> > Hi Anand,
> >
> > On 21/10/2019 16:11, Anand Moon wrote:
> > > Hi Martin,
> > >
> > > On Fri, 18 Oct 2019 at 23:40, Martin Blumenstingl
> > > <martin.blumenstingl@googlemail.com> wrote:
> > >>
> > >> Hi Anand,
> > >>
> > >> On Fri, Oct 18, 2019 at 4:04 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > >> [...]
> > >>>> Next step it to try narrow down the clock causing the issue.
> > >>>> Remove clk_ignore_unused from the command line and add CLK_INGORE_UNUSED
> > >>>> to the flag of some clocks your clock controller (g12a I think) until
> > >>>>
> > >>>> The peripheral clock gates already have this flag (something we should
> > >>>> fix someday) so don't bother looking there.
> > >>>>
> > >>>> Most likely the source of the pwm is getting disabled between the
> > >>>> late_init call and the probe of the PWM module. Since the pwm is already
> > >>>> active (w/o a driver), gating the clock source shuts dowm the power to
> > >>>> the cores.
> > >>>>
> > >>>> Looking a the possible inputs in pwm driver, I'd bet on fdiv4.
> > >>>>
> > >>>
> > >>> I had give this above steps a try but with little success.
> > >>> I am still looking into this much close.
> > >> it's not clear to me if you have only tested with the PWM and/or
> > >> FCLK_DIV4 clocks. can you please describe what you have tested so far?
> > >>
> > > Sorry for delayed response.
> > >
> > > I had just looked into clk related to SD_EMMC_A/B/C,
> > > with adding CLK_IGNORE/CRITICAL.
> > > Also looked into clk_summary for eMMC and microSD card,
> > > to identify the root cause, but I failed to move ahead.
> > >
> > >> for reference - my way of debugging this in the past was:
> > >> 1. add some printks to clk_disable_unused_subtree (right after the
> > >> clk_core_is_enabled check) to see which clocks are being disabled
> > >> 2. add CLK_IGNORE_UNUSED or CLK_IS_CRITICAL to the clocks which are
> > >> being disabled based on the information from step #1
> > >> 3. (at some point I had a working kernel with lots of clocks with
> > >> CLK_IGNORE_UNUSED/CLK_IS_CRITICAL)
> > >> 4. start dropping the CLK_IGNORE_UNUSED/CLK_IS_CRITICAL flags again
> > >> until you have traced it down to the clocks that are the actual issue
> > >> (so far I always had only one clock which caused issues, but it may be
> > >> multiple)
> > >> 5. investigate (and/or ask on the mailing list, Amlogic developers are
> > >> reading the mails here as well) for the few clocks from step #4
> > >>
> > >
> > > Thanks for you valuable suggestion. I have your patch to debug this
> > > [0]  https://patchwork.kernel.org/patch/9725921/mbox/
> > >
> > > So from the fist step I could identify that all the clk were getting closed
> > > after some core cpu clk was failing. Here is the log.
> > >
> > > step1: [1] https://pastebin.com/p13F9HGG
> > >
> > > so I marked these clk as CLK_IGNORE_UNUSED and finally
> > > I made it to boot using microSD card.
> > >
> > > After this just I converted these CLK to CLK_IS_CRITICAL
> > > as mostly these are used the CPU clk for now.
> > > Here is boot log successful for as of now.
> > >
> > > Finally: [2]  https://pastebin.com/qB6pMyGQ
> > >
> > > I know clk maintainer are against marking flags as *CLK_IS_CRITICAL*
> > > But this is just the step to move ahead.
> >
> > Thanks for the extensive debug.
> >
> > >
> > > Attach is my local clk and dts patch.Just for testing.
> > > [3] clk_critical.patch
> >
> >
> > Could you test with only the following changes:
> > diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> > index ea4c791f106d..f49f5463363e 100644
> > --- a/drivers/clk/meson/g12a.c
> > +++ b/drivers/clk/meson/g12a.c
> > @@ -298,6 +298,7 @@ static struct clk_regmap g12a_fclk_div2 = {
> >                         &g12a_fclk_div2_div.hw
> >                 },
> >                 .num_parents = 1,
> > +               .flags = CLK_IS_CRITICAL,
> >         },
> >  };
> >
> > @@ -672,7 +673,7 @@ static struct clk_regmap g12b_cpub_clk = {
> >                         &g12a_sys_pll.hw
> >                 },
> >                 .num_parents = 2,
> > -               .flags = CLK_SET_RATE_PARENT,
> > +               .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> >         },
> >  };
> >
>
I am blocked with my eMMC is not working with latest u-boot so that
I could not verify that nothing break with this changes.

Could you send this patch upstream with adding my.

Tested-by: Anand Moon <linux.amoon@gmail.com>

Best Regards
-Anand
