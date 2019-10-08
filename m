Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE98C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAE421924
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="A48ymLIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfJHRlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:41:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34209 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfJHRlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:41:02 -0400
Received: by mail-ot1-f68.google.com with SMTP id m19so14803870otp.1;
        Tue, 08 Oct 2019 10:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xOC0mpKmGEmRikgCRd9gsgQ9erZ8EhH2ac4zF2SOvfc=;
        b=A48ymLIK2rb7BiQ9QuBri46T6nbKFuIQJxa7IZOrx9u7UZZjm57jzAFIIYzYvWLrix
         m+nDdkRVAO2+gOSlB5xS91WBrGwrPIYdmbS1o615tpr57WuZBLJC3B6ckf/LOptWZ1Ub
         gJYtq5XNt82fMCqHor/KL47/Zfi03r9Lcu7ah4JpxQzHWRQAXsmiufKaM507CHWwWDzX
         wuksd3+2wJ5/sXreoS2epnF9sTqEmrgFgSyR/Z9C3JNv6wJ+IrfIXn6AFIFTduTFLAjS
         itBaUhBVZ9Qzu3Pkd74h4T4/qeYmEeqsrAAtBlj6UkpmRgDydVnCnFwNreL37zzt2K7l
         PqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOC0mpKmGEmRikgCRd9gsgQ9erZ8EhH2ac4zF2SOvfc=;
        b=ApdQQTY6UuTzBffvbbCYPAzhp7mg3GgmfKqVHnUegkmK6S7CkG7ybYkcY7KOcQlxDd
         Lhdj9c7BFwryidgcQvOyPWvtyEEaHYV8AKDCdWNSo7NMt4P2DZp9uR7rVOeI2o93xqsv
         psaHiYOKmHh2bWuKX06wI2+RIOh1J1HIv/pgJTNV8nxYhGW2j3nI34GRnk0gz6OEZClZ
         wOwz1HwBnjXXtEsjOYh/ktkM3hp8k3Y4LlF8sbfNSKT+45ILHYI/q9tsYBG0NwB00SR/
         vb7KhTVXKqIS8nYUWgbQ1YZixsocJBWb81yuqTgLGkqy9gSiU6d7r/Yi35WxGiOSh4lC
         YUNw==
X-Gm-Message-State: APjAAAV0tGLqLncGPz65pSEjCwhZ4tnkH1sgoM+eznqsrPt0U449J0oN
        pQYJNNJnP3ERw0A3QTcviKQ27DgfBgeykwFf+X4=
X-Google-Smtp-Source: APXvYqxqhXwAynybsN9Gz27KPhjj5btFKvK2S66P8tFQ842KPj4fHqw45egk61mlamGvOAvK6sbk0VhqSQzJff+YD4E=
X-Received: by 2002:a05:6830:150d:: with SMTP id k13mr25847326otp.98.1570556460961;
 Tue, 08 Oct 2019 10:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191007131649.1768-1-linux.amoon@gmail.com> <20191007131649.1768-6-linux.amoon@gmail.com>
 <CAFBinCAoJLZj9Kh+SfF4Q+0OCzac2+huon_BU=Q3yE7Fu38U3w@mail.gmail.com>
 <7hsgo4cgeg.fsf@baylibre.com> <CANAwSgRfcFa6uBNtpqz6y=9Uwsa4gcp_4tDD+Chhg4SynJCq0Q@mail.gmail.com>
In-Reply-To: <CANAwSgRfcFa6uBNtpqz6y=9Uwsa4gcp_4tDD+Chhg4SynJCq0Q@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 8 Oct 2019 19:40:50 +0200
Message-ID: <CAFBinCA6ZoeR4m4bhj08HF1DqxY1qB5mygpaQCGbo3d8M+Wr9Q@mail.gmail.com>
Subject: Re: [RFCv1 5/5] arm64/ARM: configs: Change CONFIG_PWM_MESON from m to y
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
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

Hi Anand,

On Tue, Oct 8, 2019 at 4:39 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Kevin / Martin,
>
> On Tue, 8 Oct 2019 at 04:28, Kevin Hilman <khilman@baylibre.com> wrote:
> >
> > Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
> >
> > > On Mon, Oct 7, 2019 at 3:17 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > > [...]
> > >> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > >> index c9a867ac32d4..72f6a7dca0d6 100644
> > >> --- a/arch/arm64/configs/defconfig
> > >> +++ b/arch/arm64/configs/defconfig
> > >> @@ -774,7 +774,7 @@ CONFIG_MPL3115=m
> > >>  CONFIG_PWM=y
> > >>  CONFIG_PWM_BCM2835=m
> > >>  CONFIG_PWM_CROS_EC=m
> > >> -CONFIG_PWM_MESON=m
> > >> +CONFIG_PWM_MESON=y
> > >
> > > some time ago I submitted a similar patch for the 32-bit SoCs
> > > it turned that that pwm-meson can be built as module because the
> > > kernel will run without CPU DVFS as long as the clock and regulator
> > > drivers are returning -EPROBE_DEFER (-517)
> >
> > On 64-bit SoCs, the kernel boots with PWM as a module also, but DVFS
> > only works sometimes, and making it built-in fixes the problem.
> > Actually, it doesn't fix, it just hides the problem, which is likely a
> > race or timeout happening during deferred probing.
> >
> > > did you check whether there's some other problem like some unused
> > > clock which is being disabled at that moment?
> > > I've been hunting weird problems in the past where it turned out that
> > > changing kernel config bits changed the boot timing - that masked the
> > > original problem
> >
> > Right, I would definitely prefer to not make this built-in without a lot
> > more information to *why* this is needed.  In figuring that out, we'll
> > probably find the race/timeout that's the root cause.
> >
> > Kevin
> >
> >
>
> Kevin,
>
> As per my understanding from the kernelci.org logs it seen that
> pwm-meson driver is requested more than once before it finally load the module.
>
> [0] https://storage.kernelci.org/next/master/next-20191008/arm64/defconfig/gcc-8/lab-baylibre/boot-meson-g12b-odroid-n2.txt
my understanding is that:
- the PWM regulator driver is built in (=y)
- the Meson PWM controller driver is built as module (=m)
- during boot the PWM regulator node is found and it has a matching
driver (built-in)
- the PWM regulator driver tries to find the PWM controller but cannot
find it yet (and reports "Failed to get PWM: -517")
- (this repeats a few times)
- then the filesystem / initramfs is loaded where the modules are located
- now the Meson PWM controller driver is loaded
- the PWM regulator driver tries to find the PWM controller -> now it found it

> Hi Martin,
>
> I have tired your Martin's patch [1] and still the boot fails to move
> ahead with below logs.
> [1] https://lore.kernel.org/patchwork/patch/1034186/
this patch only silences the "Failed to get PWM: -517" message
Mark didn't apply it back then because without that message it would
be harder to debug these issues

> [    1.543928] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
> [    1.550422] usb usb2: We don't know the algorithms for LPM for this
> host, disabling LPM.
> [    1.558702] hub 2-0:1.0: USB hub found
> [    1.562131] hub 2-0:1.0: 1 port detected
> [    1.566206] dwc3-meson-g12a ffe09000.usb: switching to Device Mode
> [    1.573252] meson-gx-mmc ffe05000.sd: Got CD GPIO
> [    1.607405] hctosys: unable to open rtc device (rtc0)
>
> I have put some more prints in pwm-meson.c it fails to load the module
> as microsSD card is not completely initialized.
what makes you think that there's a problem with pwm-meson?

can you please share a boot log with the command line parameter
"initcall_debug" [0]?
from Documentation/admin-guide/kernel-parameters.txt:
 initcall_debug [KNL] Trace initcalls as they are executed.  Useful
 for working out where the kernel is dying during
 startup.

you can also try the command line parameter "clk_ignore_unused" (it's
just a gut feeling: maybe a "critical" clock is being disabled because
it's not wired up correctly).

back when I was working out the CPU clock tree for the 32-bit SoCs I
had a bad parent clock in one of the muxes which resulted in sporadic
lockups if CPU DVFS was enabled.
you can try to disable CPU DVFS by dropping the OPP table and it's
references from the .dtsi


Martin


[0] https://elinux.org/Initcall_Debug
