Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECED8C33CAD
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1B924735
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA/Nl5/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfLMOXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:23:39 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34717 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbfLMOXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 09:23:38 -0500
Received: by mail-io1-f67.google.com with SMTP id z193so2576805iof.1;
        Fri, 13 Dec 2019 06:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oY4foPWzvMWBhrOb3ctOq9TVV5hU0NFwbmMTS0Zd/UU=;
        b=WA/Nl5/qzxziow27rNFDBN6AR0i/0NcNiRvRVp80t0u9W0JQMaMjKJ1FXpSIJvFRsA
         9XNtyo7R3tvMIJvxC8oiNyOk4J2wtKS7B3Ts81LXhTeznVpJDzP2bBwTq3eNp8TT5jGC
         JeJnDQdKIfDwUHRy+/BauHNwzMIsrHZwY1yL13K6S1JG3p8bmPr43mrdPMlvRX974Db3
         sejJ6jhmsn/JNHCDsnNqd+DX6Vt5JKtCkrXbQGX1nBV17cl/Lwbv1gGNky1WX5xz6cB9
         qNaJLQ5sYArh6IQ72EsTE5mzorok1Y/tT0dn2XFjhtREMCr3CwECOoTe5T6M5fG+Ice6
         rw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oY4foPWzvMWBhrOb3ctOq9TVV5hU0NFwbmMTS0Zd/UU=;
        b=KlXoeMAgnY9wxfhJhRH5/Tqns2hvtXu50qURkzSQCsWAfHwN0Lp7jM8QPfYCvKdSCS
         ouost0PLswyuEPgYs9knFipMHyTc/bEUVRyb6LB+PuGWIMyV9mCP/TVSPglRtODJ/5yg
         9QC7DOkjlO/eWQtqhf/OGcVdQnARX2NojWeEa6xIvqXSYrGCunasI1nLmiDX/Qq2ONvH
         KeO0phIXInWfgNZXhj5YRBCUHMe6XoZQ360eOizBoYAjRRTdrpLCUylU4eEg0r+huWGX
         XlP4k+n54KnQxEFvH++71BXuO6eXhSFXFJ5jyMOIr3JAfdj6EbiEHamVbn/TKsAxZ4rz
         e65g==
X-Gm-Message-State: APjAAAXuo/Id0J6TNevSr1WQ7WNAGjQ+1vbsksBAT0Ph0WKELu8sUr65
        eCQa3eehPSU8E5Guv+Dq26CY07nfg1npE9iuvQ8=
X-Google-Smtp-Source: APXvYqw9fo8CyH8rZgTkDXi/QpomXN7jj5DggXjh44v4tlkbINHuyaaFmy+kLmhjIEG8wBfM6tVMJ2kyLjCLt4kAyek=
X-Received: by 2002:a02:844e:: with SMTP id l14mr2634809jah.30.1576247017731;
 Fri, 13 Dec 2019 06:23:37 -0800 (PST)
MIME-Version: 1.0
References: <20191101143126.2549-1-linux.amoon@gmail.com> <7hfthtrvvv.fsf@baylibre.com>
 <c89791de-0a46-3ce2-b3e2-3640c364cd0f@baylibre.com> <CANAwSgQx3LjQe60TGgKyk6B5BD5y1caS2tA+O+GFES7=qCFeKg@mail.gmail.com>
 <7hfthsqcap.fsf@baylibre.com> <CAFBinCBfgxXhPKpBLdoq9AimrpaneYFgzgJoDyC-2xhbHmihpA@mail.gmail.com>
 <7hpngvontu.fsf@baylibre.com> <4e1339b4-c751-3edc-3a2e-36931ad1c503@baylibre.com>
 <CAFBinCCgKcwXSLxS_CRvz9JZvQo8PcUGm=egBbabVZSrkSc30Q@mail.gmail.com>
 <CANAwSgSFR3kftWLPqyoYfyxdQ5dcp2W7NgRCaFNkMj-xEDY1Kw@mail.gmail.com> <83791a71-a45c-383d-0406-b0f4e0a0c215@baylibre.com>
In-Reply-To: <83791a71-a45c-383d-0406-b0f4e0a0c215@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 13 Dec 2019 19:53:26 +0530
Message-ID: <CANAwSgSsJ8oc--SxtOnsqAfRHQwtBi=ExWg0hqWX7QKga=OYRw@mail.gmail.com>
Subject: Re: [RFC-next 0/1] Odroid C2: Enable DVFS for cpu
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil

On Fri, 13 Dec 2019 at 18:54, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 13/12/2019 12:28, Anand Moon wrote:
> > Hi Martin
> >
> > On Fri, 13 Dec 2019 at 01:40, Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> >>
> >> Hi Neil,
> >>
> >> On Wed, Dec 11, 2019 at 9:49 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>>
> >>> On 10/12/2019 22:47, Kevin Hilman wrote:
> >>>> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
> >>>>
> >>>>> On Tue, Dec 10, 2019 at 7:13 PM Kevin Hilman <khilman@baylibre.com> wrote:
> >>>>>>
> >>>>>> Anand Moon <linux.amoon@gmail.com> writes:
> >>>>>>
> >>>>>>> Hi Neil / Kevin,
> >>>>>>>
> >>>>>>> On Tue, 10 Dec 2019 at 14:13, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>>>>>>>
> >>>>>>>> On 09/12/2019 23:12, Kevin Hilman wrote:
> >>>>>>>>> Anand Moon <linux.amoon@gmail.com> writes:
> >>>>>>>>>
> >>>>>>>>>> Some how this patch got lost, so resend this again.
> >>>>>>>>>>
> >>>>>>>>>> [0] https://patchwork.kernel.org/patch/11136545/
> >>>>>>>>>>
> >>>>>>>>>> This patch enable DVFS on GXBB Odroid C2.
> >>>>>>>>>>
> >>>>>>>>>> DVFS has been tested by running the arm64 cpuburn
> >>>>>>>>>> [1] https://github.com/ssvb/cpuburn-arm/blob/master/cpuburn-a53.S
> >>>>>>>>>> PM-QA testing
> >>>>>>>>>> [2] https://git.linaro.org/power/pm-qa.git [cpufreq testcase]
> >>>>>>>>>>
> >>>>>>>>>> Tested on latest U-Boot 2019.07-1 (Aug 01 2019 - 23:58:01 +0000) Arch Linux ARM
> >>>>>>>>>
> >>>>>>>>> Have you tested with the Harkernel u-boot?
> >>>>>>>>>
> >>>>>>>>> Last I remember, enabling CPUfreq will cause system hangs with the
> >>>>>>>>> Hardkernel u-boot because of improperly enabled frequencies, so I'm not
> >>>>>>>>> terribly inclined to merge this patch.
> >>>>>>>
> >>>>>>> HK u-boot have many issue with loading the kernel, with load address
> >>>>>>> *it's really hard to build the kernel for HK u-boot*,
> >>>>>>> to get the configuration correctly.
> >>>>>>>
> >>>>>>> Well I have tested with mainline u-boot with latest ATF .
> >>>>>>> I would prefer mainline u-boot for all the Amlogic SBC, since
> >>>>>>> they sync with latest driver changes.
> >>>>>>
> >>>>>> Yes, we would all prefer mainline u-boot, but the mainline kernel needs
> >>>>>> to support the vendor u-boot that is shipping with the boards.  So
> >>>>>> until Hardkernel (and other vendors) switch to mainline u-boot we do not
> >>>>>> want to have upstream kernel defaults that will not boot with the vendor
> >>>>>> u-boot.
> >>>>>>
> >>>>>> We can always support these features, but they just cannot be enabled
> >>>>>> by default.
> >>>>> (I don't have an Odroid-C2 but I'm curious)
> >>>>> should Anand submit a patch to mainline u-boot instead?
> >>>>
> >>>> It would be in addition to $SUBJECT patch, not instead, I think.
> >>>>
> >>>>> the &scpi_clocks node could be enabled at runtime by mainline u-boot
> >>>>
> >>>> That would work, but I don't know about u-boot maintainers opinions on
> >>>> this kind of thing, so let's see what Neil thinks.
> >>>
> >>> U-Boot doesn't anything to do with SCPI, SCPI discusses directly with the SCP
> >>> processor, and the CPU clock is set to 1,56GHz by the BL2 boot stage before
> >>> U-boot starts.
> >>>
> >>> The only viable solution I see now is to find if we could add a DT OPP table
> >>> only for Odroid-C2 dts to bypass the SCPI OPP table.
> >> my understanding is that mainline u-boot (with whatever SCP firmware
> >> it uses) provides the *correct* OPP table
> >
> > Right now I am not sure how this OPP table is populated.
> > But I saw the same freq table used in 3.16.x kernel after enable the clk.
> >
> >> in this case it would be "safe" to have SCPI enabled with mainline u-boot
> >> @Anand: please correct me if I misunderstood you
> >>
> >
> > As per my understanding DVFS OPP frequency table for SCPI firmware set
> > for 1.536 GHz
> > somewhere in BL2 as pointed by Neil.
> >
> > Arm Trusted firmware added new secure SCPI communication with
> > Cortex-M3 co processor.
> > [0] https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/plat/meson-gxbb.rst
> > [1] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/amlogic/common/aml_scpi.c
> >
> > ATF generated the *bl1.bin* which is replace the Amlogic's bl1.bin
> > while preparing
> > the new u-boot *u-boot.gxbb* image.
> >
> >> my idea to "enable SCPI with mainline u-boot" is to have u-boot update
> >> the "status" property of the scpi_clocks node.
> >> u-boot does something similar with the mac-address property of the
> >> Ethernet controller for example.
> >> as result of this users of mainline u-boot would have working CPU
> >> DVFS, while users of the old vendor u-boot would run at fixed 1.54GHz.
> >>
> >>
> >> Martin
> >
> > Right now as per my understanding 1.536 GHz max is bit under clocked.
> >
> > Some time ago on Odroid Forum tried to over clock the cpu to 2GHz.
>
> This is the point, the Odroid-C2 is *not* stable at 2GHz,
> a large amount of board doesn't support 2GHz, this is why Amlogic
> dropped the freq > 1.536 GHz for the GXBB family.
>
> But HardKernel still delivers the SCPI table with > 1.536 GHz which breaks
> on most of the boards, but doesn't on 3.14 since they have a hack disabling
> higher freqs with a cmdline set in boot.ini.
>
> > [3] https://forum.odroid.com/viewtopic.php?f=139&t=18738
> > So more investigation need to done in this line.
> >
> > I also tried the same with HardKernel Image, with modifying the boot.ini
> > I could increase the max DVFS cpu frequency to 1.90 GHz,
> > This is just proof of concept.
> >
> > odroid:~# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
> > 100000 250000 500000 1000000 1296000 1536000 1656000 1680000 1752000 1896000
> >
> > I have some minimal stress testing attached are the results for HK
> > 3.16.x kernel.
> >
> > For now we should not enable this clock.
> > Until we can possible to check for higher clock frequency to work stable
> > on all Amlogic S905X SBC.
> >
> > I like the Neil's approach to use it's own dts OPP table for SCPI protocol.
>
> The various tests gave very little perf enhancement by going > 1,536 GHz, seriously
> it's not worth the pain.
>
> Neil
>

Ok Thanks for your expert knowledge.
I agree with you completely on this to set max freq to 1,536 GHz for
all S905 SoC.

-Anand
