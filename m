Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66962CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF6F21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2IFwS6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404352AbfJRPid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:38:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46097 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730498AbfJRPic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571413110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JTdnWheKvkUYrVaMeY3lYJ2nHqs52mFAjqgDCc0VsJM=;
        b=i2IFwS6GQimiSNUJE4nROXJ53VZsFLQtow/FpkQ3M57LGLeBIwd2q9ENgM5OkC3DWsHYNC
        r77biHbnwnnNuJMUplpA0gcrE9b3PDw4atAcDImX4oS84JNT2Ek9FhhG6c/xbsE8ftdY4k
        rfOemFuXYVhDbGObLup9E6eXrEB7Dng=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-vaDY0JFKNJ6m9w_SqeYRMg-1; Fri, 18 Oct 2019 11:38:26 -0400
Received: by mail-qt1-f197.google.com with SMTP id z12so6281920qtn.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 08:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHpooU0lck0YMXNkAeb+yjAvWSzG5nXB8oRVtwMgBWg=;
        b=KiZ/plC8JdyWxxtm4oNvvnPAJaiGnyl+2CInrPs1A+FcFnTXh9pqVPMg5Igd4Ea6Xx
         Yvz1VgptsH9wsBpGqTuo+NfdIcHbIzbgAtN7XB7bJD1jBOy6e3sYl7/kVtPafMVhTSXt
         mv1XffAQPeK+rPy6oSkb+Z932F/tIVMOD80OTxcDAaoHM2QBm+ylN0i9VxqlChR9v2Pe
         LHwhXH6rv1SKsphkzGIj4gjY31Q4J1KZ8fGzoPmnL82WLeOLFEtKyLpgRj9In5andZeR
         8iEHhRSkLnNImkzWyTD9CaYU+tmYKKVzpB18sYxxJUKMTZw6XSqMYjBW9kYGf2p1i/oc
         3jYw==
X-Gm-Message-State: APjAAAWbGVrnot7DGV96ZAyDXs/3IMH4a7DfvyZh1iYqcOlcv1cLiqIn
        n8V/g0Dd2OeVDLxWCeWw3TvVkh74gThTCJgBGq4LQaksnsKWLENz+Zr+t4kqQ5WcTfG4ruW2qwu
        lmKx50teM2MdmHwHDxeL/yQLwm5Axq9VRQOlgbDyZ
X-Received: by 2002:ac8:1e83:: with SMTP id c3mr10653473qtm.294.1571413106412;
        Fri, 18 Oct 2019 08:38:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxK/5QurjRG7eDYqrF+2bk1Vi3nAVRG9WhS28hkPLqaIdu1lKgJvcG0oIkVSCiDU6yOT0bpc8h31isrSSj1uvI=
X-Received: by 2002:ac8:1e83:: with SMTP id c3mr10653425qtm.294.1571413106084;
 Fri, 18 Oct 2019 08:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <_1Ewv9AvBhbWTNcFOkmvCyjVph73eQIz23Plyv5ffgaWWHnmPBTbSIJhs47AnYatJsmDWu4JlMjcsKE8Cf31lvmwQipYEu47YglNfroyJtM=@protonmail.com>
In-Reply-To: <_1Ewv9AvBhbWTNcFOkmvCyjVph73eQIz23Plyv5ffgaWWHnmPBTbSIJhs47AnYatJsmDWu4JlMjcsKE8Cf31lvmwQipYEu47YglNfroyJtM=@protonmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 18 Oct 2019 17:38:14 +0200
Message-ID: <CAO-hwJK3Q1Bu+6JVbXmbZ2-JqaPzX=dEVPfue=v2LRJsU7FmGA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] HID: logitech: Support WirelessDeviceStatus
 connect events
To:     Mazin Rezk <mnrzk@protonmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
X-MC-Unique: vaDY0JFKNJ6m9w_SqeYRMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 8:36 PM Mazin Rezk <mnrzk@protonmail.com> wrote:
>
> This patch allows WirelessDeviceStatus (0x1d4b) events to be detected as
> connection events in the hid-logitech-hidpp module.
>
> Devices with HIDPP_QUIRK_WIRELESS_DEVICE_STATUS use WirelessDeviceStatus
> instead of traditional connect events. Since all Bluetooth LE devices see=
m
> to act this way, HIDPP_QUIRK_CLASS_BLUETOOTH_LE aliases this quirk.
>
> Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 42 ++++++++++++++++++++++++++++----
>  1 file changed, 37 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 997b1056850a..9b3df57ca857 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -60,6 +60,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
>  #define HIDPP_QUIRK_CLASS_K750                 BIT(4)
>
>  /* bits 2..15 are reserved for classes */
> +#define HIDPP_QUIRK_WIRELESS_DEVICE_STATUS     BIT(19)
>  #define HIDPP_QUIRK_MISSING_SHORT_REPORTS      BIT(20)
>  /* #define HIDPP_QUIRK_CONNECT_EVENTS          BIT(21) disabled */
>  #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS       BIT(22)
> @@ -82,7 +83,8 @@ MODULE_PARM_DESC(disable_tap_to_click,
>                                          HIDPP_QUIRK_HI_RES_SCROLL_X2120 =
| \
>                                          HIDPP_QUIRK_HI_RES_SCROLL_X2121)
>
> -#define HIDPP_QUIRK_CLASS_BLUETOOTH_LE HIDPP_QUIRK_MISSING_SHORT_REPORTS
> +#define HIDPP_QUIRK_CLASS_BLUETOOTH_LE (HIDPP_QUIRK_MISSING_SHORT_REPORT=
S | \
> +                                        HIDPP_QUIRK_WIRELESS_DEVICE_STAT=
US)
>
>  #define HIDPP_QUIRK_DELAYED_INIT               HIDPP_QUIRK_NO_HIDINPUT
>
> @@ -189,6 +191,8 @@ struct hidpp_device {
>
>         struct hidpp_battery battery;
>         struct hidpp_scroll_counter vertical_wheel_counter;
> +
> +       u8 wireless_feature_index;
>  };
>
>  /* HID++ 1.0 error codes */
> @@ -402,10 +406,14 @@ static inline bool hidpp_match_error(struct hidpp_r=
eport *question,
>             (answer->fap.params[0] =3D=3D question->fap.funcindex_clienti=
d);
>  }
>
> -static inline bool hidpp_report_is_connect_event(struct hidpp_report *re=
port)
> +static inline bool hidpp_report_is_connect_event(struct hidpp_device *hi=
dpp,
> +                                                struct hidpp_report *rep=
ort)
>  {
> -       return (report->report_id =3D=3D REPORT_ID_HIDPP_SHORT) &&
> -               (report->rap.sub_id =3D=3D 0x41);
> +       return ((hidpp->quirks & HIDPP_QUIRK_WIRELESS_DEVICE_STATUS) &&
> +               (report->fap.feature_index =3D=3D hidpp->wireless_feature=
_index)) ||
> +             (((report->report_id =3D=3D REPORT_ID_HIDPP_SHORT) ||
> +               (hidpp->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS)) &&
> +               (report->rap.sub_id =3D=3D 0x41));

I wonder if we need a quirk after all: if
hidpp->wireless_feature_index is non null, that means that we have the
quirk.
Unless the feature is present for non BLE devices, in which case, we
might want to enable them one by one, for now.

Cheers,
Benjamin

>  }
>
>  /**
> @@ -1282,6 +1290,24 @@ static int hidpp_battery_get_property(struct power=
_supply *psy,
>         return ret;
>  }
>
> +/* ---------------------------------------------------------------------=
----- */
> +/* 0x1d4b: Wireless device status                                       =
      */
> +/* ---------------------------------------------------------------------=
----- */
> +#define HIDPP_PAGE_WIRELESS_DEVICE_STATUS                      0x1d4b
> +
> +static int hidpp_set_wireless_feature_index(struct hidpp_device *hidpp)
> +{
> +       u8 feature_type;
> +       int ret;
> +
> +       ret =3D hidpp_root_get_feature(hidpp,
> +                                    HIDPP_PAGE_WIRELESS_DEVICE_STATUS,
> +                                    &hidpp->wireless_feature_index,
> +                                    &feature_type);
> +
> +       return ret;
> +}
> +
>  /* ---------------------------------------------------------------------=
----- */
>  /* 0x2120: Hi-resolution scrolling                                      =
      */
>  /* ---------------------------------------------------------------------=
----- */
> @@ -3077,7 +3103,7 @@ static int hidpp_raw_hidpp_event(struct hidpp_devic=
e *hidpp, u8 *data,
>                 }
>         }
>
> -       if (unlikely(hidpp_report_is_connect_event(report))) {
> +       if (unlikely(hidpp_report_is_connect_event(hidpp, report))) {
>                 atomic_set(&hidpp->connected,
>                                 !(report->rap.params[0] & (1 << 6)));
>                 if (schedule_work(&hidpp->work) =3D=3D 0)
> @@ -3624,6 +3650,12 @@ static int hidpp_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>                 hidpp_overwrite_name(hdev);
>         }
>
> +       if (connected && (hidpp->quirks & HIDPP_QUIRK_WIRELESS_DEVICE_STA=
TUS)) {
> +               ret =3D hidpp_set_wireless_feature_index(hidpp);
> +               if (ret)
> +                       goto hid_hw_init_fail;
> +       }
> +
>         if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)) {
>                 ret =3D wtp_get_config(hidpp);
>                 if (ret)
> --
> 2.23.0
>

