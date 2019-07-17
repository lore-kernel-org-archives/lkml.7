Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6483AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289EA21743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="XlpPbq6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfGQIBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:01:49 -0400
Received: from mout.web.de ([212.227.17.12]:54677 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfGQIBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563350477;
        bh=jkEaRlO2fi+2jTPU/PB+JLfb55RGjL5j70dNr41geHE=;
        h=X-UI-Sender-Class:Subject:Cc:References:To:From:Date:In-Reply-To;
        b=XlpPbq6zD2Mqj6RqNbU1nxa1cwe9Tz+RXB6Y6f9HrL2nWrX10LJzIilh2gm0wlh4T
         VUTdVR7TZXKkc+EHr3yX/l8DhAHPszSGeIdqeh8jpbwQVwG4TiH/D3tNoUgRKXr54L
         ZXFLB9dreaB6br8fKDDo0Hr5FDMk2d++KRTPyPik=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.123.82]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lj2Dy-1iIsHz0aSs-00dHbB; Wed, 17
 Jul 2019 10:01:17 +0200
Subject: Re: [v3] coccinelle: semantic code search for missing of_node_put
Cc:     linux-kernel@vger.kernel.org, Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wen Yang <yellowriver2010@hotmail.com>
References: <201907171143136548526@zte.com.cn>
To:     Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <17342c44-256f-8899-0662-b0fe7168f647@web.de>
Date:   Wed, 17 Jul 2019 10:00:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201907171143136548526@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GDirqPjxEbr0gRYyhJbA0LvAthEiYXRKwdA1rtkopru4NxZh2d2
 rYmacmVG5iqPgaefuTBD9oC5eh6Gupge1n56XRiiTFdgaxS2X2FpKTP6pSvXq7AIxr1YdpS
 tNZ2Bg4qB01+hgjis++k2ExBgS/ZG13IiO+EpOQnsHK+0s93izApWaHxO+FOw99iy/NRADh
 HbDKmZMhBFArFtuyNZdRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5IDi0Y8+vXs=:K51mmenoEJA+37/Y6sjdrQ
 pAr9kbTOgeuqPwre6mqAP3jhw/o6XK+PNG94jZo8SxwvPqEPRZUTqVamtAb5UdDd/NHuWnV3T
 7Y9ffYOz95fUu6f/2VpbOzCLTNpw7Nn8lSiA5eFJ2TbL+Zp3yk5mZ+TZK+pTZu6pUmNRNkose
 8N3Te39IUAxxe95iAonq+Z789w8FXGZYhUkfQ0xvZ+GwdGWFYbSwJxDOyU22sRCJXZ80sh77T
 ZgpNAXlHZ77oaMCGnY+V6+vHNsFhxX/5VtpArsK2ZP9RqWr4OtMMnxvEoH3sTzy2wbnS1SFHh
 Dtr6h4SF4u81Ce0NGSF0/wuKDSxhsD0oPYcp9hEnIkS5HTM1WZSL1Jy5TiuVW/CFLDac1GEpX
 q96mqcRAhrB+bgVxdLF96tA5nJTtLdBn0OPkoDX9SokTakP3/hg5ZMwTYDeYjf64mPYa64gcs
 5WZCq1CpJA3wx2p4Q8gJdchv7LTZMYfevEdq9AblzrKUGJ7kUrOdm/c8t3HazPINywR4ZZI4d
 mT8XNjEBhyzGoQlb0GrQadnpPnEt2dla+B3bwT0jZMTnXdd3f+uWRnL8NoSAb06SVrB3kO5lH
 2L1tKNaf/eCDzfYEDBfjkwNPJ22aefq42yhs19OlKWFS03Ui9JhDYRnxIUMufleZHV+xTPi8k
 6m2A8SGA69n51FfI6cEX+b1Jyyn7DyIVzPUrfaslLUnmCcxYKVh4BtAE8xbqV99dpqTRYG1j3
 I61A5wtfArSYt+dlUSUahws0nnCI3y5EVjrv47zq2hc7ZxDyl7kwXxI5MkzhHRoJZm7GqIp6+
 gCXqEbU5WS65k0vVdQpCbVmo9kqguwUTZZ2gD46DYuK6eumf1meIhwqKU5+pKoVmFp9liMzq1
 NI5mgugCdH1FxYSDsb17BmsO+H2Ylz+Yw7kmv7oOap8OuhiN1vRBgUJJpMcsyujs3G7ymNteE
 C1lnipcpTCCwAIaYQM6YKo7f1V5+nqfEIvVnagIqeyo8ypQEmR3z0ATlE4DeIpy60XTymKhk8
 bRat04I1wp4oUlSNGigahqrMjJn2ILvlmFuQqLq8k5emnAdyxruoiV7rUyQ5pQUa6bZtWfEh8
 UskXJgIX2BfDJvR+XX20V5KXLyGqF8lR4xs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 2), Then SmPL A generates another SmPL B based on the function name list=
;

This would be a general data processing possibility.
Another option would be to let SmPL scripts to import relevant data
from external files or to query facts from databases.


> You expect the entire process above to be automated.

I hope that this can be achieved finally.


> This idea may be interesting,

Thanks for your feedback.


> but it can't be done now,

I got an other view. - Why is your view so limited at the moment?


> and it will introduce uncontrollable factors.

I suggest to take additional design options into account so that you might=
 get
more control on some factors.
Which software development challenges are still waiting for better solutio=
ns?


> We agree with julia's comments:
> I would prefer not to put semantic patches that involve iteration into t=
he kernel, for simplicity.

I guess that this kind of change reluctance can be also adjusted.
Some source code analysis approaches can look simple enough
while advanced ones will show more of the inherent complexity.


> Our file is called of_node_put.cocci, which contains three rules: r_miss=
_put,
>  r_miss_put_ext and r_use_after_put.

This combination is interesting, isn't it?


> If you separate them, it seems inappropriate.

* Would you like to be able to let each source code analysis task to be ex=
ecuted
  on its own?

* I guess that it can become possible with additional development efforts
  to support also a mixture of analysis patterns.

* The patch subject =E2=80=9C=E2=80=A6 missing =E2=80=A6=E2=80=9D does pro=
bably not fit to the detection =E2=80=9Cuse after =E2=80=A6=E2=80=9D.


>>> v3: delete the global set, =E2=80=A6
>>
>> To which previous implementation detail do you refer here?
>
> Here is an improvement based on julia's comments:
> https://lkml.org/lkml/2019/7/5/55

I would find an other description clearer then.
* Drop of functions around =E2=80=9Cadd_if_not_present=E2=80=9D
* Omission of iteration functionality


Are any more adjustments worth to be explicitly mentioned in this patch ch=
ange log?


> Here are some improvements.

Are you going to contribute further patch versions?


> Adding an asterisk here is more convenient to use,

This might be. - I wonder how good additional data fit to supported output=
 formats.


> it can mark the location of the code of interest, such as:

I know its functionality also. - I got the impression that the use of SmPL=
 asterisks
will be safe for the operation mode =E2=80=9Ccontext=E2=80=9D.


>>> +... when !=3D e =3D (T)x
>>> +    when !=3D true x =3D=3D NULL
>>
>> Will assignment exclusions get any more software development attention?
>> https://lore.kernel.org/lkml/03cc4df5-ce7f-ba91-36b5-687fec8c7297@web.d=
e/
>> https://lore.kernel.org/patchwork/patch/1095169/#1291892
>> https://lkml.org/lkml/2019/6/29/193

Will this aspect evolve further anyhow?


>> You propose once more to use a SmPL conjunction in the rule =E2=80=9Cr_=
miss_put_ext=E2=80=9D.
>> I am also still waiting for a definitive explanation on the applicabili=
ty
>> of this combination.

Would you like to clarify this software detail any more?


>>> +@r_use_after_put exists@
>>> +expression r_put.E, subE<=3Dr_put.E;
>>
>> I have got an understanding difficulty around the interpretation
>> of the shown SmPL constraint.
>> How will the clarification be continued?

More helpful information?


> +|
> + f(...,c,...,(T)E,...)

I would interpret such passing of a pointer for a device node
as an undesirable =E2=80=9Cuse after free (or put)=E2=80=9D.
Will this SmPL disjunction need further adjustments?

Regards,
Markus
