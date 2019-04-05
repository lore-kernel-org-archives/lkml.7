Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584FAC10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB5F21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FK09yYeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfDEL2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:28:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:43009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbfDEL2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554463710;
        bh=AcH2Y+kPjwVm0m0grrJWswjKGQxCRIPY8vyUMqtB6Ao=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FK09yYeU3831ykwrE1BQLRjd3vlMlEadDnDfLut5O29xj8Ks0E1sAUl7MQgfzwt5R
         cdkXOJjrmnWkVeDsVLjXkXlVcmfALOjBS6k0Q/L+tNVoQ7JST436ZSOrHvtSe6irUj
         BZ8JuqBi9dsW1X8P2QwSOcMKpDCJY/jKIBGO/eiw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx003 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0Ldq9D-1gTeDW3VcB-00j4a5; Fri, 05 Apr 2019 13:28:30 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v3 3/4] chardev: code cleanup for __register_chrdev_region()
Date:   Fri,  5 Apr 2019 19:27:10 +0800
Message-Id: <20190405112711.25275-3-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405112711.25275-1-cgxu519@gmx.com>
References: <20190405112711.25275-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+L48v9102JFn0TemtK4d4YQMjLKPg1HDVNCjtB97oeRWPypJdPV
 QXO1inBw4D3obyDD2CykZccqFxEltIiCeE+wHaZmkyaNFBENsieqMMZMc/wl3qcx7cgJFep
 +CKlKCrr/oBQS8HH/cffCN2RnUed01j6KIiRreCSqO5B3jeAFxJV87zrVmE8r6hLZE9sdqv
 TZICcoI1wjp9Gd1GarfVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/N4BpP4YNFI=:e+bL/GRUE3t/jwRKdN2X5G
 G9vTYYeV2gsibcwDCziu7pRg8kXDKy6rp9yNJhu9Ywb+mvQLXub1GoEfO8vHz7GhynoDjVYOP
 il0wo2ULlbRt2MJNmEQjZ5s+6hgPsFcMqE9slosz2vB0jaDFc+ByaUkaXnvpzHj8rkGmGTTq5
 wU0C1cjV9j3+HhjQs0CGDFMiVRjtZ/51lkWqgx5SVwAb90J/dx5+hNSssPdfXHW6fpHpqOKPt
 M4HZpr30kFFu0YYmVxTff+of1PyviynV7YAGjxOQBvDx6F9zb6gUvDSfPregGUou6dkPgQgo/
 bVC5JECsLQzL/IzZolk6kMgaW1+JjfjdScqp3Qm03fxhPFdkIFxnJlkfOxEDzw9kBQkFtmBw7
 1TOMIsJ+bpuc0DyH1/PfbsEVRAqMfelKAekh7cMqyYacu2Z7EDynm00+ACpxO5e283qizL8xU
 x/vuxfxctMRg/2cj71qIcerDccqQdvi0P014uu2i5AY9B1ql5ehaWAmOtztXbICU7u7goYnmK
 IWCAA3yasKmStBPIOUlL4yyEwNQPbL5+IrIwci1bVfAWkm3o46lIvrffRh9tRjeyDldIXJZAx
 hIIwek7vVroVbH1/oFGcH2ezvyF7V0kQCYiylxhcCYvUK6L+QTjn1H341qQIFrC8wCsUlC6FR
 NR5OnR3sRzM3Z7xDlLXIFXNecalvuVqD7kC6sVuDFlr8zymqGmb9OvS60qYEdJC+JS9vIInae
 qb6rRkrVTLBEGjXKrVa8+UY/PPHYOOVHqqhZkZekRIGcf3UBNWc4kdqMkFHJhLWaFXFpynjQu
 C7JFCfjuuYSAs5vohIgf+dqTI8BdUUbKTWPVpHUEL77aZHrsxMIep2NKbbiR7d/s7MXdq1mFe
 3pQhNbeyRAFXKR5C9IPc65SYHIYLdnyRwQHFvlab9QrZa9Lw7eB2FvH6lEq537
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's just code cleanup, not functional change.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
=2D--
v1->v2:
- Split fix and cleanup patches.
- Remove printing minor range in chrdev_show().

v2->v3:
- Set variable ret to '-EBUSY' before checking minor range overlap.

 fs/char_dev.c | 70 +++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 41 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 6803e98414f1..47fd0561b03d 100644
=2D-- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -100,10 +100,16 @@ static struct char_device_struct *
 __register_chrdev_region(unsigned int major, unsigned int baseminor,
 			   int minorct, const char *name)
 {
-	struct char_device_struct *cd, **cp;
-	int ret =3D 0;
+	struct char_device_struct *cd, *curr, *prev =3D NULL;
+	int ret;
 	int i;

+	if (major >=3D CHRDEV_MAJOR_MAX) {
+		pr_err("CHRDEV \"%s\" major requested (%u) is greater than the maximum =
(%u)\n",
+		       name, major, CHRDEV_MAJOR_MAX-1);
+		return ERR_PTR(-EINVAL);
+	}
+
 	if (minorct > MINORMASK + 1 - baseminor) {
 		pr_err("CHRDEV \"%s\" minor range requested (%u-%u) is out of range of =
maximum range (%u-%u) for a single major\n",
 			name, baseminor, baseminor + minorct - 1, 0, MINORMASK);
@@ -126,55 +132,37 @@ __register_chrdev_region(unsigned int major, unsigne=
d int baseminor,
 		major =3D ret;
 	}

-	if (major >=3D CHRDEV_MAJOR_MAX) {
-		pr_err("CHRDEV \"%s\" major requested (%u) is greater than the maximum =
(%u)\n",
-		       name, major, CHRDEV_MAJOR_MAX-1);
-		ret =3D -EINVAL;
-		goto out;
-	}
-
-	cd->major =3D major;
-	cd->baseminor =3D baseminor;
-	cd->minorct =3D minorct;
-	strlcpy(cd->name, name, sizeof(cd->name));
-
+	ret =3D -EBUSY;
 	i =3D major_to_index(major);
+	for (curr =3D chrdevs[i]; curr; prev =3D curr, curr =3D curr->next) {
+		if (curr->major < major)
+			continue;

-	for (cp =3D &chrdevs[i]; *cp; cp =3D &(*cp)->next)
-		if ((*cp)->major > major ||
-		    ((*cp)->major =3D=3D major &&
-		     (((*cp)->baseminor >=3D baseminor) ||
-		      ((*cp)->baseminor + (*cp)->minorct > baseminor))))
+		if (curr->major > major)
 			break;

-	/* Check for overlapping minor ranges.  */
-	if (*cp && (*cp)->major =3D=3D major) {
-		int old_min =3D (*cp)->baseminor;
-		int old_max =3D (*cp)->baseminor + (*cp)->minorct - 1;
-		int new_min =3D baseminor;
-		int new_max =3D baseminor + minorct - 1;
+		if (curr->baseminor + curr->minorct <=3D baseminor)
+			continue;

-		/* New driver overlaps from the left.  */
-		if (new_max >=3D old_min && new_max <=3D old_max) {
-			ret =3D -EBUSY;
-			goto out;
-		}
+		if (curr->baseminor >=3D baseminor + minorct)
+			break;

-		/* New driver overlaps from the right.  */
-		if (new_min <=3D old_max && new_min >=3D old_min) {
-			ret =3D -EBUSY;
-			goto out;
-		}
+		goto out;
+	}

-		if (new_min < old_min && new_max > old_max) {
-			ret =3D -EBUSY;
-			goto out;
-		}
+	cd->major =3D major;
+	cd->baseminor =3D baseminor;
+	cd->minorct =3D minorct;
+	strlcpy(cd->name, name, sizeof(cd->name));

+	if (!prev) {
+		cd->next =3D curr;
+		chrdevs[i] =3D cd;
+	} else {
+		cd->next =3D prev->next;
+		prev->next =3D cd;
 	}

-	cd->next =3D *cp;
-	*cp =3D cd;
 	mutex_unlock(&chrdevs_lock);
 	return cd;
 out:
=2D-
2.20.1

