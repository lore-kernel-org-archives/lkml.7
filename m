Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE1ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75A521925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv2Cc5fh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633733AbfJROE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:04:26 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41061 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393962AbfJROE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:04:26 -0400
Received: by mail-il1-f194.google.com with SMTP id z10so5627475ilo.8;
        Fri, 18 Oct 2019 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hFzoYmplkki9kyOBFxHB/h7HTLnl6ZxTVUTZz24IbTM=;
        b=Mv2Cc5fhH95jd20n/Sf2opUMvxeC4GuDidaIvU95LAnx2bjFB31zzog/P6oqWNI58d
         XM4kMQNx9ix/JvgLSWiV7rzZz237lTyUC6xWCtOCj91cdMKPCsv6byLDvUndFWxaGk0L
         HaFovSd7qTmKH50MXUduQUJKddS1QIt0tOelQnPWH60Wn/uylOnx7KRn78t7S3kM9aK7
         nsz2w2pVnCnOPthzSr12A/S8UYEgfISBV/Ngbi5zNtoleFlCH6MWRuOKtu7jbM4ue7kk
         OiblLeg1doD4dboEnAuQMI+pSP1pjHIH7bya5MdqmBmJVTXcYLqH7s0TZljYFeuCIxlI
         cWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFzoYmplkki9kyOBFxHB/h7HTLnl6ZxTVUTZz24IbTM=;
        b=CiTziZS13yHPp1Vw3KltkoLN/iZHWxndnkFMvY7SFJIL3614kuZ6iIx3fmMBDmm962
         xAOLdStq7ww1nYmEOGqS3eafZUv9NS4EuL7b//VkmpI9GAz7gL4K7UVDQaDBSzmjVcNI
         5g5qxYk0Q4M50A92McGb/RPbSC0wdxCFiE7YYX9ncl1nMqn6k85E+7FRmNXJuZ0KSLJI
         XC9xG3gb3c5xWCXu/E0pEJtFS4uPEsDR1NEdcZSJw0HIzyjmBDahuVN/HC8ecrF7lSiJ
         6hA+QLY9OyxG0l2H+jLfwpPNi2U3S+iNeKQO1UUaoF3OlwiIij6VgQeXsMY7C78dfnXP
         0b9g==
X-Gm-Message-State: APjAAAV7mG4AfKDWR0BziJ+ZHRKOigJx0EaOjKztnWOnkNLCSLQWCX4j
        VyYS90qL6O+iD9PkG+uBgi9OvNieDtXgBz9wildR0ZRD
X-Google-Smtp-Source: APXvYqz5b2jpVcV5HjYOaFTUFnpF8IRGwxXAMSHZl48NFIAtlszEF0ulaRrEut4XiC3rkm7Hkfuu3yszlbUbKSTUifA=
X-Received: by 2002:a92:c80b:: with SMTP id v11mr10713556iln.6.1571407464959;
 Fri, 18 Oct 2019 07:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191007131649.1768-1-linux.amoon@gmail.com> <20191007131649.1768-6-linux.amoon@gmail.com>
 <CAFBinCAoJLZj9Kh+SfF4Q+0OCzac2+huon_BU=Q3yE7Fu38U3w@mail.gmail.com>
 <7hsgo4cgeg.fsf@baylibre.com> <CANAwSgRfcFa6uBNtpqz6y=9Uwsa4gcp_4tDD+Chhg4SynJCq0Q@mail.gmail.com>
 <CAFBinCA6ZoeR4m4bhj08HF1DqxY1qB5mygpaQCGbo3d8M+Wr9Q@mail.gmail.com>
 <CANAwSgSeYTnUkLnjw-RORw76Fyj3_WT0cdM9D0vFsY8g=9L94Q@mail.gmail.com> <1jwode9lba.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jwode9lba.fsf@starbuckisacylon.baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 18 Oct 2019 19:34:14 +0530
Message-ID: <CANAwSgSoK4X3_QbO3YpZRXNTpPJ+zVeid=w93f14Eyk8Dd32EQ@mail.gmail.com>
Subject: Re: [RFCv1 5/5] arm64/ARM: configs: Change CONFIG_PWM_MESON from m to y
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome / Neil / Martin,

On Wed, 9 Oct 2019 at 17:34, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Wed 09 Oct 2019 at 10:48, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Kernel command line: console=ttyAML0,115200n8
> > root=PARTUUID=45d7d61e-01 rw rootwait
> > earlyprintk=serial,ttyAML0,115200 initcall_debug printk.time=y
> >
> > [0] https://pastebin.com/eBgJrSKe
> >
> >> you can also try the command line parameter "clk_ignore_unused" (it's
> >> just a gut feeling: maybe a "critical" clock is being disabled because
> >> it's not wired up correctly).
> >>
> >
> > It look like some clk issue after I added the *clk_ignore_unused* to
> > kernel command line
> > it booted further to login prompt and cpufreq DVFS seem to be loaded.
> > So I could conclude this is clk issue.below is the boot log
> >
> > Kernel command line: console=ttyAML0,115200n8
> > root=PARTUUID=45d7d61e-01 rw rootwait
> > earlyprintk=serial,ttyAML0,115200 initcall_debug printk.time=y
> > clk_ignore_unused
> >
> > [1] https://pastebin.com/Nsk0wZQJ
> >
>
> Next step it to try narrow down the clock causing the issue.
> Remove clk_ignore_unused from the command line and add CLK_INGORE_UNUSED
> to the flag of some clocks your clock controller (g12a I think) until
>
> The peripheral clock gates already have this flag (something we should
> fix someday) so don't bother looking there.
>
> Most likely the source of the pwm is getting disabled between the
> late_init call and the probe of the PWM module. Since the pwm is already
> active (w/o a driver), gating the clock source shuts dowm the power to
> the cores.
>
> Looking a the possible inputs in pwm driver, I'd bet on fdiv4.
>

I had give this above steps a try but with little success.
I am still looking into this much close.

Well I am not the expert in clk or bus configuration.
but after looking into the datasheet of for clk configuration
I found some bus are not configured correctly.

As per Amlogic's kernel S922X (Hardkernel)
below link share the bus controller.

[0] https://github.com/hardkernel/linux/blob/odroidn2-4.9.y/arch/arm64/boot/dts/amlogic/mesong12b.dtsi#L295-L315

looking in to current dts changes it looks bit wrong to me.

*As per 6.1 Memory Map*
apb_efuse: bus@30000  --> apb_efuse: bus@ff630000
periphs: bus@34400    --> periphs: bus@ff634400
dmc: bus@38000        --> dmc: bus@ff638000
hiu: bus@3c000        --> hiu: bus@ff63c0000

Also the order of these is not correct.

Down the line in the datasheet some of the interrupt GIC bit are not
mapped correctly for example.

*As per 6.9.2 Interrupt Control Source*
223 SD_EMMC_C
222 SD_EMMC_B
221 SD_EMMC_A

and so on.
Please share your thought if these changes are valid.

Best Regards
-Anand
