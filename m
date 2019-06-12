Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D911C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2070920896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="CzYODQvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbfFLGYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 02:24:45 -0400
Received: from mout.web.de ([212.227.15.14]:49463 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731018AbfFLGYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 02:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560320662;
        bh=Na84Tq5h53VwT/D6R1kesN31WJoCkGJYNZzkVe2nTyg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CzYODQvDOQ4y4mroeyYSwQCbzicv1j50bxigPYySrlWUtgJV8YyxznxiMAukcTuX/
         zV/4R665rbTcSxZJB4gZYqEpSx2QZrEjSViFMjR1swB8ItCRFArGbYuMrjPanZa9f4
         YckW7zcz7R3rLpKnBtBUXLUYha8SP0z3ctZ8QRo4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.21.30]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEZPl-1hqd4h1mUz-00Fhos; Wed, 12
 Jun 2019 08:24:22 +0200
Subject: Re: Coccinelle: api: add devm_platform_ioremap_resource script
To:     Enrico Weigelt <lkml@metux.net>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <20190406061112.31620-1-himanshujha199640@gmail.com>
 <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de>
 <alpine.DEB.2.21.1906081925090.2543@hadrien>
 <7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de>
 <f573b2d3-11d0-92b5-f8ab-4c4b6493e152@metux.net>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f6fe6400-8fdd-cb53-f7e1-ac6188c9e785@web.de>
Date:   Wed, 12 Jun 2019 08:24:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f573b2d3-11d0-92b5-f8ab-4c4b6493e152@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eg+5SLbiCpk5lx6pcF6ODtIkClAzwUJ4oIktvk6OaqI5h5uMxt7
 Hxa/aNSxFhgLSQzo2FT3WSot9yJxODf1dxLqtUbRTg4Lf0UkAtI5wjea3JOGQAmxy9kZx9r
 SVhOJtsJNXhq9RQoxb1298x87lTMHGbvM5PTWP1A0NLin2QihLMyBhiuuys/dDuM6rDXNz0
 lOFrgFWJRwAOrCZ+nsS+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TzAEwWl+fKw=:VXj124DHKE+3x+A6VKMdzD
 ucPfljpbod/cgMAx6WNO15DtkBWHmec1vJYzEs/YG040vIBogLwBZ0ww0+ZW4glFLK0sQBloK
 TanEVzXUWlrClXEzS7rhHLKWKQzy0e0xiEpn/5otml7wOoiFGAexEhoVnHSoO1IGAto1Y1ZyM
 Bg6WA1zu+bC2W9+yHmXFjQqMcEr43R5WGgt5ldYGyFsloXwetDcYMVoym9WOKLzkTicaVQju0
 cAp0vvw7YS8CoPoQRE8NEzMcm75s4qoTKtyOHPZsjoQ+Mb0C492LKV5TiERSggoB0Y2U1X2s+
 ZE6qGribALQZBQoVvl3B2dUttLU7hr6p4k1kzRND+LJtBWT7UIBp/5GG08sb0XZ2kVC9wV37g
 BlPJmYE+723u/JNsv/2wQFsV5sgK/H4vC3G0BR4VJ5ns/MhrphjrKjCvkDzr67GhdmN+tcqrm
 lJze53IkrP6+NUWK6+K6VIGf2to8vglZtW84LS5Mp1Z+Gf25lrKObFp/LMoX6pqwy2WpH4UX9
 3fAUJbkESK65ptJHLeeoDaMqtzHT1XgoFyTLHNpLZhl7e0y8kWJy6cEicapDbTnlE8mtzb1fF
 M5agcfXgjgNmFbEQ5OtptqHA5bl9GwDBsqyB3UiTpumSh2bxvpwG8NmRUWUSAwEVsDALIxZBQ
 BkWQ3fjk3hsY21za8ljrhKpg3k+YGceajKEz/8WT0l/1wEOeun1wf3bc0xP2BujzEwyyibAA6
 e1I20UYSAMDK38tme8Wu7ifPoVnobcmn9Ov8Z+0hvUHFFHSxmb14hv//88AnQ5pgxz4FnbbbK
 xyjV+ojioOeM11ukDWoVKuX5XcZGFUqmHFfMM21fv20ojveQFdmrKo4eXT3NSJzMt41X1DhYI
 3Nc7DUgfP86xxDq23thMh5sLvywHdBbS/PRfP0M2K30AvmT5ZhhBDQIOBLe5TYsPMnzlJb3CT
 rULKG/bddNGcNo4ByJJDZMpkguIix+C1nh3GApC0MCUcpw2C8OMIH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> The flag =E2=80=9CIORESOURCE_MEM=E2=80=9D is passed as the second param=
eter for the call
>> of the function =E2=80=9Cplatform_get_resource=E2=80=9D in this refacto=
ring.
>
> In that particular case, we maybe should consider separate inline
> helpers instead of passing this is a parameter.
>
> Maybe it would even be more efficient to have completely separate
> versions of devm_platform_ioremap_resource(), so we don't even have
> to pass that parameter on stack.

Would you like to add another function which should be called instead of
the combination of the functions =E2=80=9Cplatform_get_resource=E2=80=9D a=
nd =E2=80=9Cdevm_ioremap_resource=E2=80=9D?

Regards,
Markus
