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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E998BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C169322D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="LLzyiz+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfICOU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:20:58 -0400
Received: from mout.web.de ([217.72.192.78]:51171 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbfICOU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567520444;
        bh=vMgAzBXUWskQTecRcuVXqAK+gjDpq21bPltTH0WE3wk=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=LLzyiz+MMSl5cCqMEnzYAW/NWXCMP6xyZV1AtYa+Etj2NDgUdRV+8o8PIcYyMkfpn
         2B9GdROulxOh5t/TQXb1UqzkSgKFwjaBiVyj9yqVnSLcnPOtdjKOetasPaxByM/iZf
         /GmqRwoMWlclAn0WBWBmJOKqOCENBGMwXGUAHk6g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.133.43]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgwZQ-1hrs0h3yYy-00M3cJ; Tue, 03
 Sep 2019 16:20:44 +0200
To:     linux-ntfs-dev@lists.sourceforge.net,
        Anton Altaparmakov <anton@tuxera.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ntfs: Delete unnecessary checks before brelse()
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
Message-ID: <9d047687-af84-4688-c025-13103cc22a52@web.de>
Date:   Tue, 3 Sep 2019 16:20:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0jR0GS55GaFdFydxT9bQ63zyKh3AOSnu2BwcrtffX82rI2Nh+rd
 E1lvLYUJPtSUvdq56al/VyGkMSEP8fbHSQN0lzMuf3BvECj4VXYZgCgUaYUBTJ539pVJG6K
 rCYI84xyfu95ue3XHspWwGLE0PZfN1azwBZu244b2XEjvp8sUtRzLDnN9Z6uZl8UdwjVBpA
 /kYbBFBZ96+ogN7SMp6MQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z2QhvI6IXS8=:KyHeoZ6CAd/47a/5c1uDE0
 timjntSTdr+cwCFyHvlfw6Gof2E0HIC4TGOj9zdVb5fmshfzWB/lcN6MiYbXP7pygy8CUoTZ3
 ljWPxyTcZrRxQK90SK/FWxlNARmpe/VWliaHLYsFAL2k//XU3usNQwgeJmKdOMU+2TVHmwmJu
 3rLzzw8Dk3NFPUT+gVXtcr3i1qofi4Kt325/k1BuAm12fYxnQNV9HglX7ksGJ9G4MMgVKfVDV
 GVruJEEdHRR3Mxut0Pt2FuiATnqJMrW5yXyUMFqYC6vmh2w/pu1HvZq5n6nyeQCOTWfZK9w2H
 0Oz2pdxq/Fnmfvo/kC8ziu+jxdyOQVqkhIMADEZIgbE/3NODJRX7dV16ldnTQcOOdaJ1RlNsQ
 60jSHw5lYCFOZ0f9LS4B1XezVK/AYSgbDGX+DkVRQlGLBsudOf/gr3ED2fzkAlCJj8856omdx
 ngr8boWgOdp2QzjHMN3sA4zxGouO+rSCrxGX3gVUsg7lvI1AzIZ6xtCol4LVALBaf3w7KopHo
 Y3Uru0pOsJm8aA1H0aRbBET64bW/W+qt2cyYb7SB/cKEY5Fw1WX6CxM3ehZ9SUP4/XZVCws9W
 l37Ckr1i4jr9pALFWVDqAckCc3uXzv3uSUmp3HyEN2dMjj3arURpS7n04kDzdlWAWJ/+qKu8A
 VPdPQJH/fMB95+AYQ8mDvBa2X+RvPqhokxYgdoenhycX/Kun0+CNOq7QOnsPlLDlsvlbwIJTZ
 DJG6O6t7UQWD9FnHp+9r6cl7Lkfac5di0/aqsEs5eC3eg1RIN+gTBuOknq7RdwyieGSVfbzzf
 lZmZ4o0qN52UePPhFR466ukU9T9Oa0WeTo269NgGhOitYnn+d0P+3G2TKeQW6cpnVls5Jwt0s
 rlcpgOgiazojDG7xlvvBsuwXQhnfrVyUIQxNgpa/hW+Pb/rlVyi9I7k7MlinWEwQfL4EVvtqY
 jtv9pw7/htR8ILu6yH+sSvbk6Uq5MANDqVyo9DE82u3vHzijPK4LJ6eqq/cajPdB9VvqgFqEh
 TZJMdsl0ph2bIa/i/po/j8K535vRiZ6WgUUuubsSYQJgCl3Yp+keurd74kXzGOTaRhmuFwJnC
 kWnMEe6y1ccfpi70q3KumQnMF91ikYub6rYfznPUOOv4KqKXcARr4pkzsbKb2G/vTOD/cd+7l
 MKdqauOZIWHZrmryH5JKxNkKXwlFHRevjv+rjVs2C97YL02w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Sep 2019 16:18:07 +0200

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus the tests around the shown calls are not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/ntfs/super.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 29621d40f448..f0ed1a3e5c7e 100644
=2D-- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -676,8 +676,7 @@ static struct buffer_head *read_ntfs_boot_sector(struc=
t super_block *sb,
 	} else if (!silent)
 		ntfs_error(sb, read_err_str, "primary");
 	if (!(NTFS_SB(sb)->on_errors & ON_ERRORS_RECOVER)) {
-		if (bh_primary)
-			brelse(bh_primary);
+		brelse(bh_primary);
 		if (!silent)
 			ntfs_error(sb, "Mount option errors=3Drecover not used. "
 					"Aborting without trying to recover.");
@@ -703,8 +702,7 @@ static struct buffer_head *read_ntfs_boot_sector(struc=
t super_block *sb,
 	} else if (!silent)
 		ntfs_error(sb, read_err_str, "backup");
 	/* We failed. Cleanup and return. */
-	if (bh_primary)
-		brelse(bh_primary);
+	brelse(bh_primary);
 	return NULL;
 hotfix_primary_boot_sector:
 	if (bh_primary) {
=2D-
2.23.0

