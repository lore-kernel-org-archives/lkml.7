Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11182C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3FC2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="p20LNyLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405538AbfHWNab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:30:31 -0400
Received: from mout.web.de ([212.227.15.3]:35907 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732014AbfHWNab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566567020;
        bh=ALaFDHqwPH8Mt5DeXm4ojQGnigcAUy04TdDkzLYiDJE=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=p20LNyLL6Qtqx0hWLKG8oCnJbWfar2TVu/r30Jdqu2hnFXbqm8K3u3CRNjmL31pjz
         0Eouugubdhibh/NZvK21hUStvYzqxJarQMb45GVEXqmt4s4rqnfeB8+mMRk1EzkY+t
         Cog62BaIHpZJueR59UxhAd4phKjo2umlsMg7vgwo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.157.93]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6ml2-1iD4MS0yzU-00wZ94; Fri, 23
 Aug 2019 15:30:20 +0200
To:     devel@driverdev.osuosl.org,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] staging: vt6656: Use common error handling code in
 vnt_alloc_bufs()
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
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-ID: <91e8a9b7-e79d-dafc-10b8-dd79eb59eff9@web.de>
Date:   Fri, 23 Aug 2019 15:30:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4Q1UCrgqX3Wfn+IdiS0GOWjaZjKOAmQDNl55ErMjtkYBuB9Jc4c
 FOfOVb2sBF+wwE/Cf5hBkyjHnBw9OZEkZywetS0GIvYXAMqCek4f/D/ujdGqdEmRoRSSDMS
 qa1ezt/cp93a5x/tyJx0PzZHCjYCQe5gwSnWJOKlDOhOm+Y9BuuRh69O6w7jolSBnK0njyV
 xHMIi3M8E3npW8+768NeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NMFuZg+YpOw=:Wy50rB9lL65hc2IhRNjZm6
 z8Mz784OCczlaZuYnK3gm5yG3cSbqxLfvHAKa5g8K3hZHkFf4tQxqlSE9/8KWJjD7jo5odHLW
 VZvoERnpLIwaXFgJSqaoY18OY3lTaRqFxjJTFg43JtOLgZuPbYLJvFyF3fiyihgZHrFjHaZLS
 Ua8ocJ+QrqnprnJC+0Mf4dr2X5GsWogaGvO1nEUlBZA0/t8gPHlb6hBsnd1CPybzDzn9VrH4c
 FbdCHTzxuw0OyrYi1qj7+AldxiU6FCZVtBv4oSHSl59n2E5zMmcRKjaqOpsfPBHnLUQ1Vnmuf
 mT4zrqTim6CFP/l3f+i2/Yyihyd9I8IYEbS7Std3lGFzFGtIYwBzNSk7rAta4f3wmkno4dpU+
 m5P5kQA2M/jXgBRp8zrTr3JI86Dki1+hlG+ux4Ph8PVMP7uoji0K8KIQjbjxGlUtHY0uYeFBC
 JpXnDDTtX3XwNhYH1QPW66hra3LPkaLL8G619UO9KQqXyOBnAC94kpDhurIxr7Iz+8aPmHQBe
 93GveCdmGjfX3/QrlkcGIfV9VekCDyNrXe05ETeyF7XtnDLJXB874CLA/nXJ96yaW1x9bsiaP
 0I13+kM0rgyy4HMgz5QAhrkgSrL/gmK28z5zpaLLxWwkaNnDA1QVxkldMNkxB8V9l23n3Y58f
 YzHIT0RIMRSNtrXfsrncY2A7oASn8j13OqhNs9zTDtevB9q6NRDn1vf8PqaVLsDZHLh7yrLv+
 hdfakVfeeMRw/HZibHMrIXHq52iteH9YW00CjYXXvdLyX6pjoq1W3jdRIEVFB9P2CleGGGx9B
 kmVcBr4MmGxkMilgYz2v9ZtsFJ9fc/u1kAnOZOsT076bSfNW3GJltrCJvk9i0HUmEEF6kGGGx
 r7JbgNZt+rQPiKrArN/GoHnN3PM1MMDce0j1vnNC64uuYgPhi5Vd29I1DmAh/tdSpCRy1qWSc
 o0BYBc2rVLptogyZkJtCat5WSWE5GTWcRVE085O6HVTLvvGWV6e8y+gxnzH+pTUzvPY8LxLYb
 /+5rlHdIJm2ljlA45LaunR3cgsoO8AlZFej+RGCmNSGuxw0HAF9XCZkMH0/Fvobxy28KtCtEC
 1+11y8bh5lxsx7VGIVztCgslaqqa4DDTDoO6GssARqnL7RjNr8fqDZjrfEDzaj7rHQ6x5jthn
 q/2/8Z4ISvNAknkt6zQMmPnnrJwRC4OoGvRdlS/jVDEhjoEA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 23 Aug 2019 15:15:41 +0200

Adjust jump targets so that a bit of exception handling can be better
reused at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/staging/vt6656/main_usb.c | 46 +++++++++++++------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/ma=
in_usb.c
index 856ba97aec4f..d9f14da37bbc 100644
=2D-- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -443,10 +443,8 @@ static int vnt_alloc_bufs(struct vnt_private *priv)

 	for (ii =3D 0; ii < priv->num_tx_context; ii++) {
 		tx_context =3D kmalloc(sizeof(*tx_context), GFP_KERNEL);
-		if (!tx_context) {
-			ret =3D -ENOMEM;
-			goto free_tx;
-		}
+		if (!tx_context)
+			goto e_nomem_tx;

 		priv->tx_context[ii] =3D tx_context;
 		tx_context->priv =3D priv;
@@ -454,20 +452,16 @@ static int vnt_alloc_bufs(struct vnt_private *priv)

 		/* allocate URBs */
 		tx_context->urb =3D usb_alloc_urb(0, GFP_KERNEL);
-		if (!tx_context->urb) {
-			ret =3D -ENOMEM;
-			goto free_tx;
-		}
+		if (!tx_context->urb)
+			goto e_nomem_tx;

 		tx_context->in_use =3D false;
 	}

 	for (ii =3D 0; ii < priv->num_rcb; ii++) {
 		priv->rcb[ii] =3D kzalloc(sizeof(*priv->rcb[ii]), GFP_KERNEL);
-		if (!priv->rcb[ii]) {
-			ret =3D -ENOMEM;
-			goto free_rx_tx;
-		}
+		if (!priv->rcb[ii])
+			goto e_nomem_rx;

 		rcb =3D priv->rcb[ii];

@@ -475,16 +469,12 @@ static int vnt_alloc_bufs(struct vnt_private *priv)

 		/* allocate URBs */
 		rcb->urb =3D usb_alloc_urb(0, GFP_KERNEL);
-		if (!rcb->urb) {
-			ret =3D -ENOMEM;
-			goto free_rx_tx;
-		}
+		if (!rcb->urb)
+			goto e_nomem_rx;

 		rcb->skb =3D dev_alloc_skb(priv->rx_buf_sz);
-		if (!rcb->skb) {
-			ret =3D -ENOMEM;
-			goto free_rx_tx;
-		}
+		if (!rcb->skb)
+			goto e_nomem_rx;

 		rcb->in_use =3D false;

@@ -495,21 +485,23 @@ static int vnt_alloc_bufs(struct vnt_private *priv)
 	}

 	priv->interrupt_urb =3D usb_alloc_urb(0, GFP_KERNEL);
-	if (!priv->interrupt_urb) {
-		ret =3D -ENOMEM;
-		goto free_rx_tx;
-	}
+	if (!priv->interrupt_urb)
+		goto e_nomem_rx;

 	priv->int_buf.data_buf =3D kmalloc(MAX_INTERRUPT_SIZE, GFP_KERNEL);
-	if (!priv->int_buf.data_buf) {
-		ret =3D -ENOMEM;
+	if (!priv->int_buf.data_buf)
 		goto free_rx_tx_urb;
-	}

 	return 0;

+e_nomem_tx:
+	ret =3D -ENOMEM;
+	goto free_tx;
+
 free_rx_tx_urb:
 	usb_free_urb(priv->interrupt_urb);
+e_nomem_rx:
+	ret =3D -ENOMEM;
 free_rx_tx:
 	vnt_free_rx_bufs(priv);
 free_tx:
=2D-
2.23.0

