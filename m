Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D117C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5728A218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU/Zy4ab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfCVUef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:34:35 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35297 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfCVUef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:34:35 -0400
Received: by mail-oi1-f193.google.com with SMTP id j132so2740048oib.2;
        Fri, 22 Mar 2019 13:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t8sVUOZAowMS+LmGR6+4De+ESHUjd1tom0uV5p4H3y4=;
        b=UU/Zy4abmxJHUvYJEEOdwhnXE9Q5lp7Av7pP59UoQazmjAmbymm6WZlOJi7GN1JAoh
         8KYNLFJCuOABs4q/cC5O1fYy5uGg/rou9/wDROIzd1G9SouJnVAP/EuPEKkehAl1L1Op
         ipkDOxKCLzsdLnOKzJdIva16W/1O02b02a/K9R6D4HkhBnAcxPC18FCQjkc50Y2WdNO3
         3hYEoZGGkoPTz4MKhVTbwMpf2K8mI8xH+lxrk7NRPU0KbLrjoU2ZJ3RUbs/2gF6je/pq
         IpiB1eiORgzTBPe1a5zL1kTb2wKtPk+5yf7hbxuv9fEciF1ylbjvMxMZXQQKSrjUySKs
         uR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8sVUOZAowMS+LmGR6+4De+ESHUjd1tom0uV5p4H3y4=;
        b=kXvt1ZsS+D39+OgyaBrsxAziTDZhHwvvKWGOlrQ+OCl5/FV5tB59uW6+RjeQzVh0J0
         aagWm0gEjcRXbisW0RD5kajCAkIjFrSrjp0kxp/O8/3FRsZ9ygEi1x4OwUAyUKAML6Qg
         MZWZlpbKRNJDHGoOxw0nuYuBQ5RUh4FIcrs5mCs7pC8oiOn/z7/BvBQgKEyotooH9+uG
         fM9TSo6kbcCFNJnTMnYBgWG7UDb/t0azsKR+rHL0SPwAYnpZu/Ua+n3dwmz7J6nT0SBg
         wYhtUjdIeDnqZXwVi3fIm1tNpXaw0pXm6EYppYDr4JDI1QiFAHRFoKwn4Kvbx2c1Ob2k
         A82w==
X-Gm-Message-State: APjAAAXVsDDF/bS7eSnXJNNegGmOTTD3jzzvAbJ0fPdM4FZyxjC2px+/
        kGYy64uDudEn12yv8PfQa5RjOFs7+/n6uCZWb7c=
X-Google-Smtp-Source: APXvYqxCqEP1V0TtDvy91JNeIMhYJo4Rm6qx03OAULJVnyTYI3yzqw6UVbIRQNWlYgIyxDao3YX5KByeto5egkXmA7k=
X-Received: by 2002:aca:cd54:: with SMTP id d81mr3143641oig.124.1553286873900;
 Fri, 22 Mar 2019 13:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190321193913.q46gq3h7h63ltpgp@smtp.gmail.com>
In-Reply-To: <20190321193913.q46gq3h7h63ltpgp@smtp.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 22 Mar 2019 22:34:21 +0200
Message-ID: <CA+U=DsoWsWSfyrSneZfoWzXeYjO0u+G0PPtsPQi9ov11w+pcRQ@mail.gmail.com>
Subject: Re: Help on testing ad5933 driver
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     "Hennerich, Michael" <michael.hennerich@analog.com>,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        dragos.bogdan@analog.com, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 9:39 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Hello, would anyone mind helping me test ad5933 driver on actual
> hardware?  I went through this
> (https://oslongjourney.github.io/linux-kernel/experiment-one-iio-dummy/)
> tutorial so I was able to load iio_simple_dummy driver, create and
> inspect some dummy devices.  Now, as Jonathan has asked me, I would like
> to test ad5933 driver on an EVAL-AD5933 board which was donated to FLUSP
> (https://flusp.ime.usp.br/).
>
> So far I've been hesitating to plug this device on my Debian distro
> since this
> (https://www.analog.com/media/en/technical-documentation/user-guides/UG-364.pdf)
> user guide for Windows says not to connect it before driver
> installation. Is there something that could harm the board if plugged
> on a computer without a proper driver?
>

You should take into account that a lot of eval boards have their eval
SW written for Windows.
This is something of a legacy-thing, because most corporations have
been running their computers (for work & dev & offices) on Windows.

So, you shouldn't take things ad-literam (to the letter) when reading
stuff for Windows and when writing code for Linux.

> I also didn't understand the hardware configuration showed on this
> (https://wiki.analog.com/resources/tools-software/linux-drivers/iio-impedance-analyzer/ad5933)
> page.

Hmm, that doc was written a while ago.
The newer eval board doesn't look like the one in the wiki.

Also, since the eval SW was targeted for Windows, getting it to work
for Linux (and IIO) implies some hacking/reverse-engineering.
The reason for this (reverse-engineering) is because [traditionally]
eval boards are meant to highlight characteristics of the chip, so if
using Windows, this should be simple.

Unfortunately, the docs aren't helping in this case. So, in this case,
I would get some volt-meter & oscilloscope to help.
It looks to me that U2 is the AD5933 on the eval-board.
Worst case, you can solder directly to the pins and link them to a
Raspberry PI [on the I2C], power, ground, etc.
But, you can take a look at the T1 to T8 (if I didn't miss anything)
and connect to them, and see what each of them is for.
Hopefully, one of those test-points is for I2C, in which case you can
attach wires to them and connect them to a host.
I did not find a good doc for them yet.

But anyway, I would ask some HW guy to help here (because I'm a SW guy
mostly),and get help on figuring out the eval board

>
> Any advice will be greatly appreciated.
> Thanks in advance,
>
> Marcelo
