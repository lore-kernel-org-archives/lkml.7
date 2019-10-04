Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6124C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBA8215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DP59zQp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfJDIXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:23:52 -0400
Received: from mout.web.de ([212.227.17.12]:37919 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbfJDIXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570177402;
        bh=MAAVT7z6PROQilAKzp2ZejzZr3m0RdDVc3GmpCew1l8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DP59zQp4IhVAc1acyh1Vhd9wGFOwsY/eYn1qTaUZ9N0HwBCABwPn6vQYjbuh7+0gA
         TKaPzbFnDECFXN6XXqdnvftmA11xDpt/VU+jH6u3zZS6m6lSXicydnPH7/rxNIe/iV
         pSvjMCmAbmbziYElLlBlV7FebAlhUaXKBuxVKUsU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.78.160]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LiCsx-1hks3N2hs3-00nO0B; Fri, 04
 Oct 2019 10:23:22 +0200
Subject: Re: [Cocci] [RFC] scripts: Fix coccicheck failed
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        YueHaibing <yuehaibing@huawei.com>, Jessica Yu <jeyu@kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com>
 <9e15321d-5b95-c03c-e6eb-1d3d4a62478a@web.de>
 <alpine.DEB.2.21.1910032135140.3451@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3a4c8245-9e7b-8287-90f6-b49a658fd204@web.de>
Date:   Fri, 4 Oct 2019 10:23:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910032135140.3451@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sF63+j1O/2nNHoPsXlQrRlv7J/Ig9CHz0IZMgmOhIZGzqM78E4R
 wYY5ztTZNNILdSKzbzjYRPFs8O8Xma9kK97lHhyV3oGQWDIIa6h1ixcy8gXKq+15u1w8HfI
 qPgqzuDDzQkk32haZXtqdDlYyS8lPKBBMWHZ0BS0jTv69uyX3pb9KZIYhDFouhZAJTYJkB+
 zpT7ITge9uvNy5T4IgbAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PtRifumcYRM=:oEwCJwMX1vllbCxHS2eDXI
 nF4ojG/AN0GGh7NMgNHFHUEEdkzw29eyOFXixKuMkziXh0kqrpgNYj8IDGgn3nxOibfE/laDh
 6y2vFXAIKPd8SJ29NcvhfhNk4NdOVm3RkArdENLuZ0XeiphGA6+SEuSVceHkNdUVp8RJRnSNm
 8gI36wW67GZIiF2JmFx0U7jHlcB7a69nm2ols3O2dIiTaIjH0kKEASq/RVR2SL2nRN1+fhk+C
 0rNgUWV1yeMVh1rkjI1QkbUACIDhpZKyIJbpDGApqc1jsQZiI3I3lWiYtLutsKDi0/Iw3AFHt
 eY9Nth54VkxMwfiIWlqQXyLv44M3SKypOuQOMURMsvPrHWOI5JZaGbM5vUVYvItpDJ2TCihCG
 PrAkBqezxxQ1sE09adVITc7X0Bkm6J1A5YXRnvchySZZTKvTsDbLt0nMquGKOjp4/OcNyw0GZ
 VcGW9vcvdEsZrHliaj/TcubMr6sG98bsZ+8kCMOaRnGaZWPK8k9+7nslHkPxzV2XMWxceaoNw
 RLG6w7PwFg/gkTj0emS7kfXuuXGbQztc/CF3hwuetdcA/xoeefI/c7AiGNPgs6EaV25O+p5Df
 vM8MhhAkKKj0tsXparJyQwM6W+tOciq3RWkMUeUf7RpNfoSI0yNcbluIBBK3YfnjTI9am8jMG
 1XJ6lS3IkpBlOLAliZRsodfRnLM/vxfKwqy4IdCxMABMNgKsJfTAxWKGrj0ug+GAHGy1ayCRZ
 JXD3+pAy0TGYPrs13TUc4ZMdqt7Me2U4YEZbAs7MR8TzUXt0VKK1iEs3Arl/I8FaxjNaMAAt5
 tjIL1VcX2OHaXUEGFTJAYEkVALXtV2srniDaz0uBRN3MGCaeXnYPUv764zWgJeMUtBJwqJDdL
 nnxPD8nPkZoVQ/gwq27OmEQc+IKz8rh5as51CKqPeZtUSENDWHPVjDOAEPvxYDPHhEwTCqV0x
 6pFQVsb7ViHPIq5DphE0FrE84goYvGPhd3GWaOglXAOYqsgmBkx2rao0dHFJfxEUWXa4iJVLD
 w9OwJzUfzz69pmGebKXWipQVMqY4WhlmW/wm56HeyCHPq8gC4XGdPfcG54qvwDIRj7K1yaFuu
 iXtXmR8WD5la215WTxSUHWpQwyRgD5BAt7/qV1gkqSzaDEfL+538HdfLC3Soo9f2TI8DDYllz
 QpTom/A5NhgGcUDFb1EE2asm7cn3VlO3/f6vLZrTtqBYPuyw39lsuV1nMVnbSTywt6Y7ab20Z
 hAQlWtMqRmfp5yW2/mQl9h+cP8VPXR4MGyaMN3OLSkb2rrYPZor+HI1/bjWo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> How do you think about to avoid the addition of the SmPL variable
>> =E2=80=9Cvirtual report=E2=80=9D to the script =E2=80=9Cadd_namespace.c=
occi=E2=80=9D if you would dare
>> to integrate my change proposal for an adjusted directory hierarchy?
>
> Perhaps I'm lazy, but i seems simpler to add 20 characters than to move
> all of the files around...

I got concerned that you would interpret the difference statistics
of the published patches in this direction.

I propose to achieve a clear separation for SmPL scripts.
* Files which can be directly used (on their own).
* Coccicheck scripts which have got additional design requirements
  for this call interface.


Which storage locations are you going to select for these variants?

Regards,
Markus
