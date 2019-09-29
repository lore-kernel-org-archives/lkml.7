Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2438C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 08:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA20320815
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 08:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="s8uZYHPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfI2IVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 04:21:33 -0400
Received: from mout.web.de ([212.227.17.11]:45787 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfI2IVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 04:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569745260;
        bh=DHF/4geK6xw2vD/UIcjw/AAJtKWKszcVCMuRfroX1gc=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=s8uZYHPWfbZKd8hh0vRpe3yKupw25hU0FG0S5UdcbcmN30hH1CNSi0SNLfQGykgNE
         7NvCSwzAJYmp73Ab+GnM/p1xFbcfoKBrgb3rhCekeQHXPhcBwU9VkHPCUbMWeaimMC
         lM8kMLB0qWKB+iHHKYD8russs8P/+0lcISxwmq1U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.99.91]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LuLt5-1i7ehP2K2h-011mzi; Sun, 29
 Sep 2019 10:21:00 +0200
Cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Martijn Coenen <maco@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <20190928094245.45696-1-yuehaibing@huawei.com>
Subject: Re: [Cocci] [RFC PATCH] scripts: Fix coccicheck failed
To:     Yue Haibing <yuehaibing@huawei.com>, cocci@systeme.lip6.fr
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
Message-ID: <42fcde1f-288e-0fbe-12db-750deb15f14b@web.de>
Date:   Sun, 29 Sep 2019 10:20:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190928094245.45696-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:LlB4/quSlqZCAGOg9Em7Zau5E8OTrcR3YE6U0GHAumRMPkOfm4E
 cvO5ahRGhIrIrKPtd7cXgi0uUxI47J6b0IxJrkckPSTVqs7u9BM+58qFLE4JwLsXpgeV6qe
 NOSWurCt82KBH6ue/zTAzinI/3nzFXJcuhD8UFt30rAqjDo+dY9S5kN2+Ok7HndSZAaHEik
 K3u+uON1ZmLNhIgJdkG8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tBC0Q32EGIc=:zm2KyEUKEaBWvICBxaA19K
 +2bGiJyhzahRsmwNVUGqBDmoO0gXdd1+YnMrGjCCD08H2LDSR6GL4BHcxeGzHCCx72n9GUyqa
 a5i8ijYrJnkzy8XRYydYWmyieoyIQr5aUWyT5ZmOu2ON8s08EvAIF3IpUbRG+7OEUADT8w/11
 sSXpf3WOLCAtfeF7qCySrlfupJUPk12jbG2rXvrX0+PVQz/PBM5ObSgUQNjScbyFe8Bx35mhX
 unz+oarRQqj/tF0Kkb67Kp+9hwdMeWlYzWdrAi0YL9sQHKVIqA498NML56TZSaCV0lzxgnMca
 T6OygSoBpKmYOzDUgY1qweaLmtM4MIiOgWYeVO9WIEfNA2ApgU6LbeFUx7oL/aHhcjgGTRpqm
 bEPpqbmyFDDBuDP6KYhIaOcyzzy3+w314V0aUh72fLbePh2Q1AR/vvXUtVPIDZOhPF3/zgYRR
 VmqG8Yj9ybImc5QLaLwW4RIHf8hNijnWhjDxJXJcCxpWfLt3s+5XCm7lPi1+O7z+biJiTA0p9
 B+iXaOxOIQzfyrn6lPpO/5awuG2yjOwiqc9H8+rQta6qGgsNCodw1Y4gpOvfEoANlYBbjlqND
 508MaoghiSiv5WCDAmIWIZMADsJnrb5J2lpDWHSVyH2BqR3w8haqsWaML+M+AsFOBlzoWfD4+
 5DAimV8i2OKYSXs9HIx7lCuwF3qn9KO1OvDJ6kAyYOmfw8v52SRlMKAYbarX3+GOaIPoVeygh
 D6nQJoyDlb7ImTCtvBAlfreLuHCWK63rvVl4ullQfNEnBuat6uHrOSyaKKocnY3B9BYTrzsDv
 ekv5wioNzSKadzyZaOOddw61VO/SaSzQxVhAxL76UTHVemNLR5aZuae3bnfcPEzb9cLNkSgoW
 M4s7873m7lTT/MTjpIjM0sRUvc/y6hUgZNtKGyUI5ocb84rQQOcJFavUfrxpTnRvQg7stDqTO
 FS/0qyctshVASbzR6CEgNcoFT30FpBUxCcacr2DmRlNb9aGS28D5OgMYNnI83LQNtRegE4hW7
 Td24Sy1zQjAA6WTreL8FeBhIHDresnTWnVBwLDgf1EIIVbAPv2GTPXFd9mAs6gXepQed/Tojg
 yAdqcR18DEu5Dv2ei4r1Xn1Z23TXMegJdUC8wJkke9MrXBy/P9WY8BMrq8ZTPaL2wWH4fW576
 DgRPFMkCZRFelHwwn+3Qa8XC1txOfoPeV7IyMKOi2GZOiR3RIZiCHKA0a9y2NyoMJaleBSZLW
 sRp8iUSpzXdFdZymQ41Z4M51rk5bZ2/vSWjwrB08ipfZSejwPZNPbAshH1dg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems add_namespace.cocci cannot be called in coccicheck.

Probably, because this SmPL script was designed in the way that no corresponding
operation modes are supported.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/scripts/coccinelle/misc/add_namespace.cocci?id=eb8305aecb958e8787e7d603c7765c1dcace3a2b
https://bottest.wiki.kernel.org/coccicheck#modes

Regards,
Markus
