Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B55EC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47092189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Q8jx13Q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfH2UIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:08:22 -0400
Received: from mout.web.de ([212.227.15.14]:41831 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfH2UIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567109282;
        bh=tHlQSTvFPjb5vEY3OYaAGbIzMXF9u1cOmRv3w4Fed5M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Q8jx13Q/Hy5zREYos3a/qcTBJjJR4DzoZqXh3Fx886zPNUiyEf+/bHmY+vM7onWks
         L+A9HKoe8EPxOiBM257jPtMU1l6d29plmmSfH6MMvMwIC6S3q0FLii2HFlxnEUIgtK
         EZ5aMI3RQroemtvEAmZVARFoTsV2qhA9mMfg1vik=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.172.157]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lecda-1iXmJg0nSo-00qRnW; Thu, 29
 Aug 2019 22:08:02 +0200
Subject: Re: [PATCH v2] scripts: coccinelle: check for !(un)?likely usage
To:     Denis Efremov <efremov@linux.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Joe Perches <joe@perches.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        cocci@systeme.lip6.fr
Cc:     linux-kernel@vger.kernel.org
References: <20190825130536.14683-1-efremov@linux.com>
 <20190829171013.22956-1-efremov@linux.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f7dad682-a251-ba8f-4c25-874f511295fc@web.de>
Date:   Thu, 29 Aug 2019 22:07:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829171013.22956-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:ZSrA0zj1x92Ry8CYKvtBVsiM+kFL1Go0TYbXyXBiHukWDB+qf6k
 MjpLqC2wM/w9AUrAYXuMMAZwp7vjViKNS1iSkvsjfhRxBTouP+7xlzF2kTUbdl8wKlkcZwQ
 Y7OfSUhUWwJsR0NLQsnqMSDOFpdjs035Kbm35xzAdGH/Iln3y3c4cwCUOUydNIqMvq74bw5
 vKGnyFiFcxjJAS6MkpFxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tVxR4kwytlY=:f63uY9COG/AufpFOvjqA1j
 2gL+TIK9ASRkkAgExyCYa+N+Z8QHC8RsviTM1xJWAFIfaiDYD5ToeLR7DbUfoO4zjq8NoyXOf
 CsekE0EWfBvmNLbuH07L3j+PV281V045az8+1LURkMdIFuALI7h8uM/zXybQBgsATJDy8BN1a
 uXHlWKr5wzcKQIQUi+h4dtUTgCFRbULwtlbGdgJ7QGK++8jFIVPx0CPWL60XVUlGzpleydIfY
 +ohf0Gri9mpPdYctPE9Bn5UzFVxO2t5N00rSk+BpimF1Xgpj6Y92boIbLwcaqV+Bv34w0o9Wy
 rTSYEX8qkvcVF83WqRqRtQ1RZayK4dZ6IF8CHq1R5QYqgP4jixzImtOZfH784D69J2Rl6G9xs
 6Mq5XYCCffgohUt+/dVw4zbta7af1nyI8/e3EwTHT5+yKkyxXM0LPrhhnKMpM5E6b878phD2s
 LWm0P1U/7hJtGJYbRijW9xTZ4mWb+2f6ptjpPrw9IDBBkxto3m4T6fj/XRvSSAqmr0u7eCiDt
 3rirApK8X/v0Ag7xhZwHEcTj38SIVYab9lVzW6n+pMzjOEodrR9RjbwQQWry9ZUQnv8Hy+Vbu
 Oc8Mw7hwWxRtEY24ZEhdcWs3ZdmIw/vuCBcpjgrsw5NKh5SHVJJ9TyXk0qULeHbYNoYwNTkGq
 mJOhKfJppA6W9nAkK81Og26BYq+9xuVivr2j7syAA6sQiBrNarXMWjtQoefV191e95/B+ex/7
 qgTD30dQXADU2GwTwIKjf8hT/Dl81yHYklbXdQO176Fi8m/DzfpaB2N6keLc4hwz2wvw1eMzd
 jIRwfAFh0CLByg+91SrFcNC54zeE9Mwyf6mbv/fe1TPSXdaNwiVmEoeS5HIlTiPs+brsAJfAP
 cVRL/ffKRYwVGXQiWsfLT4OZil/FOUx2On7CCFVI/9UimAekczpqfHYEuoNLVuYVK2PdoLnzQ
 2hq0vzBP6jy3Jt5DqBWHdSeBo7aNLlh443B8bo7EAGc3VbkHCfVBBUvPriyMf/yIoo/ydbhgg
 pCqFipQjdz3WxbR569xH1OFgZLt+nzjb1f4vyTOlb5UyQl+xN9WH2p0ugats+0UUiZEMbSK/r
 /yFVCeGyIMTPliFZdfrMbuCkZHG2sjxUDNzjWd3G1zIJl41dUt4eV567/ru7rEzQ4kXFhHqWZ
 xcmAqMOF5P9Cu+VZwlQiCrui6WUq21qXqFoSCPwU6tk6nYWA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +@script:python depends on report && r1@
> +p << r1.p;
> +@@
> +
> +coccilib.report.print_report(p[0],
> +	"unlikely(!x) is more readable than !likely(x)")

Can alignment matter for the string literal together with
the first method parameter?

Regards,
Markus
