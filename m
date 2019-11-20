Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0ADC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2722F2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ILqe56Cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbfKTOdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:33:31 -0500
Received: from mout.web.de ([212.227.15.4]:51723 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729591AbfKTOda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574260403;
        bh=2MrLrsO6sGgptaX4SCeVRo9JKmeFn7RzXSUexQzyB3Q=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=ILqe56Cu/ibOgOVVu3RMi4E1TLITYDRnJNABE0mlmsbDDsPBgVgQaW39T/QpPNyfo
         otFvL4+rVSzL93v2CKnmPFha9HC+sZSLiOaR/qxsqFFR2WxbpObDNi11wtTwxFFZil
         PSEjMYG42EJNE5WdjC3EqsYZTHNqx65Dtt/wLdUs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.176.80]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6UiB-1hen1N39S7-00ySVk; Wed, 20
 Nov 2019 15:33:22 +0100
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <1574197705-31132-2-git-send-email-Julia.Lawall@lip6.fr>
Subject: Re: [PATCH 1/4 v2] coccinelle: platform_get_irq: simplify context
 case
To:     Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <072b7936-669b-e299-ba10-4f0d4ab4f080@web.de>
Date:   Wed, 20 Nov 2019 15:33:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1574197705-31132-2-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H6wAn9DnY6EpmfZ4ToBmvgVJLwZhbbVnnCoOo62BVEBMJ2KpkaJ
 O+fxEhafWytcujbnz0MbnixMQaLX/u45CSD5ho0N34penHs97fN8EN0ujelmVA/gtWxqEj/
 9XEnVU7ouaJ8Mm4BLlhijqaFKI+3bj07N1gO75p/CtRmsvXQbjpPYjTYeRMN49MJKVQdXEf
 AcBoQpPhfezdyyAYHjysQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aLwXHwVTEJA=:iuwSp09e/rqGQTNqSHO9I0
 Mb6g1O43ciVFqU7YfwGBlRWBY6+bjjwwgvhRhxHU40AzGleWrVv7xS7sLtLO8405X51cOqgIl
 op6qED64402ZPM8tXTevIj+iRzV74Egnw4ibd+1vr428ldzXxvg9IZT2DT7oCq5UHoPvQSwRp
 PU1KkS4M52baXbWfK0lZm/PycvFNLLudq/D+l7IpC0R3cRGwjgurIdoBDYTz3Y8GTVPPn7Hy6
 ucKlSSITn1gpAD7XYkEQhpZv5Q0edF7GoiCDfPXvPyVdK2pyZ7ojxK5yO+ReHKV1QctsXQJpg
 jVmW5fvJwN9o/Kz/k6K92Wg9zZCf/SfzJTVT6gDDeCJsI3JcpML7GFtye9M8uhLpUDarc0J+D
 eH67VBrZeVGGi/KNcgT05bxhrGKy5ROM9OtULn/5mAb1jSu+8BWFGS2BxDNE/FX+JFePAQpik
 mjIyHqmBxt3QJybf98Bhi4g4mcK/TJTy/SAU0VSlM9HUTnqcGTGPRLhxkgfnQ0QLMZLFQTh4O
 l4af8ujYeW9JddYT8ubB65SmOXOCj5vENgM/FfAA2U4CPPh2GJoNtnUiMym6CZsS7BJbatAXn
 1BU5AZ+AWtNYGGP6EhqXs/RYWp7hUFTst2R/2dU6AIJuKMXne0wjwmW/Q4wNEBKphwusHlJMB
 F7JtoOn49Led02aqt9nbxtC1UiDplXvMDlk6x3JI6NT2JDUDRpl+1T9cd9cK6fnLuBllY/+WO
 jqmDIbEN4ec6p+4k9ymic6mvlOlQEZg5/A0PBxx47lBWP0WQPGyhr5QnNx4HsR2NSkit0CIqd
 YzuoJduotLP5zCjpfTivpPVftiSl3pQKfOey7UrJiqHq94MS2kh0oQ1At9o4jkBFTn9gAdWMe
 IMJcpF05xNHv8MNoyY60uiwGWWKuZrIA0P6wssFf1+Ex5S7P82c4p7AWbJGGwtOMUAt9ejLF0
 CmnoRscODZU4JDGo1J9jvKwZqLDsYVHiWAQkSUfRxbJjLPQC+rYnlVqGTbmUVOKOREjRFAm0C
 kY3/XzaZhRpHxOtOT94gHTIHYzoTpS3BQBk0etivSDCbf801DhfR2LVERmRS8QZNKtkCZlDQu
 GWhVxWgzp/YfG6iH+Y6omYL0xqsQ0V//9Y437D0FkXxazk4I9CbshQRmzUMnjfXYnCdaQFRnv
 RzHT5frfdPzjDd7C2gGY2os1Mpd6l3JnpinIxAQlVXiZuKf5JndAg7gG/KlTvplIsdVnJaJEJ
 906R+N2sSOdUtAS8egYrTmrd3wX/rt4migEKj0vLoJL3b1pviG4NYVmGTxDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  if ( \( ret < 0 \| ret <=3D 0 \) )

Can it make sense to specify the comparison by a constraint for
a metavariable of the type =E2=80=9Cbinary operator=E2=80=9D instead of a =
SmPL disjunction?

Regards,
Markus
