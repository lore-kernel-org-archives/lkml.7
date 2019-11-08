Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C68C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57163206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dHW+qjMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfKHRQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:16:03 -0500
Received: from mout.web.de ([217.72.192.78]:47375 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfKHRQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573233292;
        bh=OS/a1IvogRSMfFZr6uZq6/5wzianrLUjUnxkOrbzObY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dHW+qjMX1vR1LKxVNOoeLxMJ8Ec/UDLUC4nMV8tu9pNTjZwWkHgASLBjcvKNhNzNW
         52JKIHtpOCS4yzVmlU4K6cSCCfIhz6dxjeKCE3TnvriTlddtyBQisuQXx0GmcBKY0j
         gb3T0SId56gdPwHg/y5ff6n6K0EpZ9roiShg2qL8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.72.105]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LbrQm-1i1SXY16N2-00jFKP; Fri, 08
 Nov 2019 18:14:52 +0100
Subject: [PATCH v3] s390/pkey: Use memdup_user() rather than duplicating its
 implementation
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
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <61244676-8ac1-20af-ed94-99e19c1f95d5@web.de>
Date:   Fri, 8 Nov 2019 18:14:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <c0df9cc8-c41a-1e5d-811c-1ff045c13fcc@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:be4N0LzFhSPxQQ5Ku6SB30JYKXQPgeR5FoiXs11IiXiA0+7Z9D1
 vINqGw+2JbI0AkcsBkFnLJIsjRmc3XekUNFXTa5e3SMjsyyJXz+1hd/mb0Sw04BPgbnqypC
 bJtLgWmGNf2YREzhZ3NDFC3sq9XLspKop2Ony4Zc66NVgj0BHdwHNzhXKw7FI8rBiA5eO26
 7eS7R21FgGxsIu+DgQoTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7T4x3b7gvZE=:e1dMuwKX/dsvEVkvfG7geS
 Yrkd41TJHKCXuzHoPjZ3WakvBDVVJAKgXt14+wpHK8KaJuVIm7r1El1Tt5Z/Zhy/3oKlUmrAN
 08Uk3/+H9DTWbMTutq/+6e9d3V5Kg8+gkESVFG3iOuNTf+WbldH/jcxx48Vdbzrzyo7KAP1Wf
 xXFaW7OP3xmY7Ny4YJ4XMcMAQxCtxzQN8Q+hkerYXp41LykvTkJYlsu02NV1lyWa2S4lmuI9U
 4Lyd9REcJ2RI9NQJElZy/OJgyrj3XoyQrH5a7oj8jMNLbqPi76VnMQvWXHS+yKAeK3vl3zWL+
 kb2tNUwoNPut4+8MLyKJqSgCzyJxWUuzmMFFrcQiKrqTlhUoIrh7TP2SJteyUz16a5aIbQpfz
 nHHUTSeej47PXuHNUS6d+6UFs+nNah0yHlL6WPjxvG7HaU/PVZpg5TTFwV/sWcDGI727zDKfX
 Ll4nfgive3ehxOETSsbkpanePB0qhE+xfha0QZxNvxMoV+X5g5E36RCtzM12Wp/1DE2bI+Gt0
 yzW6ud+JZVkyZ4J4dq6wXjDamE+jN94Q1glUL/ttVGO1pMI9AGZ5Lsc4tBWqvY9tl3fKh/o+g
 nTlFPXjXxb1e9bgM96QlQhAmf3fFaBIZWJY+gYTQWsEBsrkE4QzF/sTtMprHRxJtAX/0bmQCf
 XSEa/hjdij8MdShUg6s6anqVbmDQRMVh9kahTUHx9VDOZIN/51YxJMx8K6Bepfsn1gQYOxPD9
 VP/Ns5iCkB3lkq+3NsDutWyCew3xnRlPHZCCt29CYdtV38h8GJBU9gOYoTO1GzBiStnQrhfxq
 BQj324xN5G7EM/xYxqsLM9Fp5Hknhj1MjQrDp0pZc/7JGZGO3oL8VhWg6jnGwXgqyUWwJYRBP
 wPevuZnml3NMEDpTtzvjxRywq6fmMJIzZGIS6/L75T/S/7jv8wdsGegh+DINvmSWhk/5Cu0RH
 J0gbLshL/dvVP+M4iBQssAeJL1V5inlTAhfw/mI4Sq6DO1P8UqqBk+Rh5JEIRT1Df+CoVlA3O
 7Xp6FxF/z5znNRQBvCqMM/x5k/zo8wHquNuSua77gv4Co+6lUzKse/gAzJ1EyBxo3J9N15Fzz
 qbi6wZA+8pFIEB8F/w2jxPn+M1jskD5TAV8Ao+sp1Ey4JQ8ETyTknOaqsfEngl/EeBHLVbgTD
 9m5apGt8eOjTJfomYxrVn09h5bR5g3v+b8DOxAsqheZMKnbS+vC7uSbsNX2SpOsaY7ra7iM+2
 VcTaPjeOgOxGK2bU1mdWKa7fKVCqRWy3xq/OpGiOqA2FjaGRCedYV/uPTkww=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 8 Nov 2019 17:50:22 +0100

Reuse existing functionality from memdup_user() instead of keeping
duplicate source code.

Generated by: scripts/coccinelle/api/memdup_user.cocci

* The function "_copy_apqns_from_user" contained a memory leak
  because of a missing function call "kfree(kapqns)" for an if branch.
  Link: https://lore.kernel.org/r/833d7d5e-6ede-6bdd-a2cc-2da7f0b03908@de.=
ibm.com/

  Thus complete the exception handling by this code replacement.

* Delete local variables which became unnecessary with this refactoring
  in two function implementations.

Fixes: f2bbc96e7cfad3891b7bf9bd3e566b9b7ab4553d ("s390/pkey: add CCA AES c=
ipher key support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

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

