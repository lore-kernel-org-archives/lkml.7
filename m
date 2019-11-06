Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFB5C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9F4217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AFxe9+kl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfKFKWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:22:13 -0500
Received: from mout.web.de ([217.72.192.78]:43715 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfKFKWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573035728;
        bh=0+yaVCRjEoAqR6qESaIbxqTXT1G++FaLrENr6n0OCg4=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=AFxe9+klpM9U+eyrwBjBB8OTh370WJeWtvbroLJXXCfGeEokKIEDSjbOfK6CD27zM
         DG6r+RJbwgErF/xstq5NZ1m3KNE4MMZ06Rj2pd0lLdExzuadw9qO/s4np+D5GL00SU
         6yP43//XHjb/aBdGCLwOr+EtBi5F+tYu6njJrQ6E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.91.235]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lmu2K-1i0d8W26u4-00h5Lx; Wed, 06
 Nov 2019 11:22:08 +0100
To:     linux-s390@vger.kernel.org,
        =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] s390/pkey: Use memdup_user() rather than duplicating its
 implementation
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
Date:   Wed, 6 Nov 2019 11:22:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vg0SY1SAgPp7LLq7TN/QYjIksrOCeK6TRdOJm8gg+E1QhGKFmGj
 N5sw6P2FHoVFdviH9Xl1cGjTqEyZn8q/NQuvGHcpZnLKauhQgqi0axNgn8NXy6S5kbZE6FD
 Ho4+JlJnnjlH9+CUKZ93deGvMRwr9+naD+R7/wP49bhxtEQ6qkos6hWnN3pcnJAiV8PBHzy
 TBlWXBJgcjGVvOV6qS/5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IfoOOADrtko=:p4E7aiDKJrA9VZQ+83eZWH
 tbzsxJ1A7wrFB0dOeRn2k2CBElHfAH3OI000KnxsTKt3JAM6+0o7Q/DV/tWLTP92mwsmUibty
 xQ2ogEjnsoVCZnQxji9xhF3umvmLjcBisBYzenbFq4H1k8jhqBdeXjPTMOhO85k2fxTjS7qRr
 ylPSWb7I95VTd6RNDzgmgOJUFzM3DBTom2qY08Ul2hz3IWj2wLy70UI2bUHhO8PL5vO38bvb5
 FRHWA+HLXwC38dCKF+OhZc45wA16biLx1yRP8hUTN3Ae92g8uUyYboDpXTjIG7L8KuRswJCz2
 peqgf6hKM+ls9iN9YVXJctYWhGeQ7iKSV0t3DY1d9O/mOznEHTyYYuAdfSeX0AJHm2F91IY5I
 bbILYbgSJPMpFO34QSBYUmQMMyK9uVyoiOskFNSWTN12ytwI3ZBflY1pdk0q8Fo4TNazY/iLF
 oA1X/A7Kwy7QlxzOg08IAoduUsr9LWZ6MoG65Rk1wyRiD7l9Mvx4hqLEV0vNe4RILernNHk0U
 096zZaM8DVZhajzbAAZKJ0/PMYsl9GBmjEMkc8ahuHYSKIuwjBoACe1qCON8EhScNkL7kaVjk
 ms0LTxTVPCinIS3hDzVEduEscn/xWNhmBkVzy2p7vgw+/n9+XeDtehbI63WBjI1SexzMJ6ikU
 4Gu/N2ZRH9eTqgy+F9azMrlZJxHmoolJ0TF5glFaG07J0lHB2HbCQcTHKm7qMpcuCaYQhfImR
 1ex+KfelYGBlQbQrhON4wpYFeI3H5I/ZMAYM4vt+q7Loiu3VRzSo0EQ9xgUxmkULfbhrPFeXf
 bfy7vtmyj6nWJey/qZYBzTFcvnSx3NA4gdj85cCIQF0nH97HIPnq5n6qUYYiAvzxm82jM7Pp5
 DvmxEkL/kr+1O4iOcsrC9I/auVSG4jViDbniHkWath1u4cLTorbudXDnAZh2gds/kx3yAko1W
 ZWPs0Bz+tqyUOgImZOtjh1mxXBxy7LsKwGQn410Gvi/7b4XSzTMUjS2YbWaGD3QmUYX9kl/XR
 b8cA1rbUUZNPsHJ9yMrmR0aQ9E8BUEGFPsFyWJTutkuw7GNXJ+yt6JQ47THQ11J9swGRcvk7C
 PgpgJP+kdp1uAmeUtrI47nWYaxfwsMTI6ZpHMWYseAQlUUhwr25jfRxmsBwDYfOc5DYOe+fel
 VeNf/84tH96mRQObaQjH3ZyfvNkeJOVf0H2Z4d33Ezeyzs8mCvg3eGAlFHjwXsnMpkag91Zam
 uwSFvaWBqtl8bRR9PgKsgbfkCezD3ITpdUX4mnw0u+oeiCFcxc51oltC+Ugs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 6 Nov 2019 11:11:42 +0100

Reuse existing functionality from memdup_user() instead of keeping
duplicate source code.

Generated by: scripts/coccinelle/api/memdup_user.cocci

Delete local variables which became unnecessary with this refactoring
in two function implementations.

Fixes: f2bbc96e7cfad3891b7bf9bd3e566b9b7ab4553d ("s390/pkey: add CCA AES c=
ipher key support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/s390/crypto/pkey_api.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api=
.c
index 9de3d46b3253..8c0f12686cba 100644
=2D-- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -715,36 +715,16 @@ static int pkey_apqns4keytype(enum pkey_key_type kty=
pe,

 static void *_copy_key_from_user(void __user *ukey, size_t keylen)
 {
-	void *kkey;
-
-	if (!ukey || keylen < MINKEYBLOBSIZE || keylen > KEYBLOBBUFSIZE)
-		return ERR_PTR(-EINVAL);
-	kkey =3D kmalloc(keylen, GFP_KERNEL);
-	if (!kkey)
-		return ERR_PTR(-ENOMEM);
-	if (copy_from_user(kkey, ukey, keylen)) {
-		kfree(kkey);
-		return ERR_PTR(-EFAULT);
-	}
-
-	return kkey;
+	return !ukey || keylen < MINKEYBLOBSIZE || keylen > KEYBLOBBUFSIZE
+	       ? ERR_PTR(-EINVAL)
+	       : memdup_user(ukey, keylen);
 }

 static void *_copy_apqns_from_user(void __user *uapqns, size_t nr_apqns)
 {
-	void *kapqns =3D NULL;
-	size_t nbytes;
-
-	if (uapqns && nr_apqns > 0) {
-		nbytes =3D nr_apqns * sizeof(struct pkey_apqn);
-		kapqns =3D kmalloc(nbytes, GFP_KERNEL);
-		if (!kapqns)
-			return ERR_PTR(-ENOMEM);
-		if (copy_from_user(kapqns, uapqns, nbytes))
-			return ERR_PTR(-EFAULT);
-	}
-
-	return kapqns;
+	return uapqns && nr_apqns > 0
+	       ? memdup_user(uapqns, nr_apqns * sizeof(struct pkey_apqn))
+	       : NULL;
 }

 static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
=2D-
2.24.0

