Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2005FC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCEC218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftirfNjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfJHOjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:39:03 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38014 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfJHOjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:39:02 -0400
Received: by mail-io1-f67.google.com with SMTP id u8so36991396iom.5;
        Tue, 08 Oct 2019 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uiceJE125UAsY9qV5J3iJSofyaHXglRUBpS3y2nKZWo=;
        b=ftirfNjK2WvYeOLN3JGalhD5g5IP5PhtLP1nYd34nYOC4PQE14lYKtIHcMhdQfsQzd
         PUf8t+hGR91Zg5h0Uc0ZtX0imJe/ZEI75qcXfrD0/4I2LECkgNqZs7ALkw04R9E2TfJ7
         crrrbaAHFXnvZqSazXMbtCZDI9+4TTCsmG9NpJbouWfgoqnF3EZ/qpaj8jXm50P2rbab
         YKqAw3cpYyI1q9L96+6TJ4qTtzx6nlvoSssux4yiSUBHQmxJr5C3xTLd5tbeBmh3Fv+2
         3v+hXhSbAschBfZuXUu6s+nCuPuW0hppiGUVjYil3c/R0Lx6XNdcTeQR/tbHEUuUJukX
         V8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uiceJE125UAsY9qV5J3iJSofyaHXglRUBpS3y2nKZWo=;
        b=S7Slz+LZO2sriuXqIEqKIuTi1OT/PB/JnSlsfhj7EKsSI9D7VVY2E4GahYwefMdvvi
         4RJNGMe1G9KTlAAgHWWNkpSaJV2cW6M4KBeEs5BqKcMT6L/YQwqmmumvWDimhVxBguPR
         2zDCLHWEtjPWiPj96f2/7vbZtkRCgCl60um94tD6N5kxfyX9UD59MIL+I+68dNesL3je
         8+/zfVQk1j18KPQ1eeY9YZM1MUjcX9smSUrqGvGQX/W2VuFo6S9v6WCNC29tlohRpQ5m
         o3fv5sK1dfsFbh+qqH2VkCLv+IYoyzD1aFC3c32InN9JlQ7qcc4CEAoq8kGsrF9VU95d
         qWDA==
X-Gm-Message-State: APjAAAU3RufCJxdJzkLEoQ01s832dJyNffSwlLb6xb3UMDHiSKmbj0KJ
        1MUoTLD9AZnC5zBdb5NAtePyRv2NNuiZaBiB2IQ=
X-Google-Smtp-Source: APXvYqxpf6FluAbTLJWNi5zkpLIoDzexhO/UEjXqiJfh8iDu67wsDgsJ1oy3lEfx/04ZIk4fPelVZzcjWE7uZpgBnWI=
X-Received: by 2002:a05:6602:2803:: with SMTP id d3mr18366937ioe.75.1570545541296;
 Tue, 08 Oct 2019 07:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191007131649.1768-1-linux.amoon@gmail.com> <20191007131649.1768-6-linux.amoon@gmail.com>
 <CAFBinCAoJLZj9Kh+SfF4Q+0OCzac2+huon_BU=Q3yE7Fu38U3w@mail.gmail.com> <7hsgo4cgeg.fsf@baylibre.com>
In-Reply-To: <7hsgo4cgeg.fsf@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 8 Oct 2019 20:08:49 +0530
Message-ID: <CANAwSgRfcFa6uBNtpqz6y=9Uwsa4gcp_4tDD+Chhg4SynJCq0Q@mail.gmail.com>
Subject: Re: [RFCv1 5/5] arm64/ARM: configs: Change CONFIG_PWM_MESON from m to y
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin / Martin,

On Tue, 8 Oct 2019 at 04:28, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
> > On Mon, Oct 7, 2019 at 3:17 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > [...]
> >> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> >> index c9a867ac32d4..72f6a7dca0d6 100644
> >> --- a/arch/arm64/configs/defconfig
> >> +++ b/arch/arm64/configs/defconfig
> >> @@ -774,7 +774,7 @@ CONFIG_MPL3115=m
> >>  CONFIG_PWM=y
> >>  CONFIG_PWM_BCM2835=m
> >>  CONFIG_PWM_CROS_EC=m
> >> -CONFIG_PWM_MESON=m
> >> +CONFIG_PWM_MESON=y
> >
> > some time ago I submitted a similar patch for the 32-bit SoCs
> > it turned that that pwm-meson can be built as module because the
> > kernel will run without CPU DVFS as long as the clock and regulator
> > drivers are returning -EPROBE_DEFER (-517)
>
> On 64-bit SoCs, the kernel boots with PWM as a module also, but DVFS
> only works sometimes, and making it built-in fixes the problem.
> Actually, it doesn't fix, it just hides the problem, which is likely a
> race or timeout happening during deferred probing.
>
> > did you check whether there's some other problem like some unused
> > clock which is being disabled at that moment?
> > I've been hunting weird problems in the past where it turned out that
> > changing kernel config bits changed the boot timing - that masked the
> > original problem
>
> Right, I would definitely prefer to not make this built-in without a lot
> more information to *why* this is needed.  In figuring that out, we'll
> probably find the race/timeout that's the root cause.
>
> Kevin
>
>

Kevin,

As per my understanding from the kernelci.org logs it seen that
pwm-meson driver is requested more than once before it finally load the module.

[0] https://storage.kernelci.org/next/master/next-20191008/arm64/defconfig/gcc-8/lab-baylibre/boot-meson-g12b-odroid-n2.txt

Hi Martin,

I have tired your Martin's patch [1] and still the boot fails to move
ahead with below logs.
[1] https://lore.kernel.org/patchwork/patch/1034186/

[    1.543928] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
[    1.550422] usb usb2: We don't know the algorithms for LPM for this
host, disabling LPM.
[    1.558702] hub 2-0:1.0: USB hub found
[    1.562131] hub 2-0:1.0: 1 port detected
[    1.566206] dwc3-meson-g12a ffe09000.usb: switching to Device Mode
[    1.573252] meson-gx-mmc ffe05000.sd: Got CD GPIO
[    1.607405] hctosys: unable to open rtc device (rtc0)

I have put some more prints in pwm-meson.c it fails to load the module
as microsSD card is not completely initialized.

Here is what I have tried to enable sd_emmc_b node, but still it fails
to initialize this driver..

-       max-frequency = <50000000>;
+       sd-uhs-sdr12;
+       sd-uhs-sdr25;
+       sd-uhs-sdr50;
+       sd-uhs-ddr50;
+       max-frequency = <100000000>;
        disable-wp;

Below are the boot logs.

[    1.729877] meson-gx-mmc ffe05000.sd: Anand mmc proble start1
[    1.734658] meson-gx-mmc ffe05000.sd: Got CD GPIO
[    1.739237] meson-gx-mmc ffe05000.sd: Anand mmc proble start2
[    1.744900] meson-gx-mmc ffe05000.sd: Anand mmc proble start3
[    1.750594] meson-gx-mmc ffe05000.sd: Anand mmc proble start4
[    1.756292] meson-gx-mmc ffe05000.sd: Anand mmc proble start5
[    1.761987] meson-gx-mmc ffe05000.sd: Anand mmc proble start6
[    1.767668] meson-gx-mmc ffe05000.sd: Anand mmc proble start7
[    1.773356] meson-gx-mmc ffe05000.sd: Anand mmc proble start8
[    1.779050] meson-gx-mmc ffe05000.sd: Anand mmc proble start9
[    1.784748] meson-gx-mmc ffe05000.sd: Anand mmc proble start10
[    1.790523] meson-gx-mmc ffe05000.sd: Anand mmc proble start11
[    1.796578] meson-gx-mmc ffe05000.sd: Anand mmc proble start12
[    1.802150] meson-gx-mmc ffe05000.sd: Anand mmc proble start13
[    1.807980] meson-gx-mmc ffe05000.sd: Anand mmc proble start14
[    1.813642] meson-gx-mmc ffe05000.sd: Anand mmc proble start15
[    1.819416] meson-gx-mmc ffe05000.sd: Anand mmc proble start17
[    1.825491] meson-gx-mmc ffe05000.sd: Anand mmc proble start18
[    1.830984] meson-gx-mmc ffe05000.sd: Anand mmc proble start19
[    1.862000] meson-gx-mmc ffe05000.sd: Anand mmc Final proble good to go
[    1.863323] pwm-regulator regulator-vddcpu-a: Anand :
dutycycle_unit 100: dutycycle_range 100:0
[    1.871617] pwm-regulator regulator-vddcpu-a: Failed to get PWM: -517
[    1.878560] pwm-regulator regulator-vddcpu-b: Anand :
dutycycle_unit 100: dutycycle_range 100:0
[    1.886613] pwm-regulator regulator-vddcpu-b: Failed to get PWM: -517
[    1.894094] pwm-regulator regulator-vddcpu-a: Anand :
dutycycle_unit 100: dutycycle_range 100:0
[    1.901771] pwm-regulator regulator-vddcpu-a: Failed to get PWM: -517
[    1.909089] pwm-regulator regulator-vddcpu-b: Anand :
dutycycle_unit 100: dutycycle_range 100:0
[    1.916658] pwm-regulator regulator-vddcpu-b: Failed to get PWM: -517
[    1.924147] hctosys: unable to open rtc device (rtc0)

sd_emmc_b probe function return success but still not able to progress further.

Best Regards

-Anand
