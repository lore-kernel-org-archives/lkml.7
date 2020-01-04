Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2355C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C483F22B48
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mykernel.net header.i=cgxu519@mykernel.net header.b="cng1tKuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgADOVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 09:21:18 -0500
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21134 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbgADOVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 09:21:17 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1578147631; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Wm1LmxEiRdnPxgUwAF6QFOvou39oZfviXf6u9vBIe+s4Wp24uY8rW49btrDPv9isBkv4WKchZ9HgTPykYIZYlv383SWfGnsJuhY7fQAhR2Fyp9kER6BjGvkqh8S9kXxOTn03xPJABz/DQKZNNUnobxZE0uPuw6GceLkABB4hoiw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1578147631; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=7k8gaLXukPzjJGyY+xIC8DOJaUh+oLrwvPFiks3Knak=; 
        b=fZJBaexuGyqp/gqCJVR0N/D7EWMuF9C8MMisxzgrbDxZ8XIW+hjdXF+uBCK/GoiQTc8zGXJlV8Yr4I/RlulMlp+OGQVzVQPBWIxcLi9Y8IjzvQ5IDA+CSaWlEwQ1JlO2DYxgxqC4rRXlIDdiUa3z2Z3AtGKuk9Ezlc5gkOU/45Y=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1578147631;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=7k8gaLXukPzjJGyY+xIC8DOJaUh+oLrwvPFiks3Knak=;
        b=cng1tKuBAc7ah7mdBkmJMkb1ivGDCz7jaUqTUyBO/pfGl6X47GgFlfPQzTB0R8dF
        mpQSMQnATVk2uNkaUraso0szktsumaHmGPg5zINaL4UFB9+wZguvZtGIiYZiG/jyoCZ
        nE/r+3MgyPNA1dCdAgiFTowqWQKHmYrcPzLzBeXI=
Received: from localhost.localdomain.localdomain (113.116.49.111 [113.116.49.111]) by mx.zoho.com.cn
        with SMTPS id 1578147629444192.7016564807659; Sat, 4 Jan 2020 22:20:29 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200104142004.12883-2-cgxu519@mykernel.net>
Subject: [f2fs-dev][PATCH 2/2] f2fs: code cleanup for f2fs_statfs_project()
Date:   Sat,  4 Jan 2020 22:20:04 +0800
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200104142004.12883-1-cgxu519@mykernel.net>
References: <20200104142004.12883-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling min_not_zero() to simplify complicated prjquota
limit comparison in f2fs_statfs_project().

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/f2fs/super.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 78efd0e76174..ac01c3f8863d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1213,12 +1213,8 @@ static int f2fs_statfs_project(struct super_block *s=
b,
 =09=09return PTR_ERR(dquot);
 =09spin_lock(&dquot->dq_dqb_lock);
=20
-=09limit =3D 0;
-=09if (dquot->dq_dqb.dqb_bsoftlimit)
-=09=09limit =3D dquot->dq_dqb.dqb_bsoftlimit;
-=09if (dquot->dq_dqb.dqb_bhardlimit &&
-=09=09=09(!limit || dquot->dq_dqb.dqb_bhardlimit < limit))
-=09=09limit =3D dquot->dq_dqb.dqb_bhardlimit;
+=09limit =3D min_not_zero(dquot->dq_dqb.dqb_bsoftlimit,
+=09=09=09=09=09dquot->dq_dqb.dqb_bhardlimit);
 =09if (limit)
 =09=09limit >>=3D sb->s_blocksize_bits;
=20
@@ -1230,12 +1226,8 @@ static int f2fs_statfs_project(struct super_block *s=
b,
 =09=09=09 (buf->f_blocks - curblock) : 0;
 =09}
=20
-=09limit =3D 0;
-=09if (dquot->dq_dqb.dqb_isoftlimit)
-=09=09limit =3D dquot->dq_dqb.dqb_isoftlimit;
-=09if (dquot->dq_dqb.dqb_ihardlimit &&
-=09=09=09(!limit || dquot->dq_dqb.dqb_ihardlimit < limit))
-=09=09limit =3D dquot->dq_dqb.dqb_ihardlimit;
+=09limit =3D min_not_zero(dquot->dq_dqb.dqb_isoftlimit,
+=09=09=09=09=09dquot->dq_dqb.dqb_ihardlimit);
=20
 =09if (limit && buf->f_files > limit) {
 =09=09buf->f_files =3D limit;
--=20
2.21.1



