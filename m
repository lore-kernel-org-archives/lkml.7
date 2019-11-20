Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31E6C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E6522440
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="QUWCfHAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfKTJiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:38:55 -0500
Received: from mout.web.de ([212.227.15.3]:52759 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbfKTJiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574242716;
        bh=Klh70ypKVZwG0vorqxo8Kr0EXRaOdGQiO6NuWZzKH/U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QUWCfHAW0hTXFwF70kiwSO/382XAL/zKaXMn+nz75kdXlrH4Hl1F5O+2s1o7lfhMr
         EOGoLvq3skUp0PyMdxvlLgbAVq4l8j9jfEbuzND7SN74fu3RbLOBgXiZcXt7oR0j34
         waaxcdoiEYyf7xQpiCOVnzaVj0gI6JdEBGyEH77U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.176.80]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGRYe-1iboQW10c4-00DIfr; Wed, 20
 Nov 2019 10:38:36 +0100
Subject: Re: [2/4] coccinelle: platform_get_irq: handle 2-statement branches
To:     Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <1574184500-29870-3-git-send-email-Julia.Lawall@lip6.fr>
 <d178b6b3-7ef1-4ad7-a747-d65249a9667a@web.de>
 <alpine.DEB.2.21.1911192235010.2592@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5de8c4b9-2537-283d-4ef0-49fb22c18fe6@web.de>
Date:   Wed, 20 Nov 2019 10:38:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911192235010.2592@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T+o+3+wcDZ6iHs0UNx2mVfOOUHufPMF7VJk7RRJ+wP7BSLaMwZ9
 cFhUrtKbE30XpXwEg8wvY2awlMM7STDM1QD0wl969LprDJmSjrc1eq1kuViRn2qCDVSVjVx
 hbQ9fWoxLU1W/xGwb1WVSZhSuOzyqwapZvPBdfv500MaMCkGpwwqrmEAjbzcXfia1Iixbix
 3aTM4W5qKC6dBe3ky85Fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SO6Z82X9oRs=:+YEvJWAqJ/mkJYmh/E8UxC
 8aGEg0O5MFQj5m+ngLpr7PkbyayM720Mt4NvjCpkAXEynJEwFYXfJeO/lUis7NQD/3TZTpHt+
 Nh7qi/MQaDQGO+SDgEuq+ZlPWMWDMkIgT2NBcJ6SVQ2bMOwf0fLuxZJ17iWUvsxeQLMFuOgI8
 +w8oOvlJTIAQ2NtbEy4iPZneIyXm9BejZD+QF3jWm+3CWfHDHpQeaqN2Mt5eDSIxoxsrpAUw+
 FZZPyUzb1CmmBz8p8pcr2AvCR5xahCAAM9OIr4Cl+TQf2x+hMGylmEPymiB7F91Gl0amlnnJ2
 +oKX7/qU5Zl69eNQ4Vrjw74PYoFacorAnYvhaTHlJkC/RriA0iRynrgbCvzy/yzAPoq6eW8iG
 9olzrxvMShgsLWmQeBpARDjZe8VTtEyCfkDjRF/7fORoTRdwftjKmlzIgq2uJF/m4DD3stH7A
 KO9kQ4oJmyya9ETAp+Abrj+3Wq4JN+Ri8HOUvgj/y9lsF8PzOBpFtZuE22bp5+qOVTuP+GnY8
 cC6i45AfoKifOS1TgtSrIiQa4b6qdLwWZ7vuC+JQtslajKd8yPx99YeFoPzqjNZhqc/31jm36
 zkzbU2gQ7HXFlJ+BTfQmNYGm75JAGiQipeknjSleTAFsL9F2kz3uvvSCgdHA/x7gz/5YUlgyY
 Smtb6YHZZ4e9cn9i41f0CS+vKszRu4Uuii4C5tahrQFX+9r3XD7dPx2/ftLCsvUBL5xzAHOWd
 hQ/jmxduAWHZBtDwuanf8AQtdwFwTT4P7lgrpXJwej8bu4oIKEQtsCK+rj/MtkM/xFpEfQIOF
 Sc9xLdIQJwebzndCm5JseOm2ttsLTo7IPkUwbVtBIQ9GW/VgdxmV8dQ6nO1MIpNlzI/GHPEEq
 jztXcXxEqb+2JdO50grge3RTuIEk7G55o7arkDxJRy9y4CvB9o8I7tehuPtjFVhGxalha8/IF
 6+C9wY03wrCU5iLkpxba2tmH/dXcX2R2rHcD6HlHX8tfnvBvVhCNFrFds5ArYWcgMv2xCnFAc
 lDXAYTuiYfqet5YE0jogbekX02RGwmkkNd96UqdEdQR6yg3hzyEVQjCELv+MPIHlRPK4l/aig
 tqnwiQ9Hf9lMJw4k4NudSfIKEf5lh8ojCWwHYc9Iej9VagwKl+EpQ32Xn6k4bsnX/gIbAbK5+
 Q3QBR24PLvYxZmLwiDipTRS5UzrwAQzp4PhyeMuuaQl7Xazfu6I0tl3Us6nTONQRpQ1cSsMTU
 AsZ7jReEYEue6z9vOfZ0C64ThSbWDB4x4UmYzSnJz0fozbSdK7j35iyuM76Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, I seem to have done something quite wrong on this patch.

Interesting =E2=80=A6


> I will fix it.

Thanks.

Development will be continued:
https://lkml.org/lkml/2019/11/19/1681
https://lore.kernel.org/patchwork/patch/1156089/
https://lore.kernel.org/cocci/1574197705-31132-3-git-send-email-Julia.Lawa=
ll@lip6.fr/


>> How do you think about to use the following SmPL code variant?
>
> And the benefit is what?
=E2=80=A6
>> + ret =3D
>> +(platform_get_irq
>> +|platform_get_irq_byname
>> +)(E, ...);
>> +
>> + if ( \( ret < 0 \| ret <=3D 0 \) )
>> +-{
>> +-dev_err(...);
>> + S
>> +-}

* I suggest to use a different coding style for the specification of
  two function names in the SmPL disjunction.

* Would you like to avoid the mixing of code items in the first text colum=
n?

Regards,
Markus
