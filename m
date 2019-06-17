Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29661C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF05C20657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gJipdSKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfFQMeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:34:31 -0400
Received: from mout.web.de ([212.227.15.3]:44809 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfFQMeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560774857;
        bh=7of0paGiux2QgmNkMVygVoiS/Aku0RdePBQPrJ+O2kk=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=gJipdSKOiIL/b17IS3Gdo9yhTYWoEUamoIdZ09Abw1jxE9gcbv9kFyZHKxp1VqfIa
         cwY0il1r9S6CRpIKIoVjqBSvjbtKpplIPzD+wdDw6s3GOb3XatMQOa/43xSW4Y1Scu
         WvZ+4P4llHhDFmNBBWKRWGBNlfiSBl8IRc9K3L8o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.164.208]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M40jS-1iT1x50Ogs-00rWe3; Mon, 17
 Jun 2019 14:34:17 +0200
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Evan Quan <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/amd/powerplay: Delete a redundant memory setting in
 vega20_set_default_od8_setttings()
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
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <de3f6a5e-8ac4-bc8e-0d0c-3a4a5db283e9@web.de>
Date:   Mon, 17 Jun 2019 14:34:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6q8YryJyEBQzQL6cr5Dg8HDdKYlBxXGEzN8mpWdY2YzSa+nzMoF
 71tn1IqfXL+eG+IOZqRL4SmXd5pQPumVjCEB+gjFhOVzTgcDj5bCO20lHTppQHBkpAOOrmi
 WlY4a3qXMZCyAULoiQ6Urx5DkYZnO7zW57jr5YoPIQ8z4izIGMf2FuI9KNyRGFAJCz5mCeV
 g6HI7YkWddqMmWZXpq6Lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hxYF/0J9MCk=:CL0uAgH4fCekHbgjbrsIjT
 ded0/iCT6NuiDwVNSS6b8e8idaCXyJb339UCaKYE1pBAThzZV8ItFyEOFR3pqdJ9cW1moONFN
 c3G8JDsXJa4Eebwg2o1dSzmJ5zV18XlqkTwB3aF7I94hSx+x72wIwme2bxRqRttqJdEy9xUlV
 qYuOj2P03nz2/aFO7qu5nYTfIiaQpPe6gg8vm6YeLmCipqr6iHcQnwXst1UvnONk5GtL+qGPe
 ITKja1P2ZvaqPza2yA1b6yt18zLKDqesaepPrqoNsERlcrPwzSIO8pHze1gotRElH7LZWQHZL
 Cn3/Jub4DJQ0jjZ5GUnMsq0q2Od9AIpKLVB14sEupje50jdLtDjhge7+hdqRmswsz5xmG7hIR
 7+rsKqEAPPz6ZnX7v3SE/qDqucRruZ1sSNEJv6a/3cy3yIJHOTEWQn61HbNbZOdR5HYr3Ic3s
 GIaHvpJgbbumlhzcaEmLpUCbhmkq7BbRQ7VGEjMHVcxQdfaRdx4incvgy/4XJgfFwjzgnDYAa
 zUNT/2ERoPb7H9IX+Olfc30KEz1lzMrZLxwwMdJIuvL+FR8tn6KZNDigo6RxnvoT9pEVXQPcL
 1rfoXtjigx5q6DhImF2a2AXgAByrS8jbA5VOyl+mJDuVsOUAkSYTpUiELxkRbARCdmmkCd96x
 lKLopCpOyl2iRSB+IJw3R0gDGBvngBOL2kwqm3AYZCvNcOxfWyvjpfCTMS+783LyeYAauyZpV
 l76NNLPFlKYVDzH8k4MW3/40QjKSNXEvzh+sYunb3t4vgsb/jGRQZQCkPC7c/LecBwvxDzhyb
 KQZhO9heRk/P9jWL4dDH8nXTfKx5hQ0bY8N5d8VRZ44Qt0G8bhi8BMAirj0pq+1FiNvYWPFIB
 Zf/Oc7cqb5buqPrZuDiaIAKqVXc8Sa57sOVIENxSeo2t4hoz8GBCCdlmRKrn42atlRDzFZqeC
 ltBK+MYirivBDrf/C+DQQXb9DpRG+bo40cnO8qa7vz7dENzow8ScZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 17 Jun 2019 14:24:14 +0200

The memory was set to zero already by a call of the function =E2=80=9Ckzal=
loc=E2=80=9D.
Thus remove an extra call of the function =E2=80=9Cmemset=E2=80=9D for thi=
s purpose.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/=
amd/powerplay/vega20_ppt.c
index 4aa8f5a69c4c..62497ad66a39 100644
=2D-- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -1295,7 +1295,6 @@ static int vega20_set_default_od8_setttings(struct s=
mu_context *smu)
 	if (!table_context->od8_settings)
 		return -ENOMEM;

-	memset(table_context->od8_settings, 0, sizeof(struct vega20_od8_settings=
));
 	od8_settings =3D (struct vega20_od8_settings *)table_context->od8_settin=
gs;

 	if (smu_feature_is_enabled(smu, FEATURE_DPM_SOCCLK_BIT)) {
=2D-
2.22.0

