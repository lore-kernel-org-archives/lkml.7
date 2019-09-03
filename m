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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013F2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEADB23431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gTFYfUG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfICOHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:07:17 -0400
Received: from mout.web.de ([212.227.17.11]:36333 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfICOHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567519613;
        bh=q4RXe1YLletHihYnQuICVb68/R49CnEC2KcEeoctzSU=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=gTFYfUG30s9aynamovIpT5m/SCgcPKhOD6DgDClJD0zQguCAP0Kysb3M1TSenU6zK
         HA2L/aY961ezFflz+BcnUMkE7LeC80a0GqJofNpFsjnh1c4UqNnA124O3QovLbyOMd
         Z04NPjNQ1AI+b/PUnh0cCQrJg9y3kxn2aNFoHSP0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.133.43]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LlFLm-1icq783jao-00b5Xg; Tue, 03
 Sep 2019 16:06:53 +0200
To:     kernel-janitors@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] isofs: Delete unnecessary checks before brelse()
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
Message-ID: <0ab9272b-fce5-1fa3-6625-898afd1b9b8f@web.de>
Date:   Tue, 3 Sep 2019 16:06:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mZFPA8xNdmdRQrCtkeLeq+av0oFkjw3A4TyBktBF21FLlq4dwqr
 6CAKpQ+u3fm/YZGQf0jt1PmpMAvhkmKEUxULw7g+iFwZQ3fJN6G96AxEAB/WjKG03od/d3f
 LE0unixsxTgdkWyJtTxMzbdRE6MoMgF8NDf3u1rIyLTAwte8QjXHb/37gPh+amfObCegz9/
 cXeumNSUVeM6rOCtxaleg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lXg4Xvl78jo=:YG1LsogW42romWu+eHYiRi
 B0qt+xem4EwJ2iZ/oFEYTRYyIzV9pSVGTm4vpErK8lPsXpnm5P54LnwNfQ8ggK4V/vWk44d3K
 5DRVaNuM93kFyvwoo5jBKULW89aFHo858vFIKKYjrzpa4KRS5Mdrage7dZV4azHAsGvzNjeAU
 OnGHLcJmKYeUZykk6fg+aGvKKbhqCZV/XFjjQ7PaeHt3G9g0DW8ZNpdMTziBlkWD48gB5URVo
 sCCNQnR4Jogw8YR6drTkcqP7jI5OVAkyPfsj23fOHOvBz+YYBnitNsrhJ+yzm/oWSrdo+9Iuj
 eVGFz0cy5MYBqGKjuV6Bu1U/Comzk9AiXgIfITpQkO+vkOQUkz+07bMCuDNJera2rj7wFNVaF
 fzyLp5ycNIA+QCSKbfO+mngl3d6OegvJ1ZMw91uuAqzPF+Jtyp7gpfjh2SiiiBxmyNKf/OZZo
 M9g9VYXymDJQdgzNKhbcZWB8WznF1ckUYHA5zSaIhpgD16ShfaP1aAbNSVgDvi/1soJoaPt5n
 Em10hY3f9dJWXspBy9Ylpv3JY127DWUa3x/z3ZTelEUVY4tQ3419u4nQ+zLpVWigTX3M9bOaL
 hLFrd1nN/xIrOz2e2syWutM+B//eQnwDAG3UW0sqT3fh/lCuItRsmUqAr/UIiZSzmpr5jqiXf
 eRSQpzO4j4vSaS4IwHnr3gosJi1aOykXxDveeWzpAsW0r2wVRkX8yGXEKoammwmopaw3A9Bxn
 4tkLndW50qnutFB3GwfrLaI64jDVY9uGFpqUzX3nCmDY3mwazEoRdHJ2G5PlH2vIBj05NjesU
 HGCxZYZE2C4SrFHTcQBsxs11hNtJTWNaUEvjr+OKjs1dojok5YGJzM7SAegW5146ToEclS6KQ
 v9yQyIH7tFE8Iniz0O7T9ums3YQI2keJouFeGs8vkrHM2nXP7H9qhgqFZfAKV5PiLekgDIvdx
 R9umbLiuabXk+z9ClE5BMLZMVyLkI72IhIrxc+Rty6o4qFf+B/QDwHKkvytyW8duYyCi6zcB4
 8ZmsFoAEAp1oPITQpsRC8h5PLHOkklw9E9JO5f71vlstpzuo1lwhjJGBaQtyUSjZXeWAdJ1ew
 D2J0MY8AY3L90D49m5V4cKLcuX/Qw0C2QfN6SeUvhgYL4Wp0Zt4ZqEx4LR0gu4oHTjGvIRr4p
 62hoLvXqPa1Mw3jKgaKPhTjdKXcfnG0edRj0zOyiYTNJ+iiA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Sep 2019 15:51:17 +0200

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus the tests around the shown calls are not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/isofs/dir.c    | 3 +--
 fs/isofs/export.c | 3 +--
 fs/isofs/inode.c  | 9 +++------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index f0fe641893a5..8e6a09de15b7 100644
=2D-- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -237,8 +237,7 @@ static int do_isofs_readdir(struct inode *inode, struc=
t file *file,

 		continue;
 	}
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	return 0;
 }

diff --git a/fs/isofs/export.c b/fs/isofs/export.c
index 35768a63fb1d..11bf964f4886 100644
=2D-- a/fs/isofs/export.c
+++ b/fs/isofs/export.c
@@ -102,8 +102,7 @@ static struct dentry *isofs_export_get_parent(struct d=
entry *child)
 	rv =3D d_obtain_alias(isofs_iget(child_inode->i_sb, parent_block,
 				     parent_offset));
  out:
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	return rv;
 }

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 62c0462dc89f..05b6f6078d9b 100644
=2D-- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1284,13 +1284,11 @@ static int isofs_read_level3_size(struct inode *in=
ode)
 	} while (more_entries);
 out:
 	kfree(tmpde);
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	return 0;

 out_nomem:
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	return -ENOMEM;

 out_noread:
@@ -1491,8 +1489,7 @@ static int isofs_read_inode(struct inode *inode, int=
 relocated)
 	ret =3D 0;
 out:
 	kfree(tmpde);
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	return ret;

 out_badread:
=2D-
2.23.0

