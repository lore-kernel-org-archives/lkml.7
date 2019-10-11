Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BADECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAD82190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3LP3nZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfJKIvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:51:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59817 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726508AbfJKIvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570783895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wu/Rf3zNUutfn3m2zM9kQv92cgKYcwMDqv7vUduVPBc=;
        b=d3LP3nZK+Yrp/0UOWuw1dUtzjHGvt0m0f6nGfc1FhXxtO0wMRUIMgiCbL8krXBVImcCOK1
        Y/6FxFsLhmX2FQB0mIx9mfXlmWxwaax2EzfRO88hWK3W9ib3vt81wisetrjGIADHtaPyx/
        lj4mF71K4mAZiDCouzJnHJ4Zs+s63vI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-5bRFKRJzNBmsC3M5Ae6RGw-1; Fri, 11 Oct 2019 04:51:33 -0400
Received: by mail-qt1-f197.google.com with SMTP id n4so8671960qtp.19
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 01:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N10/dTN197PTl0+siuLFDZWqlAaRDfdqpN7eV7M6lL0=;
        b=fiRHPPdGQC52D32e73xeuwl5wDrxdSaJGUngqOv93Z6QVTCefJIsk/T8wh+RibrGz+
         obonHmK05x3OZkIxARkyFdItgPlPzEeo/U/fxpJBF+QrMxcM0RdWtqzgSIkp1u2enKnC
         N1/kvostbeunPG2e4nAzG4lNVCJQ+U2qqJZDMWMDjY6zJ9BRzAo1afSnjNKI6f+M7S3x
         xlvqv0pSTxvU8UwQ9x58clm275emtGTw7LQ0vdC5dPRVk2twc549L6RAcpAJB26zP/zA
         1CM315cwUI6SV07ell7sstLKsLN32v/PwTYN8NGfd0JEG/7WJEeOu64p2SFbxNfPnXVO
         RNVQ==
X-Gm-Message-State: APjAAAV/sfsLgeINT6Jvu1fNpsj1JAkmvi1OfrKYOAiFsyPtI/j0Ft9d
        yKORaWlbCrUJo1elu7OvK+kQZvB1dnvt+UeqMCpcn+oy/8pWc7dCke9hNIvcVZSBRYf4SjMESGk
        i1okzVxQ6uOOF+1mAfUaM1p2HkBhKIRoB6hoXwWRZ
X-Received: by 2002:a37:648d:: with SMTP id y135mr13907182qkb.459.1570783893299;
        Fri, 11 Oct 2019 01:51:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySLoMI6pvZ557naSRkGTpWHJHszarZ6iWrS7WWNjAZXtz1Nf2y0fUJ33374bS3uf3RZwpModlRILODHjD/gQI=
X-Received: by 2002:a37:648d:: with SMTP id y135mr13907169qkb.459.1570783893028;
 Fri, 11 Oct 2019 01:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <GOPSiaLYzQc3Hi9-MvdMQOmiF6O9whCeVYWavirKdm-9VHGb37VtawOPII8FEdYAOWZYFvk3oSQcHkPGazJKZNx8DEwBO7JfrRjLjWA84UI=@protonmail.com>
In-Reply-To: <GOPSiaLYzQc3Hi9-MvdMQOmiF6O9whCeVYWavirKdm-9VHGb37VtawOPII8FEdYAOWZYFvk3oSQcHkPGazJKZNx8DEwBO7JfrRjLjWA84UI=@protonmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 11 Oct 2019 10:51:22 +0200
Message-ID: <CAO-hwJL=j_toocbX2qqjt7JJdZS9CswPBo2fXich-7yYgKyd0A@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] HID: logitech: Support WirelessDeviceStatus
 connect events
To:     Mazin Rezk <mnrzk@protonmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
X-MC-Unique: 5bRFKRJzNBmsC3M5Ae6RGw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 2:58 AM Mazin Rezk <mnrzk@protonmail.com> wrote:
>
> On Saturday, October 5, 2019 9:05 PM, Mazin Rezk <mnrzk@protonmail.com> w=
rote:
>
> > This patch makes WirelessDeviceStatus (0x1d4b) events get detected as
> > connection events on devices with HIDPP_QUIRK_WIRELESS_DEVICE_STATUS.
> >
> > This quirk is currently an alias for HIDPP_QUIRK_CLASS_BLUETOOTH since
> > the added Bluetooth devices do not support regular connect events.
>
> No changes have been made to this patch in v4.
>
> Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 2062be922c08..b2b5fe2c74db 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -84,6 +84,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
>
>  /* Just an alias for now, may possibly be a catch-all in the future */
>  #define HIDPP_QUIRK_MISSING_SHORT_REPORTS      HIDPP_QUIRK_CLASS_BLUETOO=
TH
> +#define HIDPP_QUIRK_WIRELESS_DEVICE_STATUS     HIDPP_QUIRK_CLASS_BLUETOO=
TH

Hmm, I don't like the idea of aliasing quirks on a class. Either it's
a class of devices, and you use it as such in the code, either you
want to use individual quirks, and so each one of those needs its own
bit definition.

If you take my advice in 2/4, please assign a new bit for
HIDPP_QUIRK_WIRELESS_DEVICE_STATUS (0x1f IIRC), and logically and it
on the HIDPP_QUIRK_CLASS_BLUETOOTH here.



>
>  #define HIDPP_QUIRK_DELAYED_INIT               HIDPP_QUIRK_NO_HIDINPUT
>
> @@ -406,9 +407,22 @@ static inline bool hidpp_match_error(struct hidpp_re=
port *question,
>             (answer->fap.params[0] =3D=3D question->fap.funcindex_clienti=
d);
>  }
>
> -static inline bool hidpp_report_is_connect_event(struct hidpp_report *re=
port)
> +#define HIDPP_PAGE_WIRELESS_DEVICE_STATUS              0x1d4b
> +
> +static inline bool hidpp_report_is_connect_event(struct hidpp_device *hi=
dpp,
> +                                                struct hidpp_report *rep=
ort)
>  {
> -       return (report->report_id =3D=3D REPORT_ID_HIDPP_SHORT) &&
> +       if (hidpp->quirks & HIDPP_QUIRK_WIRELESS_DEVICE_STATUS) {
> +               /* If feature is invalid, skip array check */
> +               if (report->fap.feature_index > hidpp->feature_count)
> +                       return false;

This should probably be merged with the next return (if bool0, return
false else return bool1 can easily be transformed into return !bool0
&& bool1)

> +
> +               return (hidpp->features[report->fap.feature_index] =3D=3D
> +                        HIDPP_PAGE_WIRELESS_DEVICE_STATUS);

Oh, so that's why you need the feature enumeration.

Though, it's a costly operation when you could simply:
- add a wireless_feature_index in struct hidpp_device,
- gets this feature index at probe with a single call to
hidpp_root_get_feature()
- and check here if this feature index of the report is not null and
equal to wireless_feature_index.

Cheers,
Benjamin

> +       }
> +
> +       return ((report->report_id =3D=3D REPORT_ID_HIDPP_SHORT) ||
> +               (hidpp->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS)) &&
>                 (report->rap.sub_id =3D=3D 0x41);
>  }
>
> @@ -3157,7 +3171,7 @@ static int hidpp_raw_hidpp_event(struct hidpp_devic=
e *hidpp, u8 *data,
>                 }
>         }
>
> -       if (unlikely(hidpp_report_is_connect_event(report))) {
> +       if (unlikely(hidpp_report_is_connect_event(hidpp, report))) {
>                 atomic_set(&hidpp->connected,
>                                 !(report->rap.params[0] & (1 << 6)));
>                 if (schedule_work(&hidpp->work) =3D=3D 0)
> --
> 2.23.0

