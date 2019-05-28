Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11205C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E565021726
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfE1RHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:07:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33167 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfE1RHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:07:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id p18so23743204qkk.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 10:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G39Rpo20bfV9oatIjPpZxfb3OklAE1CP3oejmY6Bb+A=;
        b=F/l0U/bFMHYKYdNnGCvN0HWdzEC/IY453PM7mghfAfWtki+tu2Ass3ZE714pxKNUku
         /1xEtkLiEwqKMFPSeaOyTctGlMs0BgglewUq1Hoa9NjCkSzEXmSWpkhwDemNsLfz5ete
         5JpIq35wRt2jUege8rJg2Q+DVmsM/uLZ7F/mydtcUuTQ2tybZ5AKeZHCECRws1mNCSHZ
         L8EbfRSZid5PM+l19Y4rWO49+9roWUgkxFlj15u7ABjrJwOd3MGpPK72V+MvKiKZJ20P
         cuzf4mWIN20YAi98wR+rPT86RjauChWIUgu/2RhBgXvRLVCOYurYiAStZMbEbz5s5Hjt
         g7MQ==
X-Gm-Message-State: APjAAAXjeOGsNdImve1mAFNFOKW4ukK/f1jwCL0U9m6S4vBP9QkY5D3k
        F+YOpEdNQzgJ9cJv5H2oAzgzhyzTE4rY8MS+Y6REcA==
X-Google-Smtp-Source: APXvYqz50MAdAghe/dbH5vV1XdaL2gTZYN8AjpGl/kDte8UNYm/HKs2JKnk+mG2ve5ottnQoxD1txRvBsAMpQvEfcus=
X-Received: by 2002:a0c:baa7:: with SMTP id x39mr51546711qvf.100.1559063234889;
 Tue, 28 May 2019 10:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190528162924.32754-1-pedro@pedrovanzella.com>
In-Reply-To: <20190528162924.32754-1-pedro@pedrovanzella.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 28 May 2019 19:07:02 +0200
Message-ID: <CAO-hwJ+zAvDizJRpykky+D3pf1M1NhFGWztwyA4mJEv8C+nO-w@mail.gmail.com>
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

On Tue, May 28, 2019 at 6:30 PM Pedro Vanzella <pedro@pedrovanzella.com> wrote:
>
> Send a low device index when the device is connected via the lightspeed
> receiver so that the receiver will pass the message along to the device
> instead of responding. If we don't do that, we end up thinking it's a
> hidpp10 device and miss out on all new features available to newer devices.
>
> This will enable correct detection of the following models:
> G603, GPro, G305, G613, G900 and G903, and possibly others.

Thanks for the patch.
However, there is already support for this receiver in Linus' tree:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/hid/hid-logitech-dj.c?id=f5fb57a74e88bd1788f57bf77d587c91d4dc9d57

With kernel 5.2-rc1, the connected device should already be handled by
hid-logitech-hidpp :)

Cheers,
Benjamin

>
> Signed-off-by: Pedro Vanzella <pedro@pedrovanzella.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 72fc9c0566db..621fce141d9f 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -62,6 +62,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
>  #define HIDPP_QUIRK_CLASS_K400                 BIT(2)
>  #define HIDPP_QUIRK_CLASS_G920                 BIT(3)
>  #define HIDPP_QUIRK_CLASS_K750                 BIT(4)
> +#define HIDPP_QUIRK_CLASS_LIGHTSPEED           BIT(5)
>
>  /* bits 2..20 are reserved for classes */
>  /* #define HIDPP_QUIRK_CONNECT_EVENTS          BIT(21) disabled */
> @@ -236,7 +237,11 @@ static int __hidpp_send_report(struct hid_device *hdev,
>          * set the device_index as the receiver, it will be overwritten by
>          * hid_hw_request if needed
>          */
> -       hidpp_report->device_index = 0xff;
> +       if (hidpp->quirks & HIDPP_QUIRK_CLASS_LIGHTSPEED) {
> +               hidpp_report->device_index = 0x01;
> +       } else {
> +               hidpp_report->device_index = 0xff;
> +       }
>
>         if (hidpp->quirks & HIDPP_QUIRK_FORCE_OUTPUT_REPORTS) {
>                 ret = hid_hw_output_report(hdev, (u8 *)hidpp_report, fields_count);
> @@ -3753,6 +3758,9 @@ static const struct hid_device_id hidpp_devices[] = {
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC06B) },
>         { /* Logitech G900 Gaming Mouse over USB */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC081) },
> +       { /* Logitech Gaming Mice over Lightspeed Receiver */
> +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC539),
> +         .driver_data = HIDPP_QUIRK_CLASS_LIGHTSPEED },
>         { /* Logitech G920 Wheel over USB */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
>                 .driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
> --
> 2.21.0
>
