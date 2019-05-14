Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B6BC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA40B2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="P/3RK9cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfENQpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:45:34 -0400
Received: from mout.web.de ([217.72.192.78]:42667 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfENQpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557852302;
        bh=QOR1BLXQNz5je1M2863+zbS3ipBJfUxoDeGOj243Cyc=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=P/3RK9cukXMgsHwi557LTDiAWYLvjlitsO4baHoU/UHIO5uceiQkEBKIjZpY0VOsQ
         LnDqS0fBV8RmbJaV+PVJnnlYXu2i+Zt1O2BxW/5C0pGO5zBvZtqDNgKPhxp8mE+zDY
         wfbyEAs1zUI/DMRpuHgu/WboFveaV5znh9k8XkCQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.122.180]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mfq6i-1h5bn01Kjc-00NCXZ; Tue, 14
 May 2019 18:45:02 +0200
To:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Petr Strnad <strnape1@fel.cvut.cz>,
        Wen Yang <wen.yang99@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/3] Coccinelle: pci_free_consistent: Adjustments for a SmPL
 script
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
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Wang <wang.yi59@zte.com.cn>
Message-ID: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de>
Date:   Tue, 14 May 2019 18:44:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TITipfat3CM+TTRoRigcZZbAnGbJBdlLMMtjqlmlxSmxuACwVnE
 REUAaPumXaIPuRJdbd0511BXI2iZ+/PAVLQdaiZEZAZot5cC9Vce9tSX1s3jSZ/DoNU9/Os
 eqheC5xcHm8dqSXSjzj5NIZtZ6alsPywFOEJE49HxT4wrMp/o+TaWrZNhJOgAWFFkZ0Vohr
 HDyvZU0+IPnGit8MEuhKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YwiQNWbz+M8=:t2BkyuHJAZuQTl7RO5KHBQ
 Mho0eWbfqyfPzj5YsgsnfiHaBy39N0UWNodJuoUlUkaQhHaHx1py45h9x/Vd3pKyQdylgm90e
 iz5AgsCIO4/Ezmt+FBGkSgQzuMiYR8qL66Qu3AM3HAB8YVEHv6X3Vp0SmmiGwv75t36q50RVi
 fItOFkVkXHKW/68j4EFicQmY5gJXQIq2NNEA+jupdH3IbU+3wwSDYE6je9asOuWMjbThN9FxB
 tJ1BemkNCywAfeFT4NVSCMTL+2iO7Ea8sppv6YeVq6j/cNeunRt2a7sNjvAnhS5fRpYFppg72
 IVEIe91OtGfR54OSyPaYjQOuGKBFYkthcQpHD55UVXzaV6zlQaI17njrpmyJz6XAHMZB3DMqm
 NLYsghvoyLY3avM6pJg1JXguzqvwcXylQ4Ja2KV2laj5+UgSlakaXX7upQ33bZ+Govdo4Mcsx
 JorvhKg2T/mUL2lqSUzP99VXkz/ucFjQDwk6eyNMCrga2kEivzjFFXX4qZbzdPtsWbACJdpkO
 1/SO/jTwUMwHZlmjfOC+KIo4L1+kaGpbyNPUKR4rYXfzrDXzZDVCF/aGx8d2hAs75yQkxcQO8
 ZyxvP23THCZw1La5exYC8yF1mUNY7O7jVhzX2P8OZVoi7tQWGlF/u4Yt4pch2lYMlxECa/QSU
 5UKq9+e1/e0vSdgKkOyhy1rN5NdHyNrAsDRYnTl9mU/4WK0Qpl3U2sGoRd9qafDoZspPJUHEC
 XJ3OOnCQRGZbwve0nNkwoVKo5VpH7zxSgUHxFJSxw/Yu4rOqEBTqe7mKguJGdUjtT9fHa/879
 pe3KqzT96L9P2rx1zeFKfq5zWTGS0pIirP49EEvI6Cv40Egm0/EyqiB95CrOy2SQfaZV4+xpt
 Me8I5naA9zMzTkWJD14f4zpajjwDB7tZb6Xs06BDekFQvx9GIorBGvgLbndjt/Fpimfs5FKdt
 deQkKJnT8jw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This script for the semantic patch language contains implementation detail=
s
which can be improved.

Markus Elfring (3):
  Use formatted strings directly in SmPL rules
  Reduce a bit of duplicate SmPL code
  Extend when constraints for two SmPL ellipses

 .../coccinelle/free/pci_free_consistent.cocci | 28 ++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

=2D-
2.21.0

