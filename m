Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040A7C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE81F21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FbaP232Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfDEL2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:28:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:58211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbfDEL2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554463689;
        bh=jJrPSfQTr4No0lWk1eMDZc/F6tH0SR8gySoZ6VcA9iA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=FbaP232Q+xD7ON3kUuBCbKULxsqjfYQyq0OYfTqZoX1eDPskasikCUR/bNHu/zTIx
         A9M/H08jJbvBgT9J/8OuikUMNZQJnTpCiHTcHRZcmn1L8sreIcbxoDHZ5tV0wgwYS+
         l5RSfNw0e7WEpr7Ep1dnsIdOt2geXgoOCI1GUApQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx003 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0Lvkwm-1grcaC1qsW-017UOQ; Fri, 05 Apr 2019 13:28:09 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v3 1/4] chardev: add additional check for minor range overlap
Date:   Fri,  5 Apr 2019 19:27:08 +0800
Message-Id: <20190405112711.25275-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GONALFeqSIXyNTeH1jhDtUDnupuHpBWfELLKFDqXg2amsQTebA1
 GqgK2rz5ICW7+iQpPxUSrTMvoXywUv4XOHg6CYd3y8cALQxWMuvt7PZcDtodn9ZSEy4PwpY
 zHpYus/1josu+w4mu7R0LH2IP+BbepwAtDivrGs4MbD8034cWrussTEC1mPxvmT7ibQ0fzf
 MqRbBrAITfDioJrXVINgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CG3qgfyAqWs=:tn2eDjIBG2B4o4I6kO1VPx
 4il5izmLvJdcR6rsWnqNTsbJHGJFqUompMTz9UcPXeX/IiAoOSYyZiCrmAnk+XsxvDJ3LrCzt
 CL7CBQhOFIIAlRw0yntPVUeuyxx3T9QMc+ds0yLuzWREKWAPhNyu3+p32JbG5JQHC56FAaw1g
 4R/FNlImrfOZliODimsPp0fMhpHnmWvwdW5V0Y7/ABpcHWxFaGN71FCsO7MxauSo5vwM+4VyT
 8Rw8CputfOeeWNCbDEBh7ixrfGbFFh00zdQMPiPLnA0H/HrWYdjr8qH7pID3Vk86HrGYaby8F
 i/JnHsblLgJ8O7mGzHF+RZ5y/I9/29k5MkNzj0HcP3fHEil92jVhQw0kuhQagfEVxFrtoY3vL
 AiZV684GKKjKCnVB+Igcf4JRPPUw8bx8BhmtD0QJY8hvNttGuNV491iaYM7ZfHzIYwy2PTcCv
 lo7VhguLTfYMr7ECatNWA2emyakccwQJhP5X7cQEvUg6d2KgfjB7kJ+tipX7EToBuFbFyQZj0
 BaEL3X9PwES9DCM46ZKx8cRCFt3fUowfrAxptVSG6U4UvAvzEvHt9Hk7HYA2yIRPlxTrjWQY/
 BjE+EThOwxDpNxHfUYG/2DU5XuSNVl28lCTKojpHmxOlX04sgckhZLxFqfsm9DXLvQDeITpNP
 3jUBDuSypMc4/31NBswG2S9PoXSmaVCRqCl4WZDtXm4i5Y5j0qklmJgByCGZfWKPq24rU6Nog
 L/HdfuQcCbFOLk6InlHJDStzg/W7dGa5Zjg1zrTbetPZh/ljBOlKAnoeRFqACSWJ0ZOqiWQKX
 Ws+K5PDMR2n3rzNqd58h3NXzzCt8IZs3z1fVVUSzmxnqkcVCBKXXMNr6B0nl/RvMEL7TKY9qB
 iPh6hbqQ2Erp6exrwUo82qdMkGIZOzS60A8Bf7PMyEHzjK2qb21+o3z/XpkLiY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current overlap checking cannot correctly handle
a case which is baseminor < existing baseminor &&
baseminor + minorct > existing baseminor + minorct.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
=2D--
v1->v2:
- Split fix and cleanup patches.
- Remove printing minor range in chrdev_show().

 fs/char_dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index a279c58fe360..8a63cfa29005 100644
=2D-- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -159,6 +159,12 @@ __register_chrdev_region(unsigned int major, unsigned=
 int baseminor,
 			ret =3D -EBUSY;
 			goto out;
 		}
+
+		if (new_min < old_min && new_max > old_max) {
+			ret =3D -EBUSY;
+			goto out;
+		}
+
 	}

 	cd->next =3D *cp;
=2D-
2.20.1

