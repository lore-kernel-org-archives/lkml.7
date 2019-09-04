Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27A7C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9837721670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="iJj9rIm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfIDRvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:51:51 -0400
Received: from mout.web.de ([212.227.15.14]:50521 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbfIDRvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567619438;
        bh=G25W7RRLJRgtXAsMRLwlickAdb7OyjUJ/3Iap6/WNqw=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=iJj9rIm7eePcfzdFbl34IXfGKSrL4W9OTrjK7kwQU+Th9jn2bhLqk7fzB2ckihwux
         Sa9yXB1NM8iBeS7iKon/klTlV0AIWvJm88e4zm/qPxsP7LGYkWo+BJNuRQ8PItX6+v
         Aay7M3aVu+KyAJAkyahQ/LO88Af8KXqFpqZW5CIA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.100.89]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MLg8p-1i4kLW3tHX-000sUZ; Wed, 04
 Sep 2019 19:50:38 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1567491305-18320-1-git-send-email-zhongjiang@huawei.com>
Subject: Re: drm/amdgpu: remove the redundant null check
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
To:     zhong jiang <zhongjiang@huawei.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org
Message-ID: <62b33279-9ca9-5970-5336-a8511ce54197@web.de>
Date:   Wed, 4 Sep 2019 19:50:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <1567491305-18320-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J8L0lGxBrBNRQg97k+vO1uJZR0MohxQSAxwmBWvxNaOgt60XxLG
 AAUjYpmRE0Ga3uzJGOcO1Px25yjaGgIDtSyHaVRvW5pXkdDBRaWxv2S/2KpVtf1aI5OIsG4
 dzwrxkdHcwbXeYZTARkGxIMJHiqdmGO9/fWivhVzigQyNyO2RxiCN8xTVq79FExbuhFr8Ik
 0qCkRykkCe7K/TND9dUKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eM6TKP9RiSs=:iJnFXG1JRyXG6cNWofX/9r
 Pb+85q2/5fAsQ6EiARB+edrQ0uWoX+zmQxczJSu0ADjhCXcF8XQ7WnABh126lOUE0vAuTUsWK
 eIlUK+/MRDqhEZ1b+4nsPIS01Fh9viACklGXh12uU2BDRgIQJ8/w7TO9NyJt3O12rwwWJ7rSf
 GWYw7S1Dz9STQ0IKdDlP11l3ot3GP52FtJ7pqwyD1/Dyuq0DUSSsXAEjKISmo7or5FrnPJ+NG
 yUtHrPK6JthQB5otrnel1LsMUkQY+1x63H9oPk0jTzl7C2bt4ZEQKMU1x0YNGmD1LzkM66XfB
 U52U6L5Ye7yCnLszqvaieasN4xfq2AW0kYRsL/gHb5q1hcteyOLsAUNas6eRR11+unYfxeyj3
 wCdpk/6V7aljJvppdwXcnUGOW6/aqCGeBSNZFB/cI6aPxNQxppR/1Xjk2pQpCHNNXY6nNVK0Z
 z2BRL2JGZn7wbCGErtpBXodnyvi6E3SxWANknmzmLoWt63zLGj+0gfHpWVqlp49IehUV5RkxI
 sJm+Zyiq+Xn0frdALHLWiKtT4CL683jlq0dIQVARrqvx4YFY0L8oTI9JbbqW7BcMa8lIYrxO6
 0GIUELW9/apvySua59d7BqOA6TUF17j1iOQEf3gYgVeqQCyifQZVItjqmGBKNvH2EKofyxMxp
 dFl/e6Hp+0Ro3Yv8IPm5tFHdXaIyxrCFx37wrXuKNIwDI6lHsHzvPL8JpyupjZmmfB5KHBaeQ
 UK1MEeQl9U3q6+NQ11oiJjVQR+DnX9MI+nN8XOBOaf3mOxIJpNpvl/5OgDPRLhB7gsAnoAMAK
 KSfUzBNcJlCAKoQ/nVKaEmrQNYH9WE/JUcUfbLfe1akd+j/cgPPL4YaY4KR3SxikKgML8WgHB
 RV6cjnDLgDu9xEreEeOVWuX2RDjUR7TJPJT9XtG7rZRB0ktG8PqHxz3a55e9RfBEcj9nFzl9E
 UwfrHKN9ylnJaoHZpls2bpO00uqSyL+MRIckfRuSivSYUmcAq9UXJVzPZ27dE9xiRVoYMvF/g
 IBChRh8kqwKXLKMHFdNr/aw0IMyJQUXf8d4Och1HMlaw6UvWnNwoDglJ0LVnhy2fF1JQXMl9+
 TDrwhVEKIJTvouL8CZ31rBXrnP2ovIQhA7tB0S9Qt0S94ZyEfku6C/azgEObyb+mfBJl8UDhN
 mRsjrIAXwd4+i7kE8yBxXtumtJl8BqaLIsShHpCCOLtcd9Oj+utDHpWcKWYdbhAZV+yZhZBne
 tVPZWo0gIYje0zm+S
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> debugfs_remove and kfree has taken the null check in account.
> hence it is unnecessary to check it. Just remove the condition.

How do you think about a wording like the following?

  The functions =E2=80=9Cdebugfs_remove=E2=80=9D and =E2=80=9Ckfree=E2=80=
=9D tolerate the passing
  of null pointers. Hence it is unnecessary to check such arguments
  around the calls. Thus remove the extra condition check at two places.


> No functional change.

I find this information questionable while it is partly reasonable
according to the shown software refactoring.

Can a subject like =E2=80=9C[PATCH] drm/amdgpu: Remove two redundant
null pointer checks=E2=80=9D be nicer here?


Were any source code analysis tools involved for finding
these update candidates?

Regards,
Markus
