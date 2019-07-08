Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDA1C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A1820861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="m6d7Soa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfGHLu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:50:57 -0400
Received: from mout.web.de ([217.72.192.78]:50145 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbfGHLu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562586652;
        bh=/5qdp01UeFPeTv/IgWA+SlPRl1cs1H2wIs2q7jCy5I8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=m6d7Soa5/r9et8gMWytPKSbEYtI5PTZPiGQpzIIwldIqmGr8G5LplpSSKQgRr/q6R
         8BpCho0rMY8elKBbcQZPC46g8ZqjHReJL6HlM4vdmWBBzcQMUywKMZcqVX3PYGcZj4
         yMBsdVKvmUv7Nt9p0n5RV0Gq4X1YVADPC0+RAhCE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.165.233]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEEiK-1hiEBH3YJk-00FUik; Mon, 08
 Jul 2019 13:50:51 +0200
Subject: Re: mfd: asic3: One function call less in asic3_irq_probe()
To:     Enrico Weigelt <lkml@metux.net>, kernel-janitors@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <01f6a8cd-0205-8d34-2aa3-e4b691e7eb95@web.de>
 <20190707005251.GQ17978@ZenIV.linux.org.uk>
 <4b06e2fb-a0ba-56e5-b46b-98e986e6f2fd@web.de>
 <6e8eab5f-1f5c-b3dc-6b65-96a874ec2789@metux.net>
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
Message-ID: <b116fc90-9558-8609-d803-7d8da2b66e0a@web.de>
Date:   Mon, 8 Jul 2019 13:50:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6e8eab5f-1f5c-b3dc-6b65-96a874ec2789@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R8Nk1rJ9MI+MdXfvRyrxSS5g0e0xYNiBoYEy/SLER36KdCnrqtQ
 IcQrfyMsyRr4gQ5wS42nX9iei78tHb1iL0PQK2sHKldSIpwvcf/EWth4AnZbd78OV0PZRDe
 paAvCvclUoSvDcKpB+wXSQ8DsUkR+QiyHOy52hFD4jOSirDeR8rh2TpySxwldXKrY8ALMC3
 lzoXkaQYEiH6aS5YMI5Rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EPFzdssh9PI=:xXSK1eq7mJGphm94w2LPzY
 MosAtRMIU8GZK3MfraAwT2Zp7KI4q72tY1ISQP9D+pgJEIkHnA5fL3/WDmCJuZhz9wjBFOr7m
 9pLxZfCR5ke6Exwp+53+c/pnp7isKrdGi6l6XFD/ZpjPD3wqQAbVnl0mbGr+WB9Lln8r0olNJ
 5UaFiKhhhl4j7g6afndEVg4PfdXKiTaHWzaW2ABrj3TpyhqpBOTBXadskgnXt7GvEacS3M9lY
 wmLhWeHvAZ5yObWquRMTzHvdfh9PRKCSvmcloTUupG09pg8+Y3oTroP1eHNEDy0WAB2PdGtiD
 4T9K7Mxp5ktYo///ioJnLGwSfJePb+Pk8UbOG0PJb4KI4ud7kspKIlPFyGKaoNHP5A1JH8ndI
 q6euDUM8ZV18y5vRsK1HhWammCIR1suZMqkZrEUruRBHaWZOVzeujUtFqd6kJKLN4Hfpenfbu
 dNbUae4dz+Ybqwx7Xhe82oUoMhQSl0hDXaw7tncwAhib5Bdju4sfUS7HTRWFUUi9b9an9KDK9
 5JwJvG2cXltfn2C6/4P8edKZ9opv+IZ0444hY3QKCNXbWbhJCKp3AipGiEacY9HEfOE5apyso
 lfj7aKNlVi5lAJ/pWKrxZ6Yhaa7uzYguJwBdfA3FFQj/lUIgZJ0ZaIVsqzI6x2eSV4Wwf6GOl
 XT3wMNinbPjtZv5GS5TmnkrMvuDmI+Dn3QUn+AsDDn4pIIuKYnpG5W8KQwpdnu92Z7yBVPd1g
 fDlE5FGR4L6KKDhDuL2NZdt1v1K9seJK7X+Iot+e52xjPXcxCXRJmq8lZsddV32+W4FooZ+WV
 rs98oryF2cgKtYEXJxZDqOWNXnKoUUAZExst+xznAdkOolZ7yXRUn1vk6l4+fLzu9B1r2pm/5
 8NZMCRbycztL3UzGMzBaVMVi6AkM7b2Su4rLpS/eFNTJm27tr8pwgCInjyvpt9Pn5A4S7Msro
 CM6rtjZ9WrGG4ICWiKIn5BTaZ+54zAxC9xt2MW6ccTB4o4PLEsiY8bM3JAng0w9EDJviZv0tI
 826GoZCyj2kAqjWknQtd1yTJcJ7k5T+s2etGBJr5j7n8hEwI5Pd4XPrRPWPwRdBmue6+AVgCB
 6bbn5qzgJN9L5zScnfoB7ly6zJFHHTwYY9f
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I suggest to reduce a bit of duplicate source code also at this place.
>
> Duplicate code (logic) or just characters ?

Both.


> IMHO, readability is an important aspect, so we could be careful about t=
hat.

This is usual.

The code text size can influence this aspect in considerable ways.


>> We can have different opinions about the criteria which are relevant he=
re.
>
> Which criterias are you operating on ?

I suggest occasionally again to reconsider consequences around a principle
like =E2=80=9CDon't repeat yourself=E2=80=9D.


> I think it's good that you're using tools like cocci for pointing out
> *possible* points of useful refactoring.

Thanks for your general understanding.


> But that doesn't mean that a particular patch can be accepted
> or not in the greater context.

Would you like to find the corresponding change acceptance out at all?


> Note that such issues are pretty subjective

The situation depends on some factors.


> - it's not a technical

I got an other impression.


> but an asthetic matter,

This matters also.


> so such issues can't be resolved by logic.

I guess that it can help.

Regards,
Markus
