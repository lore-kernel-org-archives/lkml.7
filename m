Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0920C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C127B214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="RIsppNu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfDHQjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:39:10 -0400
Received: from mout.web.de ([217.72.192.78]:46217 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfDHQjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554741529;
        bh=jZqWsl0wILUWdqRdMG2/qb4W0eAwhRSgznEF2gYV7Pg=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=RIsppNu+S3PeEbTxI58n1Q+6Opa3yk1Fq+jFkiegxWm/it+stk/0nAi3RupYMWsx7
         ZxUoYL0IjHo8pzaHTIr0JIoBw5dQcgjRSCR6r6LJI8YJqVH9rs3R5FscnQ6PjgJ+zw
         98mVNosa1co6A5v+nGtNyquaIYCUL2CMVWVJMiEI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.184.114]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LuLxD-1gnSAg0XQN-011eyk; Mon, 08
 Apr 2019 18:38:49 +0200
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1554692313-28882-3-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: [PATCH v2] drm: rcar-du: fix possible object reference leak
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
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
Message-ID: <336e5dd6-038e-fad4-0038-bd2d19f0dd4a@web.de>
Date:   Mon, 8 Apr 2019 18:38:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554692313-28882-3-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8+ZQlpxcBtUzuVklYlKaGCTAT3UR6kgChO3iaSz1CT0+eLi3XRj
 dQJKPLwDJFvNdQWZcd+xFBu3uLA/PAkA0/7mfqDnRHBTvZC2wxo0beVnF67HwI1GhzxgE26
 eKDp7Bor/2wJEdudACYFCyVfxO0RucWmWO1C/LAFBQBaboQ5J6TJt1AvmS/7ImnBFKS9+H6
 BdUqLmEHJUhD2SI65NO3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2+G3jMvnfUM=:GUxzodXLPfDSDC3n+ywiPK
 BOwCEcFLxlNfh+Oe3PXV9/OpjpUM2BCZQqkpXkK3oIHUpqdOjD63vKzew87J450K/EjLhY68w
 Gb0q5HLHIcPGl/NSUShvD8Nhfmazu9IQbUgSP03qfRoz3QCjs/U8ygp87qqLjKOFZaWJcMV1K
 p/Kqggehpmj7jzyJAn3JdzSmUa/vmuJOe6j/KcecOjWjEdqfKF3VUvEEG9A45akpsBwkUN7zL
 KSdnbwjlBwGL4xrjyR6geO6KeQhnmL33lPojpKzPlw9MCHeEcT72ArsGty/5YQY42Bngpj4Gg
 tJyJ70SbdbHpoZqgqyq42FHx4KwQ49Qh8IZNSzzN5r5ig5duFGvWCRnCk5IKQvdTtUlLhw44M
 QJjvGgWOl6LbTJMgq845FdpzduihwMU0h4Syr9SG97XFWc09sQ/YhBZulcEw2Zt0jrIWwkTFA
 d0ZYHGCZHfkQcQJMP1WIFPkTV+/VzL7OxEqT+qQ/4sTBhZwEVDGpHyajErfo9s8/gMP1+JqOd
 +C1jQxyOgvfey2xqb90FkwgtEkvrupE5et2PrHj8opt3cYCz0v52i8Zy5RisTDNLHVO8r31Ks
 n+arlEL5OVFa1DYZ44Lewq0thZT6cvazvmHoK6hH0xjiPNVo59QRZ97HBlGSZYEic3NcwBVt3
 D1G1rrtEWY8AfBKoMgRd6ZLQX8I04Dwm8+myVszEwp6PhY4q91NJwdN5B7Lax3MnbxVgJF8XE
 DhoRzVkLbAtaDY5uvMMLN2unIlfc950C//KOjjU7hsR5xZFdPYVFMmKsSCbxgoNzicLp+WyaF
 Kek5XHG07VVY5ADMbpMab7Lh0u6K0KZmxpBo3YA2MwydZ5lOVAsU9O+uzxj8TinK3z+T+YaJV
 QDF3ZoWHVlMZkAxpAyBIStExWP5rJOsegj+daHAL2Z/flw57CeFky9lf/jtRefWXxvfgkWkA+
 jCty0eZ6NfQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> v2->v1: turn the return into a goto done.

* The version identification can be shorter, can't it?

* The expection handling should be completed for the implementation
  of the function =E2=80=9Crcar_du_of_lvds_patch=E2=80=9D in a different w=
ay.
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree=
/drivers/gpu/drm/rcar-du/rcar_du_of.c?id=3Dac5b84a1ffe93c9fb882c0f2bdfac1c=
33077b920#n195

  How do you think about to add a few jump targets (at the end)?

Regards,
Markus
