Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A5CC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC2B21D79
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="lz32pc4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404891AbfIYLeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 07:34:04 -0400
Received: from mout.web.de ([217.72.192.78]:52901 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404839AbfIYLeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569411227;
        bh=NsRWT3m7m/8+7vkXK4b1o5yrRK0tkUYm+dA7R0wuV6A=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=lz32pc4CdqnMGsa4ZeoxHWMM8N9SJD0yHOb084nAHSgC9VQ9OMzq5OU711Bp7GQGS
         vbGxrwOADtqZZ7DZTQGW9nIHHdAlH+WaoPQW0g6ne0ChIxnmJbbLbrOPxg9stNqC9E
         gtaj7SaY0MEGXxfrL5xZnmEVSq1xzXqhP3ctrFcw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.110.103]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lky6L-1herGQ33Ir-00apwU; Wed, 25
 Sep 2019 13:33:47 +0200
Subject: [PATCH] Coccinelle: Add a SmPL script for the reconsideration of
 specific combinations of assignment and return statements
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>,
        kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
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
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Message-ID: <4977fb04-cc29-3861-0aaf-cd93a0b0b1c7@web.de>
Date:   Wed, 25 Sep 2019 13:33:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909231058380.2283@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EwTs9UJltyX2v3e1ohEUFhC6AdX2g8jdVWxcaI83dCHfGo3w7kE
 NXLr0nOGm3Wi1/84FH3EXIi/+6GwG3SPOfckY2MFSAT4MJNT/ABYvOMGU73Uic0UGm8u0on
 w+F+Amqaga9KwJ6Vn7nHXSiRefB4CMzmRjS+5z2xz6nbDQQQ6dljmwz3cZAgo3gTwFCZtLm
 VHIo2Yjnk7ugyNaA6xOVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dLgVQPprfqs=:xSdh97M46cEoSbObqHiWQ5
 M2PN/KEFK4DxVwJyUagxpVEogWdQq1PuO3KIaCSeQwCPjxzAtKz1eEEs/KdoygRyXJnYQtHD8
 d2lagvihgMNUPvKN8LX/+Ef5iPRWpubXh2Y/anfsyq8JaCEWmqY6Cyi2cSJIDEFMDNbbZ66Dc
 fWsbQAaptqaVPXpnIklZMJn3NmyV4rUkADk4h1wAIWOQU7g0cj3eucJmQ02FmszhRPT07p1m+
 od4u72tCS42v2jXRU1eZXtsmkL5vdDncWtuI9sVDS+LElvovjWrVuJw4HFba9kN2H3V5ZYfyx
 bgMe7oA65xnC6uZxWtHgICB7MQOzI0qV6V7fuJ/ZiMlYJ2TMpPXGSOTzAAJKeF/SgJvzHhQC0
 nqSblpe/09lemLrGzFLU5qJo4xTb9pFDi5frM8uFpOLH9uIMNVTEdqy8aZ1ZTxHD3aqaKNUSL
 Uz7b/EBXMHcaP7O3gwuKenC20dj3B/HCSRDK5m7bs/hvGCXG1BQk51RD9eiXF9QM1QxaqVw+i
 a8EYcQYiHoHKDepJiWSnmmieTT8bP0d1XeHaX658Y6aavQAVEwNLe+t8AyezcYVei+PmP7ReL
 UN49a95iX+3idryjYUjJmumvw2+ZbhWjNvgS4pkNcUjsGQKgOBrgumTeT5tqu5OTWT17EFtII
 mFhbCXdsTwLWU52kX+haPxb7ZblR5iRs24fRVV9BIg89gurbpfQUra9dOsvizFL2+hr3aAQ/s
 pGFlDrtmSyL6UvxX+pyA88KZZRLEp+jzBqv+b6FbhfngEbjhClutloPYq0Warl/8HAGI/dO/Q
 53LnFmIqJxaokFtI74T3FxT7/utqLEmxM8v7hZC4d8j5bZdx8UfzeZub3WlXmNFpJox/avxTN
 N+PYLxztWsSs4LiRI2au8gEPascXcjMX4/uuil7honQgJ1ZUEgAoATIfsUHoMamhLiHLi03If
 3DhUR5MbzdE2fFvom47up5De2ByY/DPGAppo4QIsVk7u6yS4fzHh8Cxo1kJNEK3pVzHCAA0Mw
 vbUrghRl5sydFvD+VaQ5LqZSADqWCvfgtId3dGNI8/aSHQXHjLqfb1RW588Y/upYYLPT8CWmX
 5ITgvVU3Zv74LJi1tC++KUS5aJ/aORprVN/+jaSnVvCgjXjGBANwmPVGHkEOS2xmMN3nSoSBb
 yd8s1hqCt5rwCnMip2LTYhJHBHXcppL+4FqcQGTJpxVl1lCclXvmZ3nLGq4N9AKFXjLswDiZL
 gr61luvIpClgjyvHSNOroEIK1x6dpbCpiIlADzuivhLdmkiVZ4bAuLZYvOYc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Sep 2019 11:55:24 +0200

Values from expressions were occasionally assigned to local variables
before they will be returned by the subsequent statement.
Such expressions can be directly specified in the return statement instead=
.

Adjust affected source code by the means of the semantic patch language
(Coccinelle software).

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 .../coccinelle/misc/move_code_to_return.cocci | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 scripts/coccinelle/misc/move_code_to_return.cocci

diff --git a/scripts/coccinelle/misc/move_code_to_return.cocci b/scripts/c=
occinelle/misc/move_code_to_return.cocci
new file mode 100644
index 000000000000..78cdf84f9aaa
=2D-- /dev/null
+++ b/scripts/coccinelle/misc/move_code_to_return.cocci
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Return expressions directly instead of assigning them to
+/// local variables immediately before affected statements.
+//
+// Keywords: return statements variable assignments coding style
+// Confidence: Medium
+
+virtual patch
+
+@replacement1 depends on patch@
+expression x;
+identifier f, rc;
+local idexpression lrc;
+type rt;
+@@
+ rt f(...)
+ {
+ ... when any
+ if (...)
+-{
+-lrc@rc =3D x;
+ return
+-       rc
++       x
+ ;
+-}
+ ... when any
+ }
+
+@replacement2 depends on patch@
+expression x;
+identifier f, rc;
+local idexpression lrc;
+type rt;
+@@
+ rt f(...)
+ {
+ ... when any
+-lrc@rc =3D x;
+ return
+-       rc
++       x
+ ;
+ ... when any
+ }
+
+@deletion2 depends on patch@
+identifier replacement2.f, replacement2.rc;
+type replacement2.rt, t;
+@@
+ rt f(...)
+ {
+ ... when any
+-t rc;
+ ... when !=3D rc
+ }
+
+@deletion1 depends on patch@
+identifier replacement1.f, replacement1.rc;
+type replacement1.rt, t;
+@@
+ rt f(...)
+ {
+ ... when any
+-t rc;
+ ... when !=3D rc
+ }
=2D-
2.23.0

