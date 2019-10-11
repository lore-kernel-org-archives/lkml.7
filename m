Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495A4C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C8F205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWQji15i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfJKIZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:25:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38350 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726371AbfJKIZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570782352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oa5CwC4aazo9B5onSWr7QkDKi6iZtCWYw3qyB3Qtc6M=;
        b=WWQji15iQC95906TM2NaPLbBeg4/uHOW1Kej1o96hCOPn87wccK9v4Q+gBnl4+JVrYWLx1
        w0Tyey6kIDnCX2h4VXV5sV7bkPozzkuu8Wt9OOiFCMeIPoq2p7eyQBkp3LvXQ/QRI3ZkR4
        N6ZdZ5xtIY/mWLpALL8EtvgAu9yrQy0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-uWCdB9k_P0ikIMiiCuiZfQ-1; Fri, 11 Oct 2019 04:25:37 -0400
Received: by mail-qt1-f200.google.com with SMTP id m20so8603686qtq.16
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 01:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIkIrzWXWAmdM96VeYW9P3TpaWddtmbYcGztw5y1wok=;
        b=hgZqLoQ0Ogch4DqzrET1Ci+rrxav8329ULN4VQreccViBjOQLexGxlhJkoR9/fYTjR
         rCd2q46IVI/SZpAR+DhXU691ZPyTyYsdbbqoHH4wj1oDDD2ouYs30ESCBgeB5yLVXZZT
         7UCZGxyjjm+gUQBxjJRgAChv0MuobnbETipvReqUKFJhGFBhaN092J4hYjKI4lO4E84V
         SlFeNGX+xRxUxFmk5THvv4usNfC+vX4LSaS21UJ+iBQvdTzWeelOKHBShU8uzV0tjuih
         72t/k6khHEx7Ww5EIekpS9ZyooGe51PRtmz3cCHJxDdgfC5Xnxd3UVXhxQWJ2LK3c9/H
         sZVQ==
X-Gm-Message-State: APjAAAWZS35mzoi3c/7t4U+5J4bAYpmo0TwYih0q28/nueXDw7eieAfz
        7Li0EjU0Z64xZvpN/dI422mZtsYZ/u9GR8NOWi644GeLlzfk/cI96VjTj0U0RjDSzXF0jOSdQ3S
        AdQsW1n9j2kafwBsKEWaWBQh64KPRYb+maMm2ZmrN
X-Received: by 2002:a05:6214:5cf:: with SMTP id t15mr14854870qvz.196.1570782336673;
        Fri, 11 Oct 2019 01:25:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw8L+wx2/y2iC7N7qAvIMKY8gozyLQj1pi6XNA2w1d6Q78EX9SmxH/iKCV33DnXfhs0yhRNSfrVY3D2Hh9k33s=
X-Received: by 2002:a05:6214:5cf:: with SMTP id t15mr14854858qvz.196.1570782336376;
 Fri, 11 Oct 2019 01:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <qPLpNssAeDjlNqTurULLEjShNNHh8DtKSdK-hP2cuq217O3Pc6ZodDDwqqOk8QERJM-jbTqs4Q_iPOcdXCQta_mYX9vgmDK0tDmWmCFRrHo=@protonmail.com>
In-Reply-To: <qPLpNssAeDjlNqTurULLEjShNNHh8DtKSdK-hP2cuq217O3Pc6ZodDDwqqOk8QERJM-jbTqs4Q_iPOcdXCQta_mYX9vgmDK0tDmWmCFRrHo=@protonmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 11 Oct 2019 10:25:24 +0200
Message-ID: <CAO-hwJ+feL2mJ5Wh_0JXP0iTCf3aGExzhZ4t8JsB2aTxnmcEdw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] HID: logitech: Support HID++ devices without short reports
To:     Mazin Rezk <mnrzk@protonmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
X-MC-Unique: uWCdB9k_P0ikIMiiCuiZfQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 2:57 AM Mazin Rezk <mnrzk@protonmail.com> wrote:
>
> On Saturday, October 5, 2019 9:04 PM, Mazin Rezk <mnrzk@protonmail.com> w=
rote:
>
> > This patch allows the hid-logitech-hidpp module to support devices that=
 do
> > not have support for Short HID++ reports. So far, it seems that Bluetoo=
th
> > HID++ 2.0 devices are missing short reports.
>
> > This has been tested and confirmed with the MX Master and MX Master 2S =
and
> > is therefore likely the case with the other Bluetooth devices.
>
> No changes have been made to this patch in v4.
>
> Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 37 ++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 85fd0c17cc2f..a0efa8a43213 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -71,6 +71,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
>  #define HIDPP_QUIRK_HIDPP_WHEELS               BIT(29)
>  #define HIDPP_QUIRK_HIDPP_EXTRA_MOUSE_BTNS     BIT(30)
>  #define HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS BIT(31)
> +#define HIDPP_QUIRK_CLASS_BLUETOOTH            BIT(5)

Quirks should be kept in order.

>
>  /* These are just aliases for now */
>  #define HIDPP_QUIRK_KBD_SCROLL_WHEEL HIDPP_QUIRK_HIDPP_WHEELS
> @@ -81,6 +82,9 @@ MODULE_PARM_DESC(disable_tap_to_click,
>                                          HIDPP_QUIRK_HI_RES_SCROLL_X2120 =
| \
>                                          HIDPP_QUIRK_HI_RES_SCROLL_X2121)
>
> +/* Just an alias for now, may possibly be a catch-all in the future */
> +#define HIDPP_QUIRK_MISSING_SHORT_REPORTS      HIDPP_QUIRK_CLASS_BLUETOO=
TH

I would rather have the other way around: define
HIDPP_QUIRK_MISSING_SHORT_REPORTS as BIT(20) (change the comment while
defining it), and have a class definition that aliases
HIDPP_QUIRK_MISSING_SHORT_REPORTS instead. This way, we can add an
other quirk like you do in one of the next patches without
conflicting.

> +
>  #define HIDPP_QUIRK_DELAYED_INIT               HIDPP_QUIRK_NO_HIDINPUT
>
>  #define HIDPP_CAPABILITY_HIDPP10_BATTERY       BIT(0)
> @@ -340,6 +344,12 @@ static int hidpp_send_rap_command_sync(struct hidpp_=
device *hidpp_dev,
>         struct hidpp_report *message;
>         int ret, max_count;
>
> +       /* Force long reports on devices that do not support short report=
s */
> +       if (hidpp_dev->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS &&
> +           report_id =3D=3D REPORT_ID_HIDPP_SHORT)
> +               report_id =3D REPORT_ID_HIDPP_LONG;
> +
> +

nitpick: one extra carriage return.

>         switch (report_id) {
>         case REPORT_ID_HIDPP_SHORT:
>                 max_count =3D HIDPP_REPORT_SHORT_LENGTH - 4;
> @@ -3482,6 +3492,12 @@ static bool hidpp_validate_report(struct hid_devic=
e *hdev, int id,
>
>  static bool hidpp_validate_device(struct hid_device *hdev)
>  {
> +       struct hidpp_device *hidpp =3D hid_get_drvdata(hdev);

nitpick: empty line missing.

> +       /* Skip the short report check if the device does not support it =
*/
> +       if (hidpp->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS)
> +               return hidpp_validate_report(hdev, REPORT_ID_HIDPP_LONG,
> +                                            HIDPP_REPORT_LONG_LENGTH, fa=
lse);
> +
>         return hidpp_validate_report(hdev, REPORT_ID_HIDPP_SHORT,
>                                      HIDPP_REPORT_SHORT_LENGTH, false) &&
>                hidpp_validate_report(hdev, REPORT_ID_HIDPP_LONG,
> @@ -3775,22 +3791,29 @@ static const struct hid_device_id hidpp_devices[]=
 =3D {
>           .driver_data =3D HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
>         { /* MX Anywhere 2 mouse over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb013),
> -         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
> +                        HIDPP_QUIRK_CLASS_BLUETOOTH },

As mentioned in 1/4:
- please only add devices you know have been tested
- squash the previous one into this one to preserve bisectability.

Cheers,
Benjamin

>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb018),
> -         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
> +                        HIDPP_QUIRK_CLASS_BLUETOOTH },
>         { /* MX Anywhere 2S mouse over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01a),
> -         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
> +                        HIDPP_QUIRK_CLASS_BLUETOOTH },
>         { /* MX Master mouse over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb012),
> -         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
> +                        HIDPP_QUIRK_CLASS_BLUETOOTH },
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb017),
> -         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
> +                        HIDPP_QUIRK_CLASS_BLUETOOTH },
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e),
> -         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
> +                        HIDPP_QUIRK_CLASS_BLUETOOTH },
>         { /* MX Master 2S mouse over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb019),
> -         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
> +                        HIDPP_QUIRK_CLASS_BLUETOOTH },
>         {}
>  };
>
> --
> 2.23.0

