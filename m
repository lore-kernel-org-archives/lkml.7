Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8143C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778E02082F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="V79aRUpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfGBPkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:40:39 -0400
Received: from mout.web.de ([212.227.15.14]:50095 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfGBPki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562082023;
        bh=jbQnila/Ly8Ah5+VhWkppnndDp+owZQcXoRR4Iy+/Jw=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=V79aRUpaV8EuRewQhjXvROH+er02lkhxsTz09+dbCxf+AHHjsfR/79B2uQJN7qv5y
         DN3sJ1UzP6LdO/gHbpwzQgAEND1cqN2/GbUzIw9RmkdVcfpY3sZtudPu7Aer4kYKkI
         2xTLh1+MgxIa2ZiI7FxoIOcwIp64jUVRNhRjYoec=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.11.114]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8L3a-1iUEQ115iU-00w0uU; Tue, 02
 Jul 2019 17:40:23 +0200
To:     kernel-janitors@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] openpromfs: Adjust three seq_printf() calls in
 property_show()
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
Cc:     LKML <linux-kernel@vger.kernel.org>
Message-ID: <22563348-fefa-8540-9d71-de37764f0596@web.de>
Date:   Tue, 2 Jul 2019 17:40:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JxiWIYXw9gmhR5r6woOTjGVR6MjO2eh4EujnnpT0chsKLzSsGWH
 B2mCJnGEY4HGjFkaldkJKEejp52mp36rN04WdlcTSOyNx+Q1SHqnWTnPS4Zi8je9Z8M+n7M
 JgXr2jJ4P3qnzOWQ+qVfAsLTn9iEuxkS7HVof4ZJI3vQQlur3ju/FXTzun338MkeLCl/Yl7
 inH2GvjKi4g2oOHVTAeJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J6dmmI/s+y8=:AGCapRw8MW69tokZVkYyPC
 KdB5Gq6dQpOM2aS95rbkh8DvS/jmWHso1Ze8PdqTQk4qZTtnf/lGxA89SFb1hRLO4xfWOpURA
 AYGZVhOCYqFVXa3hkuD5cVzd4VzgPDYdaBcR8fJ8LTHld2A64wE+DXqsafO4jfAbH65dUeVXo
 2DIXCHsPlYYsPkt1k9iqOn5p1K5eKmiq7J8/tpkLmaQ/JpYvM1uzl/8Uir6L0oPnZRT6DCEYI
 kji0mLsQy7+KOPU2yY/6EYAgB3F8DQodKVDA/mUuy6BhCp0ffDkPcsDyfDO8E10khBZNKzU9C
 g235n07NeQOndwIKdfZqcWqAO2u2usYgoHVVX7UPhA/6mom1eJ77RoZxEggkRyREDWNR3kUu6
 APaC2tRYICy5+u8t2UeODclmfD6UxOb6fqyXlPeAjkN039YOJPz55RrbOmmLmQowimK/yqAsn
 UkCZBu7A80hyExbDOEdYmOA/dcaWElPK+BFa1rBkHyIGVidMujedLBUMPXzSCR99n2BUwlXbU
 RkTgO1eEbDUN3xA/G5L9c4fTRg76TEw4rv6hwmZTKNJgw0kDqEnZSrpjusdwyxqC+MpiIQoZH
 JOaiewLNd03tusylEeiM4HIaXM9Zu618ZEMSwlLLiB3+y5gy/WGZuLwtGOudshtAGVajoNF7G
 n431ZjfgYWTQUiFxxD4GB69r/mCdFjgpN3V5oLvNzrbTvMR5mzTg2KX1ExhnU0PGL+hbjXwCB
 sIzDyu6NEbAPhHt3uDqJldywJMYNYRH3NiTtg+UHJqSZrjStIXv1SXipV2FEPUrUGC20O1eMT
 RKwrc4x7wj9odgxIocRru79UvHhFLFd7TDo5ymMnBA1IrJ3tQh5+i05i2OK4omQ3gn7IbYL8J
 QVJHfv51H5A289V1SUdvwNTUET46Fp4dajfO6JItbnLhVPwR+wTIoGIqCFidYUUo8nQ+eJerB
 dBEREiNdlvyChb26xWexQTn6tANzGn0ZfA3WQ9/OUGE1h7FivPnkcbqiU49j+aQhe3wZf7LDH
 lfnfeopGAA0DqT04biGMQhlCz1SYcjHx17qYhvETXTW50o7KIg12onAlDX3snJ6Gc0JDi1JRB
 y/PwN0wOLjeHqUU3FooQ1IIPnb9sqgMhjzn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 Jul 2019 17:24:27 +0200

A bit of information should be put into a sequence.
Thus improve the execution speed for this data output by better usage
of corresponding functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/openpromfs/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index e6cb7689fec4..2234103fd8ee 100644
=2D-- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -76,14 +76,14 @@ static int property_show(struct seq_file *f, void *v)
 		while (len > 0) {
 			int n =3D strlen(pval);

-			seq_printf(f, "%s", (char *) pval);
+			seq_puts(f, (char *) pval);

 			/* Skip over the NULL byte too.  */
 			pval +=3D n + 1;
 			len -=3D n + 1;

 			if (len > 0)
-				seq_printf(f, " + ");
+				seq_puts(f, " + ");
 		}
 	} else {
 		if (len & 3) {
@@ -111,8 +111,7 @@ static int property_show(struct seq_file *f, void *v)
 			}
 		}
 	}
-	seq_printf(f, "\n");
-
+	seq_putc(f, '\n');
 	return 0;
 }

=2D-
2.22.0

