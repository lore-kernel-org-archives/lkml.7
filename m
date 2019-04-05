Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29EDC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A531E21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="E1Wj+iro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfDEL22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:28:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:51463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbfDEL21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554463701;
        bh=eB0d8bRKJNF0pxzFQ4JOHuFwAynoXOaA1xLNFPODCXI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=E1Wj+iroFgufGaXvd4NrlzfXzT1pIciGdMbjC5out3s/cSccrGL5dFlIinyjOnCEg
         1A1Bue2WtD8VsqeaqniKqCFQjKYcePVAbYVl4FMnk85OMJMTfMrcrm9EolwcfAtUxX
         p2mE0fFrvjTdPx5X63NyrAXyoUW95Vb4gwu2nb3k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx003 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MOOdZ-1hFNgX2nMD-005sCx; Fri, 05 Apr 2019 13:28:21 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v3 2/4] chardev: add a check for given minor range
Date:   Fri,  5 Apr 2019 19:27:09 +0800
Message-Id: <20190405112711.25275-2-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405112711.25275-1-cgxu519@gmx.com>
References: <20190405112711.25275-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v+vEPlB9H0WzUYD2hnP2dSErdbpgsgQzPhNb85qo3sHTlhAknv+
 VW9D9Cy8y03hZl7Kh1q8TqMe7GotCD01nhyxmwAe1euSrFI+Lx8ATbZNKj3h+s7uQDuuApK
 L+KcImu1+ZSlOHW5HnBP8nWocOuUJiSH/vkwV8g1oJ6kuByk/odnVfQn5HpI/irMbmaxpu1
 mPdsP8SwG9hi0kurhvVEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g7NsMmNeRao=:yUKwb0WqaCJXkQLJPwIqv+
 KArAGSXQqurQnd00Gw88bin/XXyYp6snaHIIypxdIgqBJCn3OkLjfyTIR87NcXqRHDOyFymgj
 3OuL5tS8+CS4w1piXg+FYc6cQohPIwKMeN7CHcd0J148LmQM5fL9sEwarrG1mS7dP7//+yK7W
 Gh9jvucZvtQ6SxnorlRuZ/ur9pfORJhSyZP4BcmOlsIOOshMkY35WdUPZjJ1widlES8g0n3c8
 VornYq7Ik27zBfI9hTRDei5GK5+7+eN4UX0qUjUmOdCJ5+p4895JiFVu1X4psW3gzBo+K62W/
 lVSpOhyWnxhTawuw9KzAvybXUdY44NDmdbJUvSkuA/5KgyMMjW1JxUfqIsq4t2xdgYoBBsKv6
 z9kIJd7O5Wi4UCy5HmO0xsg8svHrTmznA97HKlQ3VPaKqMDXr+fm6X6dVeQvXNO/TLjiXtwTm
 NhQtgb1+2DTyNtoI+GvxmjVCwtfmnue0jWRNU9fxEqRQwBSfLTZthEj1qWZauuIidU8poYACW
 WJr/dLJ2g7vEIrcESGvn42c5pL94m6v6gnL6GXHX5OSJmGdVc/UxrKMlW5TvOYCt1xv3qaXdk
 xQvFruUUSIu60330rHHWmRwWNcJlWXvvPHN545D0wDgSu+ZjhWvPmv0GPi/ocntxutcag47ds
 QiX9N4QzgFAWAMh6TreLNjl7QN8v0ZyoTLwFG4zcLXDebgm+qG8C2okCiPIom8/pSQ/DU9uyw
 Wsd2SPT2CCb6I69V0XGadzrjepcoPK3h361FU9TEdM76WA9Rsi62TE9CjxzVTuEzfjjo1sUcw
 jSDrQXT3slK/MIDdFJGy+ERFor4jzwFjyUTHk90h7wDCuz3ZWHGfJksyuuu9YI1Ydwwu+87Lw
 ZDskLjYVRhTAgatqVs9nUUYgIFCMvtKexoDmqnUKWn1GaYP/njc45Q3pwCy6Or
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

register_chrdev_region() carefully checks minor range
before calling __register_chrdev_region() but there is
another path from alloc_chrdev_region() which does not
check the range properly. So add a check for given minor
range in __register_chrdev_region().

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
=2D--
v1->v2:
- Split fix and cleanup patches.
- Remove printing minor range in chrdev_show().

 fs/char_dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 8a63cfa29005..6803e98414f1 100644
=2D-- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -104,6 +104,12 @@ __register_chrdev_region(unsigned int major, unsigned=
 int baseminor,
 	int ret =3D 0;
 	int i;

+	if (minorct > MINORMASK + 1 - baseminor) {
+		pr_err("CHRDEV \"%s\" minor range requested (%u-%u) is out of range of =
maximum range (%u-%u) for a single major\n",
+			name, baseminor, baseminor + minorct - 1, 0, MINORMASK);
+		return ERR_PTR(-EINVAL);
+	}
+
 	cd =3D kzalloc(sizeof(struct char_device_struct), GFP_KERNEL);
 	if (cd =3D=3D NULL)
 		return ERR_PTR(-ENOMEM);
=2D-
2.20.1

