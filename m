Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF328C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 04:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61E32082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 04:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PimQxjHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfDDEBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 00:01:40 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53965 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfDDEBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 00:01:38 -0400
Received: by mail-it1-f194.google.com with SMTP id y204so1548929itf.3;
        Wed, 03 Apr 2019 21:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VEp0EzaW85fyyi3RDMPyjToGAl+ylvfVqYJc+8EAs4M=;
        b=PimQxjHcd10je6OuRcr3mfM8romC2ZO5V5eNMuMVhE+XdRSEqqLwpWuhMFt6b1AwDM
         /mPHDNjk5muLj4YmYL3ZMJ5GQhmyIaXgVvbN1l+xXy3Vll+ZocMwrrY/FjRyI6fkNNgU
         L1c+kD8u39PNF9czUaE2AEacvXVk4taCdNNrSGAEQl7MStRP6D04GHPfmQuoAySb88Gn
         4I93Sb8JWu+2rBAQWOUNegSgqYybQ1aSlm2ciosjLh8YDCyNe3+S6LVtWAYcHTY608/4
         lxFKT05r1BqGvg+CctYNLVdmzx44hT4M3iMO3OwAXalJ5imY/hwkdswrf5P1EWWzf+a6
         Kb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VEp0EzaW85fyyi3RDMPyjToGAl+ylvfVqYJc+8EAs4M=;
        b=VNmVfxTKaAs77jm0k8iAq3Zf2X1n4uyuefRtLvGO7moUvG4G+UCwlMEB1Pw77d8KBq
         RIvs69wQsa9uqQuuQFNpsomgaiKeUXU4bd5aT4J7KoLuh8jsaSZlZkT7jAxxZt3NH9DM
         1idALzjJ4pEKCPwnjghi9k43KF3uYPd3AzGZtXZ8Z91G15uR9q7EdZEP77aLwUWNr3II
         /9ZhbOtSmlWSLk2+De9k6I6LVwgs98o2udQWK4NQfBbzznd+miZ5e+8t4xILNWmst+K+
         J5FELy+XalRixfHiRqXEK4XQ9DDEN8R/mHAFXmKxYywErhzq6WN2quAG+/HE82Bwf6Nw
         4RXg==
X-Gm-Message-State: APjAAAVi8fowHZxmYzpIhbN7HCd6S9gqijnbShUMh5lzK1ws1ymz7Cmj
        +FstDk5RseMkQm6ecQsceSS47OQEA5KbfIJvHuI=
X-Google-Smtp-Source: APXvYqymuXJJX4+h6Nl0oBRyEqj/0L/JcOjmYBAP6oq2yNsbXfZsT05XUUiutCG4dE+cA877feLpPXAnBpODtGFceJo=
X-Received: by 2002:a24:90a:: with SMTP id 10mr2980097itm.131.1554350497144;
 Wed, 03 Apr 2019 21:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190324083256.1047-1-linux.amoon@gmail.com> <CAJKOXPfLyLRwJKWcMCtDg10em2pfWZJzXr8FkFTf1vtavRdoTw@mail.gmail.com>
 <CANAwSgTS5nkxOwoS1hJLgN_Mw9X2FopgeCr=7itGm-caJzVXUw@mail.gmail.com> <CAJKOXPdCMPpC=q4WfPm9k8ZqgfRE+gpj0QmZU3h5yi0dqBBiCA@mail.gmail.com>
In-Reply-To: <CAJKOXPdCMPpC=q4WfPm9k8ZqgfRE+gpj0QmZU3h5yi0dqBBiCA@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 4 Apr 2019 09:31:25 +0530
Message-ID: <CANAwSgQV0KANQ4Odspq-WoNJGMdnJ7+XRXAM1ka_sZa4w-KqGQ@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Krzysztof,

On Tue, 26 Mar 2019 at 16:28, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, 26 Mar 2019 at 11:35, Anand Moon <linux.amoon@gmail.com> wrote:
>
> (...)
>
> > > This is third or fourth submission but you marked it as v1. This makes
> > > it very difficult to discuss and reference previous versions.
> > >
> > > The commit message did not change since beginning (first version). I
> > > asked twice that you need to explain exactly why you put the the
> > > regulator to off or on state in suspend. Why?
> > > Because:
> > > 1. This change looks without justification - once you put on, then you
> > > put off, now again on,
> > > 2. Anyone reading the code later must know the rationale why this was done,
> > > 3. I am not quite sure whether this is good setting so I would be
> > > happy to be convinced.
> > >
> >
> > Like I mention in the patch summary that this.
> >
> > Current changes are based on
> > [0] https://www.kernel.org/doc/Documentation/devicetree/bindings/regulator/max77686.txt
> >
> >   Regulators which can be turned off during system suspend:
> > -LDOn : 2, 6-8, 10-12, 14-16,
> > -BUCKn : 1-4.
> >   Use standard regulator bindings for it ('regulator-off-in-suspend').
>
> I do not see how this is related to my questions.
>
> > > How to provide such explanation? The best in commit message. Sometimes
> > > in the comment in the code, depends.
> >
> > Ok I have been testing with following regulator debug prints to catch error.
> > [0] max77686-regulator.patch
> >
> > below is the console logs during suspend and resume.
> > -------------------------------------------------------------------------------
> > Last login: Sat Mar 23 18:22:46 on ttySAC1
> > [root@archl-u3e ~]# echo no > /sys/module/printk/parameters/console_suspend
> > [root@archl-u3e ~]# rtcwake -d /dev/rtc0 -m mem -s 10
> > rtcwake: wakeup from "mem" using /dev/rtc0 at Sat Mar 23 19:56:17 2019
> > [   38.595854] PM: suspend entry (deep)
> > [   38.596603] PM: Syncing filesystems ... done.
> > [   38.629351] Freezing user space processes ... (elapsed 0.002 seconds) done.
> > [   38.633192] OOM killer disabled.
> > [   38.636035] Freezing remaining freezable tasks ... (elapsed 0.001
> > seconds) done.
> > [   38.675059] smsc95xx 1-2:1.0 eth0: entering SUSPEND2 mode
> > [   38.753120] dwc2 12480000.hsotg: suspending usb gadget g_ether
> > [   38.754007] dwc2 12480000.hsotg: new device is full-speed
> > [   38.758960] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
> > [   38.765507] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
> > [   38.774050] wake enabled for irq 119
> > [   38.775761] BUCK9: No configuration
> > [   38.779191] BUCK8_P3V3: No configuration
> > [   38.782852] BUCK7_2.0V: No configuration
> > [   38.786851] BUCK6_1.35V: No configuration
> > [   38.790752] VDDQ_CKEM1_2_1.2V: No configuration
> > [   38.796220] BUCK4: regulator suspend disable supported
> > [   38.800769] BUCK3: regulator suspend disable supported
> > [   38.806002] BUCK1: regulator suspend disable supported
> > [   38.810644] LDO26: No configuration
> > [   38.814169] VDDQ_LCD_1.8V: No configuration
> > [   38.818267] LDO24: No configuration
> > [   38.821732] LDO23: No configuration
> > [   38.825262] LDO22_VDDQ_MMC4_2.8V: No configuration
> > [   38.829992] TFLASH_2.8V: No configuration
> > [   38.834040] LDO20_1.8V: No configuration
> > [   38.837883] LDO19: No configuration
> > [   38.841349] LDO18: No configuration
> > [   38.844878] LDO17: No configuration
> > [   38.848667] LDO16: regulator suspend disable supported
> > [   38.853889] LDO15: regulator suspend disable supported
> > [   38.858931] LDO14: regulator suspend disable supported
> > [   38.863771] VDDQ_C2C_W_1.8V: No configuration
> > [   38.868378] LDO12: regulator suspend disable supported
> > [   38.873508] LDO11: regulator suspend disable supported
> > [   38.878545] LDO10: regulator suspend disable supported
> > [   38.883384] LDO9: No configuration
> > [   38.887190] LDO8: regulator suspend disable supported
> > [   38.892168] LDO7: regulator suspend disable supported
> > [   38.897279] LDO6: regulator suspend disable supported
> > [   38.901872] VDDQ_MMC1_3_1.8V: No configuration
> > [   38.906363] VDDQ_MMC2_2.8V: No configuration
> > [   38.910541] VDDQ_EXT_1.8V: No configuration
> > [   38.915134] LDO2: regulator suspend disable supported
> > [   38.919753] VDD_ALIVE_1.0V: No configuration
> > [   38.935229] usb3503 0-0008: switched to STANDBY mode
> > [   38.935981] wake enabled for irq 123
> > [   38.955192] samsung-pinctrl 11000000.pinctrl: Setting external
> > wakeup interrupt mask: 0xfbfff7ff
> > [   38.975448] Disabling non-boot CPUs ...
> > [   39.029279] s3c2410-wdt 10060000.watchdog: watchdog disabled
> > [   39.029576] wake disabled for irq 123
> > [   39.044319] usb3503 0-0008: switched to HUB mode
> > [   39.144089] wake disabled for irq 119
> > [   39.144812] dwc2 12480000.hsotg: resuming usb gadget g_ether
> > [   39.422626] usb 1-2: reset high-speed USB device number 2 using exynos-ehci
> > [   39.774632] usb 1-3: reset high-speed USB device number 3 using exynos-ehci
> > [   40.106478] OOM killer enabled.
> > [   40.106609] Restarting tasks ... done.
> > [   40.111100] PM: suspend exit
> > [   40.124058] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
> > req 400000Hz, actual 396825HZ div = 63)
> > [root@archl-u3e ~]# [   40.364705] mmc_host mmc1: Bus speed (slot 0) =
> > 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
> > [   41.220200] smsc95xx 1-2:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
> > -------------------------------------------------------------------------------
> > > How such explanation could look like? For example like this:
> > > f8f3b7fc21b1 ("ARM: dts: exynos: Fix regulators configuration on Peach
> > > Pi/Pit Chromebooks")
> > > Marek clearly explained why he put the regulators "always-on", even
> > > tough we do not know everything about this. More over, he mentions
> > > that this fixes specific issue.
> > >
> >
> > Thanks but I am not the expert here in general with regulator on/off.
> > I will add comment if needed explain in more detail.
>
> This kernel log does not prove whether these DTS properties make sense
> or whether are proper at all. They  prove that kernel uses some
> configuration but I did not ask for this.
>
> >
> > [snip]
> >
> > > Summarizing, please answer:
> > > 1. Why this is made off-in-suspend?
> > > 2. Why this can be made off-in-suspend?
> > >
> >
> > On MAX77686A PMIC. (some quote from the datasheet).
> >
> > Power ON/OFF by PWRREQ in PMIC=ON sequence is only effective when ON/OFF
> > on all regulators above are assigned by PWRREQ=H/L.
> >
> > All programming must be done before the AP enters the sleep mode by
> > pulling PWRREQ low since
> > the AP does not have programming capability in (deep) sleep mode.
> >
> > *Regulator are not really turned off but set into IDLE  / Standby
> > state too be restored to Normal state*
> >
> > Power summary in image : [1] https://imgur.com/gallery/l74kliX
> >
> > Power Summary for MAX77686A of the regulator support PWRREQ
> > Power   Default ON  |  ON/OFF
> > --------------------------------------
> > BUCK1  |  ON        | PWRREQ or I2C
> > BUCK2  |  ON        | PWRREQ or I2C
> > BUCK3  |  ON        | PWRREQ or I2C
> > BUCK4  |  ON        | PWREWQ or I2C
> > BUCK5  |  ON        | I2C
> > BUCK6  |  ON        | I2C
> > BUCK7  |  ON        | I2C
> > BUCK8  |  OFF       | I2C or ENB8 The external enable/disable pin, ENB8
> > BUCK9  |  OFF       | I2C or ENB9 The external enable/disable pin, ENB9
> > LDO1   |  ON        | I2C
> > LDO2   |  ON        | PWRREQ or I2C
> > LDO3   |  ON        | I2C
> > LDO4   |  ON        | I2C
> > LDO5   |  ON        | I2C
> > LDO6   |  ON        | PWRREQ or I2C
> > LDO7   |  ON        | PWRREQ or I2C
> > LDO8   |  ON        | PWRREQ or I2C
> > LDO9   |  OFF       | I2C
> > LDO10  |  ON        | PWRREQ or I2C
> > LDO11  |  ON        | PWRREQ or I2C
> > LDO12  |  ON        | PWRREQ or I2C
> > LDO13  |  ON        | I2C
> > LDO14  |  ON        | PWRREQ or I2C
> > LDO15  |  ON        | PWRREQ or I2C
> > LDO16  |  ON        | PWRREQ or I2C
> > LDO17  |  OFF       | I2C
> > LDO18  |  OFF       | I2C
> > LDO19  |  OFF       | I2C
> > LDO20  |  OFF       | I2C OR ENL20 ENL20, external enable/disable pin
> > LDO21  |  OFF       | I2C OR ENL21 ENL21, external enable/disable pin
> > LDO22  |  OFF       | I2C OR ENL22 ENL22, external enable/disable pin
> > LDO23  |  OFF       | I2C
> > LDO24  |  OFF       | I2C
> > LDO25  |  OFF       | I2C
> > LDO26  |  OFF       | I2C
>
> You quoted the datasheet which describes PMIC behavior. This does not
> answer to my two questions at all.
>
> >
> > > >                         ldo20_reg: LDO20 {
> > > > @@ -421,6 +451,9 @@
> > > >                                 regulator-max-microvolt = <1100000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > >
> > > I questioned this change two times. You did not answer to my
> > > question... If you turn memory bus regulator off, how the memory will
> > > work in Suspend-to-Memory mode? I might be missing here something but
> > > it just looks suspicious. Maybe the regulator does not supply the
> > > memory itself (so refresh works even when it is down), just the
> > > interface? I don't know, it just looks suspicious. I need to see
> > > proper explanation.
> > >
> > > I am sorry but I will not check other hunks in this patch. Please
> > > provide the answers for all my questions here first.
> > >
> >
> > As per above table of MAX77686 PWRREQ capabilities regulator nodes
> > can be turned off during suspend reset of them remain on during suspend.
>
> Just because something can be turned off does not mean that it should.
> Apparently you made this assumption everywhere here and for my
> questions "why?" you reply "datasheet of PMIC says it can be done".
> This is wrong assumption and wrong justification for the patch.
>
> I cannot accept this. Please answer my questions and provide proper
> rationale for this patch.
>
> >
> > > Best regards,
> > > Krzysztof
> > >
> >
> > We could monitor the regulator states via sys filesystem and also
> > using below tool
> > https://git.linaro.org/power/powerdebug.git
> >
> > I have tried to summaries the feature required for this patch.
> > some of which I have overlooked earlier before sending the patch.
> >
> > I am really poor in english for transform / interpreter the technical details
> > required at for your queries. But I will try to improve my self in the future.
>
> Again this is observing of kernel behavior after applying patch. It
> has nothing to do whether change should be implemented and how it
> affects real hardware. This is not even a measurement...
>
> Best regards,
> Krzysztof

Lets discard this patch. sorry for the trouble in review.

Best Regards
-Anand
