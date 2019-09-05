Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BC0C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF43206CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IU5uIaah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbfIEOX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:23:56 -0400
Received: from mout.web.de ([217.72.192.78]:42193 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfIEOX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567693417;
        bh=vDcMhGqXGoYNbcDOrEA+uJ9Ezo8bs4BQHB/7eSujz0g=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=IU5uIaahpZfPBi/DGZ3HZmmSfqzcxaghXF5O8i5tIGmsyIBrw6CqDpvW26HajwD/m
         tPhisqQqzuPPbFsrMYWChnsP9hGCf+8VCT0ko3fnfWwBVcyJsEuwixA6kSVAO0P5TY
         pRsfuVqlfep4C0m57uws3dA99Z07NNRYs0pGT/2s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.131.221]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfAwe-1iUE3l0XLU-00oooT; Thu, 05
 Sep 2019 16:23:37 +0200
To:     Denis Efremov <efremov@linux.com>, kernel-janitors@vger.kernel.org,
        cocci@systeme.lip6.fr
Cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <20190904221223.5281-1-efremov@linux.com>
Subject: Re: [RFC PATCH] coccinelle: check for integer overflow in binary
 search
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a9fabfbe-d75e-ef40-c5e6-946c52344308@web.de>
Date:   Thu, 5 Sep 2019 16:23:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190904221223.5281-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1://RCTpDKoQr1MmnTTPGKGOFQii2zTC+j41g2/gifdw4N6IYu3GW
 yod9//MASwxVUh5vgQLODg+r8dQRAp7wnjsf/QOHIu5Nnjoel9ZEhJOk7STmkYqYyHu8RPq
 tfLhXpViqAzQEeR2Z8pYlAouK3cqEvplJJkCT+HaanEwAE4sw/PvBFb1T9e0YGGYVoyuipd
 Hi54IIEmawgTMe9QD3sCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xZW9mIaafbI=:50L862vc6lF0viDcqggF9v
 tIHH4C3NIgbQfGyzlKNgzLLd07OUmOKZ7eXi5B/hiLAuivZotZ5aPkwd/8a/La05r7gTs/FJq
 qF7MwaECzkd14USgFmA6RoVLScXWWgteyA5RcTyNEWePL2fi20FbCCIR3UPjxb/LpFjKytZA2
 p7liPcCAdgo6eo6Z+pCdNFy69UMOU6mBQUga4zDbOafBL10Epa/eFzYB6ysxXuqhyyTjQiLvj
 Y42kQVfNKB3luJLbMpPughLPql9Elh9a+uBPb+NCR9/PAcuxJNohj0eG0EUhybdFgouQ5HJDL
 aCC9lEBCCJXK52Bwy7mdtlDQ7XWg9ieYb6gpf9JR30NSV8VcP5rXyhM7Itm1nQEdMAZmMmaoO
 EXx2xQ9b7FOQkD5Jv1xc0p5w0NAxDZaXDCbztzXP4DaatfaRRaDKtZ8U6iTTiXIqaAuiRyosV
 cHYhs+wD5C48vFG0TJ5YqrswU0IYHp9p2Yqr+nov46X72egC11fsTX515M0lqotgtynvh+BCs
 thMuFNyo2NuN2NLe4jA1yGnLxddN94wJl8e2JJ6/rsZFBxfxN6XDp7Vv7aNyHiSq/3RJJL0RV
 fayWTRnyTmt23NBqByQ9ozNOCccZxuD7AHf5Wfcydju46cMK+L/7rWOZLEnmIN0DvVGwcw0hs
 1vZIYg/21wlyQ0WbAzSUbU8DlTvjDYWF790ZGJ5grLb6s/eOWtvFqbAEgGT0Vq/i2WjhD3AVG
 ei4UnFCn5PciCDZHY2YcEWRlPgQI3HntGqDWOl23Kqq4pi9IPrP7J8FVc8599rMqpCAB8avjM
 7oO6yrU7jnbYCPIv05J/eqP3++6f6P+69ITKDuJXQrHdT8xh6dzR9LkbgssqlKf76zTzkvkuv
 2Wft5tdKHMUd1C+9Hp0k/FWkOCm3rda3SIb/lyGkR2tPTCl0ClfiIg4P/qb4OPBMq0zidRtiA
 hjGkedW1qfsGimDhlCo8QlGzDkq8K1lbTZ5Jqg7sZ96t56gQRsOFGlo1OvT7/40jXfWdz4FP5
 cKXWbqHzc1uXMaibDtdOYxGo7XnIOcE7iILDoX2M8S/fnUPPz9HwWyVw8BZUG6bBR3kVvHyb2
 gpfIFVKRc6ZSqqiIP3ox6Lwpj72cUeCLncZTrA3Y8lhtwTzeFYWBhF9fr2M1jcpHfbnxrwyST
 JZOlI0ggJm6vRJYW6ve7LQ8/N1Wyls5De7/ORevP7XMmvUSZYi6itXzcO4WDwY0hute4orXkg
 74dFqcndYF2lLX4TB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +@@
> +(
> + while (\(=E2=80=A6\)) {
=E2=80=A6
> + }

It seems that compound statements are mainly checked for
control flow statements by this source code search approach
so far.
Would you like to handle also single statements (without the
curly brackets)?
(Will additional SmPL disjunctions be needed then?)


> +statement S;
=E2=80=A6
> +|
> + for (...; \(=E2=80=A6\);
> +      m =3D \(=E2=80=A6\)) S

* Can the metavariable =E2=80=9CS=E2=80=9D look nicer on a separate line?

* Should assignments be taken into account for more variables?


> +|
> + for (...; \(=E2=80=A6\); ...) {
> + }
> +)

I find the shown case distinction incomplete.
Will loop initialisations trigger further SmPL development challenges?

Regards,
Markus
