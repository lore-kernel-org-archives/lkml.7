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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4493ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C01A222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX7Lj4fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409789AbfJRPWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:22:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42203 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389421AbfJRPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:22:04 -0400
Received: by mail-io1-f67.google.com with SMTP id r15so4184423iod.9;
        Fri, 18 Oct 2019 08:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6aWYf2EJ6T3lEMsTnZ85l374tBYCs4qR6iBnDivBEd4=;
        b=TX7Lj4fpNaw+rPLdWCLGA+/mqMT0HXgsnWfnMBYLb8tnQvu8/szGyx5oR1ijczOcvR
         U4XFvHBasVLmxX7FVJ5xzubfHofrzKvdpQY0sWTOt1VtlRPmi4pOpGp+iVi2RQE4PquB
         eb+t4LcEDGC503ZWFBi/0chC8eGTK4DF2fdW8s8ip9JgNTwlAe0rjzujRC4TCIV60AT2
         VMHXqj9QceAAi+70kuzo1+5QIpJ7gw8aUZEGINUlPFtTv/kJiDaFeqKjKDPPWPr3dD94
         F5TjFwjSOS/l2lNRhCU1Lriyd5I3Iem5mt41D7bSZsEmZZBdXM2JhFExX+dTh5V+Vn1A
         DB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aWYf2EJ6T3lEMsTnZ85l374tBYCs4qR6iBnDivBEd4=;
        b=JIO4FF91jMT7P8vMZYnIPwFSVI3mwKXUM4IJcAw8B9Z/ppwpSCR7KpdXWJpB/mXmDk
         TWNjnaE5RK6K/PlXFqWTMgEAKsl4CJMf9r0cNDCQXOTPdE6FH2N/1LaoF6+0vHj19efA
         vdxGx6/zQnWZmURZVrZZd+7K55fQEqMbCW3WGmj+UuZ1n4Mdsi2hUBV8Z0U9eI9T8Uyg
         fjQwrGEv0hJbx7IYPA5snU1cvGAnXO3XdJw4pZXgGs8fXSjdviYZT39WUCZBQdN1AP9p
         8fvEsk9G9VCGSc9gNOpEhoZTIOpijefdsDOQCtSG+L390/tySh4i/0o8FNRlucVlLbWc
         R1vA==
X-Gm-Message-State: APjAAAWLPvieZgcU1MfGyOV9Xr8praTPOZyUa9Eg0MrAUMXDaN7ysDdX
        a3t3QE08Aa4lSjYyxX/EpuXZhhcvQh97lZyzjrg=
X-Google-Smtp-Source: APXvYqzKP3eWnLIodD8BQ96h1uueunpugA3ee1X9sSaev9gUaslu2v+ETYGgUTRIX0Wlj4SxjQBXVE0aOt1x9ISXt2Y=
X-Received: by 2002:a02:c646:: with SMTP id k6mr6271439jan.141.1571412123645;
 Fri, 18 Oct 2019 08:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191007131649.1768-1-linux.amoon@gmail.com> <20191007131649.1768-6-linux.amoon@gmail.com>
 <CAFBinCAoJLZj9Kh+SfF4Q+0OCzac2+huon_BU=Q3yE7Fu38U3w@mail.gmail.com>
 <7hsgo4cgeg.fsf@baylibre.com> <CANAwSgRfcFa6uBNtpqz6y=9Uwsa4gcp_4tDD+Chhg4SynJCq0Q@mail.gmail.com>
 <CAFBinCA6ZoeR4m4bhj08HF1DqxY1qB5mygpaQCGbo3d8M+Wr9Q@mail.gmail.com>
 <CANAwSgSeYTnUkLnjw-RORw76Fyj3_WT0cdM9D0vFsY8g=9L94Q@mail.gmail.com>
 <1jwode9lba.fsf@starbuckisacylon.baylibre.com> <CANAwSgSoK4X3_QbO3YpZRXNTpPJ+zVeid=w93f14Eyk8Dd32EQ@mail.gmail.com>
 <1496ed3e-e91b-3f09-d359-f36a8944e6b0@baylibre.com>
In-Reply-To: <1496ed3e-e91b-3f09-d359-f36a8944e6b0@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 18 Oct 2019 20:51:50 +0530
Message-ID: <CANAwSgRwLp02u1_u6oX_dXAueb2nASL_iiMmAt1Q3t9JfxiDPg@mail.gmail.com>
Subject: Re: [RFCv1 5/5] arm64/ARM: configs: Change CONFIG_PWM_MESON from m to y
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
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

On Fri, 18 Oct 2019 at 19:43, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 18/10/2019 16:04, Anand Moon wrote:
> > Hi Jerome / Neil / Martin,
> >
> > On Wed, 9 Oct 2019 at 17:34, Jerome Brunet <jbrunet@baylibre.com> wrote:
> >>
> >>
> >> On Wed 09 Oct 2019 at 10:48, Anand Moon <linux.amoon@gmail.com> wrote:
> >>>
> >>> Kernel command line: console=ttyAML0,115200n8
> >>> root=PARTUUID=45d7d61e-01 rw rootwait
> >>> earlyprintk=serial,ttyAML0,115200 initcall_debug printk.time=y
> >>>
> >>> [0] https://pastebin.com/eBgJrSKe
> >>>
> >>>> you can also try the command line parameter "clk_ignore_unused" (it's
> >>>> just a gut feeling: maybe a "critical" clock is being disabled because
> >>>> it's not wired up correctly).
> >>>>
> >>>
> >>> It look like some clk issue after I added the *clk_ignore_unused* to
> >>> kernel command line
> >>> it booted further to login prompt and cpufreq DVFS seem to be loaded.
> >>> So I could conclude this is clk issue.below is the boot log
> >>>
> >>> Kernel command line: console=ttyAML0,115200n8
> >>> root=PARTUUID=45d7d61e-01 rw rootwait
> >>> earlyprintk=serial,ttyAML0,115200 initcall_debug printk.time=y
> >>> clk_ignore_unused
> >>>
> >>> [1] https://pastebin.com/Nsk0wZQJ
> >>>
> >>
> >> Next step it to try narrow down the clock causing the issue.
> >> Remove clk_ignore_unused from the command line and add CLK_INGORE_UNUSED
> >> to the flag of some clocks your clock controller (g12a I think) until
> >>
> >> The peripheral clock gates already have this flag (something we should
> >> fix someday) so don't bother looking there.
> >>
> >> Most likely the source of the pwm is getting disabled between the
> >> late_init call and the probe of the PWM module. Since the pwm is already
> >> active (w/o a driver), gating the clock source shuts dowm the power to
> >> the cores.
> >>
> >> Looking a the possible inputs in pwm driver, I'd bet on fdiv4.
> >>
> >
> > I had give this above steps a try but with little success.
> > I am still looking into this much close.
> >
> > Well I am not the expert in clk or bus configuration.
> > but after looking into the datasheet of for clk configuration
> > I found some bus are not configured correctly.
> >
> > As per Amlogic's kernel S922X (Hardkernel)
> > below link share the bus controller.
> >
> > [0] https://github.com/hardkernel/linux/blob/odroidn2-4.9.y/arch/arm64/boot/dts/amlogic/mesong12b.dtsi#L295-L315
> >
> > looking in to current dts changes it looks bit wrong to me.
> >
> > *As per 6.1 Memory Map*
> > apb_efuse: bus@30000  --> apb_efuse: bus@ff630000
> > periphs: bus@34400    --> periphs: bus@ff634400
> > dmc: bus@38000        --> dmc: bus@ff638000
> > hiu: bus@3c000        --> hiu: bus@ff63c0000
>
> If these was wrong, the drivers simply won't work, at all
>
> >
> > Also the order of these is not correct.
>
> The order is correct, actually
>
> >
> > Down the line in the datasheet some of the interrupt GIC bit are not
> > mapped correctly for example.
> >
> > *As per 6.9.2 Interrupt Control Source*
> > 223 SD_EMMC_C
> > 222 SD_EMMC_B
> > 221 SD_EMMC_A
>
> There is an offset between the doc and the actual GIC_SPI line,
> they start the datasheet numbers from the GIC_PPI numbers (+32).
>
Ok. Thanks.

> Neil
>
Thanks for answering my query.

Best Regards
-Anand
