Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF137CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B78621872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgNDkoDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbfJVKP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 06:15:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30355 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731778AbfJVKP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571739325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jb+jSLMMXhdA2TXJb5G1pOFPifh/azLKzIqyNehvil8=;
        b=UgNDkoDTC252jB2hFd3Fsfb7QlX8K/cs7nzl06jQADrJc52ovWA4glR3dQg89OcRcv1C5+
        /OQL8wX4O76eZqjdUbx87yy1tNquuDS4Srs9trNk3LKh6QE9M5bNpu0bYVn1V3OKK0X3zC
        4eknomgcEIELZFR/rNTcrLyHvPY8Y84=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-KwjT40cYNaCmXPH9U9KO2g-1; Tue, 22 Oct 2019 06:15:21 -0400
Received: by mail-qk1-f199.google.com with SMTP id d25so16165186qkk.17
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 03:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+tB79fPqhNVkFo2VEsWEyKbhlVTlDgMTu/kLHgRvk0=;
        b=nq0Q1q/PtFqDnGFo/KKiG95oa3pl1D7XBaod/+0rGppHX11xvuwPePiKTVNk7ef2j/
         4X5dVZFGiQYLj03P6trlhlhBd25yjJ2wQQqEJPwQAy4sK2GrWMBDNepYFy/Nx4z7hcdI
         SmiWsSAQKoYryHSlQ2uFbtnt5ynuqOZ78qccT62tw3yC3pbK3TH1nxvZ656C9FtgBfHd
         ykS0msQ4nr0I9Z4Xy21YlojpbnNb2rpZwZFl/afGRSS3D3bMS/AMmqO2ybCJVVxz7+hx
         bfNsUb7BzLSbOk7wQtfMtK1NlCez/7XJt6/xibTsiBmjlty5BeFGSK9VlwZGFOBuRZHV
         SQTA==
X-Gm-Message-State: APjAAAXtXNH06vFj0n7h7pE48W/tltMGtpedSTyByhzt7/cu2S4kG630
        yX7kdjAiZAwNvkQpZT63kTJ8rYMp/TZleysdnMrA52+q6qyc86zONukTNeu+VLh9arSzZVg2jtn
        nYrB9V7epQm1XPl9bAf3TVT5wOSL8lv8kVgVNOoXQ
X-Received: by 2002:a0c:abcc:: with SMTP id k12mr2302876qvb.101.1571739321351;
        Tue, 22 Oct 2019 03:15:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw3wlp22/ODzKPhuKB4Wguk4PUNSjqc4San3at8E7aERmoz6go8O9OAAVKGDfW8/RCdENvOC2RZnVCL4j6Ezjg=
X-Received: by 2002:a0c:abcc:: with SMTP id k12mr2302839qvb.101.1571739321002;
 Tue, 22 Oct 2019 03:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <rzUqln0ASGmn_QTpqCkke6UzMFQDj2H7fIngMOxQwtiX52PkWc_BbxkGy4XcIm7kaVcQHwAYhO7ITZoMotLSHw_2WZre9_QJBDhXoMPTLsw=@protonmail.com>
In-Reply-To: <rzUqln0ASGmn_QTpqCkke6UzMFQDj2H7fIngMOxQwtiX52PkWc_BbxkGy4XcIm7kaVcQHwAYhO7ITZoMotLSHw_2WZre9_QJBDhXoMPTLsw=@protonmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 22 Oct 2019 12:15:09 +0200
Message-ID: <CAO-hwJKmZX8MksRvXC=iyG_eaDxmr3N4tRM_moACxX1aNYSokg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] HID: logitech-hidpp: Support translations from
 short to long reports
To:     Mazin Rezk <mnrzk@protonmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
X-MC-Unique: KwjT40cYNaCmXPH9U9KO2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mazin,

On Sun, Oct 20, 2019 at 6:41 AM Mazin Rezk <mnrzk@protonmail.com> wrote:
>
> This patch allows short reports to be translated into long reports.
>
> hidpp_validate_device now returns a u8 instead of a bool which represents
> the supported reports. The corresponding bits (i.e.
> HIDPP_REPORT_*_SUPPORTED) are set if an HID++ report is supported.
>
> If a short report is being sent and the device does not support it, it is
> instead sent as a long report.
>
> Thanks,
> Mazin
>
> Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
> ---

Yep, I like this patch much better.

I also tested the 0xb012 MX Master, and it now works like a charm :)

nitpick: can you squash the next patch into this one? Because to be
useful, this patch really need one or 2 supported devices.

Cheers,
Benjamin



>  drivers/hid/hid-logitech-hidpp.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index e9bba282f9c1..ee604b17514f 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -49,6 +49,10 @@ MODULE_PARM_DESC(disable_tap_to_click,
>  #define HIDPP_REPORT_LONG_LENGTH               20
>  #define HIDPP_REPORT_VERY_LONG_MAX_LENGTH      64
>
> +#define HIDPP_REPORT_SHORT_SUPPORTED           BIT(0)
> +#define HIDPP_REPORT_LONG_SUPPORTED            BIT(1)
> +#define HIDPP_REPORT_VERY_LONG_SUPPORTED       BIT(2)
> +
>  #define HIDPP_SUB_ID_CONSUMER_VENDOR_KEYS      0x03
>  #define HIDPP_SUB_ID_ROLLER                    0x05
>  #define HIDPP_SUB_ID_MOUSE_EXTRA_BTNS          0x06
> @@ -183,6 +187,7 @@ struct hidpp_device {
>
>         unsigned long quirks;
>         unsigned long capabilities;
> +       u8 supported_reports;
>
>         struct hidpp_battery battery;
>         struct hidpp_scroll_counter vertical_wheel_counter;
> @@ -340,6 +345,11 @@ static int hidpp_send_rap_command_sync(struct hidpp_=
device *hidpp_dev,
>         struct hidpp_report *message;
>         int ret, max_count;
>
> +       /* Send as long report if short reports are not supported. */
> +       if (report_id =3D=3D REPORT_ID_HIDPP_SHORT &&
> +           !(hidpp_dev->supported_reports & HIDPP_REPORT_SHORT_SUPPORTED=
))
> +               report_id =3D REPORT_ID_HIDPP_LONG;
> +
>         switch (report_id) {
>         case REPORT_ID_HIDPP_SHORT:
>                 max_count =3D HIDPP_REPORT_SHORT_LENGTH - 4;
> @@ -3458,10 +3468,11 @@ static int hidpp_get_report_length(struct hid_dev=
ice *hdev, int id)
>         return report->field[0]->report_count + 1;
>  }
>
> -static bool hidpp_validate_device(struct hid_device *hdev)
> +static u8 hidpp_validate_device(struct hid_device *hdev)
>  {
>         struct hidpp_device *hidpp =3D hid_get_drvdata(hdev);
> -       int id, report_length, supported_reports =3D 0;
> +       int id, report_length;
> +       u8 supported_reports =3D 0;
>
>         id =3D REPORT_ID_HIDPP_SHORT;
>         report_length =3D hidpp_get_report_length(hdev, id);
> @@ -3469,7 +3480,7 @@ static bool hidpp_validate_device(struct hid_device=
 *hdev)
>                 if (report_length < HIDPP_REPORT_SHORT_LENGTH)
>                         goto bad_device;
>
> -               supported_reports++;
> +               supported_reports |=3D HIDPP_REPORT_SHORT_SUPPORTED;
>         }
>
>         id =3D REPORT_ID_HIDPP_LONG;
> @@ -3478,7 +3489,7 @@ static bool hidpp_validate_device(struct hid_device=
 *hdev)
>                 if (report_length < HIDPP_REPORT_LONG_LENGTH)
>                         goto bad_device;
>
> -               supported_reports++;
> +               supported_reports |=3D HIDPP_REPORT_LONG_SUPPORTED;
>         }
>
>         id =3D REPORT_ID_HIDPP_VERY_LONG;
> @@ -3488,7 +3499,7 @@ static bool hidpp_validate_device(struct hid_device=
 *hdev)
>                     report_length > HIDPP_REPORT_VERY_LONG_MAX_LENGTH)
>                         goto bad_device;
>
> -               supported_reports++;
> +               supported_reports |=3D HIDPP_REPORT_VERY_LONG_SUPPORTED;
>                 hidpp->very_long_report_length =3D report_length;
>         }
>
> @@ -3536,7 +3547,9 @@ static int hidpp_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>         /*
>          * Make sure the device is HID++ capable, otherwise treat as gene=
ric HID
>          */
> -       if (!hidpp_validate_device(hdev)) {
> +       hidpp->supported_reports =3D hidpp_validate_device(hdev);
> +
> +       if (!hidpp->supported_reports) {
>                 hid_set_drvdata(hdev, NULL);
>                 devm_kfree(&hdev->dev, hidpp);
>                 return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> --
> 2.23.0
>

