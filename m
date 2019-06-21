Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F6FC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBA82070B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfFUO6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:58:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45564 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUO6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:58:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so4592570qkj.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 07:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EqZRMkqOniBCixSFRp+cfD2VJpKMsQVukvd6kSrRzw=;
        b=DOK/HC33lQT9mciAMONGcw4s4y9S2qLZ5Q9Ltzg2f8AxVe+75Ewvfzh3ZxRdiyFTR6
         WcpLUUvtwjGu+VB05vxyo+dr7rjFYWbHqHTBA9UcvKHKICQJPvz0+X5mzCuIdhl79WX0
         S+/CH2qte7+m9BvtwG/2y9hjOl81T2Mq+XU4o/Q6aBIn8Nw5x91LiriW3ITmpHarRdYW
         RerM58emM5KD24tbxACxDvjhgo66ySl4itAaY2ABDDAyEd8ITzbz8bh5gCSz40ugih0B
         o8fnHDAhvCi62RmNz+2tzfsuvQOH+gzP6hNcp2eG/zn4i9oiqm08qOPj6TXUc2FA1nh0
         Xj8w==
X-Gm-Message-State: APjAAAXDL9922hDDGCyE9h1TjFq0X/Hwt0Zx4OXIF91iqDyS1MUqregq
        8QIfKHrl7pzK1VZkUA/VFj49ZGxuzYGHltsqLpw=
X-Google-Smtp-Source: APXvYqza5KATpHhSv7Eb+RXyoEX0xVbBRFMGX2Tgbo95UaJbV22bmSlyqV/7lLtAUv7vs9Bb7yMi+0UDNWHsiJ4mO3A=
X-Received: by 2002:a37:dcc7:: with SMTP id v190mr111622560qki.286.1561129110957;
 Fri, 21 Jun 2019 07:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pyf1AmjWOFFdJFXV9-OBv-ChpKZ130733+x=BtjF62mA@mail.gmail.com>
 <20190620141159.15965-1-Jason@zx2c4.com> <20190620141159.15965-3-Jason@zx2c4.com>
 <CAK8P3a1Dfx0MayHFP46KL0RDta9cZYBy3pVRTaVTbEsbMOy5xg@mail.gmail.com> <CAHmME9qDAEzZKBDowLmdaxtc8fJqp-w_cvOWsvubh5Yr=Kgm-g@mail.gmail.com>
In-Reply-To: <CAHmME9qDAEzZKBDowLmdaxtc8fJqp-w_cvOWsvubh5Yr=Kgm-g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jun 2019 16:58:13 +0200
Message-ID: <CAK8P3a0MWFCvB_pMuYyZbhBQzuA6++i_Y14cJ9n0TozJpqpKPA@mail.gmail.com>
Subject: Re: [PATCH 3/3] timekeeping: add missing _ns functions for coarse accessors
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 4:46 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Fri, Jun 21, 2019 at 4:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > I would prefer the 'coarse' on the other side, i.e.
> > ktime_get_coarse_real_ns instead of ktime_get_real_coarse_ns,
> > as this is what we already have with ktime_get_coarse_real_ts64.
> >
> > I originally went with that order to avoid the function sounding
> > "real coarse", although I have to admit that it was before Thomas
> > fixed it in e3ff9c3678b4 ("timekeeping: Repair ktime_get_coarse*()
> > granularity"). ;-)
>
> I can do this, but that means also I'll change get_real_fast to
> get_fast_real, too, in order to be consistent. Is that okay?

I care less about these since ktime_get_real_fast_ns() already
exists. My preference would be leaving alons the _fast_ns()
functions for now, but making everything else consistent instead.

Thomas created the _fast_ns() accessors with a specific application
in mind, and I suppose we don't really want them to be used much
beyond that. I wonder if we should try to come up with a better
name instead of "fast" that makes the purpose clearer and does
not suggest that it's faster to read than the "coarse" version.

       Arnd
