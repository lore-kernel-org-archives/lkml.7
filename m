Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD08C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BB921880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EUpNtT1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfHEMbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:31:03 -0400
Received: from mout.web.de ([217.72.192.78]:33601 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbfHEMbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565008256;
        bh=tzKShZ2/Dvkrww1urrj29rSoI7Xak7oU4hVwPnF7So8=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=EUpNtT1LFyfKbEUZ11vH9Qk/YMefOSXoXIcQ6qY/y919tkCAMGGiLVQFrX7KQkdHt
         I1w8HgZDHCIFbU3K8Zxg21V7sSPSOf+80P8bFcJRNPS59FL70wV3bhuEeUR+t8wE0M
         q6Jl6m8hRcNlUBZYFHIaXXKkiF4klxNKWLwvwcNk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.163.134]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1G68-1iAEBM0LlI-00t9zm; Mon, 05
 Aug 2019 14:30:56 +0200
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190804162023.5673-1-nishkadg.linux@gmail.com>
Subject: Re: [PATCH] regulator: core: Add of_node_put() before return
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
Message-ID: <127231a4-f181-e172-2262-eb2604cacb0b@web.de>
Date:   Mon, 5 Aug 2019 14:30:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190804162023.5673-1-nishkadg.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8kabLYinEM8xQO8kHHX3i+qIraeKMHwrh8Og99qJ1m7KAWg4MZ3
 DTv618bMfp2H1gyP8PTLXnEXowh56aK2WYJY0sz14EnXqLeh3fAbxZcLuJ2TfKViWk68g7+
 FxfK4wc5+illvU0e0/NtLwNtC+GLINDcIRCrwSGTZuChnmVn8kIpWoAfoZTGjOTIqfOzQUQ
 gJ5bFzfOufd4EQHryo3Ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1a7Q0J7/lgs=:ZkJWcf3+6AJELJbzqNesIh
 WvHjhAAoyvRJNtBLTJh+P+PzxnDzgF5/uBd8eJxBeeZ1de1T17BO1hBasMFZlIsHtzBspjeqB
 KKhgH0guETdYQc1FednIxXLSiPnK7LE0dZhSEd8wKdjwpwHjo0CExABwUHHToh2m3p+8Ztwsv
 EC0WKG2AnfiZZop1n84AjcXpTBc81rBXsNnbEAyZbipH6e9ne2sw4IV0TgB0k3vAxeMYjcDei
 3YqShlr2dGs5CVgwHHWsWFFwDFr+K+Kf9QShKAFBhQNIBz3h81f5SkeTTe/w3Ur3JhKsgRsKm
 WYcyX1qR5iP5bGsI4xoEvH5bxcPO7RwlJbS6RA5lEkSu36G7be/oM+pUnuVEqg86z42XfiUIr
 FpAgaYhJNFY6oynyD+pmUXy7NyUSNYOMOO4EZ79nuKuRHlYaInTNelcC8ynOnBY9DyHV9Px7d
 cZcxdUUvuNXbpXXHr4pmEKJJFKIiAA7cZcjC5U202W+FPHLTcdd0UEusZzgJ6mZzwLjoshnO4
 ePBilG19XvZpTymzDdF+w2A7sEyW+HgcIH9claVkilDHp49X4SVxkGSp2bu00kJUOVLWi7VqW
 hchP65mWquMgZVWmYnEyrfFPnLQs3f+LVnThpL/gtRJ+9Q6WlALSxKJtVqkeg8HimfcbhYJgt
 DJ80KvKp8m9YJPI9OpiNW0pfr82fjdWJfn84DHgJE48YYl6imZBZSLx4y3E92Sd7rjl/XUAAH
 4C5eH1U47dpTBXooMoh7c66oP/kOcxfBKF31uKt6v/V97UIBRetQKRgnzp//ORElUYWsC9IOQ
 ogbgshelniMn/KzVrZk3tQJwA3Zs8JSDm5ROFUGSy0IcwbVWLHKdOoFGb8CFOw8wO39y2O+JR
 /ScXDfA+w2mkMmaawjXN7bs8ua2P5YpwRd8b45QeYazvKWUI6CPZktzkPL0j4WgE2F7QIDUtn
 7z22vRmCbdPoYvs/u609RB2INkP2thl4kldg1wJTgBTV/lN1Ox4ICt76RUMz3WslxggvITRJH
 vTQPsinw3f6fKoruwDVQbFCO47Y/94CRihSC0FZLthjsqW7kX4pizeNv1L3bJ1UkxwkugiHMq
 1Zs6c2AS6OcnCNyke1pOjDGksOwfrZQ4TRLFHoJ94uOGrWUjC3L37sM5SAyBOrlFeO+TzPXEO
 2B7l0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/drivers/regulator/core.c
> @@ -380,9 +380,12 @@ static struct device_node *of_get_child_regulator(s=
truct device_node *parent,
>
>  		if (!regnode) {
>  			regnode =3D of_get_child_regulator(child, prop_name);
> -			if (regnode)
> +			if (regnode) {
> +				of_node_put(child);
>  				return regnode;
> +			}
>  		} else {
> +			of_node_put(child);
>  			return regnode;
>  		}
>  	}

I suggest to move common exception handling code to the end of
this function implementation.
Would you like to add a jump target like =E2=80=9Cput_node=E2=80=9D?

Regards,
Markus
