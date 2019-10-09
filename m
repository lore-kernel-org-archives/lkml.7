Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EEDECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA6B20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eODIBGQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfJIJfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:35:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25546 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725942AbfJIJfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570613739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wIiSU13TZ9jZ/7OA/RD49mIlEHsSk7raamqZN0rBDDk=;
        b=eODIBGQqCXTVEr2XhiebbpB53Q/3zKTQWwvsSLVvTPFLF5g6SVjt5Nu7GAWzwL4vLdpR8E
        KlUFS1xXToWB7Jm0dGouehe1fqEN5v95X20Lvw9ttTY3L2wzhAEnemaCHBQhL9Gf4jhC3R
        ADmxV6fP3mNnh6yVKeEWNAtIaUr95OI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-BR_jnFwrMc6LyOCfD7YDIA-1; Wed, 09 Oct 2019 05:35:35 -0400
Received: by mail-ed1-f69.google.com with SMTP id c23so1010105edb.14
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 02:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m+EOjV/VuUDotBWP2JnVujV9Hl44RjnHb49OdTmGiVo=;
        b=alKW9kRhImpwQW2OVjE+vaJYYhDBSgI8i4cYCR3LztaeGq48Js6LIYch94YxktS2N/
         cKbmBN+7WdX+w+y4fwqM0qJnoM4pwxESPzDl7s0A0Rtf6KIoP9eI/9x64Xij2BQ2VHup
         Lw0Xao/NRlmg5SYJikv5OCDu7JIgyAhTa2LzndH28QqW8HLrZ8SLcY/b4kRJEE2vJVWy
         Xm+D8CXAYJsJO0hD9jAmRXn1LbaPHHeZoqAyw/tlO74JOu/HEuKDutFBXpYgCXHi1+oC
         fKyiXLkvstSH0uneh+Flv9Q8OL8lpwvWd/HD4BDwIkF9y3paIKHmY3tMx/GltwtMh1q4
         xSZg==
X-Gm-Message-State: APjAAAUU47DYfCDm8k3DlUNV7E8fJeLjW4b/mmsxYry4TjZShBgr0P3x
        /Mdlpr+a1Fd9FbbWBxr+/rDIUMdlGg0m64L9EWL2alXRFG6YLT247vvyYNU7AL3Zi/QtCF3ztHM
        ukyzT+InLFhSQmkLBzfVI4va4
X-Received: by 2002:a05:6402:88d:: with SMTP id e13mr1973738edy.246.1570613734716;
        Wed, 09 Oct 2019 02:35:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxZmm9V3I2YhZskIm1cKbboIQy+yXFRdaHYKIvjJsZB5tj/g9zi5Ehci5uDueRmNCpIZouewQ==
X-Received: by 2002:a05:6402:88d:: with SMTP id e13mr1973726edy.246.1570613734526;
        Wed, 09 Oct 2019 02:35:34 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id l7sm271377edv.84.2019.10.09.02.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 02:35:33 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: hal: Fix memcpy calls
To:     Denis Efremov <efremov@linux.com>, devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Jes Sorensen <jes.sorensen@gmail.com>, stable@vger.kernel.org
References: <20190930110141.29271-1-efremov@linux.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <94af475e-dd7a-6066-146a-30a9915cd325@redhat.com>
Date:   Wed, 9 Oct 2019 11:35:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190930110141.29271-1-efremov@linux.com>
Content-Language: en-US
X-MC-Unique: BR_jnFwrMc6LyOCfD7YDIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

On 30-09-2019 13:01, Denis Efremov wrote:
> memcpy() in phy_ConfigBBWithParaFile() and PHY_ConfigRFWithParaFile() is
> called with "src =3D=3D NULL && len =3D=3D 0". This is an undefined behav=
ior.
> Moreover this if pre-condition "pBufLen && (*pBufLen =3D=3D 0) && !pBuf"
> is constantly false because it is a nested if in the else brach, i.e.,
> "if (cond) { ... } else { if (cond) {...} }". This patch alters the
> if condition to check "pBufLen && pBuf" pointers are not NULL.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Bastien Nocera <hadess@hadess.net>
> Cc: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: Jes Sorensen <jes.sorensen@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Not tested. I don't have the hardware. The fix is based on my guess.

Thsnk you for your patch.

So I've been doing some digging and this code normally never executes.

For this to execute the user would need to change the rtw_load_phy_file mod=
ule
param from its default of 0x44 (LOAD_BB_PG_PARA_FILE | LOAD_RF_TXPWR_LMT_PA=
RA_FILE)
to something which includes 0x02 (LOAD_BB_PARA_FILE) as mask.

And even with that param set for this code to actually do something /
for pBuf to ever not be NULL the following conditions would have to
be true:

1) Set the rtw_load_phy_file module param from its default of
    0x44 (LOAD_BB_PG_PARA_FILE | LOAD_RF_TXPWR_LMT_PARA_FILE) to something
    which includes 0x02 as mask; and
2) Set rtw_phy_file_path module parameter to say "/lib/firmware/"; and
3) Store a /lib/firmware/rtl8723b/PHY_REG.txt file in the expected format.

So I've come to the conclusion that all the phy_Config*WithParaFile functio=
ns
(and a bunch of stuff they use) can be removed.

I will prepare and submit a patch for this.

Regards,

Hans



>=20
>   drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/sta=
ging/rtl8723bs/hal/hal_com_phycfg.c
> index 6539bee9b5ba..0902dc3c1825 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> @@ -2320,7 +2320,7 @@ int phy_ConfigBBWithParaFile(
>   =09=09=09}
>   =09=09}
>   =09} else {
> -=09=09if (pBufLen && (*pBufLen =3D=3D 0) && !pBuf) {
> +=09=09if (pBufLen && pBuf) {
>   =09=09=09memcpy(pHalData->para_file_buf, pBuf, *pBufLen);
>   =09=09=09rtStatus =3D _SUCCESS;
>   =09=09} else
> @@ -2752,7 +2752,7 @@ int PHY_ConfigRFWithParaFile(
>   =09=09=09}
>   =09=09}
>   =09} else {
> -=09=09if (pBufLen && (*pBufLen =3D=3D 0) && !pBuf) {
> +=09=09if (pBufLen && pBuf) {
>   =09=09=09memcpy(pHalData->para_file_buf, pBuf, *pBufLen);
>   =09=09=09rtStatus =3D _SUCCESS;
>   =09=09} else
>=20

