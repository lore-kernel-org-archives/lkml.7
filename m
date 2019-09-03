Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C23C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EFD206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="nju9EEZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfICTQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:16:06 -0400
Received: from mout.web.de ([212.227.17.11]:57555 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfICTQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567538159;
        bh=zzrEATD+1BmU9PsscIqSYQZeK8WIT7N6zHjK6UVPtDM=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=nju9EEZETWY99eLf1p+9rtRrG+2vRBloianG8Ocq3ESJAceOfR5KsbYrQpe0GtSPP
         /Hn3rHqaJMP0I8IizxaVA2o7Z+cKygMqEaH049KiP1kmSEPGTUgYUpI4zgvVmVqqxv
         0TU9NNxpiNE0durkzL99DoSiOVvZqIgNGa4BXLxg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.133.43]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgpNC-1iYBq51k8M-00oFmN; Tue, 03
 Sep 2019 21:15:59 +0200
To:     kernel-janitors@vger.kernel.org, Jan Kara <jack@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] fs-udf: Delete an unnecessary check before brelse()
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
Message-ID: <a254c1d1-0109-ab51-c67a-edc5c1c4b4cd@web.de>
Date:   Tue, 3 Sep 2019 21:15:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FrWCpTqEp8JSv8hpv4MGgz+kV5tmJtQwdjH5cdo6ZUA5ZC7kOnr
 nwqdZ0V46WzTz74i3HBggJvcENuusqnWNIhxmkzAjx8O/YsCg1Cf9ZE9fs75DUxdXluicEJ
 LWWXeplH1b3xAb84e5lLImSXYgp2rN2UxmdzjBvshlFTZiudQ0W9Dq0PcL0YldSGbqMHf+l
 BQVVRq0hMnKCix/eXEm4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h4g9ClBbIXE=:NuNq4MHu4rRIj4K4nhfKBO
 bCwQmabwkc1zg1tkA7gq6O/vUD2cr06thCzrAtGkeT27ytOcPWeLH604xX++9lpUyEiJe1AG3
 oAaPcdg1NITKDdUwBFuivGymLIlWKKbF+CBnAv7TSUALs5Ec95FnWSvROxcbeqYjSWP7SHo2I
 c876y/cUO9BQH2f1xyP2JDAo852toaG0fHEyfCPYhQHn8RfLd+7wmC1+MjVTuzqKx4pTvM8CO
 32nJfAXWq4sa1boCK0MG3FXQPY5kPdwPgRRmvx9rGqopVaaq5yN64Pn32e5B4DMQmldVsIvyi
 jI/YeWB0G1yem7KLwzZzrqzFdxX3KLJ6AcWnuXpy8NwH7kfXscrj0Nsq4CLgXNxrh+aQ6RPcs
 omwZRKwn6dBFsDJrmeNlyx7/PkI/B1RfEj9DzZgJG0sYNkHf0vHqQdMzVlB5vaAXRdz+Laaoo
 hPgDmZ+/5SDerizSqIMb0Km7RFhhJNhX1PAT509DjonIuesH0MTKAr76WIkq5qNCbxkV+s5wN
 GcBCWP4Z1I83pqyWURpuQ70AsGQT6MQU1kGDZau9dP7Z0I+Op8ldW+8rx5BNCPNwzDOGocJbO
 Uddv0KtN1oqaKVm/KeXZ/rX/BkgLmT/xefgZsiXEA86heUeTFJnZ6dlxsaLs0uHAFdK5PNa//
 23d7av2dwhQds6uElPRtpL1/nLhzEwCNsQP8Gmofa4UVDuVCe644VslNoZBW69jQlDbS4F+aB
 uQpZi+8ZCnPXMXmoYrM54G4YC28YHUD8t16WXUpgH/25gtqhqQyYYP8Az6b5npUHl/A/MWcJR
 q+Z1YMpbEfLsL2/pYbbvGW11ViF57OVG74fIgjFe99kuqh74mm19cN/fQc4dQ54bOCZcYe6tC
 wGRtjPLQqyXzBHfxvxiGJZzn5zS1bkS0mAegK/mebWIrKJGClSUDvyFiydeAHRXrhWMzK6eyq
 RCC+tRYuxSJRcbxq9OH8PI2l3mKifwIHBkIETtUYYwzuErxTqiFmfUQthjZ3I5xnKOml4daKb
 +k6GGyEoCHn0E2NIlxRs9+q8OWBLNBqP86M0wPgqg1MQC3Gki4xTIAycfS851SCr2A0GJ1Uz2
 GcZcscr+tXdsY1fBwXA/AEUwtBiJAzj17gA1Y0/TfNePIvZeDJArAO4pXH7GLJL7u9Mfdy55/
 NgvoCXJhkrvAtu/BH2UUBYku5+wnEUTy4xgaXrtauXzRmaP+ObfM5aydgHFsNly7MZjheTxal
 +3mlWhcFtc9D9lRm4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Sep 2019 21:12:09 +0200

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/udf/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 56da1e1680ea..0cd0be642a2f 100644
=2D-- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -273,8 +273,7 @@ static void udf_sb_free_bitmap(struct udf_bitmap *bitm=
ap)
 	int nr_groups =3D bitmap->s_nr_groups;

 	for (i =3D 0; i < nr_groups; i++)
-		if (bitmap->s_block_bitmap[i])
-			brelse(bitmap->s_block_bitmap[i]);
+		brelse(bitmap->s_block_bitmap[i]);

 	kvfree(bitmap);
 }
=2D-
2.23.0

