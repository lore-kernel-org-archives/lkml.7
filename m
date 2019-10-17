Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09815FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06B22089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mykernel.net header.i=cgxu519@mykernel.net header.b="SGqri2vB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408896AbfJQKjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:39:25 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21573 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408885AbfJQKjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:39:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571308735; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=KMGjVJ9n2Jf3BbfCyzwyDcHqgZbNBBr3zMWlN2dD77p1OiKHc4qf2KNljoBw35dNGOICciLs/SE1kE5ZYL1TntwfjZ9FyVJPTcuGQ50y+17jhG1MacmQeSesE2qXxocHywpUIQ6QxbWbnxs8DHzyTx1IPLXEllXriol3gkT0+ZI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1571308735; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=4Ck44gH3F5vkNVlOz4QQfajHuL8YMWxdkY+aDrIBl1I=; 
        b=kKy/nUtZYwd5faTMgC9fttMXn7xhq/Tz/PGaZqVfqmOMdST02/kuSnMkZ2UD2p1QRURpLDhuHku6xkRMp7KuUt5BjoMVB0hIvJXiE0Smg0hzufbxNwFAqVRUWpjv2UkaBAMF/pv09Ux8QUuHnPHG82QSygotpSC4RCkjH4np37Y=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571308735;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=893; bh=4Ck44gH3F5vkNVlOz4QQfajHuL8YMWxdkY+aDrIBl1I=;
        b=SGqri2vBkpqGdHo6O2bH/Ylu7wMNXC+ATNmKcUR+U/NVl5MjbloUb/xT74zp+AyY
        aafVe6Cxcl5CiDWG9pvpxcjZj/V6MU8Cffhd5xSRoZHdWibotYSdJsXYyYM0RVWbeCg
        8QevtI4Fq6feQ8QwJc6xC1RdWLp9WwU491EZ910g=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1571308734172527.2831788423041; Thu, 17 Oct 2019 18:38:54 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191017103822.8610-1-cgxu519@mykernel.net>
Subject: [PATCH] hugetlbfs: fix error handling in init_hugetlbfs_fs()
Date:   Thu, 17 Oct 2019 18:38:22 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid using incorrect mnt, we should set
mnt to NULL when we get error from mount_one_hugetlbfs().

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/hugetlbfs/inode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a478df035651..427d845e7706 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1470,9 +1470,12 @@ static int __init init_hugetlbfs_fs(void)
 =09i =3D 0;
 =09for_each_hstate(h) {
 =09=09mnt =3D mount_one_hugetlbfs(h);
-=09=09if (IS_ERR(mnt) && i =3D=3D 0) {
-=09=09=09error =3D PTR_ERR(mnt);
-=09=09=09goto out;
+=09=09if (IS_ERR(mnt)) {
+=09=09=09if (i =3D=3D 0) {
+=09=09=09=09error =3D PTR_ERR(mnt);
+=09=09=09=09goto out;
+=09=09=09}
+=09=09=09mnt =3D NULL;
 =09=09}
 =09=09hugetlbfs_vfsmount[i] =3D mnt;
 =09=09i++;
--=20
2.20.1



