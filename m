Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CDEC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 08:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99B02081B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 08:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="da+rwUz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394572AbfIGIFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 04:05:35 -0400
Received: from mout.web.de ([212.227.15.14]:50429 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387769AbfIGIFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 04:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567843516;
        bh=Ibhi6v134hcnMVb/T9ZY8HU9Se+R/dtGzn6B7Qn4RT0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=da+rwUz/rQm0dM/tKweBsitv2PJWqRZn6tfH4euVH3bQdMKYaRBbAIsk+rWICoSh5
         BaTEZwNU5Xtrexb79GX0fiGQyxY6RBjsJZp8uRG9+VYwfLbvQ/DJ3ypfBreCVFVX0z
         4see95Tf9Vo8hGcBWCHYyw9SopeQm5ND9SmIrwzw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.16.142]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LwlY0-1iDAai2m5I-016LtE; Sat, 07
 Sep 2019 10:05:16 +0200
Subject: Re: [v2] scripts: coccinelle: check for !(un)?likely usage
To:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
Cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20190825130536.14683-1-efremov@linux.com>
 <20190829171013.22956-1-efremov@linux.com>
 <alpine.DEB.2.21.1909062217240.2643@hadrien>
 <3981b788-cd0b-d2c4-4585-d209f6f6a522@linux.com>
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
Message-ID: <53e58345-f2dc-8fa3-22b7-cf4ee1308043@web.de>
Date:   Sat, 7 Sep 2019 10:05:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <3981b788-cd0b-d2c4-4585-d209f6f6a522@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:ACZ+eKyB844k4VmBqi9C/KE3F41gWYWt2IlWGHLPaOVfz8SbHSo
 ZfiehmzBYAJCn1hDNeCWvltL3AHDh9C5YeMdgcWR7jr11cJPAcSwWDU0EC0KYJm8LCk9Hc/
 gDHvNnvfXJya7WtzNCIJMXAsa8/jlElKy264NSeVObCazBg4Gq03wGGhAU/9z2YcowYZBRG
 nUh0/iucl+9vH6O8FDeQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AsnlIfl01s4=:GxfECbWsCJ0TpLqPSCFKL4
 nX+glMV/jqi7u5J+ciieDHeRNrXH+ARlaYczVfiBKgYstBNCJ2a1fJacnGOV4L7yg5nJHBPFO
 lrO/M7J9xtHP2tc13EgZKxLqgWwFK/WQKQe5YxPcHLEtRR7+IDRxX/dXbsE4bRt0ifAIREj1s
 a9cVRT6hGCTwufiu5707QOmhsiP+Nkpu5XFjzuXWvL758DA746LljC8KtXBkXongMItntprTw
 AGmnj9PwFAnpx0z6fCjs2t4WGfGj5JTYZHcsu3AWfIRY0JpKqXbiVStqobdZuWDClWSlsVakz
 epMCWq4QQQ5bOuEBPpJ30Jrc8FT54QQR5eeGyQL6Jjl3F4R9ac0cYD3IHeTezYxW7ix4enXAM
 AEBWUMCwYyi+ot+z65ZPMQcdvOrIYqsfpnFTY8XHz3Uonb3Y27jkPK9mqRg59xv0caR5DpgQf
 Ls4BeR/RgoAE0lhD5HhgqaRLKviNoGhusY57D4TmwPSGb0F4H8fD3htmUPVDbBeufmim++Ztt
 eH6kGXaCJ+htTa13NrwoYIozdy4Y/sCUZulg9EA/Ha3B8leySL4f3QmT9P+fQSbyZydmwBcor
 aHHNjwbXT+Y0dItpkWn1SPrOHN75GtZgDMejkCSgbf9FHyjpNbmMbcariEjotjI46F7rrPsMh
 KlCN0BAIbiK8twLi5FvxUMFzp7HioHSHjRw0BjfK2YP/TNIljZR1mKtPiI4QO2Tlco1DIwzHM
 wOxAxwYFXiZKlxELuIat8ylqgaNJDQRNo4kYSpScotGqDRd4mkJiOOWoKwL8bJP4+Pm4wYdft
 wUHboWJaM0120YceE6Ovopdu04VIFowesHtfnEcqh36dcZF8RfG2VtbZuRvUDZPcikBTt+5Mz
 ODDHwYL54IB/N++yyeCarolG8Y6CCvHS2XtdNyxOOLLHdfNModXYHXcaukmRUNgjfnOutk2BL
 RlPIxKiys8SeVUqtm5fAppVUT3Hw97WeWQ2e8h3V7aDt8inaq+VXufErhQm82BWgx0pUWlA4n
 KR213qKiyCRIlqDbbpdDttIYRu/DcMqnvC577IcYe0W0F8LESXpuxhCV01q+/vwXghl2R7Smq
 WWV6yuf/dmIX3Xjllbag93u252hoXeDxQ0zcBW7iGu5uvr1drLfvDoPFstC7eKBuMDqL2zDmR
 KNi8Hs5OoPq+Fl8L8sfRk/e9KGMuqfowRKoYJadnIsLhjsU6Fco1KAeCRDClRxDg7t/794Vri
 FMbKoRliD32FeI6Jg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think I will resend this patch as a part of patchset with all warnings fixed
> in a couple of days. Hope this will help to create a discussion point with other
> developers about readability of "!likely" and "!unlikely".

Will the influence of code variations become more interesting also for
the discussed SmPL script?

Regards,
Markus
