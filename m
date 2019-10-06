Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3469C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 07:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C9A2087E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 07:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="NFa6pKsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfJFHBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 03:01:17 -0400
Received: from mout.web.de ([212.227.17.11]:59575 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfJFHBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 03:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570345244;
        bh=cap2itIuwTwJCEEc+CwtCrCHPuU8MHtUN+Sr+/CO8u4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NFa6pKsD0x+j2WCEDA9Wc3bEizf0P8temtT0WcztwNsbNREFoeUro3cfCkioZWwpM
         rb30S88bIMI333Yu4DAFx0D0PgOzCIx9/mKk4fKN1QHs5KiFFH6LrDOZK+4yYWXeHC
         CZEmOS9xaojwEaLSxfnS7qQ7f6VHefvpUNpWVTYI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.114.140]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCIe5-1iPZ7a44Th-0099zp; Sun, 06
 Oct 2019 09:00:44 +0200
Subject: Re: scripts: add_namespace: Fix coccicheck failed
To:     Julia Lawall <julia.lawall@lip6.fr>,
        YueHaibing <yuehaibing@huawei.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
 <20191006044456.57608-1-yuehaibing@huawei.com>
 <f9862128-8fa2-812e-cfb3-c9953b9e98a2@web.de>
 <alpine.DEB.2.21.1910060843030.4623@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <fd7a2ab6-3fd3-e967-1959-04a828331884@web.de>
Date:   Sun, 6 Oct 2019 09:00:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910060843030.4623@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0v+W9j4ZLFM97dC2nxdW307/e/Wl+wOWttPB8c05cp4KF35OZ6G
 WQaIBL6Q6IST1QUp/NiQ5kCmCVq8ygbcKxZNbBzvq4F7lzfvcmGkwj498rbCLIMqIciVtB8
 +Y0Es4RDTHvv9RnizWMn0kcTqctNANK4elXsrI5P6WMOlYhU2Haj+X3DLU+42lkPzA6/9kn
 3ntD28n1ioADkUWJxzgTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gT5L0ihqhUw=:T6wYo/8oFmp7EALD46uDn3
 9NSTHtdoTfyrjJX1MwP3vn3RVfBbAJcmkb1sxV4CuLB3Zcp4KwqA/uI3lwlckl8PAH//LDIwU
 6ej//CxDy0sWp3YOfCTxoPZrHoFykF8KR4EDqDVMl0dRkUfkNUniJhsPvJirBFdyjxjfYYC+o
 hu//xk6QMIevQ///y0NHqmg93dAiXRpHOgF8FGibczjnpodJQjDJAptEA4Cem5VOeHdXUA2pC
 4h4usqra7KBtB5wuMPX4Q2Ge6AzDLmQJ1Eu90JAWFtI8NkyWz1rVMhtr206E1kUMygO/0I8hD
 mJnfyDHHJdYC01X4yfM4Nr7c+aTyNqMKiSeI8Y1yW4g04M7jP442MKzfZbsCS1NdVNsoFHSsX
 kvVjHKX56tvhCUERIVUESk88rMpI1bNhWa3BYsW0HIFMZTRuQVMipZTAMGTZYAnEea5w5dPHg
 Kjrw8srxaIfhMJoWDUj7g47B6cPHaVVQwAbu988FD+G1NTuyQYT5HajOMr161Mxf9fivsC4gE
 FyVqr4l2TRlXJxSrH99p3ScDFnaoswyPQa63Qi/vpoklaFGgQf6Qf1xF3abm4DoNR8Rn5+v6w
 Rs2GmxLqaf9v8rvbUYIf7I6m5t0d8bRV/WV6b4ukUWF/TmxTqkW92/C1YphivP0je22qwp6hB
 2hZUO/0BfMlHw6NCw6yyHwnYD+TQndi4m78j0YwtykxD4u9vfzR3hq8bdeXf4Yn1x3I4mUUhx
 w/r0y6FSz37ShOEVR8h9n96TuWrcThiFpzoRprUAGMTT06r2z1FVZ2Nk3bMIM5UGQuSU6YQGp
 vxH6VF40d5QgTZpMLnbzASQ7gGDwtTR6y56TRjw2YOWYHpbUNP7wTNF16hvtf3//vZhVPG0XL
 j28ynKIZKO7Rrdx1nnzkTyvwO/IDfNWOZoU3jvGg9gqkii4YDUURvf7aaaQIpjxTbcUjwjJtq
 hHwrne2oQQLs0Hg4+WrVD3dlx8a8sp5xbPgZKz60bf4Vzet+qMRmuBi8/0CVjAbSsaV18JD02
 0ktnyJ7WIYPG8mjdaxE+F25L93zYJ9Bez9WhTYkrwT9xVQ7sZ3tULPOGC+qLgScSKCIAINODk
 21mk0WKT/m21F/Dnts8MLD2DkrlB8GE3AmDouoznKzvhAPzkuXEA9JXcJcuMCJxxoGcEQoCU5
 x/M4lOZ6flg/jnPLPctJdWwxOZuyJ+3q2aDVvZ1yTKefQT8ra2aJBQAWprf4PPVV1OsfD/jvm
 A21+QI6QZyoRMtdIqEcRt9Su+wDaAgSnOmL8gvagq1hvU5478NhTZuK8aTg8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I would find a commit subject like =E2=80=9Cscripts: add_namespace:
>> Add support for the default coccicheck operation mode=E2=80=9D more app=
ropriate
>> (if this software development will be clarified further in the shown di=
rection
>> at all).
>
> Please let this go.

This will not happen for a while.


> Please stop criticizing the English of others.

I am occasionally trying to provide some code review.

Chances for further improvements will eventually be lost, if you do not
get informed about corresponding update candidates.


> The message is understandable, and even more informative than what you p=
ropose.

I would appreciate the selection of a better wording also in this case.

Regards,
Markus
