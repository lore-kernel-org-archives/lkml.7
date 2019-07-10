Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CA7C004EF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861E320693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="oGObuqhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfGJJGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 05:06:00 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:39082 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726580AbfGJJF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 05:05:59 -0400
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2019 05:05:57 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 33068404CB;
        Wed, 10 Jul 2019 08:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:in-reply-to:mime-version:user-agent
        :date:date:message-id:organization:from:from:references:subject
        :subject:received:received:received; s=mta-01; t=1562749046; x=
        1564563447; bh=LhWEa2Id3LIYjkm9wZEFKYi5Dtn9EgTe/6BhUhNP2Sw=; b=o
        GObuqhYQ7J4gMv+t5L6pTJyA3R5RIoCdh4eg0zOiIhFqSN3T0fQ15iQbHBOQHzK/
        LJnWLJfmZyCRTJCSa4bS1Z5u6U6ElB5XXpUEk05pMkYD7RCIxPVdt0Q1doKv9In7
        VdrmbtpP5l5ubk+x/NMlRvi7umNR6BGYy7WT8W02OM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6E_ZYmdHbjt7; Wed, 10 Jul 2019 11:57:26 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 77BB341209;
        Wed, 10 Jul 2019 11:57:26 +0300 (MSK)
Received: from [172.17.14.197] (172.17.14.197) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 10
 Jul 2019 11:57:25 +0300
Subject: Re: [PATCH] hwmon (occ): Add temp sensor value check
To:     Joel Stanley <joel@jms.id.au>
CC:     Guenter Roeck <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Lei YU <mine260309@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20190710072606.4849-1-joel@jms.id.au>
From:   Alexander Amelkin <a.amelkin@yadro.com>
Openpgp: preference=signencrypt
Autocrypt: addr=a.amelkin@yadro.com; prefer-encrypt=mutual; keydata=
 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
 dTYsE5wSxM06T2l/MILupCNZ7A==
Organization: YADRO
Message-ID: <d8617f81-ed54-1d5f-de93-abf5410c4a78@yadro.com>
Date:   Wed, 10 Jul 2019 11:57:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190710072606.4849-1-joel@jms.id.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="nrdfzVufGHCEucwqkkiYbemcIzvnNchnH"
X-Originating-IP: [172.17.14.197]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nrdfzVufGHCEucwqkkiYbemcIzvnNchnH
Content-Type: multipart/mixed; boundary="2dQYpAQWAa888nHozIP3eb5YJVbiYgjlr";
 protected-headers="v1"
From: Alexander Amelkin <a.amelkin@yadro.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
 Eddie James <eajames@linux.ibm.com>, Lei YU <mine260309@gmail.com>,
 linux-kernel@vger.kernel.org
Message-ID: <d8617f81-ed54-1d5f-de93-abf5410c4a78@yadro.com>
Subject: Re: [PATCH] hwmon (occ): Add temp sensor value check
References: <20190710072606.4849-1-joel@jms.id.au>
In-Reply-To: <20190710072606.4849-1-joel@jms.id.au>

--2dQYpAQWAa888nHozIP3eb5YJVbiYgjlr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Thanks, Joel!

JFYI, Alexander Soldatov has left the YADRO team some time ago, so his e-=
mail @yadro.com isn't valid anymore.

Should anyone have any questions regarding this patch, feel free to email=
 me.

With best regards,
Alexander Amelkin,
Leading BMC Software Engineer, YADRO
https://yadro.com

10.07.2019 10:26, Joel Stanley wrote:
> From: Alexander Soldatov <a.soldatov@yadro.com>
>
> The occ driver supports two formats for the temp sensor value.
>
> The OCC firmware for P8 supports only the first format, for which
> no range checking or error processing is performed in the driver.
> Inspecting the OCC sources for P8 reveals that OCC may send
> a special value 0xFFFF to indicate that a sensor read timeout
> has occurred, see
>
> https://github.com/open-power/occ/blob/master_p8/src/occ/cmdh/cmdh_fsp_=
cmds.c#L395
>
> That situation wasn't handled in the driver. This patch adds invalid
> temp value check for the sensor data format 1 and handles it the same
> way as it is done for the format 2, where EREMOTEIO is reported for
> this case.
>
> Fixes: 54076cb3b5ff ("hwmon (occ): Add sensor attributes and register h=
wmon device")
> Signed-off-by: Alexander Soldatov <a.soldatov@yadro.com>
> Signed-off-by: Alexander Amelkin <a.amelkin@yadro.com>
> Reviewed-by: Alexander Amelkin <a.amelkin@yadro.com>
> Reviewed-by: Eddie James <eajames@linux.ibm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/hwmon/occ/common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index cccf91742c1a..a7d2b16dd702 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -241,6 +241,12 @@ static ssize_t occ_show_temp_1(struct device *dev,=

>  		val =3D get_unaligned_be16(&temp->sensor_id);
>  		break;
>  	case 1:
> +		/*
> +		 * If a sensor reading has expired and couldn't be refreshed,
> +		 * OCC returns 0xFFFF for that sensor.
> +		 */
> +		if (temp->value =3D=3D 0xFFFF)
> +			return -EREMOTEIO;
>  		val =3D get_unaligned_be16(&temp->value) * 1000;
>  		break;
>  	default:


--2dQYpAQWAa888nHozIP3eb5YJVbiYgjlr--

--nrdfzVufGHCEucwqkkiYbemcIzvnNchnH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJdJah1AAoJEOiTWHtbdBeN25oQALdidpJJ0OPk2zG00XUGJssP
nVfissnr3GF0AsBTtIMuLqziS75dPq1OY/uW36+EOKdazXOMH0rkD3llhd1i9Wl3
8CJ04XpOE+eNRcGe77SBcxEwyh0+71A9KiIm3lG2tRb0k8O29Adx9//gJ+rGziwg
Z+Qb9uYttU7jTp7ojqRyoRs71w7b4zstE0AmQTg5tyqEt0hbtUBgnD/sNpsxIvMk
+PxJ7o6LaP++AOZR5XBLFtanXgjIxKKdmeGc3RayyWh0IYd5KuERaqFBqICKhPXE
kmntiIcs99vFzu6lwVp3Y6qxcYEWl5aohIlWEycip7MtTeaUk1v5rRqTFeGVN1SQ
hdo0cfboSzT2s/sDg5ky8Qq0+ycANdRaoMYWoZoo7kldWBKGg2YsGAT89WQOXrZb
Ce8LaMJOqxS6EKWXTt3gaIlwAR3vSrVJrK++h20dePfYoXfPE0cS/BvHL71DzG4O
5XlkIw5G1MTAn0cAkC48vcSw+9fZRNGXXNQY0avVlfstG+b3fVLQO5WRNhiChLJw
Ex/L8W2RH7TvTMlycxOtjzKjhjJ/1O5moe1f3MG29D1ywVY/OsgILkLZkZx3AVLZ
XBOmmD79lVyWouDq9n30ahVvy+k2CYap8q4vbe9D/ykujjI453USC+XwR8DW8i/n
ZxnvnTJCkp69jYRbQlad
=lmWr
-----END PGP SIGNATURE-----

--nrdfzVufGHCEucwqkkiYbemcIzvnNchnH--
