Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9180AC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1B320661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="N4UJD9Yn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgAIMBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:01:16 -0500
Received: from mout.web.de ([212.227.15.3]:46645 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbgAIMBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1578571253;
        bh=MtuFhM24nmAwmDe9k5ReeWMFA1+3sNpHn7OcfJGEcXQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=N4UJD9YnoMzYi1VKfueXGLm6S2RjZ8M1Ao33pzFIsmX8GkwbTmKAUrzK9dA8GLA9q
         rqH9zRpDUDZvcEcJRsKuSHvZLrbBHPnZ17tss0aVRWBTFr7Qg+Jyi3Uzj69QVbV3CH
         oyFa9V0YoYQFEDPkuh0SqcEAij3WMBZEhK+TE/kI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.1.10]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCqWJ-1ixX6M0Quh-009iAH; Thu, 09
 Jan 2020 13:00:53 +0100
Subject: Re: [v2] coccinelle: semantic patch to check for inappropriate
 do_div() calls
To:     Julia Lawall <julia.lawall@inria.fr>,
        Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200107170240.47207-1-wenyang@linux.alibaba.com>
 <9a2b7d00-442e-0c1b-73cc-aed2bbecd13a@web.de>
 <alpine.DEB.2.21.2001091140380.10786@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
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
Message-ID: <e479c5c7-2556-eb77-9e9c-8833fb883a39@web.de>
Date:   Thu, 9 Jan 2020 13:00:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001091140380.10786@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5aYwA7S70RO6EmQuqK9G6MB1qflCOs2VzvPvtvC4OVEy+5kPEoj
 reNyD9BKxuJtE950FKoILjGt/z0S85jdJ1EM5Js76IFl487jWh3xayNuBJ7K3EapDI5LYar
 t6fpLWPmgFuR5pH6wHINZqvYCFCIx+ZXBl/Uy5bNplIyNg0cIyY/njOASpwFxq4R8XzUbn5
 Um9rF4xnhcCHntJKqVFyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P+A7F8x5jR0=:CuI1FYWm0Ehek67SIKlz/O
 zjhylomqixm/79cKD2zG2uwWdv9+mgq6UOhfr7teA/2JCqg1x6bWFD+GaskriMWEyObh48Lj0
 +tEqhBQjVl8kv5ZIsxj67cfvGdrtEbQeT7R6F84IQPgCw9b4OSgiBjVxqrAeGbBQpTbkLKC6R
 VxTF84Xr1bPuSg7AtHnhzde+nnjElnfUtOlUkirNH78vcxEAoTPQbsTNlI2l+NdFYlyWYGoL7
 w0DlriciXkThyP7O5a9TaTz7Sl3qdAh+W0QayUkLxEYq0fUP7MoLfl+sdz2EgVmfDbz8ugFsm
 21zdmTueE2v2N4CF/VWzVtG3wTqibs1VE4mYvJ1WjmSYH+ukNhw7kRAsIvTg5tjLbCmD0QVx0
 qaTwGu09UKxdGre5fgSN/o1yRNNTJ6dG97Fx4LAr4xbDhd6Y40sTASHpUAYS+IGbj5PN4F89v
 OakNsOb8JZ5Qx3FCnw0/rdEXJvHovs839oZpIxdB4V0zd/NM10+O/uN24qjOxDDECxnT+I27U
 4kLEHyE5GsbGfJjLv0ocvOnJQDBGGXxEZV7ArKn+ZALt8OkQZKhMM/pxRivyjbG3VMDlQtoxW
 9jAAZFHszUc/GIZ55F2uPkDdxNviFTqVnkExOCB1FYprBZDxdUaKv3FItZFf/FTcbw0It6O/l
 1R0ZCzmDytWBU3W2LEBul826lyH0sTtyzdaj172p4GykAfhmhmCQ2a/D7cPLlHNiBhy/cCn3t
 VuLzneEVviEBoSoXznZE9IF3wvnJ8uA6XtdU79zgoQR3kZgcEEJCpNFo/P0LYjBEvT493Uc+L
 Fvux07ns6DDtxsNkGAufFPTUUqoWuhRhDELzDVuqW6d4G35puYnOU7lQxzKyV9FGhnhwybfOP
 1EVwtY9VlACFwnPS41+MoUXyGsDkaM9Bmqm6H5tgoa58GkbxEnp5fqSeetcCfV/jULNurvEwA
 XEC3gYP4Z9c984fmxAth7+saFQMtGukDSeKmU6qnbt8llh4SHUw2VXlORsYq79TakIq2G3Qa7
 g3vY4rtIfXfmgk9sj7yASG1i6Sp1HnJoPMd/ba7nCPQzfLEQpz/srEAqUOvGc3uUlKE1ihXAa
 XtV1tMezcOYcr0mpn2cRUQDMsWxw4fKVONcARAci4ErPz7L4z1x0qKbC/IBcbWd2ikKkzfeuA
 HMBSpFidB1Kvvj4JxiaxpzNaHuPNSl9pHFZuN0JEbLrA0DtJ3F++V5TwME/6cdKpJnOPryRR/
 EK+LuvGemPPhCBwC10ZWB3gM/fM1KUvvTzfCndC54wAOfRbIH49xBFahTcVg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Thus I suggest now to split the source code search pattern into
>> four separate rules.
>
> Why?

Does the Coccinelle software ensure that a variable like =E2=80=9Cr.ul=E2=
=80=9D contains
really useful data even if the expected branch of the SmPL disjunction
was occasionally not matched?

Regards,
Markus
