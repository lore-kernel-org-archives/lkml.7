Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35173ECE58B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 17:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0524E20862
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 17:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="FJ5Q/cZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfJERuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 13:50:21 -0400
Received: from mout.web.de ([212.227.15.3]:54491 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbfJERuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 13:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570297791;
        bh=jsR06q+t7pJCAnSPj64314LWwBEj/jpyrv50D8vGJjU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FJ5Q/cZNrCTa+1saiYyriZc14n4x28U2+7s6A4fFeVDlksh/pKQmlf/tNnhS5dP/Y
         6brjiONJRSsgx+zxojGT58jjmvsGqZdl0Xur8pBcuDeDFOqUDbFrv2ULpH1eWKjiLb
         7r5V+oMG8yF6u0pHkKC+KZFk6WuMoWwstF4mkP3o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.178.111]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEmbK-1iJa7w3Hnm-00FzKr; Sat, 05
 Oct 2019 19:49:50 +0200
Subject: Re: [Cocci] [RFC] scripts: Fix coccicheck failed
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yue Haibing <yuehaibing@huawei.com>,
        linux-kernel@vger.kernel.org
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
 <21684307-d05c-1856-c849-95436aedeb86@web.de>
 <alpine.DEB.2.21.1910051425050.2653@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c23dae0b-9cfb-7a61-eb09-f1654040e635@web.de>
Date:   Sat, 5 Oct 2019 19:49:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910051425050.2653@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r+o4bwvzLNbQJR8eSVT4EUyOCMF2RMqO5whUj3JRB7uAsXPf2um
 19qnX3F/Q/QlsHyqwQUSh7YyxTibBI0DVJHFAX2H+i8Fb63JQ6HejyMH6Dom/rXXtN5ul9a
 B11hpHWgdJbM9RRO1MKX/S/MP9VA5rrHoKubW29wxovGjnVpa43Um9cYAkfP3XwHvtuv0jn
 Duh4wr5FcfnqN0NNefrdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MJ7iQyV1lYo=:1x6hLujAtK0S27vdtsBFjA
 hMmyP+hDDaFy/3HCcLJGKWEd88EIHUTDL2w0zTK30D6eo3MW6Or7sJ0VRxnN7vWEMBjJd9WCm
 i90r+L5wWyH3RfezQrJ1iwWqCrI/StPrKFN5BhrLKcUakUw6PrRmQilegEovI7b8V/qtQRh/J
 YKdxXXHp4qS0qKW5mKvPQqRJT5nQ2hSGD445KUQWy6HQMQg0UqogkMahT7ngLYZC8UWIH2JsE
 jWqjRF11C+lHC1qfTnwtQahqaAGi8BMRZJp0Y4WTBI9Y0RM8BrUfl0pTMfNpqKg6V3ItlpIRW
 IAGzMnpeWvYHQgghI+8DV4LKFGbybOA0XEHUXRNhM0go3IVSzxDqV7bmJ3MuEqWzs+rJABvgb
 H0ahbk3mII9hcLQcmumw4XUIq56Vhm92Dv9zHiTyWC/yEt+N+flwgP8cDqAyngP32Os5EiPl1
 rPW65qa1tQy6ZgIb63f9/lABImoID/9CkQlqtR3nNYNPENgE7typgFNFd2VS7ss72N3ZKQFv8
 Qet1Eht+lO2Qfj6YF4w/pr/NNOQ93RdCJCGmjAXzcCLyMYESw8b4nYo/kRl4dou0TsLh0GO4J
 AygY0ZmRlFS5sczxazyYMpZiv/v/fo0o4pAGDIY5l3dMdp/8F7ozmjfyWrvD10oFzusn8qHV+
 CuxvjYAhRYz2FTu6bI64S0op4Y/gZ4EXY74tI6xhLppLXRmwT8XyVtOu5B5ky9s5D/vn0OQ7I
 72I3MKkyerDaVVRmkbmZCIACrhkeALAWik/WhkffIWaJ4qZwpo6MekubS23/oVNZ19c+c9GJd
 vYt9OUAPW3yZI1xSS2WElCFZ3VBpqlUqDVKd2PSrtRuxPb/2xW7xF0XVyvTnaz9zDzXwRLjJQ
 1Akso0yJ4TY9Xccu/09GtIbAcItCRngANKutDMA1+kgyaN77ZiQlx+Qq9/J3yhURDcKV1TBqu
 /dVP663kNCiYyVRjoxYijcYZk2yLr7jJPJlamB11vgAlOUxNhiKDEBIE7qVAhuXGQs1EvIiei
 f2iPKNnypfQ8cG9Mbkd8V7m6re9ZgJnXzMTdm2CXNd0WbWv+SXurY60zsxvDw3MQiK++UZ5MD
 hQtaPknTf03QaFwBN08hrTxNFR66+7tq60o2rw6ikdfgmTgrXbSTWvYLiuOsWSXDHErNX4Lc8
 D2v1SzVXVFMRed51oXJ8CqZqrXpUd9JnfIZtPDRW+e5OfyhwqpKThM8nxNuGvw6moDsFmfX5r
 f1Gl8Ro7kXvaquJm4ewAktZ5vtmSHQ8JOTofBvkBBOgXN7beHNc6C+k6toDI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Would you like to take the change possibility into account
>> that the coccicheck system configuration should be adapted instead?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/scripts/coccicheck?id=3D4ea655343ce4180fe9b2c7ec8cb8ef9884a47901#n257
>
> I prefer the one line change for now.

Thanks for this information.


> If more issues arise one can see what is more desirable at a larger scal=
e.

I suggest to reconsider the corresponding software design consequences now=
.

* Do you accept only SmPL scripts which will work together with
  the operation mode =E2=80=9Creport=E2=80=9D of the tool =E2=80=9Ccoccich=
eck=E2=80=9D?

* Under which circumstances will your change resistance evolve in the way
  that a clear file type separation can be applied finally?

Regards,
Markus
