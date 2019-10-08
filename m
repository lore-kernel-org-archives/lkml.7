Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85166C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E2220815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="al7Erghl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbfJHNDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:03:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47940 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730876AbfJHNDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570539798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxmMftRW33ilmvHEF4q513oM2n5F6dAceKEAMgpG0is=;
        b=al7ErghlelD7SkQVt6k73xa/ZecNJ9mEmY34g0moIqtSRYQyPLC1ngZH7cArp7M8YQugST
        yNQwX+c+QvfB4pT+PQuWJxx/XjryO4Vqxx5zmkCkDNw0iW70kFw1h8tq2THSs14eNlotG/
        xcBRirzxDe0F7jeZ3RxGmUoeXumYPqw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-biFnbf6hP6SY3eM43OICEw-1; Tue, 08 Oct 2019 09:03:16 -0400
Received: by mail-wm1-f71.google.com with SMTP id o128so1048861wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 06:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kwfb3UTIvU2cGizqrnufWeXc1wS5svvR5Zo+8/126Po=;
        b=PBfp4Cnn0AxgccTyuT/v888xk/8G812Z0Sn6hC30FFeB8AncGysuslNc4fvtWYljlv
         DKcdcx+Pcrep3Pkn50S9Nwyp7HKkCj8qr49zYP8nTuUrIFVhcs5tQH00UrGtD1lYPxxs
         e12k11p2iTH5dPEwpXkB77dEq07v57Pweiz9j61lTYFUIXJH8G1lSeUp3kgk7HEqlbSk
         lgk1DTU8pNGyNI+y0QlcBvZzEluiLwXpTIZln/EqrONyxWmW+k+Em6S7xvfJ/z08kS3D
         2I7dukTYPRqNikoYPxxWuj5ruPLZ5PgO/egqPvCJ+ctyQdDuN22KQOajq4CSLybomoAN
         XUfQ==
X-Gm-Message-State: APjAAAXjQGcE502qXDp6q77DIQ+wZituITLYJz5KIhi6SgWeDsMChuMb
        IchlFu60RVgEZMls5BB7v027wMLfB8pcz4u/fVhY/SdYEOyBqVcrmsJWEOZvkvv+wg/mbo0TOE7
        TP/xHTStmakS2OIYtKltWqrhw
X-Received: by 2002:adf:9788:: with SMTP id s8mr24547825wrb.123.1570539795028;
        Tue, 08 Oct 2019 06:03:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw0DpB3v9g0M+22at0sVGbIN0Mzw5ciphF17zruCFbCOO1LrtxBueQb7h8rBK/F6qE9Hm+TDA==
X-Received: by 2002:adf:9788:: with SMTP id s8mr24547787wrb.123.1570539794791;
        Tue, 08 Oct 2019 06:03:14 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id y186sm6647679wmd.26.2019.10.08.06.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 06:03:13 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: peaq-wmi: switch to using polled mode of
 input devices
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191001185822.GA48020@dtor-ws>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bb766307-2d9c-fc6d-588a-9394a2b852e8@redhat.com>
Date:   Tue, 8 Oct 2019 15:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191001185822.GA48020@dtor-ws>
Content-Language: en-US
X-MC-Unique: biFnbf6hP6SY3eM43OICEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01-10-2019 20:58, Dmitry Torokhov wrote:
> We have added polled mode to the normal input devices with the intent of
> retiring input_polled_dev. This converts peaq-wmi driver to use the
> polling mode of standard input devices and removes dependency on
> INPUT_POLLDEV.
>=20
> Because the new polling coded does not allow peeking inside the poller
> structure to get the poll interval, we change the "debounce" process to
> operate on the time basis, instead of counting events.
>=20
> We also fix error handling during initialization, as previously we leaked
> input device structure when we failed to register it.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Patch looks good to me and I've also given this a test-run on the
hw which uses this driver:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>=20
> v2: include input.h instead of input-polldev.h
>=20
>   drivers/platform/x86/Kconfig    |  1 -
>   drivers/platform/x86/peaq-wmi.c | 66 +++++++++++++++++++++------------
>   2 files changed, 42 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index f0a93f630455..c703c78c59f3 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -804,7 +804,6 @@ config PEAQ_WMI
>   =09tristate "PEAQ 2-in-1 WMI hotkey driver"
>   =09depends on ACPI_WMI
>   =09depends on INPUT
> -=09select INPUT_POLLDEV
>   =09help
>   =09 Say Y here if you want to support WMI-based hotkeys on PEAQ 2-in-1s=
.
>  =20
> diff --git a/drivers/platform/x86/peaq-wmi.c b/drivers/platform/x86/peaq-=
wmi.c
> index fdeb3624c529..cf9c44c20a82 100644
> --- a/drivers/platform/x86/peaq-wmi.c
> +++ b/drivers/platform/x86/peaq-wmi.c
> @@ -6,7 +6,7 @@
>  =20
>   #include <linux/acpi.h>
>   #include <linux/dmi.h>
> -#include <linux/input-polldev.h>
> +#include <linux/input.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>  =20
> @@ -18,8 +18,7 @@
>  =20
>   MODULE_ALIAS("wmi:"PEAQ_DOLBY_BUTTON_GUID);
>  =20
> -static unsigned int peaq_ignore_events_counter;
> -static struct input_polled_dev *peaq_poll_dev;
> +static struct input_dev *peaq_poll_dev;
>  =20
>   /*
>    * The Dolby button (yes really a Dolby button) causes an ACPI variable=
 to get
> @@ -28,8 +27,10 @@ static struct input_polled_dev *peaq_poll_dev;
>    * (if polling after the release) or twice (polling between press and r=
elease).
>    * We ignore events for 0.5s after the first event to avoid reporting 2=
 presses.
>    */
> -static void peaq_wmi_poll(struct input_polled_dev *dev)
> +static void peaq_wmi_poll(struct input_dev *input_dev)
>   {
> +=09static unsigned long last_event_time;
> +=09static bool had_events;
>   =09union acpi_object obj;
>   =09acpi_status status;
>   =09u32 dummy =3D 0;
> @@ -44,22 +45,25 @@ static void peaq_wmi_poll(struct input_polled_dev *de=
v)
>   =09=09return;
>  =20
>   =09if (obj.type !=3D ACPI_TYPE_INTEGER) {
> -=09=09dev_err(&peaq_poll_dev->input->dev,
> +=09=09dev_err(&input_dev->dev,
>   =09=09=09"Error WMBC did not return an integer\n");
>   =09=09return;
>   =09}
>  =20
> -=09if (peaq_ignore_events_counter && peaq_ignore_events_counter--)
> +=09if (!obj.integer.value)
>   =09=09return;
>  =20
> -=09if (obj.integer.value) {
> -=09=09input_event(peaq_poll_dev->input, EV_KEY, KEY_SOUND, 1);
> -=09=09input_sync(peaq_poll_dev->input);
> -=09=09input_event(peaq_poll_dev->input, EV_KEY, KEY_SOUND, 0);
> -=09=09input_sync(peaq_poll_dev->input);
> -=09=09peaq_ignore_events_counter =3D max(1u,
> -=09=09=09PEAQ_POLL_IGNORE_MS / peaq_poll_dev->poll_interval);
> -=09}
> +=09if (had_events && time_before(jiffies, last_event_time +
> +=09=09=09=09=09msecs_to_jiffies(PEAQ_POLL_IGNORE_MS)))
> +=09=09return;
> +
> +=09input_event(input_dev, EV_KEY, KEY_SOUND, 1);
> +=09input_sync(input_dev);
> +=09input_event(input_dev, EV_KEY, KEY_SOUND, 0);
> +=09input_sync(input_dev);
> +
> +=09last_event_time =3D jiffies;
> +=09had_events =3D true;
>   }
>  =20
>   /* Some other devices (Shuttle XS35) use the same WMI GUID for other pu=
rposes */
> @@ -75,6 +79,8 @@ static const struct dmi_system_id peaq_dmi_table[] __in=
itconst =3D {
>  =20
>   static int __init peaq_wmi_init(void)
>   {
> +=09int err;
> +
>   =09/* WMI GUID is not unique, also check for a DMI match */
>   =09if (!dmi_check_system(peaq_dmi_table))
>   =09=09return -ENODEV;
> @@ -82,24 +88,36 @@ static int __init peaq_wmi_init(void)
>   =09if (!wmi_has_guid(PEAQ_DOLBY_BUTTON_GUID))
>   =09=09return -ENODEV;
>  =20
> -=09peaq_poll_dev =3D input_allocate_polled_device();
> +=09peaq_poll_dev =3D input_allocate_device();
>   =09if (!peaq_poll_dev)
>   =09=09return -ENOMEM;
>  =20
> -=09peaq_poll_dev->poll =3D peaq_wmi_poll;
> -=09peaq_poll_dev->poll_interval =3D PEAQ_POLL_INTERVAL_MS;
> -=09peaq_poll_dev->poll_interval_max =3D PEAQ_POLL_MAX_MS;
> -=09peaq_poll_dev->input->name =3D "PEAQ WMI hotkeys";
> -=09peaq_poll_dev->input->phys =3D "wmi/input0";
> -=09peaq_poll_dev->input->id.bustype =3D BUS_HOST;
> -=09input_set_capability(peaq_poll_dev->input, EV_KEY, KEY_SOUND);
> +=09peaq_poll_dev->name =3D "PEAQ WMI hotkeys";
> +=09peaq_poll_dev->phys =3D "wmi/input0";
> +=09peaq_poll_dev->id.bustype =3D BUS_HOST;
> +=09input_set_capability(peaq_poll_dev, EV_KEY, KEY_SOUND);
> +
> +=09err =3D input_setup_polling(peaq_poll_dev, peaq_wmi_poll);
> +=09if (err)
> +=09=09goto err_out;
> +
> +=09input_set_poll_interval(peaq_poll_dev, PEAQ_POLL_INTERVAL_MS);
> +=09input_set_max_poll_interval(peaq_poll_dev, PEAQ_POLL_MAX_MS);
> +
> +=09err =3D input_register_device(peaq_poll_dev);
> +=09if (err)
> +=09=09goto err_out;
> +
> +=09return 0;
>  =20
> -=09return input_register_polled_device(peaq_poll_dev);
> +err_out:
> +=09input_free_device(peaq_poll_dev);
> +=09return err;
>   }
>  =20
>   static void __exit peaq_wmi_exit(void)
>   {
> -=09input_unregister_polled_device(peaq_poll_dev);
> +=09input_unregister_device(peaq_poll_dev);
>   }
>  =20
>   module_init(peaq_wmi_init);
>=20

