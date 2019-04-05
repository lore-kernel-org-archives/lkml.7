Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08515C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7C021738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NIg/59lN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfDENxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:53:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:42463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfDENxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554472426;
        bh=53RG4ZGmQNPTkwmRy5vzvKtSjJjq1u9O1NuRhhP8N48=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=NIg/59lNJNJzDzz6+4+7n+mw9lTNFuPOYqFiHgPQ9jQhUOmD6/xj2DdIcWOqOUgQ9
         1FYB8m/EGmc6jYv5KMDIz2O+UsgeSycgqVFnAXupwygBAUWjHv2+nHepSqJRlGZ5Rh
         DZjc24iuTgqs7D2B5hBgRt7dUf/kX5nM4TKwus6Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([113.116.49.152]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MNuwp-1hI9mk1FvP-007Rs1; Fri, 05 Apr 2019 15:53:46 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] chardev: set variable ret to -EBUSY before checking minor range overlap
Date:   Fri,  5 Apr 2019 21:53:06 +0800
Message-Id: <20190405135306.10188-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.2
X-Provags-ID: V03:K1:kWpfzNfBvsLZx+Af3QxO0Zf+aUo0TxJvm5Sz9lAYnysj5vo0SnV
 1QQKMSqoi5cGpARTcx1T8Bi6gc93RH3KSFLpaq9r8Heu1KZsYphqvOs5bxyDngfU6tWkCBo
 0FcimWjUhQ2RSIQfGJzCTImjebCjgiyEip4ENktkYYsNsYjOZRp6uar+0O7d25Nv4+ZT09l
 3nl1SNj8rovaVz+NUmWDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kJ2tiIhF5fY=:Gcp3wXqVy9lsfX0FR9USRw
 +om0uWyZmx0yoRWtdrqYN2yczh2jAEPcHZWxNEt6uLTMw4n6vGmNcyODy45k6fYuaX9XbIcae
 mEX+SyOGfRExbgX7+Yr6C/ulf0FLEVq3+6GZMrGmiYPxPkHtjAeLqEetb+QpdMkpYXqaNOhVn
 2Od9dI21KPRXy2u8LtH87j8ivUKxw4mE8Cw4H1mvPa7YMaAqXk8YiarSzsZmrRKXTi0KHRFvF
 VvY11wfkcd08e7/8zVNFmWWs9KP2iRezHhr5wsIvIH+qVTcQJcf3J40JSU2wmiSLDFCbRpjoY
 4d8aqrlDLK3l5w0Iq0Fw4bF41EEmRqDlwfnID2sLX7CIZ3F54ucdP1iSK4Udb+zy/U+c4bKig
 0PdbKFOfA9K5ceqsjH9jAhjMnEeR7Ii/jR8ZtpJ57EiopII9xnsBA/hft5CVWxYnHeM5oQ+6X
 2BkoUQFzFi8n4ZPWjdN9Xvx9kOCKH8RAGX7ojXQYDdwt5vcDV0QEB1mr8x23sI+a2H+6hLfdj
 7dmuRghkKc6vkVJJTcAkZO74KiHKg67lRdqx3SGImMiAYrrZ6QyOmN9cCZUpTNjrEuBOW/3y8
 KfTm6U3s4w4AhZEczgP6KClKqMnBaU57TqXz0SHH0Nj1yzNT3EjhxOoOmcXespxmgB/woOzP2
 KDxViKliMPIxNe9IKqk1LRHW/VB96Tq1odrx9MxnHKIih0QDzElDorFfudrdjX8Idqv69u8YQ
 /89XJ1gGM2NfLtWEy6rb+S/UOyAcF8npDX/WLaKVzzoFGnGdf3YIsAlOqY2DkzQNhNhuxMk74
 LFw+D2oXuxgujsgpmx3J0/lNK5Ilj8AQFqJL7u/ibzeIwE+cgGZLfUesjXcxHDx+14AikfEDs
 7yogCWY+dZuQgytf8ZBguNKW7rTHJIeUDbZyvIPoZ+JO07n1s+y2aZi2xt1hWH
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating dynamic major, the minor range overlap check
in __register_chrdev_region() will not fail, so actually
there is no real case to passing non negative error code to
caller. However, set variable ret to -EBUSY before chekcking
minor range overlap will avoid false-positive warning from
code analyzing tool(like Smatch) and also make the code more
easy to understand.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
=2D--
 fs/char_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index df6a54045ac4..00dfe17871ac 100644
=2D-- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -98,7 +98,7 @@ __register_chrdev_region(unsigned int major, unsigned in=
t baseminor,
 			   int minorct, const char *name)
 {
 	struct char_device_struct *cd, *curr, *prev =3D NULL;
-	int ret -EBUSY;
+	int ret;
 	int i;

 	if (major >=3D CHRDEV_MAJOR_MAX) {
@@ -129,6 +129,7 @@ __register_chrdev_region(unsigned int major, unsigned =
int baseminor,
 		major =3D ret;
 	}

+	ret =3D -EBUSY;
 	i =3D major_to_index(major);
 	for (curr =3D chrdevs[i]; curr; prev =3D curr, curr =3D curr->next) {
 		if (curr->major < major)
=2D-
2.17.2

