Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4068C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC07B206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="eSy3bF1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392553AbfIFHl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:41:26 -0400
Received: from mout.web.de ([217.72.192.78]:36267 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390377AbfIFHlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567755650;
        bh=n0kCz4gwZlDRbUarj51SXfpdtpwYXmwh0XFzK+Po7+I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eSy3bF1AoR2d2lu5eeNXKFR1C1FAHVUxx7/RIsnr+Lhv96crhhwhgVH7uMg5eDOTm
         uyQrRMB/8+ex/ULAwCy791EQO2xAdGPH3TAuMF1BFNppnAchode5RUz92Xevvhs5+K
         /v+bnjQYzqO/uPJ2nXZHCyoOcGmdj1/QiCHfThRA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.58.4]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3Bdr-1iOli243mx-00srq8; Fri, 06
 Sep 2019 09:40:50 +0200
Subject: Re: [PATCH -next] coccinelle: platform_get_irq: Fix parse error
To:     Julia Lawall <julia.lawall@lip6.fr>,
        kernel-janitors@vger.kernel.org, cocci@systeme.lip6.fr
Cc:     Stephen Boyd <swboyd@chromium.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Denis Efremov <efremov@linux.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>
References: <5d71eb6f.1c69fb81.31bc8.da2d@mx.google.com>
 <7818ad20-615c-2ce9-c0d1-3f7a09bedf34@web.de>
 <alpine.DEB.2.21.1909060857290.2975@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <970643a9-5f19-29ee-dde6-5b81c9038a04@web.de>
Date:   Fri, 6 Sep 2019 09:40:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909060857290.2975@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IuJd6zRlAs4NG7jeVC9h33Px6Op1gSYNKfFrNP4/fPCEUg6CTU/
 j7eFsXAq3YoNZY8dGkltdNqjeIpghjh1aXE3yPnPqIyqUov1VtodfDWUl1CnNfF+O6U4sIQ
 NP3OZBG7vrFwknE+9DcdaPzqhy79i63Ll5yodGoa+7RyD0Ta2eRumvUe8QLub0EnodXgGM2
 3+SYzNdZduWUsDYfIFXKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hC2i8+3wG0s=:Vg0P4geFXVAEl5IJtumNDN
 aGR6RgGCafwDDbwG4nFWYQPwZgCp4ixfyypPKb/d5ClUXYitJbqxA6IXy9mJN0IaIH0SSwnI3
 WTDlYa04kyV06htmzMJC0BH6t7EdCXQnpevmEJRT4+v/9P2uj2jHhNrXsDdUe7bYC8VJtGPc5
 gg5p5Q0RCFeDkuRqWOR5DrEOA+Iq/aaMbpGI51xD+h9jnPwTdSRwSU8zzq4zsZnbAU6MxExqb
 uZtnBXvEvtR8w/wVZzHOT8Nk+csBc3M/agJ6VPB7HNGTSLyN88k8hgTSJLIq7GgxqeWTjFrFF
 VcPcWQSC1i7p/NPgcCNmiv2+Atc8oJ/FKqVREmJfxDbNdVMTuwYOZhT4ZYM14CuuxsMu4XsGz
 jD7dDIbbeprRfx+RH6usTKsiomw+0Df69SWmZUTd8w3N3fgNilpHmn6QOqbJz38mWCFek/51N
 Am4xOAsbrMmiVb/V5qE25cpIMVseqcW7w9jV8zl/XwjDGjyoY71XyXmk7ggcHOMo11wGRMQwP
 Uln086gvHeKgPr5U6lNCsFcyPK728LI0xmVItfVXKrxhPDiA8x1q7WUAgmTK8O5z35nzq/AKh
 KRIYh2LJQD4vKBZjAPGe0BCKVc8EtONtF7lyGxKFgKB6JnNBgEr68cKS211pSayfx1dpPTUJb
 yWGeZLLPkj4iUpvwEGcJhpp2VDzMyxe2hybQF8Zy8PPT6MYm59tK9SvsQnWHc7ICi59v55zbE
 AZDqocm4qYCOAH9Ta81Hje9/jlqDdTPZCjSV9+WYZDsBZDc9JVgzLGKRTDQeWd/lWn/aM0Yy3
 pCwEO8YibH1gfFuSZBUSmzYDI3IfnxFMTqT1LPWf3eh+iEIh8MlrWwYStTj/ywFfpc2iUAgZB
 IhPYfqHou47fEPMmy4LOoN0DH9EkZ19vnOxXPvYxL3FllZaaZmj/4cTNJSrBvX0IdZHnTp4/+
 8UYhWBqZYsII6hGNEHrugpFbI328Hhomu5hh8aKJtMZ/G1xKHTVG1KPc4MQ2JKTD0L35uLGCs
 /Cxeuspgb+j+Dst38t4ITNVkNTPHoWWmtImHansjOf1K7qA1aBCNnZNFMF09vZa6tPIVgdxh6
 cnshGCP88vXQF/v5ig7MsO3pRF1OYAUYHYgtRWpaopFp5XuPRGsh0vK96jRSfnax1ashp38f1
 DkT5Kg/DPOAfvBt37Cuv+F2TbdA3SIsMTHPCOfj2rKvhKWThqidV4znOFG0sKdl0ziOkNPl64
 z8+iVgZKbKDsM9riz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I proposed something also during the development for this SmPL script.
>> https://lkml.org/lkml/2019/7/24/274
>> https://lore.kernel.org/r/c98b8f50-1adf-ea95-a91c-ec451e9fefe2@web.de/
>
> Markus,
>
> This is not the first time you have suggested to someone to do something
> that was simply incorrect.

We come along different application expectations.


> Please actually test your suggestions before proposing them.

I dare to express also =E2=80=9Cquestionable=E2=80=9D development ideas.


>> Should disjunctions eventually work in the semantic patch language also=
 together with
>> comparison operators?
>> https://github.com/coccinelle/coccinelle/issues/40
>
> No.

Can a similar effect be achieved by using a SmPL constraint for
a metavariable of the type =E2=80=9Cbinary operator=E2=80=9D?
https://github.com/coccinelle/coccinelle/blob/b4509f6e7fb06d5616bb19dd5a11=
0b203fd0e566/docs/manual/cocci_syntax.tex#L266


>> Will any additional software adjustments be taken into account?
>
> No.

I imagine that this view can change over time according to remaining featu=
re requests.

Regards,
Markus
