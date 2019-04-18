Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DECC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161B3217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knVBa7D2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388980AbfDRMVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:21:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34097 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388375AbfDRMVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:21:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so1057339pfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1SYKp7+MfElXRd1sO4ET6eRMz9V6tyIBHsQE06h7vZE=;
        b=knVBa7D2GK6+IVYWe87tEasDbQE6ueo+Kwxp0FCbYULPfZmphTeVj/chyphkT0VxKD
         Hf4ixPul1+kOVFyzemdEb5ex6hClEXQipSJrwlsE7P7iYWLgWEhqSNISgHPPf5OsoERZ
         cdz3E4LE4XWbT08mDB19MgOyj2GycnfY77jXxo9lkG2DQEwsy+Dg41wDOeJcfbz0FdfL
         L3vktzL8p8N/KSczzuXNRJpXtBwO0m+g/3VH26MXm4emsmkmFRuXypJG0/DZiaqiPm7o
         URIMV3cWx8JlEmzHj7BBhzd1S8Edyu76rIsnm+8muYd0iR4925nj2Y+FIvo1pSB1WeE8
         Ds6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1SYKp7+MfElXRd1sO4ET6eRMz9V6tyIBHsQE06h7vZE=;
        b=pmgDwPqtjWCoyIGg05/v78Tbr8IE8+mxXsB0MjsINdvVniQrcrf2oeTJpRFkFQi1il
         y0S2yJrBLcJjttMaYrKYqeKP0GoxQQ+73v3qNPTwLv71mASlIXAGDehSSPZVF6ZuyOnz
         UoBkJa4d9ADtTELLIX0n8cHk0XpW0oURGaYdlj4bdbw8AvDE4YSUVvUgdrJLoB8Kc67B
         RDYD3WanDE3l1CdcZj5RF1s2DXPLnR2Jc+g20Pyxw0PulzxnkjhK5otx2cmt2e4KWytJ
         Os73Pdu05mP4yjuS1WJGn4onaShqvXu/0xSyyaj8v8xT714hFHVfS6OSuBbEgrYXJmsn
         rp3Q==
X-Gm-Message-State: APjAAAWlhGOh04u0jKi3iL8IZBwuCxVQyWAkv3TzWlRTveLQd3NjZNXf
        EMKCiG0lCT22EW4Yn2sxnSIWu+YMY0rS979Cx5q+2Q==
X-Google-Smtp-Source: APXvYqxMY7xayTEGCSlvqcfHS8kYinoea8A+SA/x7b8pMqB9rGwTn+iiMXKIAER/Be9oMWthsDKZMOZDYffJkRJ2Wzs=
X-Received: by 2002:a63:5b4b:: with SMTP id l11mr58047437pgm.95.1555590114070;
 Thu, 18 Apr 2019 05:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000edf1630586acca2b@google.com> <Pine.LNX.4.44L0.1904171503410.1400-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904171503410.1400-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 18 Apr 2019 14:21:42 +0200
Message-ID: <CAAeHK+yPfrbM4id7dft3aDfvNh46LVsFGB9JAaDN-AxV45H_8A@mail.gmail.com>
Subject: Re: INFO: task hung in usb_kill_urb
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+d919b0f29d7b5a4994b9@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 9:09 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, 16 Apr 2019, syzbot wrote:
>
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer still triggered
> > crash:
> > INFO: task hung in usb_kill_urb
>
> That's surprising.  This patch was awfully similar to the previous one,
> which did prevent the crash earlier.
>
> > Tested on:
> >
> > commit:         9a33b369 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan/tree/usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10b5e057200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=131dca6b200000
>
> Andrey, is there any way to increase the console output buffer size?

Hm, I'm not sure why it got truncated here, the previous one was full.
I would try running the syz test command again in this case.

> The link above doesn't go all the way back to the beginning of the test
> (it starts at timestamp 486.614697).
>
> Also, here's a slightly revised patch for testing.
>
> Alan Stern
>
>
> #syz test: https://github.com/google/kasan.git usb-fuzzer
>
> --- a/drivers/usb/gadget/udc/dummy_hcd.c
> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -979,8 +979,18 @@ static int dummy_udc_start(struct usb_ga
>         struct dummy_hcd        *dum_hcd = gadget_to_dummy_hcd(g);
>         struct dummy            *dum = dum_hcd->dum;
>
> -       if (driver->max_speed == USB_SPEED_UNKNOWN)
> +       switch (g->speed) {
> +       /* All the speeds we support */
> +       case USB_SPEED_LOW:
> +       case USB_SPEED_FULL:
> +       case USB_SPEED_HIGH:
> +       case USB_SPEED_SUPER:
> +               break;
> +       default:
> +               dev_err(dummy_dev(dum_hcd), "Unsupported driver max speed %d\n",
> +                               driver->max_speed);
>                 return -EINVAL;
> +       }
>
>         /*
>          * SLAVE side init ... the layer above hardware, which
> @@ -1784,9 +1794,10 @@ static void dummy_timer(struct timer_lis
>                 /* Bus speed is 500000 bytes/ms, so use a little less */
>                 total = 490000;
>                 break;
> -       default:
> +       default:        /* Can't happen */
>                 dev_err(dummy_dev(dum_hcd), "bogus device speed\n");
> -               return;
> +               total = 0;
> +               break;
>         }
>
>         /* FIXME if HZ != 1000 this will probably misbehave ... */
> @@ -1828,7 +1839,7 @@ restart:
>
>                 /* Used up this frame's bandwidth? */
>                 if (total <= 0)
> -                       break;
> +                       continue;
>
>                 /* find the gadget's ep for this request (if configured) */
>                 address = usb_pipeendpoint (urb->pipe);
>
