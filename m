Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF47DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE9F22DA8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfFDHCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:02:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40888 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfFDHCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:02:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so12522573qtn.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZhC1lENrEFgimv6sdeFIBKs72SRqFRtCu7WdaF7Vsso=;
        b=C3DcycSk052oxTKlRiwURS7n+V1drPQejtIfwDUn0GszBGFKicb65h+Q0N57D1yf7F
         QJj/x0lAlEDs+FH57WxFVlFY5HdY0EjZvkAjgDPoN/xK+7nuOZGQvJqEoiUdIHIOzvxZ
         4C8jp9zunWAdH22blGr3fR9s312nYJLDiGZpp/EZ7cUymzlLfGWqzrfTuVOdlb7wjPVj
         bdYFkrQ0v43GA4bAXXJZwZFxAkA6+qdbsJlC0bnRF3MrUiM6eVRRKpwulRYu8q/RXeEn
         zkqyXaLVguZh/rbjd55DSiDoEqzbuJFx3rTLowKbWYXTJOkWSTC5CxkB+PNM8SoZx2AH
         S0fw==
X-Gm-Message-State: APjAAAUnUNYmu7OMeOUf38WM4evB5FdD9M1SWHwYP1/l7oMf6a3wpM84
        qtp8clvUhvc33SXin3wUZV9pRW0/aLywLvSHchdh0w==
X-Google-Smtp-Source: APXvYqznnJVZGIgYwAw/MnqEYckWgjrGh9RH5HIIi/H7SDijmQix/Wxv4jKZIjn/IMTmenEHoFJG0qYhI8EldZqozHo=
X-Received: by 2002:ac8:2cba:: with SMTP id 55mr10239342qtw.260.1559631744088;
 Tue, 04 Jun 2019 00:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190528162924.32754-1-pedro@pedrovanzella.com>
 <CAO-hwJ+zAvDizJRpykky+D3pf1M1NhFGWztwyA4mJEv8C+nO-w@mail.gmail.com> <20190603214438.2cnmrx7g2sakjdr4@Fenrir>
In-Reply-To: <20190603214438.2cnmrx7g2sakjdr4@Fenrir>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 4 Jun 2019 09:02:11 +0200
Message-ID: <CAO-hwJ+0WEgAvkRsr1oEnR5wCJcGKzhim+=5em1Y-GzC4GowMg@mail.gmail.com>
Subject: Re: [PATCH] HID: hid-logitech-hidpp: detect wireless lightspeed devices
To:     Pedro Vanzella <pedro@pedrovanzella.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 11:44 PM Pedro Vanzella <pedro@pedrovanzella.com> wrote:
>
> On 05/28, Benjamin Tissoires wrote:
> > On Tue, May 28, 2019 at 6:30 PM Pedro Vanzella <pedro@pedrovanzella.com> wrote:
> > >
> > > Send a low device index when the device is connected via the lightspeed
> > > receiver so that the receiver will pass the message along to the device
> > > instead of responding. If we don't do that, we end up thinking it's a
> > > hidpp10 device and miss out on all new features available to newer devices.
> > >
> > > This will enable correct detection of the following models:
> > > G603, GPro, G305, G613, G900 and G903, and possibly others.
> >
> > Thanks for the patch.
> Thanks for reviewing it :)
>
> > However, there is already support for this receiver in Linus' tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/hid/hid-logitech-dj.c?id=f5fb57a74e88bd1788f57bf77d587c91d4dc9d57
> >
> > With kernel 5.2-rc1, the connected device should already be handled by
> > hid-logitech-hidpp :)
> Why are the wireless receivers handled by hid-logitech-dj and the wired
> mice handled by hid-logitech-hidpp? They are, in the end, all hidpp
> devices, and having them all handled by the -hidpp driver with a quirk
> class would allow us to check for support for the battery voltage
> feature, as it seems to be an either-or scenario here.

Yep, and this is exactly what is happening:
- the receiver is handled through hid-logitech-dj -> it creates a
virtual HID device for the wireless physical device
- the actual wireless device is handled through hid-logitech-hidpp
(with the virtual HID device created above)

This has the advantage of presenting the wireless device in the same
way the wired device is. From hid-logitech-hidpp point of view, both
are regular HID++ devices.
Also, this makes sure each physical device gets its own product ID (we
are relying on the wireless product ID), meaning that userspace can
differentiate a G900 from a G613 when both are connected to a receiver
with the same product ID.

Hope that helps.

Cheers,
Benjamin


>
> - Pedro
> >
> > Cheers,
> > Benjamin
> >
> > >
> > > Signed-off-by: Pedro Vanzella <pedro@pedrovanzella.com>
> > > ---
> > >  drivers/hid/hid-logitech-hidpp.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> > > index 72fc9c0566db..621fce141d9f 100644
> > > --- a/drivers/hid/hid-logitech-hidpp.c
> > > +++ b/drivers/hid/hid-logitech-hidpp.c
> > > @@ -62,6 +62,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
> > >  #define HIDPP_QUIRK_CLASS_K400                 BIT(2)
> > >  #define HIDPP_QUIRK_CLASS_G920                 BIT(3)
> > >  #define HIDPP_QUIRK_CLASS_K750                 BIT(4)
> > > +#define HIDPP_QUIRK_CLASS_LIGHTSPEED           BIT(5)
> > >
> > >  /* bits 2..20 are reserved for classes */
> > >  /* #define HIDPP_QUIRK_CONNECT_EVENTS          BIT(21) disabled */
> > > @@ -236,7 +237,11 @@ static int __hidpp_send_report(struct hid_device *hdev,
> > >          * set the device_index as the receiver, it will be overwritten by
> > >          * hid_hw_request if needed
> > >          */
> > > -       hidpp_report->device_index = 0xff;
> > > +       if (hidpp->quirks & HIDPP_QUIRK_CLASS_LIGHTSPEED) {
> > > +               hidpp_report->device_index = 0x01;
> > > +       } else {
> > > +               hidpp_report->device_index = 0xff;
> > > +       }
> > >
> > >         if (hidpp->quirks & HIDPP_QUIRK_FORCE_OUTPUT_REPORTS) {
> > >                 ret = hid_hw_output_report(hdev, (u8 *)hidpp_report, fields_count);
> > > @@ -3753,6 +3758,9 @@ static const struct hid_device_id hidpp_devices[] = {
> > >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC06B) },
> > >         { /* Logitech G900 Gaming Mouse over USB */
> > >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC081) },
> > > +       { /* Logitech Gaming Mice over Lightspeed Receiver */
> > > +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC539),
> > > +         .driver_data = HIDPP_QUIRK_CLASS_LIGHTSPEED },
> > >         { /* Logitech G920 Wheel over USB */
> > >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
> > >                 .driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
> > > --
> > > 2.21.0
> > >
>
> --
> Pedro Vanzella
> pedrovanzella.com
> #include <paranoia.h>
> Don't Panic
