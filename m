Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3997C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9FF2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAn0aY/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfCMHJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 03:09:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40779 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfCMHJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 03:09:00 -0400
Received: by mail-oi1-f195.google.com with SMTP id k11so576802oic.7;
        Wed, 13 Mar 2019 00:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gw80XlS3yCF4Doylgw+f8iCEzff/0Bfo53KY6fiaRjs=;
        b=AAn0aY/iXG2J+Cc2N/IaDUKxFTl68IusH+lAMGHSd9uWD0Cs+tvLy1RYMbmFjeTfh0
         sAKXMzKX8dKj3zyw6BfhlmIPj8PKgoMsnG5QJJ9jDjh3mC4hav+kTctvQlE+KvPC1+eR
         LuktGRdVwUcrr3FPsCoakKiDdjW9Te0epG3+VGYRoC3D23WBY5wYsUCReFS9gpr9ciXt
         wNkMfx6IA6x9jzVDfnB6yadKTNwmR7hoc+SJNRkK5w8M6Wc/40qM3vnc+wo9INR9lixD
         BW7oo3XGmn2p0FMaeFlaN28e1H90pZ/WSEwvd79JWreWQDArgIWYgSYkGS52rTONIb4R
         9Knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gw80XlS3yCF4Doylgw+f8iCEzff/0Bfo53KY6fiaRjs=;
        b=ckit5Out1An64xqfD+G/tR8AxUzZJhVfJmkBlb2NaSbGF7knwXOipSXKrPgnYjxznk
         erdR14gLJPNZEn7LyATl1EWCHrb0Oc876IUgFUmdtGGJuQg6YT5XdTiiEyw2l73m7eUe
         LhHx2GU0rHpJZdlqwAgnOqXx6lwOitk+f8LisYSq2dI9JsQ3Ln/s3lyHtMDqgd93Y1Qz
         Rkn0mvK7yqCtgv3qzkMnGz8xQXae5dHDpSZo4dcT4e0xNkX/Sl289/i1IobRWOzqP+MP
         W54hOCvf7EwticdOAXbceXX+UfnT44HMNnGDq9R/ycSLmEMcMLhAGvCs5IvVXRzeJMi8
         zw4A==
X-Gm-Message-State: APjAAAWMPY0/YvoRokelJnTBhMMmq1RHOTyzpf4mf8Gflmx1QeHJvY6/
        zKecEpWRNpvJxMSCSsc7DtiW/pakaxz0v7ILl8E=
X-Google-Smtp-Source: APXvYqymLlFWsAxzS8lDuYgZsP0nJxTZt5PP/goLdg+pc1rCTEP7elERXXg99wbXEnvN4EOazjoa84hWhiyTUfVNo8Q=
X-Received: by 2002:aca:b904:: with SMTP id j4mr880943oif.128.1552460939336;
 Wed, 13 Mar 2019 00:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190310174640.dksy7pfkptrbcdgj@smtp.gmail.com>
 <CA+U=DsoTGLtnbkKoffm8TW6p_OhTfe2ViE3fEshKX9wJMPUzww@mail.gmail.com> <20190312173107.5gclkelpdswfdqzo@smtp.gmail.com>
In-Reply-To: <20190312173107.5gclkelpdswfdqzo@smtp.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 13 Mar 2019 09:08:47 +0200
Message-ID: <CA+U=DsosXU09CvxLP_fzG12xrbof71=9TxdSsSSNW7pgd2cPkw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] staging: iio: ad5933: add ABI documentation
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com,
        "Ardelean, Alexandru" <alex.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 7:31 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> On 03/11, Alexandru Ardelean wrote:
> > On Sun, Mar 10, 2019 at 7:47 PM Marcelo Schmitt
> > <marcelo.schmitt1@gmail.com> wrote:
> > >
> > > Add an ABI documentation for the ad5933 driver.
> >
> > There's already an ABI documentation for this driver.
> > See:
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer-ad5933
> >
> > Apologies for not mentioning this sooner.
> >
> > Could you check for other references for ad5933 in the kernel (in staging) ?
> > I don't think I missed other stuff, but it's good to check.
> >
>
> Didn't see any other reference for ad5933 with find and grep inside iio,
> neither on general documentation. I'll replace mine ABI doc by yours and
> add your sign-off-by on my next patch set. OK?

You don't need to add me anywhere :)
I did not contribute anything to that ABI doc.
I just raised a note about it.

But, that doc should be taken care of; whether you update it, remove
it, or anything.
It's good to not forget it in staging.

>
> > >
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > ---
> > >  .../ABI/testing/sysfs-bus-iio-ad5933          | 39 +++++++++++++++++++
> > >  1 file changed, 39 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad5933
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ad5933 b/Documentation/ABI/testing/sysfs-bus-iio-ad5933
> > > new file mode 100644
> > > index 000000000000..8a60dd178b1f
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-ad5933
> > > @@ -0,0 +1,39 @@
> > > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_start
> > > +Date:          March 2019
> > > +KernelVersion: Kernel 4.19
> > > +Contact:       linux-iio@vger.kernel.org
> > > +Description:
> > > +               The start frequency. Set this to define the frequency point at
> > > +               which the device should start the next frequency sweep.
> > > +
> > > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_increment
> > > +Date:          March 2019
> > > +KernelVersion: Kernel 4.19
> > > +Contact:       linux-iio@vger.kernel.org
> > > +Description:
> > > +               The frequency sweep increment. Set this to define the amount by
> > > +               which the frequency is incremented after each scan point. After
> > > +               the measurement at a frequency point is completed, the next
> > > +               measurement will be made at a frequency point
> > > +               'frequency increment'Hz higher than the previous one unless a
> > > +               repeat frequency command is issued. This behavior will follow
> > > +               until the defined number of frequency points have been measured
> > > +               or frequency sweep is somewhat reset.
> > > +
> > > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_points
> > > +Date:          March 2019
> > > +KernelVersion: Kernel 4.19
> > > +Contact:       linux-iio@vger.kernel.org
> > > +Description:
> > > +               The number of increments. This defines the number of frequency
> > > +               points in the frequency sweep.
> > > +
> > > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_settling_cycles
> > > +Date:          March 2019
> > > +KernelVersion: Kernel 4.19
> > > +Contact:       linux-iio@vger.kernel.org
> > > +Description:
> > > +               Number of settling time cycles. This sets the delay between a
> > > +               start frequency sweep/increment frequency /repeat frequency to
> > > +               be proportional to the excitation signal frequency times the
> > > +               number of settling time cycles.
> > > --
> > > 2.20.1
> > >
