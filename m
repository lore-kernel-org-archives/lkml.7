Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF33C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 07:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E086214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 07:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Zza18gqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfF2HlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 03:41:25 -0400
Received: from mout.web.de ([212.227.17.11]:41873 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfF2HlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 03:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561794052;
        bh=JGm6xjnJ/hvdnhaxOvO5r4QNC/iO6BgDVdE/wPZe9z8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=Zza18gqEAaHreow3+DIA3ZoGBENvFOyD50F30lix5aIlZvUynzQvcdLenFcL6Jac8
         zwq/GnzVhzwkbw81qDqPXrMJhlRFCCuzXC6F0kIUlJt/jyBVyzNykCEGqM4RVVQIEM
         rmvig2SExsRER2n1JKN5C2oU20BXuh/kT+eoa+mY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.176.71]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M40zO-1iXZyQ09uE-00rYIk; Sat, 29
 Jun 2019 09:40:52 +0200
Subject: Re: [v2] coccinelle: semantic code search for missing of_node_put
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Cc:     Yi Wang <wang.yi59@zte.com.cn>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <1561690732-20694-1-git-send-email-wen.yang99@zte.com.cn>
 <904b9362-cd01-ffc9-600b-0c48848617a0@web.de>
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
Message-ID: <76641efc-2e3e-8664-03b2-4eb82f01c275@web.de>
Date:   Sat, 29 Jun 2019 09:40:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <904b9362-cd01-ffc9-600b-0c48848617a0@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kQ3P0CsmExYuhpgLOWqOg91cp8lvok84fySGm5yOssSiP5iuL9G
 zNT+A0uRqecWi4HnKVq5bJr7FwdeDQ+PdYbxbkmeMmkXuvB0sFxcj2PY5lFfBxImN+kULhQ
 7mycJX2Re4m9ZE5njSbGGsj4gVyW+vy8DKJnbJxHdWYkHN8c89iUqLGvroHNjA3yL+nNqEs
 ncIT0w9/T9uf1ZfTWYslg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W7bN9icyko8=:Re3W9TdA834co/YS5gnAs8
 y7GK8OUA0U0GbZg2W58IeYCwl1EY9l7RjL+wlioC5T8Ihde5VTQPo5d0gnbpKbT0mDqrhLpIx
 7k6tDZO7oq3N7EhIrHIoxaaBTZyBT1PClJrBpOcwyvNkZKuqWrZqNYsrNC9jxOZXKHPd3b/3r
 7Fe7TNdSnSlQKLUZdzxGdOtz2ftnWnEgzYm6ahoMBBVPqEFs7Jp1/+dr+ZPb9qz71CTVlIQpH
 JvSoeD52hP5SCiN/uDJ9imo29lTAnnuBqTPtTsxQt78c5h2fUv7jYpAT9oJn1o0kkWd/J00C9
 TQGJx7djBbqBWsj+z9s3QIed1qSrxoYhrmACSK1uHEl4IY3Qpygj6rn/7X5ZPVvm2ofzwpSPM
 2Fi4WA2G0LNE8rvr6BdRllwVoDZw9AMEPtqio6V4TCTBDAfRpW6LgaM/flCA8o9HOOK6KkvAR
 rqCNbgIJpbiLFIZ9uFovaEAHKrDruDvbtTjl0O/5utAIfW8zbon+rSIVlGHpc8ldx/zEoA4Z+
 ge4TCjLMIFIlPjofLD5qNaffRf1W2f9R45RMEBmbsp7f4sV8+kLT81LRZhd3EolRq4xPt+yqp
 SRRLJAByEIG5r5BsTdUajMZ0Qu12o1GbosgqEEn0JlsghsR8uclg1l7UZFbreGC0KJxtxhy0K
 H5y/e+1dTu+arFXOWCSZoZfjwdmNgjmWj+3Gml/WtHq0K57dLWpMpcASYAsxRLGupTZgZiVnN
 BC9WUL6R3gqvp/HJ3YlDLFHki+CHhUHAXxME57K78LtZKle3FQDt1P9VkXFNtFj7gyBZaix9i
 eVUh6rhy/WQMx6C2BXkG2gst9jcCEehNUujUWn+v13FN/p7fTwahvUvep7DLLm/rdn8AxvI10
 EAGpCqkijEQXnVUZkUlvI3Y9vrrF4N/1UOy5xtLHmhi+3UTJ3Vdrifculm27mkvoMX9+HKPhf
 wOoT6MkQwzok4YmW8EgMJGonW/34RLRoFzSFfpawbywE9HCVLjUiEeJ0CGyd1hDCqzavbLYsh
 FImktHz45FxIr1IpjLoqUj6OBwMD1ltGiWzrYyIDwfImepGnEW4wI/HvB1pBk41IsmfMrr4o9
 UVB8EvxCbUkUtfsAa8T9R7Yt3Xl91mhHZFF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +if (x =3D=3D NULL || ...) S
>> +... when !=3D e =3D (T)x
>> +    when !=3D true x =3D=3D NULL
>
> I wonder if this code exclusion specification is really required
> after a null pointer was checked before.

I would like to add another view for this implementation detail.

The when constraint can express a software desire which can be reasonable
to some degree. You would like to be sure that a null pointer will not occ=
ur
after a corresponding check succeeded.

* But I feel unsure about the circumstances under which the Coccinelle sof=
tware
  can determine this aspect actually.

* I find that it can eventually make sense only after the content of
  the local variable (which is identified by =E2=80=9Cx=E2=80=9D) was modi=
fied.
  Thus I would find the exclusion of assignments more useful at this place=
.

Regards,
Markus
