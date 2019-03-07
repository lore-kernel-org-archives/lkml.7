Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8075AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3AC20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="dIXWJydi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfCGLDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:03:18 -0500
Received: from office2.cesnet.cz ([195.113.144.244]:39882 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfCGLDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:03:18 -0500
Received: from localhost (unknown [IPv6:2001:718:1:2c:9077:1a3:d51f:f1d6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id BE13440005D;
        Thu,  7 Mar 2019 12:03:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2; t=1551956596;
        bh=4Ct9CIfAN+AfFxqS7cdF44TW53g3S1YgKvoPsbhKkoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dIXWJydiB88nm5aAbBDsGWd6uIW6P5KsVDH2k7kBMb527R6XJtLvGijDwmDkZip5a
         iBM/UTY6x/6/oXNIG0LQGWiffWzN83f0qQrr6tpUqiHK74TRT3qqQhyKtCgfKLbAaQ
         XMEReP746Wk4kkw/u8Fmyggf965HM0r2gduhkLxs=
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: max310x: Use =?iso-8859-1?Q?struct=5Fsize()_in_devm=5Fkzalloc()?=
Date:   Thu, 07 Mar 2019 12:03:15 +0100
MIME-Version: 1.0
Message-ID: <99ee4232-3d1c-470a-b406-16af30ca6990@cesnet.cz>
In-Reply-To: <20190104213913.GA21248@embeddedor>
References: <20190104213913.GA21248@embeddedor>
Organization: CESNET
User-Agent: Trojita/v0.7-377-g27bf90aa; Qt/5.11.0; xcb; Linux; Gentoo Base System release 2.4.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On p=C3=A1tek 4. ledna 2019 22:39:13 CET, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>     int stuff;
>     void *entry[];
> };
>
> instance =3D devm_kzalloc(dev, sizeof(struct foo) + sizeof(void=20
> *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance =3D devm_kzalloc(dev, struct_size(instance, entry,=20
> count), GFP_KERNEL);
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/tty/serial/max310x.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 4f479841769a..1d700a8ab517 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -1197,8 +1197,7 @@ static int max310x_probe(struct device=20
> *dev, struct max310x_devtype *devtype,
>  =09=09return PTR_ERR(regmap);
> =20
>  =09/* Alloc port structure */
> -=09s =3D devm_kzalloc(dev, sizeof(*s) +
> -=09=09=09 sizeof(struct max310x_one) * devtype->nr, GFP_KERNEL);
> +=09s =3D devm_kzalloc(dev, struct_size(s, p, devtype->nr), GFP_KERNEL);
>  =09if (!s) {
>  =09=09dev_err(dev, "Error allocating port structure\n");
>  =09=09return -ENOMEM;

Reviewed-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>
Tested-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>
