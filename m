Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79311C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2169E2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwqsiShW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfCZKfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:35:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41420 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfCZKfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:35:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id v7so9483610oie.8;
        Tue, 26 Mar 2019 03:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=51DtETW7B0WdnpZv6DsXwmQHt8px4YpRO2YK0moCvJM=;
        b=OwqsiShW4sefHEyAff5t8iMAYGfGjQlK5PxM7EV/29N7d3VNlktTX1BQMt6SHOmxAC
         4L10bqpb/MU+5AcW/EOJzfvQnrFvqXm6q3Qoc3utfFq0V1pPqHxIOAV1nJE6Pr1tF46H
         dvRS91tzVcvr2JANRe5FyUYqyK9BdCu99RQcev770J0lvPjrcgAE9kHAaWV7K5y7N56M
         Rx53WvbmpjqiQy4WArEoYnL46leKKEGcd1YUm3DPYd7xD+PxqYzV3vrEMphSuH6XbfTs
         WnKokot9QvEIt5TdWOAWZbe3UI5hzH7wCi1PFXzFROlxWplliVyzjc+FWFaiGz+7mROp
         CkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51DtETW7B0WdnpZv6DsXwmQHt8px4YpRO2YK0moCvJM=;
        b=HQoJDbT6HVuOQPv7ndgcm2YO9uaqYBYKWIIWzezWO+8DXqBcOI/nGWmEVgurTonS5V
         mGxqyqLm4vD4s3isp6L1PAKRrcp+eLO16B75kzQVLQLMUXuGYIW1dIE25MYx136GVeDI
         xaEwekLnl/zNye5ODQWhdrYHtmVARdJnqiqAwyBeN+/Ve5l50Zd3Qplj/aPH7DjokZbV
         0n1rWr20E/XSBElTae2rM/R9hXNeorSDbV10RpR+gCVtaSukM0UAQ78oVZ2pQUf4FWhi
         U8s5feCMr6cV+ra7PHkbuPOjoQJhOhc7cslzeDpJjevtyaafLSUfVCtRoabE/o5EMu43
         7Fhg==
X-Gm-Message-State: APjAAAUamCgixiKevSKSmTL6iAxev8hSjLG4sjaZfxLW+QpBxm+C8FBx
        7W9o30Ggm70HG4Z6Pwf/YzwLdKR9eScc3cWPgMs=
X-Google-Smtp-Source: APXvYqycYPR1y6yPC3NLBuGPE2kMD8UYgDGHEA4HClRAii6yKhFTaHoTWEgJnQ62EgY6CAPbgSKAccQPuGtz5YAvlnQ=
X-Received: by 2002:aca:af83:: with SMTP id y125mr14894704oie.163.1553596541174;
 Tue, 26 Mar 2019 03:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190324083256.1047-1-linux.amoon@gmail.com> <CAJKOXPfLyLRwJKWcMCtDg10em2pfWZJzXr8FkFTf1vtavRdoTw@mail.gmail.com>
In-Reply-To: <CAJKOXPfLyLRwJKWcMCtDg10em2pfWZJzXr8FkFTf1vtavRdoTw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 26 Mar 2019 16:05:28 +0530
Message-ID: <CANAwSgTS5nkxOwoS1hJLgN_Mw9X2FopgeCr=7itGm-caJzVXUw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="000000000000f62a3a0584fce1c0"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f62a3a0584fce1c0
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks your for your valuable comments.
I will try to answer your queries to best of my knowledge.

On Mon, 25 Mar 2019 at 18:16, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sun, 24 Mar 2019 at 09:33, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Add suspend-to-mem node to regulator core to be enabled or disabled
> > during system suspend and also support changing the regulator operating
> > mode during runtime and when the system enter sleep mode (stand by mode).
> >
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Current patch:
> >
> > Note: Both microSD and eMMC suspend resume works this changes at my end.
> >
> > regulator-off-in-suspend:
> > set the regulator node into suspend state i.e. standby mode during suspend
> > operation.
> >
> > Current changes are based on
> > [0] https://www.kernel.org/doc/Documentation/devicetree/bindings/regulator/max77686.txt
> >
> >   Regulators which can be turned off during system suspend:
> >         -LDOn   :       2, 6-8, 10-12, 14-16,
> >         -BUCKn  :       1-4.
> >   Use standard regulator bindings for it ('regulator-off-in-suspend').
> >
> > drop the suspend off binding which are not supported by the driver.
> >
> > RFC version
> > [1] https://patchwork.kernel.org/patch/10810909/
> > These changes had some problem with eMMC not entering into suspend mode.
> > with some miss configuration in regulator-off-in-suspend mode.
> >
> > Changes from previos patch.
> > [2] https://patchwork.kernel.org/patch/10712549/
> >
> > Set all the non used regulator in suspend-odd state
> > LD02, LD03, LD05, LD06, LD07, LD011, LD013, LDO14, LD016
> >
> > BUCK5, BUCK6, BUCK7 and not confirable as per driver max77686-regulator
> > ---
> >  .../boot/dts/exynos4412-odroid-common.dtsi    | 39 +++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > index 08d3a0a7b4eb..375156ad5454 100644
> > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > @@ -288,6 +288,9 @@
> >                                 regulator-min-microvolt = <1800000>;
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
>
> Please maintain proper versioning of patches.
> First patch sent to lists should be either RFC or v1. Second
> release/submission is then always v2. Third v3.

I tried to mixed up some changes that's the reason.
Ok if needed next version will be Patch V3.

>
> This is third or fourth submission but you marked it as v1. This makes
> it very difficult to discuss and reference previous versions.
>
> The commit message did not change since beginning (first version). I
> asked twice that you need to explain exactly why you put the the
> regulator to off or on state in suspend. Why?
> Because:
> 1. This change looks without justification - once you put on, then you
> put off, now again on,
> 2. Anyone reading the code later must know the rationale why this was done,
> 3. I am not quite sure whether this is good setting so I would be
> happy to be convinced.
>

Like I mention in the patch summary that this.

Current changes are based on
[0] https://www.kernel.org/doc/Documentation/devicetree/bindings/regulator/max77686.txt

  Regulators which can be turned off during system suspend:
-LDOn : 2, 6-8, 10-12, 14-16,
-BUCKn : 1-4.
  Use standard regulator bindings for it ('regulator-off-in-suspend').

> How to provide such explanation? The best in commit message. Sometimes
> in the comment in the code, depends.

Ok I have been testing with following regulator debug prints to catch error.
[0] max77686-regulator.patch

below is the console logs during suspend and resume.
-------------------------------------------------------------------------------
Last login: Sat Mar 23 18:22:46 on ttySAC1
[root@archl-u3e ~]# echo no > /sys/module/printk/parameters/console_suspend
[root@archl-u3e ~]# rtcwake -d /dev/rtc0 -m mem -s 10
rtcwake: wakeup from "mem" using /dev/rtc0 at Sat Mar 23 19:56:17 2019
[   38.595854] PM: suspend entry (deep)
[   38.596603] PM: Syncing filesystems ... done.
[   38.629351] Freezing user space processes ... (elapsed 0.002 seconds) done.
[   38.633192] OOM killer disabled.
[   38.636035] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[   38.675059] smsc95xx 1-2:1.0 eth0: entering SUSPEND2 mode
[   38.753120] dwc2 12480000.hsotg: suspending usb gadget g_ether
[   38.754007] dwc2 12480000.hsotg: new device is full-speed
[   38.758960] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   38.765507] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   38.774050] wake enabled for irq 119
[   38.775761] BUCK9: No configuration
[   38.779191] BUCK8_P3V3: No configuration
[   38.782852] BUCK7_2.0V: No configuration
[   38.786851] BUCK6_1.35V: No configuration
[   38.790752] VDDQ_CKEM1_2_1.2V: No configuration
[   38.796220] BUCK4: regulator suspend disable supported
[   38.800769] BUCK3: regulator suspend disable supported
[   38.806002] BUCK1: regulator suspend disable supported
[   38.810644] LDO26: No configuration
[   38.814169] VDDQ_LCD_1.8V: No configuration
[   38.818267] LDO24: No configuration
[   38.821732] LDO23: No configuration
[   38.825262] LDO22_VDDQ_MMC4_2.8V: No configuration
[   38.829992] TFLASH_2.8V: No configuration
[   38.834040] LDO20_1.8V: No configuration
[   38.837883] LDO19: No configuration
[   38.841349] LDO18: No configuration
[   38.844878] LDO17: No configuration
[   38.848667] LDO16: regulator suspend disable supported
[   38.853889] LDO15: regulator suspend disable supported
[   38.858931] LDO14: regulator suspend disable supported
[   38.863771] VDDQ_C2C_W_1.8V: No configuration
[   38.868378] LDO12: regulator suspend disable supported
[   38.873508] LDO11: regulator suspend disable supported
[   38.878545] LDO10: regulator suspend disable supported
[   38.883384] LDO9: No configuration
[   38.887190] LDO8: regulator suspend disable supported
[   38.892168] LDO7: regulator suspend disable supported
[   38.897279] LDO6: regulator suspend disable supported
[   38.901872] VDDQ_MMC1_3_1.8V: No configuration
[   38.906363] VDDQ_MMC2_2.8V: No configuration
[   38.910541] VDDQ_EXT_1.8V: No configuration
[   38.915134] LDO2: regulator suspend disable supported
[   38.919753] VDD_ALIVE_1.0V: No configuration
[   38.935229] usb3503 0-0008: switched to STANDBY mode
[   38.935981] wake enabled for irq 123
[   38.955192] samsung-pinctrl 11000000.pinctrl: Setting external
wakeup interrupt mask: 0xfbfff7ff
[   38.975448] Disabling non-boot CPUs ...
[   39.029279] s3c2410-wdt 10060000.watchdog: watchdog disabled
[   39.029576] wake disabled for irq 123
[   39.044319] usb3503 0-0008: switched to HUB mode
[   39.144089] wake disabled for irq 119
[   39.144812] dwc2 12480000.hsotg: resuming usb gadget g_ether
[   39.422626] usb 1-2: reset high-speed USB device number 2 using exynos-ehci
[   39.774632] usb 1-3: reset high-speed USB device number 3 using exynos-ehci
[   40.106478] OOM killer enabled.
[   40.106609] Restarting tasks ... done.
[   40.111100] PM: suspend exit
[   40.124058] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
req 400000Hz, actual 396825HZ div = 63)
[root@archl-u3e ~]# [   40.364705] mmc_host mmc1: Bus speed (slot 0) =
50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
[   41.220200] smsc95xx 1-2:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
-------------------------------------------------------------------------------
> How such explanation could look like? For example like this:
> f8f3b7fc21b1 ("ARM: dts: exynos: Fix regulators configuration on Peach
> Pi/Pit Chromebooks")
> Marek clearly explained why he put the regulators "always-on", even
> tough we do not know everything about this. More over, he mentions
> that this fixes specific issue.
>

Thanks but I am not the expert here in general with regulator on/off.
I will add comment if needed explain in more detail.

[snip]

> Summarizing, please answer:
> 1. Why this is made off-in-suspend?
> 2. Why this can be made off-in-suspend?
>

On MAX77686A PMIC. (some quote from the datasheet).

Power ON/OFF by PWRREQ in PMIC=ON sequence is only effective when ON/OFF
on all regulators above are assigned by PWRREQ=H/L.

All programming must be done before the AP enters the sleep mode by
pulling PWRREQ low since
the AP does not have programming capability in (deep) sleep mode.

*Regulator are not really turned off but set into IDLE  / Standby
state too be restored to Normal state*

Power summary in image : [1] https://imgur.com/gallery/l74kliX

Power Summary for MAX77686A of the regulator support PWRREQ
Power   Default ON  |  ON/OFF
--------------------------------------
BUCK1  |  ON        | PWRREQ or I2C
BUCK2  |  ON        | PWRREQ or I2C
BUCK3  |  ON        | PWRREQ or I2C
BUCK4  |  ON        | PWREWQ or I2C
BUCK5  |  ON        | I2C
BUCK6  |  ON        | I2C
BUCK7  |  ON        | I2C
BUCK8  |  OFF       | I2C or ENB8 The external enable/disable pin, ENB8
BUCK9  |  OFF       | I2C or ENB9 The external enable/disable pin, ENB9
LDO1   |  ON        | I2C
LDO2   |  ON        | PWRREQ or I2C
LDO3   |  ON        | I2C
LDO4   |  ON        | I2C
LDO5   |  ON        | I2C
LDO6   |  ON        | PWRREQ or I2C
LDO7   |  ON        | PWRREQ or I2C
LDO8   |  ON        | PWRREQ or I2C
LDO9   |  OFF       | I2C
LDO10  |  ON        | PWRREQ or I2C
LDO11  |  ON        | PWRREQ or I2C
LDO12  |  ON        | PWRREQ or I2C
LDO13  |  ON        | I2C
LDO14  |  ON        | PWRREQ or I2C
LDO15  |  ON        | PWRREQ or I2C
LDO16  |  ON        | PWRREQ or I2C
LDO17  |  OFF       | I2C
LDO18  |  OFF       | I2C
LDO19  |  OFF       | I2C
LDO20  |  OFF       | I2C OR ENL20 ENL20, external enable/disable pin
LDO21  |  OFF       | I2C OR ENL21 ENL21, external enable/disable pin
LDO22  |  OFF       | I2C OR ENL22 ENL22, external enable/disable pin
LDO23  |  OFF       | I2C
LDO24  |  OFF       | I2C
LDO25  |  OFF       | I2C
LDO26  |  OFF       | I2C

> >                         ldo20_reg: LDO20 {
> > @@ -421,6 +451,9 @@
> >                                 regulator-max-microvolt = <1100000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
>
> I questioned this change two times. You did not answer to my
> question... If you turn memory bus regulator off, how the memory will
> work in Suspend-to-Memory mode? I might be missing here something but
> it just looks suspicious. Maybe the regulator does not supply the
> memory itself (so refresh works even when it is down), just the
> interface? I don't know, it just looks suspicious. I need to see
> proper explanation.
>
> I am sorry but I will not check other hunks in this patch. Please
> provide the answers for all my questions here first.
>

As per above table of MAX77686 PWRREQ capabilities regulator nodes
can be turned off during suspend reset of them remain on during suspend.

> Best regards,
> Krzysztof
>

We could monitor the regulator states via sys filesystem and also
using below tool
https://git.linaro.org/power/powerdebug.git

I have tried to summaries the feature required for this patch.
some of which I have overlooked earlier before sending the patch.

I am really poor in english for transform / interpreter the technical details
required at for your queries. But I will try to improve my self in the future.

Best Regards
-Anand

--000000000000f62a3a0584fce1c0
Content-Type: application/octet-stream; name="max77686-regulator.patch"
Content-Disposition: attachment; filename="max77686-regulator.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jtpis0te0>
X-Attachment-Id: f_jtpis0te0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVndWxhdG9yL21heDc3Njg2LXJlZ3VsYXRvci5jIGIvZHJp
dmVycy9yZWd1bGF0b3IvbWF4Nzc2ODYtcmVndWxhdG9yLmMKaW5kZXggODAyMGViNTczNzRhLi5m
Y2QxY2UyM2U4MjQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcmVndWxhdG9yL21heDc3Njg2LXJlZ3Vs
YXRvci5jCisrKyBiL2RyaXZlcnMvcmVndWxhdG9yL21heDc3Njg2LXJlZ3VsYXRvci5jCkBAIC0x
MzEsNiArMTMxLDggQEAgc3RhdGljIGludCBtYXg3NzY4Nl9zZXRfc3VzcGVuZF9kaXNhYmxlKHN0
cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2KQogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAKKwlw
cl9pbmZvKCIlczogcmVndWxhdG9yIHN1c3BlbmQgZGlzYWJsZSBzdXBwb3J0ZWRcbiIsCisJCQkJ
cmRldi0+ZGVzYy0+bmFtZSk7CiAJbWF4Nzc2ODYtPm9wbW9kZVtpZF0gPSB2YWw7CiAJcmV0dXJu
IDA7CiB9CkBAIC0xNDksMTMgKzE1MSwxNyBAQCBzdGF0aWMgaW50IG1heDc3Njg2X3NldF9zdXNw
ZW5kX21vZGUoc3RydWN0IHJlZ3VsYXRvcl9kZXYgKnJkZXYsCiAKIAlzd2l0Y2ggKG1vZGUpIHsK
IAljYXNlIFJFR1VMQVRPUl9NT0RFX0lETEU6CQkJLyogT04gaW4gTFAgTW9kZSAqLworCQlwcl9p
bmZvKCIlczogcmVndWxhdG9yX2lkbGVfbW9kZSA6IDB4JXggc3VwcG9ydGVkXG4iLAorCQkJCXJk
ZXYtPmRlc2MtPm5hbWUsIG1vZGUpOwogCQl2YWwgPSBNQVg3NzY4Nl9MRE9fTE9XUE9XRVJfUFdS
UkVROwogCQlicmVhazsKIAljYXNlIFJFR1VMQVRPUl9NT0RFX05PUk1BTDoJCQkvKiBPTiBpbiBO
b3JtYWwgTW9kZSAqLworCQlwcl9pbmZvKCIlczogcmVndWxhdG9yX25vcm1hbF9tb2RlIDogMHgl
eCBzdXBwb3J0ZWRcbiIsCisJCQkJcmRldi0+ZGVzYy0+bmFtZSwgbW9kZSk7CiAJCXZhbCA9IG1h
eDc3Njg2X21hcF9ub3JtYWxfbW9kZShtYXg3NzY4NiwgaWQpOwogCQlicmVhazsKIAlkZWZhdWx0
OgotCQlwcl93YXJuKCIlczogcmVndWxhdG9yX3N1c3BlbmRfbW9kZSA6IDB4JXggbm90IHN1cHBv
cnRlZFxuIiwKKwkJcHJfZXJyKCIlczogcmVndWxhdG9yX3N1c3BlbmRfbW9kZSA6IDB4JXggbm90
IHN1cHBvcnRlZFxuIiwKIAkJCXJkZXYtPmRlc2MtPm5hbWUsIG1vZGUpOwogCQlyZXR1cm4gLUVJ
TlZBTDsKIAl9CkBAIC0xNjYsNiArMTcyLDggQEAgc3RhdGljIGludCBtYXg3NzY4Nl9zZXRfc3Vz
cGVuZF9tb2RlKHN0cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2LAogCWlmIChyZXQpCiAJCXJldHVy
biByZXQ7CiAKKwlwcl9pbmZvKCIlczogcmVndWxhdG9yIHN1c3BlbmQgZGlzYWJsZSBzdXBwb3J0
ZWRcbiIsCisJCQkJcmRldi0+ZGVzYy0+bmFtZSk7CiAJbWF4Nzc2ODYtPm9wbW9kZVtpZF0gPSB2
YWw7CiAJcmV0dXJuIDA7CiB9CkBAIC0xODAsMTIgKzE4OCwxOCBAQCBzdGF0aWMgaW50IG1heDc3
Njg2X2xkb19zZXRfc3VzcGVuZF9tb2RlKHN0cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2LAogCiAJ
c3dpdGNoIChtb2RlKSB7CiAJY2FzZSBSRUdVTEFUT1JfTU9ERV9TVEFOREJZOgkJCS8qIHN3aXRj
aCBvZmYgKi8KKwkJcHJfaW5mbygiJXM6IHJlZ3VsYXRvcl9zdGFuZGJ5IG1vZGUgOiAweCV4IHN1
cHBvcnRlZFxuIiwKKwkJCXJkZXYtPmRlc2MtPm5hbWUsIG1vZGUpOwogCQl2YWwgPSBNQVg3NzY4
Nl9PRkZfUFdSUkVROwogCQlicmVhazsKIAljYXNlIFJFR1VMQVRPUl9NT0RFX0lETEU6CQkJLyog
T04gaW4gTFAgTW9kZSAqLworCQlwcl9pbmZvKCIlczogcmVndWxhdG9yX2lkbGUgbW9kZSA6IDB4
JXggc3VwcG9ydGVkXG4iLAorCQkJcmRldi0+ZGVzYy0+bmFtZSwgbW9kZSk7CiAJCXZhbCA9IE1B
WDc3Njg2X0xET19MT1dQT1dFUl9QV1JSRVE7CiAJCWJyZWFrOwogCWNhc2UgUkVHVUxBVE9SX01P
REVfTk9STUFMOgkJCS8qIE9OIGluIE5vcm1hbCBNb2RlICovCisJCXByX2luZm8oIiVzOiByZWd1
bGF0b3Jfbm9ybWFsIG1vZGUgOiAweCV4IHN1cHBvcnRlZFxuIiwKKwkJCXJkZXYtPmRlc2MtPm5h
bWUsIG1vZGUpOwogCQl2YWwgPSBtYXg3NzY4Nl9tYXBfbm9ybWFsX21vZGUobWF4Nzc2ODYsIGlk
KTsKIAkJYnJlYWs7CiAJZGVmYXVsdDoK
--000000000000f62a3a0584fce1c0--
