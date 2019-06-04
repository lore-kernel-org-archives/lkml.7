Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A128C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1542249CD
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WAyVGB0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFDF5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 01:57:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36620 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDF5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 01:57:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id v22so13306728wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 22:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=bbeR503p+wv1ZvD9OWStlhR/wMQFxV658+S6NDzamMQ=;
        b=WAyVGB0ToeoFE+B4bDdTFe1BVunRDYf6Spi2ZEcV8Etz6hz4wwPfiZMpucad4mdrD3
         5g1BJNa+RCzhmPO2I+V+0YGQ/AFnxzrA68TWOwn4QDdNaIMInffkWr8IvPGN8JGZoesZ
         Dx9yBSqbqR1lsy39yn74DrYI77BPJFO2AtcsKw4CxuR/6L9V3YjsZZcnfqkDwGLrxnH3
         R5VmM6A+e5cqm4mXXuoJ4Cf/We2nZvjxlCVX8EKn1X7Kxica+Exc6dItPrfZoYsAHTWR
         h5Cab7Yj/7aD/UX6ZHqZjPRlPT2VgqlGZOLY5RbFcEZdrLMlL9j8S7HYmm8ydBsDdMHZ
         stog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=bbeR503p+wv1ZvD9OWStlhR/wMQFxV658+S6NDzamMQ=;
        b=Xs6KHRKiSvdoyOJbLcpamT5Q91Ey3c1GzrkNzxr5gNlEZ6b55fGw0rxMcD64NdYgUH
         Sh4Il3jLW/7x8wOUVmS5zCkyUggUe0ydcTWPfV2oi4R3paelNC+1NFBl328CVyySItoS
         jBvQuF3o36W8yV4vcvB7Nt6d2N22qqt2/xW8Nc1+zlntx4vixQiZJV6FfB0tGRedvP7I
         /LTQdVdUGRDYDsDTRJ9xA82ImUnXwGcCrqkbN6QTbXfGfOit15nvI/JYsuZRNTzaFfBi
         xj8ykTZhpsAl+ggReSGekV/lWe/0CcWk4HotEomhY58xPdP3sI2MsmBszpjqtaVubE2S
         gMHw==
X-Gm-Message-State: APjAAAXKcVXL4z75niiG1srFloKVoS2iupzNyiRouZ8PwkItSm2AAYpB
        EU5kbSryEukZmqb1NZmsfE/bCw==
X-Google-Smtp-Source: APXvYqx8rJggTMhwm6JBFoBgXUsS5M4GBhiwi/73kjX+aZzfstGqfzxO1YiXx5B877eFxm3KaaTSxA==
X-Received: by 2002:a1c:51:: with SMTP id 78mr17568940wma.9.1559627855215;
        Mon, 03 Jun 2019 22:57:35 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id h12sm13149983wre.14.2019.06.03.22.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 22:57:34 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the clockevents tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20190603121350.653cacce@canb.auug.org.au>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6592f64c-79c1-7ac4-dfa5-499362539319@linaro.org>
Date:   Tue, 4 Jun 2019 07:56:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603121350.653cacce@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NrJx8NTzwLwIiQQR8J2rTXucbgAU2hrW5"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NrJx8NTzwLwIiQQR8J2rTXucbgAU2hrW5
Content-Type: multipart/mixed; boundary="lhrNJrKFPsbnxvHxyPMMfXzt6lrMJuyEZ";
 protected-headers="v1"
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Message-ID: <6592f64c-79c1-7ac4-dfa5-499362539319@linaro.org>
Subject: Re: linux-next: build failure after merge of the clockevents tree
References: <20190603121350.653cacce@canb.auug.org.au>
In-Reply-To: <20190603121350.653cacce@canb.auug.org.au>

--lhrNJrKFPsbnxvHxyPMMfXzt6lrMJuyEZ
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


Hi Stephen,

I dropped the patch from my tree.

Thanks

  -- Daniel

On 03/06/2019 04:13, Stephen Rothwell wrote:
> Hi Daniel,
>=20
> After merging the clockevents tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/clocksource/timer-atmel-tcb.c: In function 'tcb_clksrc_init':
> drivers/clocksource/timer-atmel-tcb.c:448:17: error: invalid use of und=
efined type 'struct delay_timer'
>    tc_delay_timer.read_current_timer =3D tc_delay_timer_read32;
>                  ^
> drivers/clocksource/timer-atmel-tcb.c:461:17: error: invalid use of und=
efined type 'struct delay_timer'
>    tc_delay_timer.read_current_timer =3D tc_delay_timer_read;
>                  ^
> drivers/clocksource/timer-atmel-tcb.c:476:16: error: invalid use of und=
efined type 'struct delay_timer'
>   tc_delay_timer.freq =3D divided_rate;
>                 ^
> drivers/clocksource/timer-atmel-tcb.c:477:2: error: implicit declaratio=
n of function 'register_current_timer_delay'; did you mean 'read_current_=
timer'? [-Werror=3Dimplicit-function-declaration]
>   register_current_timer_delay(&tc_delay_timer);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   read_current_timer
> drivers/clocksource/timer-atmel-tcb.c: At top level:
> drivers/clocksource/timer-atmel-tcb.c:129:27: error: storage size of 't=
c_delay_timer' isn't known
>  static struct delay_timer tc_delay_timer;
>                            ^~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
>=20
> Caused by commit
>=20
>   dd40f5020581 ("clocksource/drivers/tcb_clksrc: Register delay timer")=

>=20
> I have reverted that commit for today.
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



--lhrNJrKFPsbnxvHxyPMMfXzt6lrMJuyEZ--

--NrJx8NTzwLwIiQQR8J2rTXucbgAU2hrW5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEGn3N4YVz0WNVyHskqDIjiipP6E8FAlz2CE0ACgkQqDIjiipP
6E9tgQgAo2dvX1ARK2lzEtylpEAmE8a+PEX7kSmXn0oApwkvIpPZUUEVr8BDiM0E
1Cg/ggAI+OWvTJSPzLeT3I6DJ3zPF6r9j0p2/Kx9q79sLErtu+xYGIS6M08kN+yk
YMlVwUPyCiCqwoEzDio7pWkSx9Bpuy8JQeUkR0/7Lk4pbDSEs3B5La8bVpKr2om8
AvRYU43k9Hshkd0jlkpSnG3MDEABcP+wM8R4AlKUhGu3dLJzDAqG+GapMiotNXmj
b1elfETgfYZb8KM00+ssBby07Rh19TIlHGm/LkvyGWuKUbIvZ3Ce7YLwLDkAPwJc
wIW/+/lKzjl9RTascpxq/HOn/WlZdA==
=hV81
-----END PGP SIGNATURE-----

--NrJx8NTzwLwIiQQR8J2rTXucbgAU2hrW5--
