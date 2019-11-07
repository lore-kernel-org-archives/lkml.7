Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC44C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C87206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Avr1nZQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbfKGKGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:06:16 -0500
Received: from mout.web.de ([212.227.17.12]:34323 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbfKGKGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573121166;
        bh=tGmR5calghk7RYQVWvGi9ql++YV29Qmsl3lu1QpyWeg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Avr1nZQEV8CnYgtItZ3YVLnof+kjMsY4SU6LXnxx2oshTGflYQLfBGtCna9Jj3U39
         S51FhBSw5Ov9rvrL3W3G25339Qs1O87WhID5Dobc4SXy9GLWdQUFlr5XgllnA8o92w
         7p7G4iJqeBse5LGepm45tiKvj5eUbGkJuixJ34q0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.68.124]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mb8sh-1iCMD83CoN-00KdBA; Thu, 07
 Nov 2019 11:06:05 +0100
Subject: [PATCH v2] s390/pkey: Use memdup_user() rather than duplicating its
 implementation
To:     linux-s390@vger.kernel.org, Joe Perches <joe@perches.com>,
        =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
 <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <deb7893f-3cfe-18fc-3feb-b26b290bf3c6@web.de>
Date:   Thu, 7 Nov 2019 11:06:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ma/uEGKWkEfnuuES8DbJVhQlCtL3mwvFI0yXMGIUmdtfh9w63lb
 67r/O6/PvxNX6h0dve5mVDcFRDDMw4GXnoiliukMyGGiVB5u/E7J0AX6jSHoBx03lZL3LUg
 1dJMTsgDFLXqyWtuyBhbYZLntXp+nchmmC1jSjmNd4vaJhouCzFdevzucH+KzfRTuRsfr4h
 Ty+F097NNQi8UUxPFIFLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UYbxHRl+Bdc=:GCLq4K0YaKqJ9mPbXv5o4Z
 wN+WBfiK7avtt5qyK+I626UJ/X3yqQGO4npYaER+3QwnOMSkeMtshQY8eKJB5DALFsfyOfA+i
 WtO9xk++TijxXoVhT2GDPVFOIlir1AaBZUqH9uJ1j2z4b5DDosGOMlWe3VCvUpNHcBAgB2FpH
 PCCOpkKYQ81pOelEmNjDCk/tLefrz3desRFtOHvSIMWcDbqBVvBSEcmotirRMk0eOz6tbXzFj
 qFgL0aHqP+uoM0FkS9HRRme1aNvesn4IqByUShji65v42glrI2RWdRl/+0oTRgy+9bhNZLWHW
 DgIjpAICbYc3sc2SDn4xD6FFJMcsBphuueT57/bVZAWKryR9nXiCZEPUdF3smKk8Ekuxb1cW/
 NdHaSuX6cGXKv17QY5WuVYkfEVv0jhvanlPX846DHtn5hjSyyagp0ClxpnDB3N7fEFdktdyZ6
 0kLDBwrh0urD1ka9DaCUSBRm+2NLBY9uyr0Mq9ZR4xo2lly5/sRImRYs/eyVAL2amhoN48J6k
 C2tTYYkhsAVpQCcKaPobJ5cy27R4LMS+dchmUqo68KMAwywCpJ3o3vihKkTo+EaoaKaJ49r7w
 Wwiw/my+RAj3JQtAm3Uvbwot3oHwlyJRY3u+uFVNCayr9qXmCFTUg5ZX034JQlvVZTwxVd7xx
 B6MmiawBdi4hEkqv6in3sBC3HFXYvgU/Ocn/01bM0gpn2vrfVm+Wy79DXIDmqbQS2cyQPi5N+
 NFdN6InZEa8LK1jpk0eNEDsK8feiyhwlS/3REcfsJ9JaWpyqz0xuxJ4gaLX2+McRaqsx3DbZg
 q4YAbz7bNcMWnY1/GDJYrDAEJU6Uid1hDn2uznPBJb8wXIjI3tTfcDaWQWZQ4/kDROlHcc4Aa
 6PBSlLqGuVlkzumTfc+D6XfVK9f/NnYV6J4GhGbL7EDeaM9gxAQ3qN9wMshPdFV2WshVkaB0J
 xZagb5p2fV0CXgOkwQ3rkWT3HOt0QVJQIMdQgUwM2ykgGq7t6zgW8sjJwajguF5IfLX6tXvBH
 gM+xM6pfo+5C11TlbVKTZ6ObkScp6iOfJC0y1JitSBwxoxv5yIG1KfSzawGhOSpGfRjGkFGZx
 iqvqadMkVd29No7HW/6erXEIBM540+luOgUVjQgWm/Xg2SNqVUwXG9v0UihzSXEH2wag4uGA9
 b7+8+oDjqeLBECfVjLZVYkybIA6QsNXzG24+BwdKW0ufRZ2gyg+Fq4semh9/SVtGLCo+i03Wo
 brQoeXKX/Jc0GQd7psssRKve/PN5XgooAg4SUPn5EOhF3QGBobkDjrEbIC9o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 7 Nov 2019 10:40:18 +0100

Reuse existing functionality from memdup_user() instead of keeping
duplicate source code.

Generated by: scripts/coccinelle/api/memdup_user.cocci

Delete local variables which became unnecessary with this refactoring
in two function implementations.

Fixes: f2bbc96e7cfad3891b7bf9bd3e566b9b7ab4553d ("s390/pkey: add CCA AES c=
ipher key support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
Further changes were requested by Joe Perches.
https://lore.kernel.org/r/6137855bb4170c438c7436cbdb7dfd21639a8855.camel@p=
erches.com/

* The proposed usage of two conditional operators was replaced by
  an other code structure.

* A sanity check was adjusted for the function =E2=80=9C_copy_apqns_from_u=
ser=E2=80=9D.


 drivers/s390/crypto/pkey_api.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api=
.c
index 9de3d46b3253..ac99fd97569d 100644
=2D-- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -715,36 +715,18 @@ static int pkey_apqns4keytype(enum pkey_key_type kty=
pe,

 static void *_copy_key_from_user(void __user *ukey, size_t keylen)
 {
-	void *kkey;
-
 	if (!ukey || keylen < MINKEYBLOBSIZE || keylen > KEYBLOBBUFSIZE)
 		return ERR_PTR(-EINVAL);
-	kkey =3D kmalloc(keylen, GFP_KERNEL);
-	if (!kkey)
-		return ERR_PTR(-ENOMEM);
-	if (copy_from_user(kkey, ukey, keylen)) {
-		kfree(kkey);
-		return ERR_PTR(-EFAULT);
-	}

-	return kkey;
+	return memdup_user(ukey, keylen);
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
+	if (!uapqns || nr_apqns <=3D 0)
+		return NULL;

-	return kapqns;
+	return memdup_user(uapqns, nr_apqns * sizeof(struct pkey_apqn));
 }

 static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
=2D-
2.24.0

