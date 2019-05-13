Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC84C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40B82084E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dAysFmdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfEMMfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:35:41 -0400
Received: from mout.web.de ([212.227.15.4]:42027 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbfEMMfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557750925;
        bh=s2JwT04pr5DiFfwCGxcWShqS8T53ijJOigWJJZv4vuk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dAysFmdVUbWM8lf0wWzfmL2zO4qJ2wbghvyENo4npsu8/BuVj8WyaVzPWhgBiKzud
         Gm28h3sRANd0emKC1uBaQBuNQV177gJeW2OmVeyNlbRP5yskabBDBwikkeVNUvfnkr
         46qhYewnIT9kyhgtqqZjZKD53DhHsjI6bas2iK2g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.147.80]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LuIAZ-1gjZeN3Y63-011lES; Mon, 13
 May 2019 14:35:25 +0200
Subject: Re: [5/5] Coccinelle: put_device: Merge two SmPL when constraints
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
 <a29de02f-8726-c487-6d71-30979d153647@web.de>
 <alpine.DEB.2.20.1905131129440.3616@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <d8f6adfe-6b43-2450-adb1-d7f16a805fcf@web.de>
Date:   Mon, 13 May 2019 14:35:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1905131129440.3616@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iKADvqiuEbSsQrOYCIOCR5LZyHPQBjlk27Vl0vsVdDslztbNaL5
 YS/geaM1bcrKZu5SkH4KpCass1rN30uQsSdGMSnHN5zn6CQKCc8YEgjj0XMPszNmjcfCosd
 in0H+9vrLS51bimH56C845VQgIy7MPFdgEx6d+VcyWO55rhrirkRQ0nsN5NVS9yxzlj5t+Y
 E6ceHsAXoP9ZSbZVGKL/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aLo5GEiIGD4=:xkaV7XMCOUDBrR7KM23Y7q
 rk2BR5Y73Q7M4ZKcQIFfRJ9QoXez37zE6+NyTeqAEfZHnsH4mPrz60fAr1B+uZh7ceOqHSvjz
 NOlR81m2/OWUDf/Q63jGoChry7400jAjlNPVPZ+8NvEG/zrWd+fSBMTma8pfgGkuF4IXZJBWD
 72TGQNRGW17eT1LCr3uhdaCa55yuJosDwNPGE4ggt+f5bixAK9Mb0p5Xh/lXaI7Ac82TiTPMa
 CVGBlGKqkwiwLTEXPd8sSZp+LAHkF4vP3keEUvq3y6JeIGPARxhsOxDKA1qrtzi5gdFCRaAcq
 CyMbXm5QoZVwhqDtow0iScWAZejfFkuuZjO89kZaTTCG8kXJFAcK7OLLLWS7MgNoRuy3dxWMc
 YVUsCYYSl9xj3Gxz76oKzZoS6TqOTFJTq7RJ+2l2/Bi1M2mms4S3zT7EENGo4IuEpxg24thqS
 5KX6q1gd7qJgCgzD3px1UfgxYpYTsa/hZbNLoCFqm39etdJ/JhPYK1wsAa0xkOSj3zLFnvn/n
 BMfvx0JlA6OxMdCpoC/G1DcgRNXQlWluuxBGOxQcnWieCvnSVjhgjxnZpMlcx2C7+LPPPih7C
 /AZ7/IP9ksbttgzi7kV+IHoRW6ams47MZuUwKlslGWQFOGzMPMgegfKkhpGAH7AsuC+H2oUAR
 Hm8WnXdRchwF0zUQiU3kL2sRF4uerNEChLhgqvH2w6hkAKflCAwEEzZIH/d+kVCESeHs+fahX
 1DYVhSXshqfFRNA6Xg16TkUOIAvRzffxGQaae9C/DRtFYAvEmY3e2n/IGAFL7YlmBNtx7CFkw
 ooKOu/pJCgrQLhZwE8O3/KHWE2Gccp2Zex7DxsMWgOirb2gj+Uq9IJth8jXL8If9e09FFJglF
 C6+4nbWUHlJnCTIkA7Gz9+kXCniQOwimh2AMqF1pvKuf9/W4XizbHPQ/NoRTylyowgWNf0qNS
 U3tIZmsu6yg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Combine the exclusion specifications into a disjunction for the semanti=
c
>> patch language so that this argument is referenced only once there.
=E2=80=A6
> NACK.  This hurts readability

I suggest to reconsider such readability concerns once more.
Can corresponding software limitations be adjusted any further?


> and gives no practical benefit.

I guess that you know better which aspects can matter also here
for software fine-tuning.


>> +++ b/scripts/coccinelle/free/put_device.cocci
>> @@ -22,8 +22,7 @@ id =3D of_find_device_by_node@p1(x)
>>  if (id =3D=3D NULL || ...) { ... return ...; }
>>  ... when !=3D put_device(&id->dev)
>>      when !=3D id =3D (T6)(e)
>> -    when !=3D platform_device_put(id)
>> -    when !=3D of_dev_put(id)
>> +    when !=3D \( platform_device_put \| of_dev_put \) (id)

Can the reduction of a bit of duplicate SmPL code result in nicer
run time characteristics?

Regards,
Markus
