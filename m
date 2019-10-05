Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600F5C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 11:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2646A222C5
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 11:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TeiRHBn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfJELSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 07:18:23 -0400
Received: from mout.web.de ([212.227.15.14]:54207 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfJELSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 07:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570274276;
        bh=wc8ZKrREN2JvcgL+XN8AGZz0/9mX994+e/rc2Npyur4=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=TeiRHBn+y0RljCHXZuCvWiHcibXy1btflElffWtpdqJrkbPBxwSoMCqOxP1r6F26b
         5cruIJpTKgA/+MIbopLBUDAsq/QCAUoBGb5VaUcuJ9wqz3iXcK3X5F+nQxlYWJiEsV
         9/84cDYhE58dXX/20dZYKLkafdiT/vGSI4njuqiE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.178.111]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lcxfc-1hqPjA29VA-00iAq7; Sat, 05
 Oct 2019 13:17:56 +0200
Cc:     linux-kernel@vger.kernel.org
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
Subject: Re: [Cocci] [RFC] scripts: Fix coccicheck failed
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yue Haibing <yuehaibing@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <21684307-d05c-1856-c849-95436aedeb86@web.de>
Date:   Sat, 5 Oct 2019 13:17:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xEzJk+LKJMSjE8AA4JD6AAGoJKidki0S6DqmnE2RCwb84FyrCVb
 4yHdFK+zmm1ghxVVcp4Up8ODgbZZaSkBJAsP6n+QhHH4jSBvA3KLp+YQQE8USrSOfuF6Dsw
 +tFqnjW6WkaoJq4guejTmxT04rFOluRbLhpgkM8Mpo1eaqTjY8mWyPVlqRFZ6T5eQPkiJy+
 ILy+vilDUaGi3VlY0FZwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LKAAEvLv4+s=:Cuj02HyWu5I9Pjfu3OZgXX
 t3gy1w5PVUyGa3mxKyEEHnQXg8xsZ0uGJAyJGG3oLujfJu/X9lsUf1HlVoLKQBAdsnoim4BEH
 0YU0gVrdvpVhwz9RNxbwq6yaTLtDgVQhuzMH/ANut2FCItCvn3a022Llpla5D2VdFP/LEF4XY
 M771aGzOYAyqXnWnvuOwJCM1ZdcAPg6Thz2eeIigBGDRlx1BcW/efxSXdA/ZqN3t/jMQp3RPQ
 FAiFps8lbhyvds+ijnAF+5Th5yDqwpY74g2uZBvJcPej3XE86O75rKfWE+CcwQixtfLvUSMym
 5fb1NWZ6TdrbHR4nSFphItFoZkUpWxqgE2EPdTO47dPPpUDmO+XNkG/fUYYyENB12cJNUqY3g
 e3+ENzRyWmTApkScK6Ki1o22KkILc77g3ZHPrlNJH/2yerNmXbI9Bz4x0dAptLk6EpLzzZ8eg
 mZpKeq7QgKamlX7TmpFKOtyxgwFyW4BSZio9e+V0gLXQkm7y9dLKkpp67HsSZ512vF8CUDqsk
 n1aX0XCHanQzGRA+mvkP2+sE/sghWFiHVRRUQm7w/WIzfzAfE2j08sCKolAB+vQHSyjY4OsoK
 sLZ3I5McmUnvp5pVN++xJS3GRq9xjQNGWZzHE01OzhbIlmj2LMyscXr9InUtrlAZKNEjcTwI4
 ydnfMj4kjqag7CabHtfZwC5FEJ87hhzAKXffmYRVE+QiO7hLPDrPzxiej9W1wxEkdLuhR/I/9
 7pVOz8yVr9+WYQXfSEAEiDVZ9O8ZjTYssK9g3qrauSBSf7TaD1QU3/ObXhKlsNhkrNqzx+9CY
 HkcFswHROZtG0DGlukgrej79Fkg07ptAMQVautx3wBkY+2IifkGw/jyPIcsedI9mPCnzYSQTt
 xN6Dtcgq7b0l53+/6PIC5llYaaV3YPXCQsqrz+FL4i8gqH1rU3bM9frwyvkWVXilWkkgz0rEY
 Ho04kcpziiyiPBqVXQzWvrzXL+q15WtSygu4IbOsQUHN++6EbuGF0wFfMGlXFBZDIzHqYAIg+
 hVwLWabZ4g/KaMBddw1DA+VlkJPt2mQ8egVrVlptieTmwRplfyWHlO1eNINZTgzrFTKJuKkiE
 hUyGSNdSKfZb9zqIhLZb+CM5sDBKK5DH4z+efpYbYsyBGy4yDE2sGHfGy5AKdVA2t4GSksXi+
 tCXkCvR6qb8HIeX98lDAYYeRyaXEKIOLd5a1QvxfLqAgqnXDTVhaOjyAxvLr1wX8C0g3+/GbY
 VU2rFEZaEwksT522xcljpYfzzJPHv/Uo5n+aBOsVl4s+oMDHqlLiZldTXLGU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You gave Acked-by to the one-liner fix "virtual report",

It was (temporarily?) accepted to use the script =E2=80=9Cadd_namespace.co=
cci=E2=80=9D
without such a type of SmPL variable.


> and I am happy to apply it to my tree.

Would you like to take the change possibility into account
that the coccicheck system configuration should be adapted instead?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sc=
ripts/coccicheck?id=3D4ea655343ce4180fe9b2c7ec8cb8ef9884a47901#n257

Regards,
Markus
