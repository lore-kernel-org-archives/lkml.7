Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F31C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 06:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8709A21848
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 06:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOGLv3WH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392442AbfIQGXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 02:23:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53432 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391323AbfIQGXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 02:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568701399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zMiRk2ms4JfM5aLeMVQGGA4/MtjygVM42vaH00zzKKY=;
        b=gOGLv3WHuq5GRmg6b0G3aR+iF60Mp/8ZReBWzqBzFtYxtGN7YaKTCr5lvjXHHjMoSMDyiJ
        uDimkDzg38SH5sMd0Sd+94VHV0Rxph5M1RitcrKM9z77fSLg5arNPiUPap6qDWcpplz/l5
        HOJII5QI0RkpZgRTJMyLRU59ow8MQic=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-tuYle47ePBK6Htqmk-LpDw-1; Tue, 17 Sep 2019 02:22:13 -0400
Received: by mail-ed1-f71.google.com with SMTP id s3so1442985edr.15
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 23:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HSlTRPtlogqHiN/XXzyRXMI4JrrjbmmMFYoLQL7idOQ=;
        b=nD4SA/C3Bd8tAt3uMOzhil7jOH/K7QAZjcn5ldIW5skYNQAto/B3K2I37WjIwIupdg
         Uj3ukTCadwNiSDLelnt84/BamYFTdyaBO0MjyN1osP6NyIxF9iewyjpQehBMifefbeyY
         3un642t23SyhT+a4208bN0MV464EwvVLO9SsaKYy594wVcSFgjMLQ6Y2fECWur8cOIfv
         sVzrjZcpcAcbHcDeGS6qQKg2D2aRhHkfZmINs9/cknLJQqKq8PLZ2R6hik6XvDV8uhDF
         jhYKEwo+y+jwBtrAmCt+uTmvLhuEdo91eY61wkr9mFvbxYxUThEY3cKvcAMjIBVcJXup
         NXMg==
X-Gm-Message-State: APjAAAVa+mngSYEADZ9iwHtQd9nPlIUpxPFZTv5feApcAu+68NypD3eW
        sN3nIQabTxk5K/GdwTZXmsZHS/6cY1x6jzaVOK3s4ij2O4iIVtgipSZKH6ERryD+SU0a5CeXW6V
        +EHvqQ8vG21vrr7dd5e7T33r5
X-Received: by 2002:a17:906:5214:: with SMTP id g20mr3211198ejm.220.1568701332165;
        Mon, 16 Sep 2019 23:22:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy4EMLl6CFmRRRSMzs8a9+t02q4uGESbCt01kO8AXuNOaaqmOzELPxpjk37tcFFPvHCWNLK2Q==
X-Received: by 2002:a17:906:5214:: with SMTP id g20mr3211189ejm.220.1568701331949;
        Mon, 16 Sep 2019 23:22:11 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id c22sm249266edc.9.2019.09.16.23.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 23:22:11 -0700 (PDT)
Subject: Re: [PATCH v2] extcon-intel-cht-wc: Don't reset USB data connection
 at probe
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190916211536.29646-1-jekhor@gmail.com>
 <20190916211536.29646-2-jekhor@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6579a7ed-f35d-7459-e1bd-c2d01d432407@redhat.com>
Date:   Tue, 17 Sep 2019 08:22:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190916211536.29646-2-jekhor@gmail.com>
Content-Language: en-US
X-MC-Unique: tuYle47ePBK6Htqmk-LpDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16-09-2019 23:15, Yauhen Kharuzhy wrote:
> Intel Cherry Trail Whiskey Cove extcon driver connect USB data lines to
> PMIC at driver probing for further charger detection. This causes reset o=
f
> USB data sessions and removing all devices from bus. If system was
> booted from Live CD or USB dongle, this makes system unusable.
>=20
> Check if USB ID pin is floating and re-route data lines in this case
> only, don't touch otherwise.
>=20
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



>   drivers/extcon/extcon-intel-cht-wc.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon=
-intel-cht-wc.c
> index 9d32150e68db..da1886a92f75 100644
> --- a/drivers/extcon/extcon-intel-cht-wc.c
> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> @@ -338,6 +338,7 @@ static int cht_wc_extcon_probe(struct platform_device=
 *pdev)
>   =09struct intel_soc_pmic *pmic =3D dev_get_drvdata(pdev->dev.parent);
>   =09struct cht_wc_extcon_data *ext;
>   =09unsigned long mask =3D ~(CHT_WC_PWRSRC_VBUS | CHT_WC_PWRSRC_USBID_MA=
SK);
> +=09int pwrsrc_sts, id;
>   =09int irq, ret;
>  =20
>   =09irq =3D platform_get_irq(pdev, 0);
> @@ -387,8 +388,19 @@ static int cht_wc_extcon_probe(struct platform_devic=
e *pdev)
>   =09=09goto disable_sw_control;
>   =09}
>  =20
> -=09/* Route D+ and D- to PMIC for initial charger detection */
> -=09cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
> +=09ret =3D regmap_read(ext->regmap, CHT_WC_PWRSRC_STS, &pwrsrc_sts);
> +=09if (ret) {
> +=09=09dev_err(ext->dev, "Error reading pwrsrc status: %d\n", ret);
> +=09=09goto disable_sw_control;
> +=09}
> +
> +=09id =3D cht_wc_extcon_get_id(ext, pwrsrc_sts);
> +
> +=09/* If no USB host or device connected, route D+ and D- to PMIC for
> +=09 * initial charger detection
> +=09 */
> +=09if (id !=3D INTEL_USB_ID_GND)
> +=09=09cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
>  =20
>   =09/* Get initial state */
>   =09cht_wc_extcon_pwrsrc_event(ext);
>=20

