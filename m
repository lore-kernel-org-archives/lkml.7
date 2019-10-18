Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8121CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B743721852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBY8Ku6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408849AbfJRPgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:36:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51454 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728110AbfJRPgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571412980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lyYjRHP3gN7IAdSg/zSTXjc0q+hU5LSKzHOdTvgAUVk=;
        b=PBY8Ku6Cg2kvibOgu1+U3iKKgQWUzzsl1gPkaO66AjLtx4jShD0PuTL/iO1CRUpmNzf2bc
        FB1vV41osUbKa1I06PIOojcZy63+UbVxtx+dVWVkc9izl4MITc3NRktQNaYhPGYCM2J41l
        ZHWa7IsOXJezLe5iexAr9eFBd5yxfW8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-7_zfvF7mOJGR_VmxSpkQ6w-1; Fri, 18 Oct 2019 11:36:17 -0400
Received: by mail-qt1-f198.google.com with SMTP id 59so6250857qtc.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 08:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3XjpxhccyZHQzqrK60FF7DFkSZmCbVnNJ0TkofNodrU=;
        b=Xi9R5Bxuwjb/Posv+ewPEpvsouK4xOktxKKUFVaQtiCQTeDvB6ELlLByUKeGqQdaR3
         8W8pd6QWm0+jLjSoujPYmvZKQ9x+z/F9+GhVVCRfQVilQOhFr+M3WJwvz+ypPrO0VixT
         sew8RU7R+TswXLCNhKOFHHUrXSRhbeFOX1ORp+b2WLH5W1HesbCfxsSysxn0T4PpRCV/
         zorNYb+xr16JwVpSN/B2Aa5+TV/YexTOS4PcL0k6TOFVoC3l8YYiaPmvYKU3cqkp1N+t
         G7qvN2MVY8cIHsjRwbZZgJqWIj9Ya1aC/ghgBiQd2kSQgUvH9oUQMjggMKoEN+ef5l2Z
         otJQ==
X-Gm-Message-State: APjAAAVpqdhzu6wKLIeZdS+tPb0iHDp9cs1PSJ5R1XX0xGdZHjJl7Xfs
        Ct+2NSQ2heWUWIAPIq8699Z+IZGUkZVX1fzVQ681MgjQeYeH9uFZrfwaEdGMSSu9ULar1gESn4X
        rMh91JRN/JGu+u/g6hMgF0vJlq5UJRG4ebiaCKWmi
X-Received: by 2002:a0c:8eca:: with SMTP id y10mr10417375qvb.138.1571412976764;
        Fri, 18 Oct 2019 08:36:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyTyDdlpvS579S+SFTu+02sCbWuhKx0mODNMGrum4qpeM6witBSpxOSFS1KklAzUZNuddH9XQ07M2b48KhYCS4=
X-Received: by 2002:a0c:8eca:: with SMTP id y10mr10417349qvb.138.1571412976482;
 Fri, 18 Oct 2019 08:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <ggKipcQplIlTFmoP3hPnrQ-7_5-C0PKGd5feFymts3uenIBA8zOwz47YmKheD34H1rpkguDAGdx5YbS9UqpwfjT5Ir0Lji941liLVp--QtQ=@protonmail.com>
In-Reply-To: <ggKipcQplIlTFmoP3hPnrQ-7_5-C0PKGd5feFymts3uenIBA8zOwz47YmKheD34H1rpkguDAGdx5YbS9UqpwfjT5Ir0Lji941liLVp--QtQ=@protonmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 18 Oct 2019 17:36:05 +0200
Message-ID: <CAO-hwJJ18L3nDMQ_OqCZPyA+FFk3QsnbY=dYSNkELWzTSAnQLA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] HID: logitech: Add MX Master over Bluetooth
To:     Mazin Rezk <mnrzk@protonmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
X-MC-Unique: 7_zfvF7mOJGR_VmxSpkQ6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mazin,

On Mon, Oct 14, 2019 at 8:36 PM Mazin Rezk <mnrzk@protonmail.com> wrote:
>
> This patch adds support for the MX Master (b01e and b012) and also adds
> foundational code for other Bluetooth LE HID++ devices to be added.
>
> Some devices do not support short reports and thus have a quirk
> (HIDPP_QUIRK_MISSING_SHORT_REPORTS) that forces short reports to be sent =
as
> long reports. Since all Bluetooth LE HID++ devices seem to act this way,
> HIDPP_QUIRK_CLASS_BLUETOOTH_LE aliases this quirk.
>
> To allow for some space for future quirks, I changed the comment that
> defines the bits reserved for classes from 2...20 to 2..15.
>
> Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 0179f7ed77e5..997b1056850a 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -59,7 +59,8 @@ MODULE_PARM_DESC(disable_tap_to_click,
>  #define HIDPP_QUIRK_CLASS_G920                 BIT(3)
>  #define HIDPP_QUIRK_CLASS_K750                 BIT(4)
>
> -/* bits 2..20 are reserved for classes */
> +/* bits 2..15 are reserved for classes */
> +#define HIDPP_QUIRK_MISSING_SHORT_REPORTS      BIT(20)
>  /* #define HIDPP_QUIRK_CONNECT_EVENTS          BIT(21) disabled */
>  #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS       BIT(22)
>  #define HIDPP_QUIRK_NO_HIDINPUT                        BIT(23)
> @@ -81,6 +82,8 @@ MODULE_PARM_DESC(disable_tap_to_click,
>                                          HIDPP_QUIRK_HI_RES_SCROLL_X2120 =
| \
>                                          HIDPP_QUIRK_HI_RES_SCROLL_X2121)
>
> +#define HIDPP_QUIRK_CLASS_BLUETOOTH_LE HIDPP_QUIRK_MISSING_SHORT_REPORTS
> +
>  #define HIDPP_QUIRK_DELAYED_INIT               HIDPP_QUIRK_NO_HIDINPUT
>
>  #define HIDPP_CAPABILITY_HIDPP10_BATTERY       BIT(0)
> @@ -340,6 +343,12 @@ static int hidpp_send_rap_command_sync(struct hidpp_=
device *hidpp_dev,
>         struct hidpp_report *message;
>         int ret, max_count;
>
> +       /* Force long reports on devices that do not support short report=
s */
> +       if (hidpp_dev->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS &&
> +           report_id =3D=3D REPORT_ID_HIDPP_SHORT)
> +               report_id =3D REPORT_ID_HIDPP_LONG;

Wouldn't it be faster to just store which report needs to be put here
in struct hidpp_device?

> +
> +
>         switch (report_id) {
>         case REPORT_ID_HIDPP_SHORT:
>                 max_count =3D HIDPP_REPORT_SHORT_LENGTH - 4;
> @@ -3482,6 +3491,12 @@ static bool hidpp_validate_report(struct hid_devic=
e *hdev, int id,
>
>  static bool hidpp_validate_device(struct hid_device *hdev)
>  {
> +       struct hidpp_device *hidpp =3D hid_get_drvdata(hdev);
> +       /* Skip the short report check if the device does not support it =
*/
> +       if (hidpp->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS)
> +               return hidpp_validate_report(hdev, REPORT_ID_HIDPP_LONG,
> +                                            HIDPP_REPORT_LONG_LENGTH, fa=
lse);
> +

I just merged Andrey's report detection, which means you will need to
update this hunk:
https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=3Dfor=
-5.4/upstream-fixes&id=3D905d754c53a522aacf806ea1d3e7c929148c1910

The good thing, is that now you can simply auto-detect if the short
report is missing. If the returned report_length is null, you know
that the report is missing (and thus you can remember to set the
quirk/which report id is needed).

Cheers,
Benjamin

>         return hidpp_validate_report(hdev, REPORT_ID_HIDPP_SHORT,
>                                      HIDPP_REPORT_SHORT_LENGTH, false) &&
>                hidpp_validate_report(hdev, REPORT_ID_HIDPP_LONG,
> @@ -3773,6 +3788,13 @@ static const struct hid_device_id hidpp_devices[] =
=3D {
>         { /* MX5500 keyboard over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
>           .driver_data =3D HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
> +       { /* MX Master mouse over Bluetooth */
> +         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb012),
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
> +                        HIDPP_QUIRK_CLASS_BLUETOOTH_LE },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e),
> +         .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 |
> +                        HIDPP_QUIRK_CLASS_BLUETOOTH_LE },
>         {}
>  };
>
> --
> 2.23.0
>

