Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8760FCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D1120650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6oVzshA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407006AbfJWQI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:08:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26093 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390502AbfJWQI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571846906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j5F+WwyDO2ZtmwG6p6q1K0/ZlxsBaPFm9NQHC5+lRFs=;
        b=h6oVzshA03AOJiY/ZmZtXy7fsOr13M/Q0OFHP2D8tf8tSqCxyFEXzVmH21z4UfNBuRKdie
        MtB2ACNz5RbZU4kjbERwcXF2a5hs9OWtSgRL972X1CNAypB1ngkuJ0Sh+v4ulYQMZKwHsD
        gqOZFsmWxNXXE8llh8J66wGggguH/aE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-x_HO5n90Pca-5O3Eq_xSKg-1; Wed, 23 Oct 2019 12:08:25 -0400
Received: by mail-wr1-f70.google.com with SMTP id h4so11237132wrx.15
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 09:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xr8vxRZiOlLM4EoAX9LWK4R5e1B8TFG0+exomtADaEs=;
        b=KUNqNvi5FLfSzGmQEIMCM48DpXGD9fXDg5lFN90QY7LQBFXFxyQPdNasICp9RonoQy
         G/ZDM4gU92D/gxckwpg0cnoB03YEP06BPddnzIoZpzGwDQ1Ef+RHTeOg/q7TMtjGw2C/
         +pGFYNNPBkiAp8yCG+z5v3ofauf8cQyPIpaovG0uv7DVY3HyJSnCJpFZ5Ot745SKIPef
         bP5qNsEn/zxvw3jIiXgLox5VCJrz4/UzHs13rFXvxmpuvnH0d1dW1ZwIog4Ijle4nc1p
         UbnsPY7Np9fXdaNNX3Xc5ByKnfemZo8aIvLmOLsCQOg/EUwrFZ4jC+kmiT9ZMAd+qEvq
         XX8g==
X-Gm-Message-State: APjAAAU7Y3q8DuehGtbFArod6UuMmt5Ho7rUNSXxqtG+FrcuyNTY9Wk2
        ZalfBUmiZ+X8OG7jUMzIVx+EPHNQlxi/AQqckszWAvL5SFnlsDKRswjjSlLi5PXqKB6Fk3/SF2q
        69Tv5eQuuhwtb+WOo1rG7Ybqs
X-Received: by 2002:adf:ff81:: with SMTP id j1mr9117885wrr.98.1571846903397;
        Wed, 23 Oct 2019 09:08:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzyZNLo1G0I7rZ9aMH3XIzpFN6PoUIDdAVVRNGs3wm8HtHhAEjWh2Wad0+prs1sUts2jhXGbA==
X-Received: by 2002:adf:ff81:: with SMTP id j1mr9117859wrr.98.1571846903140;
        Wed, 23 Oct 2019 09:08:23 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id o70sm29138427wme.29.2019.10.23.09.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 09:08:22 -0700 (PDT)
Subject: Re: [PATCH] Add touchscreen platform data for the Schneider SCT101CTM
 tablet
To:     Daniel Gorbea Ainz <danielgorbea@hotmail.com>
Cc:     "dvhart@infradead.org" <dvhart@infradead.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <VI1PR10MB2574F4636A90613136ACF4BED86B0@VI1PR10MB2574.EURPRD10.PROD.OUTLOOK.COM>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <05eec4e5-927c-fdd6-037b-71520e149d5b@redhat.com>
Date:   Wed, 23 Oct 2019 18:08:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <VI1PR10MB2574F4636A90613136ACF4BED86B0@VI1PR10MB2574.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
X-MC-Unique: x_HO5n90Pca-5O3Eq_xSKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23-10-2019 17:23, Daniel Gorbea Ainz wrote:
> Add touchscreen platform data for the Schneider SCT101CTM tablet
>=20
> Signed-off-by: Daniel Gorbea <danielgorbea@hotmail.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Daniel, I received your patch just fine, shall I resend
it to the list for you ?

Regards,

Hans




> ---
>   drivers/platform/x86/touchscreen_dmi.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x8=
6/touchscreen_dmi.c
> index 1c7d8324f..8baaf0dfa 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -498,6 +498,24 @@ static const struct ts_dmi_data pov_mobii_wintab_p10=
06w_v10_data =3D {
>   =09.properties=09=3D pov_mobii_wintab_p1006w_v10_props,
>   };
>  =20
> +static const struct property_entry schneider_sct101ctm_props[] =3D {
> +=09PROPERTY_ENTRY_U32("touchscreen-size-x", 1715),
> +=09PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
> +=09PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
> +=09PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +=09PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> +=09PROPERTY_ENTRY_STRING("firmware-name",
> +=09=09=09      "gsl1680-schneider-sct101ctm.fw"),
> +=09PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +=09PROPERTY_ENTRY_BOOL("silead,home-button"),
> +=09{ }
> +};
> +
> +static const struct ts_dmi_data schneider_sct101ctm_data =3D {
> +=09.acpi_name=09=3D "MSSL1680:00",
> +=09.properties=09=3D schneider_sct101ctm_props,
> +};
> +
>   static const struct property_entry teclast_x3_plus_props[] =3D {
>   =09PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
>   =09PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
> @@ -908,6 +926,14 @@ static const struct dmi_system_id touchscreen_dmi_ta=
ble[] =3D {
>   =09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "0E57"),
>   =09=09},
>   =09},
> +=09{
> +=09=09/* Schneider SCT101CTM */
> +=09=09.driver_data =3D (void *)&schneider_sct101ctm_data,
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Default string"),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "SCT101CTM"),
> +=09=09},
> +=09},
>   =09{
>   =09=09/* Teclast X3 Plus */
>   =09=09.driver_data =3D (void *)&teclast_x3_plus_data,
>=20

