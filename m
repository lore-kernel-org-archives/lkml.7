Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A08C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221CF2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mykernel.net header.i=cgxu519@mykernel.net header.b="Kah02m1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733129AbfJJIZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:25:17 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21349 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727389AbfJJIZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:25:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570695856; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=JeY1ppLsYRXfwaGsu1IYbcg23JGr5MiG0clFMfX8ZRItkpWZ/EJepEGlwRbEWvgNmhpRZOQg+/yHuJb7uprVByI+Svlylh3/GJwQAw3AWBC454EE3vDbLWqGbizhBAAB3qG7oR95udRUYyl+S37J0vi2lrdha16AXFRQNg60XI8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1570695856; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=+mIt5eY6CLtRZO3kW8Ol8NCr4m0IkhmJ5R5sN3OnhL4=; 
        b=LkxYMyduu35A9bAIOvweOoIxsjUt0goGlBrMpgQWduSYCUmK3FkyXf7D8nAZkG4uuLPE32XUVWoZvRSsMdTicQDpT9IPRR2LRX8hZ9OT1bTSK+6ThyRTVWp/2FTNB5z/I+R9fX2gyzgIWHvYL5te3jZ/LMxC0/fEO9kDYKIXGO0=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570695856;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=1104; bh=+mIt5eY6CLtRZO3kW8Ol8NCr4m0IkhmJ5R5sN3OnhL4=;
        b=Kah02m1GbNS/doTKqQrx+qumpIQAYUaf86NnsRX8RvlEvNAZBsgcT0YuAu22/pks
        25qiNOzEy/GQdKglheCY0+PQmWPRwwgXEJjhD56xc6VX6vjIonstOXvQgBGbjDy3OYk
        3gsjsKV6Yr1lq4et1HNvLsGUVso9yKetQYK0t8ns=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1570695854328638.6969031731684; Thu, 10 Oct 2019 16:24:14 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191010082349.1134-1-cgxu519@mykernel.net>
Subject: (RESEND) [PATCH] ocfs2: Fix error handling in ocfs2_setattr()
Date:   Thu, 10 Oct 2019 16:23:49 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should set transfer_to[USRQUOTA/GRPQUOTA] to NULL
on error case before jump to do dqput().

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ocfs2/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 2e982db3e1ae..53939bf9d7d2 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1230,6 +1230,7 @@ int ocfs2_setattr(struct dentry *dentry, struct iattr=
 *attr)
 =09=09=09transfer_to[USRQUOTA] =3D dqget(sb, make_kqid_uid(attr->ia_uid));
 =09=09=09if (IS_ERR(transfer_to[USRQUOTA])) {
 =09=09=09=09status =3D PTR_ERR(transfer_to[USRQUOTA]);
+=09=09=09=09transfer_to[USRQUOTA] =3D NULL;
 =09=09=09=09goto bail_unlock;
 =09=09=09}
 =09=09}
@@ -1239,6 +1240,7 @@ int ocfs2_setattr(struct dentry *dentry, struct iattr=
 *attr)
 =09=09=09transfer_to[GRPQUOTA] =3D dqget(sb, make_kqid_gid(attr->ia_gid));
 =09=09=09if (IS_ERR(transfer_to[GRPQUOTA])) {
 =09=09=09=09status =3D PTR_ERR(transfer_to[GRPQUOTA]);
+=09=09=09=09transfer_to[GRPQUOTA] =3D NULL;
 =09=09=09=09goto bail_unlock;
 =09=09=09}
 =09=09}
--=20
2.20.1



