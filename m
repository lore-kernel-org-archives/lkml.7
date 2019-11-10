Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69BFC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 18:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F042077C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 18:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0LpdoVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfKJSAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 13:00:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53740 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726800AbfKJSAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 13:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573408817;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hixz/IzNhB0JpEt6Ya+nzMEp0JX0n9HHRljmP2H+u7k=;
        b=D0LpdoVmmNrPKpfZoR/SlXNnE1+S9dMHjULcfWQ96A+BwAirOWXABHgDyDVUmyqZ/UnhFz
        LOQndWPDiwTZsnycNdkpEYdcZjZnfEv5tuZ24kDoaaKP6iaL2KrWEQomQouXUO/ZKXsfmX
        fGCLF6jODld2OeBHgYGT/e4y+vIcwZ0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-jlxO3uNUNXaIlyT9tSvhCw-1; Sun, 10 Nov 2019 13:00:13 -0500
Received: by mail-pl1-f199.google.com with SMTP id a11so8880186plp.21
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 10:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Um2+4ViHEGLtX+G0u5WhQV8LmjxfVLK7h3RGaAChVEk=;
        b=fi8HqtVwUXpvCFHIgOWQGuwWTG+H/M315QkSkCbORra+M17uNxoJ/C9UrLvwIMtFY3
         aJclJ/zHIPED10h/oo9KWDXa03Sh2wNUFLvn9Pgj0mLf4eKpHn9ByZE+z1msHqGmXu9E
         XzO0m7MH2u6ULO9qrXyG6fgULHBJU6EbXCbP4fdd9K/+x6Zbp4iSxc7Q5EhQUx8qp9X9
         80V9dwCwjq7bpixXLay4j0OubYLcSZCxITuohWqwaTnzcWtMscueFbMJ+B2oco7jxizc
         RHn1cPDN3QLxdzyqlRle/chIIZjU5I4fswIhEaJUXysXeFASPRq6VVI3G8ehAE64zTL4
         STHg==
X-Gm-Message-State: APjAAAWGLlxEmIfNyO6SOfLh2XJjmojz2tQm2m1UzGcealmOo07lNLXY
        j8eGXgs2dSuWsms33zeFO98KNbdc+7KNcAQFL/yYVPOh5XCP3AuQEnRoqdNoXC+M16lj0XDkV+C
        Ib77c/9b5XCfq0S4JmyG3okVn
X-Received: by 2002:a17:902:b20b:: with SMTP id t11mr22199287plr.211.1573408812856;
        Sun, 10 Nov 2019 10:00:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqyfWm4OglYklA+A7wQRUWJBtP0mHnD6YYVjbFQFg9Q6GxMN0YxEL0MKIhZn8HxYbk8Q0luQ3A==
X-Received: by 2002:a17:902:b20b:: with SMTP id t11mr22199248plr.211.1573408812514;
        Sun, 10 Nov 2019 10:00:12 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id 27sm12289493pgx.23.2019.11.10.10.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 10:00:11 -0800 (PST)
Date:   Sun, 10 Nov 2019 11:00:10 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     amirmizi6@gmail.comg, Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        ayna@linux.vnet.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hagar@nuvoton.com,
        amir.mizinski@nuvoton.com
Subject: Re: [PATCH v1 3/5] char: tpm: rewrite "tpm_tis_req_canceled()"
Message-ID: <20191110180010.xyvv4gf6jiqyrac3@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: amirmizi6@gmail.comg,
        Stefan Berger <stefanb@linux.vnet.ibm.com>, Eyal.Cohen@nuvoton.com,
        jarkko.sakkinen@linux.intel.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        ayna@linux.vnet.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hagar@nuvoton.com,
        amir.mizinski@nuvoton.com
References: <20191110162137.230913-1-amirmizi6@gmail.com>
 <20191110162137.230913-4-amirmizi6@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191110162137.230913-4-amirmizi6@gmail.com>
X-MC-Unique: jlxO3uNUNXaIlyT9tSvhCw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Nov 10 19, amirmizi6@gmail.com wrote:
>From: Amir Mizinski <amirmizi6@gmail.com>
>
>using this function while read/write data resulted in aborted operation.
>after investigating according to TCG TPM Profile (PTP) Specifications,
>i found cancel should happen only if TPM_STS.commandReady bit is lit
>and couldn't find a case when the current condition is valid.
>also only cmdReady bit need to be compared instead of the full lower statu=
s register byte.
>
>Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
>---
> drivers/char/tpm/tpm_tis_core.c | 12 +-----------
> 1 file changed, 1 insertion(+), 11 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_co=
re.c
>index ce7f8a1..9016f06 100644
>--- a/drivers/char/tpm/tpm_tis_core.c
>+++ b/drivers/char/tpm/tpm_tis_core.c
>@@ -627,17 +627,7 @@ static int probe_itpm(struct tpm_chip *chip)
>
> static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
> {
>-=09struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>-
>-=09switch (priv->manufacturer_id) {
>-=09case TPM_VID_WINBOND:
>-=09=09return ((status =3D=3D TPM_STS_VALID) ||
>-=09=09=09(status =3D=3D (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
>-=09case TPM_VID_STM:
>-=09=09return (status =3D=3D (TPM_STS_VALID | TPM_STS_COMMAND_READY));

Stefan were these cases you found that were deviating from the spec? Wonder=
ing
if dropping these will cause issues for these devices.

>-=09default:
>-=09=09return (status =3D=3D TPM_STS_COMMAND_READY);
>-=09}
>+=09return ((status & TPM_STS_COMMAND_READY) =3D=3D TPM_STS_COMMAND_READY)=
;
> }
>
> static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>--=20
>2.7.4
>

