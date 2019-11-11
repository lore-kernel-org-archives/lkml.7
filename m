Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA45CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D5D222C1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Arnr4ZLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKKOpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:45:42 -0500
Received: from mout.web.de ([217.72.192.78]:44843 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfKKOpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573483525;
        bh=uMoDkWJUgFT1gvyvqjo2rYa3D4aad3/mfFPRtyiVCP0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Arnr4ZLX88KyLn9xlJdLEaG2NSF8PKHfCqRmVg3by8/JRmk4nHwG2kLzNewwhwgEl
         SG6/RYZ69JWLUUohxVTy0B5cXHHsrQD1MAdRFHK0HO9Q9AhqavvnL7jxG2kE8J9+bn
         /lYkMH8Ybin76BUwBnfWueKEndS9TFMSi7ELUUvQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.55.229]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lkh7Q-1hwDAX1sZw-00aTlV; Mon, 11
 Nov 2019 15:45:25 +0100
Subject: [PATCH v4] s390/pkey: Fix memory leak in error case by using
 memdup_user() rather than open coding
To:     linux-s390@vger.kernel.org,
        =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
 <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
 <deb7893f-3cfe-18fc-3feb-b26b290bf3c6@web.de>
 <833d7d5e-6ede-6bdd-a2cc-2da7f0b03908@de.ibm.com>
 <1b65bc81-f47a-eefa-f1f4-d5af6a1809c0@web.de>
 <733b29df-207e-a165-ee80-46be8720c0c4@de.ibm.com>
 <8f98f9fc-57df-5993-44b5-5ea4c0de7ef9@web.de>
 <c0df9cc8-c41a-1e5d-811c-1ff045c13fcc@de.ibm.com>
 <61244676-8ac1-20af-ed94-99e19c1f95d5@web.de>
 <040f3e18-d97a-fc32-b237-20e7553e1733@de.ibm.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <aca044e8-e4b2-eda8-d724-b08772a44ed9@web.de>
Date:   Mon, 11 Nov 2019 15:45:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <040f3e18-d97a-fc32-b237-20e7553e1733@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vv4/yrx5YeN+Rejl3yr+6ogSVlusXLgt44atnhw2xRn0UjiymnL
 j5XXSSKhLFP+n9hYBHZTEF3S11bOV3SDRTttmjK6EFPrAgtjfw9viUHby/eKG7zvzv+PA/Q
 wWyx+Z8C7/dFhPuQGlvch+KSN06IFarQ7P2UbTm9rnuaYABbDo3nnr5bZltJx7LzFzdVqzN
 DwbkqOELoOuX5eSNFbDNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m5Eyl2mAIT0=:znTxTalbGgJpIHiDRy2kgh
 FXXS7+Rm35fUSyTHC1FANbwaCIjn8mc9+Ofu+w4+nBWZqynagIQWtjX9YIAqxoWVFUWXblJ2Y
 9Y3WnZsbvo8+c1z9qtm/NHF2TB7Jvt+1ZlAbVdluBb7UA33S7A+7vKBglo5HJrawc0V+ejNZ6
 VJ4EigrbBzAo3dC7m8e4HnNQmwA6zWEWMTrSt8R9seThHFq6HrZlFb5sZCowQ08RWTWM969hO
 TMXGgDFHS8/eYdDKrH8Pwjb9egKAMgoIl+0/8iqtJrQcXO+/KAsYoxo5fH9zzsnNFKQm9WBab
 yz0jli0nTEwr1SPBueaNF7Ne9iHqtxemtFhCWaj6OADey9uXd2XydR2FOsX7e21yaH5/Z93B6
 dvcPpIn4K9glzGpSc4rGvaucv59B0eKzrsBKLWekg5EASYPN4QjJLlLFlsYNX65mmtQD2blW6
 gYDf3D0UTPCWl6rgmUtD2I1T2GISc+CYkkvnyx/p2+LiCk9wqcVT2Vuky8BO2vk8Di7MOkhfF
 vxi1b0F2KyO64hxB+aL+kSuXyfz7VvuE6N9Hot36Vls1LfjJrBwt9eY2URW6/DBz/i7pR+x4T
 xeNmDK8XwLzLDgVOfz72s1eE12MTNK79Khl25czIMUV3OmunriTRB/YFd5U+dRsPaWreG5IXe
 BN1BazTbEYgg2+jAdPErQTu/7An6w+k0qwpvMBfrf/pCdv4KutQTxqUhRPjGHo3ViMoUyN7vz
 t2RvIRwBdEHOJdCwcx7s8beTgCWEqSaZHrHl7zUR+iwIlMYROmSkZ5WeRttDbiXK1yaqlG/h4
 J6T3YOVwr3ysMNyqDJOt95rJZjaS/VULEDBUM9K9UiGZjzR6MrXTXTtNnYW/QG1jozSyPr4Yn
 //ejdiuxCoHOxhTgO9lSNga44nr47v0+EFROhQ84SID4rZ3l3LgvO0aduxCSwJayIcTA84Mpf
 JEjzJUZH/ly3G/PHTgjYv0BW4G6xL6tAnB5mwyVIuGZsaAtBKSA8N7jJAE5C4Rj2RCy/CPyeh
 gLchK2IlwT8wHBlYUKCOhd2QlbhwBKKNJisUqpBCbxk6pPU29NwNrvQ4H/sexRSQiXlDiiZr1
 Vc3rpN8g6TLTtCtot7mn4AkVsQ7um/HkUOeoHqmH9PFDjMcfSjXpb8reIciUnlYEPLp5LGVcj
 /gjZ9Z86eyAYBYxhQak6/aUanwbTMpUJiDlGMEElJ+xA3uUimias5f3duCov8+iBWi7RGEtuX
 J7abSM7EIBeetuBqCtYgOKtz/YUXQ8X3HeWYqLXlz/9ogJO2nDQQSTL+E2Ow=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Mon, 11 Nov 2019 15:20:44 +0100

Reuse existing functionality from memdup_user() instead of keeping
duplicate source code.

Generated by: scripts/coccinelle/api/memdup_user.cocci

* The function "_copy_apqns_from_user" contained a memory leak
  because of a misssing function call "kfree(kapqns)" for an if branch.
  Link: https://lore.kernel.org/r/833d7d5e-6ede-6bdd-a2cc-2da7f0b03908@de.=
ibm.com/

  Thus complete the exception handling by this code replacement.

* Delete local variables which became unnecessary with this refactoring
  in two function implementations.

Fixes: f2bbc96e7cfad3891b7bf9bd3e566b9b7ab4553d ("s390/pkey: add CCA AES c=
ipher key support")
Signed-off-by: Markus Elfring <Markus.Elfring@web.de>
=2D--

v4:
Further changes were requested by Christian Borntr=C3=A4ger.
https://lore.kernel.org/r/040f3e18-d97a-fc32-b237-20e7553e1733@de.ibm.com/

* An other patch subject was selected.

* An other email address was used for the tag =E2=80=9CSigned-off-by=E2=80=
=9D this time.

v3:
An adjustment was requested by Christian Borntr=C3=A4ger for the change de=
scription.
https://lore.kernel.org/r/c0df9cc8-c41a-1e5d-811c-1ff045c13fcc@de.ibm.com/

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

