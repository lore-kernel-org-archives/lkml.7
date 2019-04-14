Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0847FC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36032084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jE3vBi7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfDNQii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:38:38 -0400
Received: from mout.web.de ([217.72.192.78]:35063 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfDNQih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1555259907;
        bh=FfS41OKkF9LftjWFvQaDoAYLm4ifKbz3rYhoKYfx5B4=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=jE3vBi7NpPL4PCY+qkeJQM5kvPmayaeV0UvWzSYXf5rPZXF1FHkhZnpxoebmbd8kH
         kHS6kXPi2vsF+mym2i1Jmt/rBL+2iXsnIHvzPa2qrtkePEZT7hirqzc9RZqwhT/w0Z
         31Eo7a6fp9bup22Wut+Herebtmoz6KpJ+NLjwPN8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.103.133]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LuLxD-1gpctI1Mu7-011ewh; Sun, 14
 Apr 2019 18:38:27 +0200
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
References: <1550928043-14889-12-git-send-email-Julia.Lawall@lip6.fr>
Subject: Re: [11/12] ARM: OMAP2+: add missing of_node_put after
 of_device_is_available
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <903ec107-46ed-f19f-56a7-c20031247503@web.de>
Date:   Sun, 14 Apr 2019 18:38:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1550928043-14889-12-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vxN9B38wSUUg0K+RJ6bUpBRpyb1jGlswd5roAVzexAAWjKKi1BP
 sIOLcGG+uV69UAsjCrrvXFbQqoUFlcqFL+FImb3rRIz7rb5pKoilS3um5bNU7yaKi5Gh3wT
 xo2WtadAQ5P2nn6gWdbgC5SyU5w76znlu8vSzarJRa8GZsyOTdxolHs9341uOa+D8bDDglY
 6mZ/OrmBx6QWDulJUBDzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fc8+cjLD+vA=:uVR45OvK/xTe142FlQ2d8d
 pdK6OMz+TpiumLILTu2vSKNgUYaChFu+70+iNnf7jCPjgQ5ZuObheiLs+9LtCUkXHxhv/muo5
 Gsy3cB9lHlw5dmc128w6Z4j0O484uZ7QjiFuTl0z1i4ekLrjaYlUjG5hAXsXbn/WYacd9WR8y
 V3iwFxAvK3bD3vn8biEt0i+I5EUHeN6V6PQyB9AO2AqvZAZUCowiLiOr9ZuTyXVIiNiVjF5t/
 YFD+1+wTYOG9jXuJdd73eRxQz+v7eQB8riXCF/X5oe36vCX1f9Yae6mA8W4NU1wQ8eNLjKWbU
 OTHlUesNJ3wSE/0E8+hs88PPtj1Vb+2u2PtjR3b8Fj6er5dXSUEP2iKBJPhsvDByu8x+t6OlA
 aEEBcG9agM7JGWf7Z1GWYHCB5XUUKVno4zy0Rrj6GT6Fz1YR2AdD99/HkyZEibVs2oNQG2jxD
 zdLTGSjvXdxWMgIqgwueWNCvIWlEmPzUIhZjvkKur18WCB3eZiERTS4nM27rnvYni62+N3Vml
 9vn/khFEXGHfaPBHw7W4AqpWz6jZ3xzW2ypbownZXlsCxCAhxLEWilSm7eXzj7xu1t/HpvBni
 BFc9NWMYehHd+b6C+3RQyhN8VpXjj4+5+mL4Horrsp/FqFaNYeqw38E5h9oybn6MXkRWygKEa
 K8VooUYTmeE5OiYqXXAvtorsrXI/VfFksr70sbMD6eJ8CHJhJIFgnJZHdlwEbLWU0cqAu0Tem
 swngsud/Tyn9TxFZWEGtZMsmOcTKUNCJXLeVvfGsKNLpTu2+APSgrlTGgzpY9DNIbNLBhMTpG
 m+gtWeI17OYBii10J7lWnc6kZVh7/IfDAK8k8iKZEQKGS5tUpx7P8q4mmjXmCghrzO0woap1q
 f4gmveX+Bqoodr9QYqfW/tR1hwBXjnXPslpual4RV0ThG1AGys/kEQu5zjQEXKrk8jQ98O9Vr
 GMTHTfP1Xy9skgdMDRVEXhKkJrOaTNhMZR4RF1H6TIrDp4b+ZSdZZUG6STIiuPG1oaB3EcBy8
 gChA+xr38t6ier30QU6CtfICgn/L5C3slqEV0CqA64iGxWUQ1T4zdQHh5AnBSB9hEB1wHwkUf
 sC5rNHfHOSY/5sqEEtyFT0kfuo5mhCZqp+7yj7s3j69QBHohz8hQOXwVw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -250,8 +250,10 @@ static int __init omapdss_init_of(void)
>  	if (!node)
>  		return 0;
>
> -	if (!of_device_is_available(node))
> +	if (!of_device_is_available(node)) {
> +		of_node_put(node);
>  		return 0;
> +	}
>
>  	pdev =3D of_find_device_by_node(node);

Is there a need to put the node also in subsequent if branches
for complete exception handling in this function implementation?

Regards,
Markus
