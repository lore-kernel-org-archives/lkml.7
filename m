Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27D9C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794DD2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="HPia1lGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfEMLsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:48:52 -0400
Received: from mout.web.de ([212.227.17.12]:53475 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfEMLsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557748108;
        bh=/TUElLrp3qrIx5JkytwpMcAYLDzBJ3PVW+f5ZLjI6K0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HPia1lGH/KOlXHMq1bJu5NZk3derC3Ktr4WnLiTaefCSu7Zt1TCjNI6rGW+JryWMA
         uyPSo05X8zF91iRkZINS4yqnClFa+9yl8iUg6WIhNy+LZxknsGLKulDhV6nbDAEyf0
         GACyaFPKs1gJC+GJtuCzngxD5HTlxQHffxffZqwc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.147.80]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWjAd-1hAy7L0Vvn-00XuKx; Mon, 13
 May 2019 13:48:28 +0200
Subject: Re: [3/5] Coccinelle: put_device: Merge four SmPL when constraints
 into one
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
 <6b62ecb5-ab88-22d9-eee2-db4f58b6d2ae@web.de>
 <alpine.DEB.2.20.1905131132250.3616@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2bd3e838-b28c-ad62-4440-3b8790314210@web.de>
Date:   Mon, 13 May 2019 13:48:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1905131132250.3616@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EdIOIogVy4Y3YGvd1ZnrasfajLET7BduajLN3D3ZR1JUkhkOl7B
 bi6k4JPdi//mB53kcwLNfBO+bXcVEj1UqQYjihFVBlj4ut40GbCpV585pUF/DGoy+UcslYP
 cGxMsOi1kAO2wwUp5xfVx29mn6MAJvGN4GoO2eGfNv1WLTFHnrHJ1uca4exF8R6hUtLilz5
 bsPZiA7TYT0JFT+W9ucyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YV5BpllwAac=:b4rVCqdhEQffUOGXooqsfM
 ElU17LD4alt9Tn992/O1OG1YNZRgA0hQy9MPFg04Gc+r874/KBfK7mj+5oYU0h1luaum9Mpgo
 X0Uob6zba3zofl/DPCM0j6ylesshvm7q3ydTKYy6oQBa/qcP1mDTbDmb1t17PISIOK9jiTBnm
 kflJOqF5niXxSppMCm/3Cfa62IoFxQwgRyDUgWfknCpHHUawRGmtY/lyJ/N+pxSW/OLqczZ8s
 0tXAb0UjTfShFx68TUqpUUiN/1Mi/jKdSGqL/V3GAdxXZBQ3IcMDFlfrA45UZMHQOJDoLgDqw
 eImd88ArJeIUINm1nMe4RzZ98Vef80+yyyOf7oOreiaHStlyxpZXe6vrNuwkQxzKpkcUe0utB
 07MZU+q1AFFU5X/r4WE2YVY8ALP0dwUqXR2+Ug7sLXzd3WVthBJTXmP3261G0NcRbFxxzzBT/
 Hjd94vcATVZS2bt2WOeJ8W/Xkydy7GDL7StSSmi4e5MMha9zhiuDi52W42R2QaigHWDQn722J
 /LY5fBAmUvcszhBogKz2xKq+8dY0FgWpQdLvKBKwxVbKy7JtNBmGkfizSm9PQ3tSr9YtTK853
 YKao1IBPaqmYrbQIdXUzzB2RnOJX0O8TO2PGB1dbenES3zN32V/mdIgTrf9ib1OnkwsyM5wOt
 Mp5C8/qBLr39UZ3H4P7zFsmAasu8LIxF0gYHSbdDgWdX68byWze4/hP0cbgyQuBLNkHgdEmF4
 DQfA+rxf2ZaR/vqjcC8CAqDHxsarWh0qm4H/87A4fVTHvEUwJtUfH48ZaehF7jorf929CrA8e
 nZoUQMr/CAVMJz9Cerb0+8ij8JOjSACLGAZINVHUhLf0Dqi3M9rvK+bwac3ZUCQAkrl6igIXc
 niHuhb31GZ+0UT8NWRlAaDy0cRXQm/MlC2UOlVyRvhpjVFE07JPwkwHHsKAXqdimbkFW0PQ3N
 F/OcIf3NGNw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> An assignment target was repeated in four SmPL when constraints.
>> Combine the exclusion specifications into disjunctions for the semantic
>> patch language so that this target is referenced only once there.
>
> NACK.

I find this rejection questionable.


> This exceeds 80 characters

The line became 105 characters long.
14 space characters can eventually be omitted.


> and provides no readability benefit.

I try to stress SmPL functionality in this use case.


>> +++ b/scripts/coccinelle/free/put_device.cocci
>> @@ -23,10 +23,7 @@ if (id =3D=3D NULL || ...) { ... return ...; }
>>      when !=3D platform_device_put(id)
>>      when !=3D of_dev_put(id)
>>      when !=3D if (id) { ... put_device(&id->dev) ... }
>> -    when !=3D e1 =3D (T)id
>> -    when !=3D e1 =3D (T)(&id->dev)
>> -    when !=3D e1 =3D get_device(&id->dev)
>> -    when !=3D e1 =3D (T1)platform_get_drvdata(id)
>> +    when !=3D e1 =3D \( (T) \( id \| (&id->dev) \) \| get_device(&id->=
dev) \| (T1)platform_get_drvdata(id) \)

How do you think about to extend the Coccinelle software in the way
that such a detailed constraint can be specified on separate lines
(without duplicated SmPL code)?

How long will it take to reconsider corresponding software limitations?

Regards,
Markus
