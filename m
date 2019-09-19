Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D4DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E5521D56
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390310AbfISM1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:27:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34414 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389301AbfISM1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:27:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so1499966qta.1;
        Thu, 19 Sep 2019 05:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/0D0353E6Hm2+XCaezdnymc67+5gasscV/rWpZrvTE=;
        b=J3nCY0f/CSORhcPHmrjMjLzPI1Fab0HEkxQbIhMuRAkzR4etRlHMogPOoSqcxtf6AV
         PyAO1EwtzK7PZiIWl2Ph5acSZRmHNmqnT+6HKjuC1YBJHCTCjSJaJdY/b7PFRrOmok2x
         IfhDy6r3Mfbp7DWlb29MusWkjZ6kIycnJpNyC0dg0h+UjQduiWAIlonDjNlZ4DX18IWU
         gGgI//gLS655sMQL2IKWdQuC5B0Yw93a4ZgIhtQ75l6IZQFtFh+BwaJs0dlrH/HZ1S8/
         hTjres0LyD0bXeCJfAyeVUbk53sHCrv56I+V4kUWEeQ9RrYPYwlvctKVmrwdKNhrFy9L
         sn6w==
X-Gm-Message-State: APjAAAUNrXh8uXIP754ZVGcHUQKiL64TWixUG10ne421W99nDJMBgsYG
        07wjPtkjoGsQEF1KzzTtAcEcaCkpp2ESt8GI5LM=
X-Google-Smtp-Source: APXvYqzqqT5dWecKSTpOOwa97E/2UBZygBcus1k9y3ou0vKU3/Pcoh+6/LRK3ZfE8Oygvm6S5ikViHBTVMNSsSgmJjg=
X-Received: by 2002:aed:2842:: with SMTP id r60mr2807482qtd.142.1568896031667;
 Thu, 19 Sep 2019 05:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190918195918.2190556-1-arnd@arndb.de> <C6D98BD8-F57F-411F-A2F2-D9E531137002@holtmann.org>
In-Reply-To: <C6D98BD8-F57F-411F-A2F2-D9E531137002@holtmann.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Sep 2019 14:26:55 +0200
Message-ID: <CAK8P3a0AeGi2pd78A3yzh0NNGdgGvo_y1LCginyTCY3OUeVHkg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: avoid unused function warning
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Alex Lu <alex_lu@realsil.com.cn>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 9:32 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> > The btusb_rtl_cmd_timeout() function is used inside of an
> > ifdef, leading to a warning when this part is hidden
> > from the compiler:
> >
> > drivers/bluetooth/btusb.c:530:13: error: unused function 'btusb_rtl_cmd_timeout' [-Werror,-Wunused-function]
> >
> > Use an IS_ENABLED() check instead so the compiler can see
> > the code and then discard it silently.
> >
> > Fixes: d7ef0d1e3968 ("Bluetooth: btusb: Use cmd_timeout to reset Realtek device")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > drivers/bluetooth/btusb.c | 5 ++---
> > 1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index a9c35ebb30f8..23e606aaaea4 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -3807,8 +3807,8 @@ static int btusb_probe(struct usb_interface *intf,
> >               btusb_check_needs_reset_resume(intf);
> >       }
> >
> > -#ifdef CONFIG_BT_HCIBTUSB_RTL
> > -     if (id->driver_info & BTUSB_REALTEK) {
> > +     if (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) &&
> > +         (id->driver_info & BTUSB_REALTEK)) {
> >               hdev->setup = btrtl_setup_realtek;
> >               hdev->shutdown = btrtl_shutdown_realtek;
> >               hdev->cmd_timeout = btusb_rtl_cmd_timeout;
> > @@ -3819,7 +3819,6 @@ static int btusb_probe(struct usb_interface *intf,
> >                */
> >               set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
> >       }
> > -#endif
>
> I prefer that we stick another ifdef around the btusb_rtl_cmd_timeout function since that
> is how we did it for the other vendors as well.

Ok. Can you just commit that with 'Reported-by: Arnd Bergmann <arnd@arndb.de>'?

> However I start to wonder if we need all these vendor ifdef anyway. The vendor specific
> functions should turn into empty stubs if their support is not selected.

It just wastes a little bit of object code space, which my approach
above avoids.

I guess one could also be clever and redefine those macros like

#define BTUSB_REALTEK (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) ? 0x20000 : 0)

so the if() section gets silently dropped, in addition to treating
zero like BTUSB_IGNORE.

      Arnd
