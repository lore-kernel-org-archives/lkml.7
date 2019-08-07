Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DFBC31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52534214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxghsRAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfHGBUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:20:21 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40380 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfHGBUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:20:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so40538021oth.7;
        Tue, 06 Aug 2019 18:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2h6gOAY3YgD8MOX44OfV8vPJGYNX/elEpaQ/VKNmceM=;
        b=MxghsRAGFfqPvSB51oGFXysHGy1zHqGpjNmxCvowxoZlRlhQ2vSE1IkWtrsPqPS8M+
         XUPiHQfnxmOVTkV1/nR/XKLMuLSKbEhTRE2UqPu+cqn5lfwLc9ZDHiTN/AO50LC/WvCr
         RJw/2J6JcyDxfaZiRwS639smOUzWBt3TMb3ZUNylo9usZT2C+WhuI8TmjLJ0NmhiXZo3
         2LGPh5IWSouJLwln0v74RqY0Gl8rflYRz03Hg6TNmWb7uTfRGgQKmn/kYzXINvs9KZ9E
         nKlLU/HI/PDki9+BIDbFx+cc5CXlPPIw0mcugwFNnFMG5a8YihQinumS5dquZ9D4kdeF
         ZkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2h6gOAY3YgD8MOX44OfV8vPJGYNX/elEpaQ/VKNmceM=;
        b=JYactO/nBsbnuZG9C7KBGYzDTZrs4e3/fyLzc6B9mxg9v1xi+c2zGuCctxU+9tqflC
         WyByJmp+mcu9q0znUA0a251jr6JrK/3R6IhSDsafSCNPajrsJQSwq/vucRrqSCijpgWv
         JEPyTB+POHB9yjsXbDOs1DATnLFPxCbQu035D2ZLZSrlhdmFRp7+BnroS3Ziu8zATYxc
         0L1ueCAI/GgXwxlAOVmARFLY5TkFZHhD5MUWK7hb+mDiQBDl31s6f1CEwLpLX2bGUukZ
         1E4ow/ZxMByRn6u9Pa512CKgrLpgWwNE6BaqzdvNWA9o4OSO4UP+Lq7g6m60IzIuL03c
         Cv2A==
X-Gm-Message-State: APjAAAXJV+vNygfhjvGBoJobm1Y0pnkyFLabL5ycTx1RcM8oHMiSMiEJ
        mfR+MvKKFihBsdd0OA8XnSfDXTC10/yo088guSJFlgd1
X-Google-Smtp-Source: APXvYqwh+o7bRSbeyxSOOO5j1tZb7YSn3BqkHPQf1tUh9RemZjk6jVzQA+RhZtN1lTV2+QTQnY+7SVTzAGJWbTgh5BE=
X-Received: by 2002:a02:13c3:: with SMTP id 186mr7445332jaz.30.1565140818255;
 Tue, 06 Aug 2019 18:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190805193243.18584-1-andrew.smirnov@gmail.com> <CAHp75VcjUwUj-6r+k2bTFhhr9hk942-ZEu=GhvhKNjfgEYf1Qw@mail.gmail.com>
In-Reply-To: <CAHp75VcjUwUj-6r+k2bTFhhr9hk942-ZEu=GhvhKNjfgEYf1Qw@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 6 Aug 2019 18:20:06 -0700
Message-ID: <CAHQ1cqEHNq9jJfKWKrZ1utbsk8HG4gywuaxNNMFOgFZGULwyEw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: Introduce uart_tx_stoppped_or_empty()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Chris Healy <cphealy@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 11:48 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Aug 5, 2019 at 10:36 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> >
> > The vast majority of the serial drivers check for
> >
> >     uart_tx_stopped(&p->port) || uart_circ_empty(xmit)
> >
> > condition one or more times. Create a dedicated helper function and
> > convert drivers to use it.
>
> Sometimes the arguments are swapped. It means that in case of first
> being false the second is aslo going to be checked.
> So, does ordering have any side effect?
>
> Please, elaborate this in the commit message.
>

Neither  uart_tx_stopped() nor uart_circ_empty() should have any side
effects. I also didn't see any comments indicating that ordering is
important. Is that enough of a justification?

> >  drivers/tty/serial/8250/8250_dma.c          |  2 +-
> >  drivers/tty/serial/8250/8250_omap.c         |  7 +++----
> >  drivers/tty/serial/sc16is7xx.c              |  2 +-
>
> For the drivers I care about (see above) I prefer to see conversion on
> per driver basis. Of course, if Greg is okay with the current, I won't
> object.

I am more than happy to split this any way necessary.

>
> > -               if (uart_tx_stopped(&up->port) ||
> > -                   uart_circ_empty(&up->port.state->xmit)) {
> > +               if (uart_tx_stopped_or_empty(&up->port)) {
>
> Yes, it becomes one line, but...
>
> > -       if (!(dmacr & UART011_TXDMAE) || uart_tx_stopped(&uap->port) ||
> > -           uart_circ_empty(&uap->port.state->xmit)) {
> > +       if (!(dmacr & UART011_TXDMAE) ||
> > +           uart_tx_stopped_or_empty(&uap->port)) {
>
> ...wouldn't be the case here as well? And perhaps in other places?

Hmm, not sure I am reading this comment right. Are we talking purely
about formatting here? If we are, yeah, I probably can make this into
a single line. Not sure if there any other places like that,
sirfsoc_uart.c perhaps?

Thanks,
Andrey Smirnov
