Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B58C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5639E2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfFUOi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:38:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40152 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUOi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:38:27 -0400
Received: by mail-qk1-f193.google.com with SMTP id c70so4565703qkg.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 07:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CRb8rEVwj3xD/OX/ev6bOexfluPSohKc3yML8J8kJU=;
        b=iDPahZNETu1aDHNQRY1WCe3GBh3XamgQ5pyAMOgiEjxBwO21pptmmE6wY31LRfDk42
         xg8J2YGCY0pXn4Wjyj/SMQy3OfsjRsjXjaSsln9qEI0X8gvTjqd9raWIXuc7ml+JNQT/
         4/ZJFs37ls0mbxEz6rQSxlLAJBZ+1TpHX3hTuYF9rwix16XvtvdQ3UesGg2Vee4wLlSx
         lsVI2BHVxVCJ8hBX2Tlhe3tx2VneqFENRMzBubqaf7H86ony7e33oQM/yRMhWAVpKlZz
         WtW5Yly1T8Tt9/2tlTzvB6AgaPwH8bgvQHaeX2cw/mNJ8pWdTFk7oabQelYTes7nuxDu
         NwmQ==
X-Gm-Message-State: APjAAAV/q4BoNSJZzgqfjDy+Xflfb/XLi216Xy8LhooDb7TXyaU7cgrI
        BAAza2Fw6+XRbfOWk6JYR+PcXCvBylWtSQHMUo4+0tXWJLQ=
X-Google-Smtp-Source: APXvYqxUuXOzoDD8geWtMxjvlbgnxskUcBpHzZj9ZlA7C+/V5zeG3P5S7lpHjDshNe+JpjCg/OgUAsiCvLGdox9T1/A=
X-Received: by 2002:a37:76c5:: with SMTP id r188mr5851468qkc.394.1561127906623;
 Fri, 21 Jun 2019 07:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pyf1AmjWOFFdJFXV9-OBv-ChpKZ130733+x=BtjF62mA@mail.gmail.com>
 <20190620141159.15965-1-Jason@zx2c4.com> <20190620141159.15965-3-Jason@zx2c4.com>
In-Reply-To: <20190620141159.15965-3-Jason@zx2c4.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jun 2019 16:38:10 +0200
Message-ID: <CAK8P3a1Dfx0MayHFP46KL0RDta9cZYBy3pVRTaVTbEsbMOy5xg@mail.gmail.com>
Subject: Re: [PATCH 3/3] timekeeping: add missing _ns functions for coarse accessors
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 4:12 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
>
> diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
> index ad32085174f8..d5e88f0e06a4 100644
> --- a/Documentation/core-api/timekeeping.rst
> +++ b/Documentation/core-api/timekeeping.rst
> @@ -99,16 +99,20 @@ Coarse and fast access
>
>  Some additional variants exist for more specialized cases:
>
> -.. c:function:: ktime_t ktime_get_coarse_boottime( void )
> +.. c:function:: ktime_t ktime_get_coarse( void )
> +               ktime_t ktime_get_coarse_boottime( void )
>                 ktime_t ktime_get_coarse_real( void )
>                 ktime_t ktime_get_coarse_clocktai( void )
> -               ktime_t ktime_get_coarse_raw( void )
> +
> +.. c:function:: u64 ktime_get_coarse_ns( void )
> +               u64 ktime_get_boot_coarse_ns( void )
> +               u64 ktime_get_real_coarse_ns( void )
> +               u64 ktime_get_tai_coarse_ns( void )

I would prefer the 'coarse' on the other side, i.e.
ktime_get_coarse_real_ns instead of ktime_get_real_coarse_ns,
as this is what we already have with ktime_get_coarse_real_ts64.

I originally went with that order to avoid the function sounding
"real coarse", although I have to admit that it was before Thomas
fixed it in e3ff9c3678b4 ("timekeeping: Repair ktime_get_coarse*()
granularity"). ;-)

I would also prefer _boottime over _boot. Unfortunately we
are already inconsistent and have roughly the same number
of callers for ktime_get_boot_ns() and ktime_get_boottime().

      Arnd
