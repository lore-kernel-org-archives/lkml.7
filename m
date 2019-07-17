Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D78C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CDD2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jm2NGPcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfGQJXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:23:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33745 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfGQJXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 05:23:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so24556460edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 02:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GjXFQQeHJ+fl2jQ+pppRGYrRRfSPb6dldy9chydzl8s=;
        b=Jm2NGPcY1MgQ8E6LT0Yms4VtrWynODXiXXFZl9RKGUlcK77XK1D8emXNmS7gDR7DSZ
         5oAFdfi4or0iw0PvqKJnJcFLh19MtP3tCo8hv4f15eFUynr028/tEqBRT4cK4p7qN416
         xYsBcAxP29bmFLYYc++YeT2IC965Y6q3c3CNOBDHIHEHk58mL+mIFNa7xyE+J8HVB4dR
         ArqdHIe95EEyUO2GiIWgFninEPRYGjFywEZGXGE5suxIBTpYBQQhTd2+o5heZUaEd7P4
         eHRid+lpoOlKmVHn4bEVNbVRlBM1TYtdGRsaHqnjY84s1snd08LfWAXpnoki1Ew64805
         s1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GjXFQQeHJ+fl2jQ+pppRGYrRRfSPb6dldy9chydzl8s=;
        b=guxNXVk4IiwyLUpivDOrhL/MUxsWGxSor0BGRrqWOvx17Ok3U+ybFw3l3IIH7EqH1O
         5eBwzLkN8YAiWsoOrEQwyrYkJ4drBRjXrkWlsqWAvnEAodNE3zK/OqOyt6n2aOQJfYLf
         4+jqBh25JIomyZRA5APhZ/IR6jQMudSP4+sziYxye+bksG+xX5cT/DQdTsLg2g4dK03r
         in+AlmAnATE9GY77CoKlwnNAuCEJZm0YQRFJpXK0bAB8Wfuk9YR2npwuaQpYRH2JTApm
         KfP/eZms8Mice6Pf7NyFo2NN9D/jIZ8BrkhWeQVeK56jcd5qM7bwGsYOJJhD1q3z3KBF
         ZqIA==
X-Gm-Message-State: APjAAAWEdB5wjta/XK1SY8aWFt7vSy0LDVwFAnZ6Bs/oXfB+vyJEEU3Q
        x2dDsl0Y38bU7Ilz/0OFD05rB3+SlenQiLFO0fekPw==
X-Google-Smtp-Source: APXvYqxPihozv+RQ6usOA6Dd2Ft4DEFbhMpmKG9moDXs/PmkqCmmUtwcWQeBtQWFjiqFep92RJ92opmkftOqX46zrEU=
X-Received: by 2002:a17:906:e0cd:: with SMTP id gl13mr29714304ejb.52.1563355400215;
 Wed, 17 Jul 2019 02:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a55d7d058d51ad4f@google.com> <CACRpkdYbuJ_yJ+UKtvWrkmBCbQzfk-1mn1-A836dkNMrmTtZow@mail.gmail.com>
 <20190717091621.GC16694@localhost>
In-Reply-To: <20190717091621.GC16694@localhost>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 17 Jul 2019 11:23:07 +0200
Message-ID: <CACT4Y+b_KhNhYb0TdnR65MLvqnq0r25LsP-m8Bw0id9z1+Kb5g@mail.gmail.com>
Subject: Re: WARNING in gpio_to_desc
To:     Johan Hovold <johan@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        syzbot <syzbot+cf35b76f35e068a1107f@syzkaller.appspotmail.com>,
        Vincent Cuissard <cuissard@marvell.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Samuel Ortiz <sameo@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 11:16 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Tue, Jul 16, 2019 at 11:52:19PM +0200, Linus Walleij wrote:
> > On Wed, Jul 10, 2019 at 1:07 PM syzbot
> > <syzbot+cf35b76f35e068a1107f@syzkaller.appspotmail.com> wrote:
> >
> > > HEAD commit:    7829a896 usb-fuzzer: main usb gadget fuzzer driver
> > (...)
> > >   __gpio_set_value include/asm-generic/gpio.h:104 [inline]
> > >   gpio_set_value include/linux/gpio.h:71 [inline]
> > >   nfcmrvl_chip_halt+0x4e/0x70 drivers/nfc/nfcmrvl/main.c:259
> > >   nfcmrvl_nci_register_dev+0x2d4/0x378 drivers/nfc/nfcmrvl/main.c:176
> > >   nfcmrvl_probe+0x4e9/0x5e0 drivers/nfc/nfcmrvl/usb.c:344
> >
> > This bug is somewhere in the drivers/nfc/nfcmrvl* code handling
> > GPIOs.
>
> Right, and it's my bug.
>
> > It should be converted to GPIO descriptors and fixed up, see
> > drivers/gpio/TODO for details on how to do this.
>
> Conversion will have to wait, let's fix the regression first. :)
>
> > Johan/Vincent, tell me if you want me to forward the full fuzzing
> > robot crash dump.
>
> No need, thanks. I got it the report.
>
> Something like the below compiles and should fix it. Vacation starts
> today so I'll revisit and send a proper patch in a couple of weeks.
>
> Perhaps someone can feed it to the bot meanwhile (no time to play with
> it right now).
>
> Note that this issue has been there since 4.12, so guess no one uses
> these devices...
>
> Johan
>
>
> From e9d9d0ef5ffd6b306cffb2f4e2514f503aa626a5 Mon Sep 17 00:00:00 2001
> From: Johan Hovold <johan@kernel.org>
> Date: Wed, 17 Jul 2019 11:07:13 +0200
> Subject: [PATCH] NFC: nfcmrvl: fix gpio-handling regression
>
> FIXME
>
> Fixes: e33a3f84f88f ("NFC: nfcmrvl: allow gpio 0 for reset signalling")
> Not-Signed-off-by: Johan Hovold <johan@kernel.org>

Please don't forget:

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+cf35b76f35e068a1107f@syzkaller.appspotmail.com

> ---
>  drivers/nfc/nfcmrvl/main.c | 4 ++--
>  drivers/nfc/nfcmrvl/usb.c  | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
> index e65d027b91fa..529be35ac178 100644
> --- a/drivers/nfc/nfcmrvl/main.c
> +++ b/drivers/nfc/nfcmrvl/main.c
> @@ -244,7 +244,7 @@ void nfcmrvl_chip_reset(struct nfcmrvl_private *priv)
>         /* Reset possible fault of previous session */
>         clear_bit(NFCMRVL_PHY_ERROR, &priv->flags);
>
> -       if (priv->config.reset_n_io) {
> +       if (gpio_is_valid(priv->config.reset_n_io)) {
>                 nfc_info(priv->dev, "reset the chip\n");
>                 gpio_set_value(priv->config.reset_n_io, 0);
>                 usleep_range(5000, 10000);
> @@ -255,7 +255,7 @@ void nfcmrvl_chip_reset(struct nfcmrvl_private *priv)
>
>  void nfcmrvl_chip_halt(struct nfcmrvl_private *priv)
>  {
> -       if (priv->config.reset_n_io)
> +       if (gpio_is_valid(priv->config.reset_n_io))
>                 gpio_set_value(priv->config.reset_n_io, 0);
>  }
>
> diff --git a/drivers/nfc/nfcmrvl/usb.c b/drivers/nfc/nfcmrvl/usb.c
> index 945cc903d8f1..888e298f610b 100644
> --- a/drivers/nfc/nfcmrvl/usb.c
> +++ b/drivers/nfc/nfcmrvl/usb.c
> @@ -305,6 +305,7 @@ static int nfcmrvl_probe(struct usb_interface *intf,
>
>         /* No configuration for USB */
>         memset(&config, 0, sizeof(config));
> +       config.reset_n_io = -EINVAL;
>
>         nfc_info(&udev->dev, "intf %p id %p\n", intf, id);
>
> --
> 2.22.0
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20190717091621.GC16694%40localhost.
> For more options, visit https://groups.google.com/d/optout.
