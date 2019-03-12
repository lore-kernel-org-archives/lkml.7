Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97262C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656F42087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5GqcRyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfCLRbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:31:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35580 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbfCLRbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:31:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id h39so3536268qte.2;
        Tue, 12 Mar 2019 10:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NG4FIXFmwNU4N0QfHMcblAnerq1FuvYmDrsaj7KdJrw=;
        b=B5GqcRyvtrMnl7zMeQbDH2jctUHlNUE4t+Fr0Sxmtt9XwaD742bA0zUj9vWjks3XDc
         UJLWBbMzSHfTRS2JG/JuiG0SwEn5Qa5ysCMbrdE5FDPaBzF6GpRuFlR+ttvJLQUrEsta
         W45n/9cl1vHf+S9heSRQfQ0Q5ednQ6NJsYDWZkgOLSnr8dUyeZgxpqsNh58aN3hyS8Rj
         NoUE2ttBJUF/iRCtNzwpXNT6huYCxt4NJvdjpnQPf/Ste9jzzz1+UCBtPjbNkE8ttWXs
         nl1Yp9IxJIMdQqq2KAVaCAwDN++vuXGem+k38eWIcx7T1P95hYcqC/URYgpRfv3S6Aqw
         N/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NG4FIXFmwNU4N0QfHMcblAnerq1FuvYmDrsaj7KdJrw=;
        b=cZoTxCYv6l7OGa/y4d68stFAYwBQhAQkm/dcLyytzBSpmuvYr5Mdnz4R5pMf+1nYMm
         zEdKZWL9qQQ2O7dbEMfVcGj+ykGNACZ0Mw9crbc4vFa/Q6X0rSPbqTn5g/8/ekzJjEXK
         pWdagpA6JX4t0oGYvZZUVys61uyR4YruyJGRt+O0Wz8SEQlolwVKfjsIxEzqi4Xk2tvC
         1MpAud1ImM803+JdcQjpH28TWL7LcjdLd+/cxW9U/Nz7b9VavOpmYlfbNNMjbDitZukm
         +ySNDN3vGEc+B+JSIqAYXQUNlQ71jokyYpYhO1eeFczrLZBnr2XIKfZV3vozchn1CiWw
         oUhw==
X-Gm-Message-State: APjAAAUm4JK0C3jWyHpsRxzMhmqnhmvi/9VAB+GpZMHEbOf+kW/EvHKm
        cXlw7RGEm9TDwdHBZcK4fQo=
X-Google-Smtp-Source: APXvYqzhmyX94TwFMBKhJANoWLX6G9FRXF3E5ith6GAAhjM9Up+d+B50WzfJaTbITZLPaCDd/pKcfg==
X-Received: by 2002:a05:6214:182:: with SMTP id q2mr8590399qvr.247.1552411874899;
        Tue, 12 Mar 2019 10:31:14 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e22sm3163047qte.42.2019.03.12.10.31.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 12 Mar 2019 10:31:14 -0700 (PDT)
Date:   Tue, 12 Mar 2019 14:31:07 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     lars@metafoo.de,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com,
        "Ardelean, Alexandru" <alex.ardelean@analog.com>
Subject: Re: [PATCH v3 5/7] staging: iio: ad5933: add ABI documentation
Message-ID: <20190312173107.5gclkelpdswfdqzo@smtp.gmail.com>
References: <20190310174640.dksy7pfkptrbcdgj@smtp.gmail.com>
 <CA+U=DsoTGLtnbkKoffm8TW6p_OhTfe2ViE3fEshKX9wJMPUzww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=DsoTGLtnbkKoffm8TW6p_OhTfe2ViE3fEshKX9wJMPUzww@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11, Alexandru Ardelean wrote:
> On Sun, Mar 10, 2019 at 7:47 PM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Add an ABI documentation for the ad5933 driver.
> 
> There's already an ABI documentation for this driver.
> See:
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer-ad5933
> 
> Apologies for not mentioning this sooner.
> 
> Could you check for other references for ad5933 in the kernel (in staging) ?
> I don't think I missed other stuff, but it's good to check.
>

Didn't see any other reference for ad5933 with find and grep inside iio,
neither on general documentation. I'll replace mine ABI doc by yours and
add your sign-off-by on my next patch set. OK?
 
> >
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > ---
> >  .../ABI/testing/sysfs-bus-iio-ad5933          | 39 +++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad5933
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ad5933 b/Documentation/ABI/testing/sysfs-bus-iio-ad5933
> > new file mode 100644
> > index 000000000000..8a60dd178b1f
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-ad5933
> > @@ -0,0 +1,39 @@
> > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_start
> > +Date:          March 2019
> > +KernelVersion: Kernel 4.19
> > +Contact:       linux-iio@vger.kernel.org
> > +Description:
> > +               The start frequency. Set this to define the frequency point at
> > +               which the device should start the next frequency sweep.
> > +
> > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_increment
> > +Date:          March 2019
> > +KernelVersion: Kernel 4.19
> > +Contact:       linux-iio@vger.kernel.org
> > +Description:
> > +               The frequency sweep increment. Set this to define the amount by
> > +               which the frequency is incremented after each scan point. After
> > +               the measurement at a frequency point is completed, the next
> > +               measurement will be made at a frequency point
> > +               'frequency increment'Hz higher than the previous one unless a
> > +               repeat frequency command is issued. This behavior will follow
> > +               until the defined number of frequency points have been measured
> > +               or frequency sweep is somewhat reset.
> > +
> > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_points
> > +Date:          March 2019
> > +KernelVersion: Kernel 4.19
> > +Contact:       linux-iio@vger.kernel.org
> > +Description:
> > +               The number of increments. This defines the number of frequency
> > +               points in the frequency sweep.
> > +
> > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_settling_cycles
> > +Date:          March 2019
> > +KernelVersion: Kernel 4.19
> > +Contact:       linux-iio@vger.kernel.org
> > +Description:
> > +               Number of settling time cycles. This sets the delay between a
> > +               start frequency sweep/increment frequency /repeat frequency to
> > +               be proportional to the excitation signal frequency times the
> > +               number of settling time cycles.
> > --
> > 2.20.1
> >
