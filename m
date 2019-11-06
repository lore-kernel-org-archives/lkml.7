Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6563DC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2D9217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Sbcy0H95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbfKFTSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:18:16 -0500
Received: from mout.web.de ([212.227.17.11]:51809 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbfKFTSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573067886;
        bh=nUznGpfstPycpqKVbu+foKUPDV+1Xm5lDGkw6bfU0XE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Sbcy0H95/vR5YizE5kiA5/rywbdwvior0xHpzBY8FoCFYqL8sfgv0sdz9cLDjiB+u
         8pdvTJJyAgxELfucb3lPPgXS23370gOwezzmc+saf578RzqYmyqNJR8LJ1UxS1KZlO
         OtPMlNZzG5LdkuMck9PpOv0O6tOizfLa58gWxwUM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.91.235]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MDgLi-1iiO2q2fZm-00H4E7; Wed, 06
 Nov 2019 20:18:06 +0100
Subject: Re: s390/pkey: Use memdup_user() rather than duplicating its
 implementation
To:     Joe Perches <joe@perches.com>, linux-s390@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Cc:     =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
 <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
 <0f90b278-7b3e-6509-1633-301d16513c5d@web.de>
 <47c55ab899aafe10898e6581582363aa446b2091.camel@perches.com>
 <cba4068c-0d63-fc0a-44bb-2664b690f126@web.de>
 <7b6295e48dbb4b5b9c578516f40b61ad2afd115b.camel@perches.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <298c5ecf-2fc7-b604-b97a-85c0717cafc9@web.de>
Date:   Wed, 6 Nov 2019 20:18:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <7b6295e48dbb4b5b9c578516f40b61ad2afd115b.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ivP7Ayc+8l2QrGHXeQNzI50+BTim+l2WE+BmsN1snU3FlspAecR
 aGnOTMnJak/mz4RN9kLzbtMKruOzrcyl0K4uHbXot0pd5aH05Aiv1HXuK52Y6dtfRB3Huj1
 R3HVj3zXIs9Tfo4UDTfrDKi2KlyoQsPMd/0/dVUjTil1lGpzpxtv7hG9HddIO4qgohnayc+
 OoU0Io4QNGTzOT1obRrdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZV1XDlmpQTQ=:ncioeVX9pIUqnXPhOGnrv9
 QukYRuDTXf9tEtGR/Vz1rw4NBt2OfWcj0s8BmoW8Gt3A6FH44HIg+wQ2OVl/Zuwo2ERg/3emF
 G4kV+HZmmq9uw8yAHxwtsGmDiych7aO0l+1gwvvZ3dX/woII/UqGQ8lAQ1Sxx8WL0wTVtdWo9
 F5E3YX21JEZUXwjLB8owekBMmk0GHFjcCHMO9Y0oXxz1chG9noKj1ZSsnIeijW1XsOwNqKB9P
 tOPi9eW4Ym18PxKHoduEqurYxbJNLX2txCt/7bc2zLr5YPeymH+Nkn+Cd4k7yTYauYrDcKj6O
 oym6pYvaIpc55RjF6jfwWZ107meohnadu84+mFcMb9BZQOO44LUPo47XZysoPE/YQrx0G4aV5
 d2qj3Kw2z3ZoBNtYh4DbF2OpRJ4X0mldvj396cssP9o8bl56pBXyd8yW/YV43lTny8tyBUoOI
 5hEKxt+gOiJPmn893DhAdFy6E+o1ZJdPUw2m2lvDzt2ZK9UP0IsgqWK/ekIjm6Br1W1TsPgv7
 ItGbRB04FBlP4DHbkNB/FwoQGTGdO1GGWeh8ZMyNpzUxFyyaV1sa9CwMlTe+zKj1NM1lEJFHv
 XKLGc2tZwnDSCllVwpfM/QHH43Vo7yebBBE/QYcIvAX6I4lq7fV48/z4Ie+foYV7OmKqnRR2U
 BwA3mG9cmxiKXKDSGarxnQl5YkFp8wBmqfWz4sGJ7RsOOm6huIUMOSRGVGPFFGZlSNMhkv/Ms
 z5YGXAL5lVn0FEagqB+9qhjDWjAGoRukJXptModbxOXxGRYFtoqaY+zftjkDg7Y6q6knzDPb8
 4LxuPrxx3+7/WBC3wKORzbWFzGMIC3MOR/oMmA8DK+ME5kXk0R0DbL6NUSqWq21aR6tbZc5zg
 5W/EtlOPEqT5yk4NgcY9ATAC0IFmFmZnCkBu0CjMpyP2sP7RoJyoL0bXrBLv8y5ULqD6Pygo4
 HUvSc1G3E8+XwG+bDlO4sCZFN8dxufUgFyaTfRJ4fpqkROA7scNfcjusxn50T52SEVzRCuzve
 U5Q8wDfULyTMtF4o50jxNgc1nidBmuW62C7grnyyINlkM3YdfKMOsieaEbk2EOqbnNDeHyKZ4
 KWUvYKhjqH5yiNkIPTE/zXVYCUTZC1RvhiXO5jSls7/LuIK4Shtqhx9j2ji2iTEp2dzn7vYun
 rSmQFE8AUdCsJQUyUlCAONZh1D3egXBmHjNwyOBy20VAiV4nRqv61cfHt6xLm06f41nQV0Imr
 7/uuoOTs9P74hmmXy02MTelkcEJthxG8x/+7xWCYokHSAu37UGZIHwQZV2c4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> There is no bug here.
>>
>> Do you find duplicated source code questionable?
>
> No.

Do you disagree to the following information which can be provided by
a coccicheck run?

./drivers/s390/crypto/pkey_api.c:722:8-15: WARNING opportunity for memdup_=
user


> It is something that can be improved through
> code consolidation though.
>
>> Is this also an error item?
>
> Definitely not.

Your view seems to be very limited at the moment.


> It is _only_ an error if there is some logic defect.
> There is no logic defect here.

I suggest to consider additional software weaknesses besides logic errors.
Do we occasionally care any more for the development principle
=E2=80=9CDon't repeat yourself=E2=80=9D?

Regards,
Markus
