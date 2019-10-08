Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED54C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E075206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mykernel.net header.i=cgxu519@mykernel.net header.b="TaUNNTFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfJHPGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:06:31 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21543 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbfJHPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:06:31 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Oct 2019 11:06:29 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1570546276; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=brFUoouPEMjJSqsa8+K9u9vBzwF8LLEcUDjzvdPUb44eMP0eYlmrKDAntG4o7xgPfm57wlCk3MYuwEZSJGSVEptKtLiMfvM1Iik8W4lkQh2+j+IV4mBKJfUQGfdxLQEYjDJefRMI72Ik72mZEoFz+sd4fjd4koiG7287gBvJH2Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1570546276; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=iWLsd00kA2pIWjpDhgqoOn/cVUxOJx70YwdIj1xn/rY=; 
        b=KKnfq3OF+IV0w8iKJJYewfJ2/qtZ/8GJEjcyTjkKS6WgjqOBLX/9Gk4Ml07cUVLl5GS7iOrvL4vFuGaS5xRtgXhrW89Wh5fLnf5CdrjmwaxbYWQIcd0EDBCqrWOvd+NlDJ6zHlSTz7NMy36svLfdAbWEbHyBPGGHMJzKzdxY/sQ=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570546276;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=1328; bh=iWLsd00kA2pIWjpDhgqoOn/cVUxOJx70YwdIj1xn/rY=;
        b=TaUNNTFhjoldUyM6Ks2KaiQNYCHUOkq7VmOkAMoR7f1CBj3BIvu0NKGkFKtOavmT
        323Pful323iDGIp5jI1R5Bni/9oeLoE+w0C2wsaRumc8dcYK/7iRhhVoaCRaXTXn13q
        4V/bWmC+B53FunhFypVTTdRifUhgwxgEZoralXnI=
Received: from localhost.localdomain (113.116.49.170 [113.116.49.170]) by mx.zoho.com.cn
        with SMTPS id 1570546274198707.4831055250032; Tue, 8 Oct 2019 22:51:14 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191008145059.21402-1-cgxu519@mykernel.net>
Subject: [PATCH] quota: check quota type in early stage
Date:   Tue,  8 Oct 2019 22:50:59 +0800
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check quota type in early stage so we can avoid many
unncessary operations when the type is wrong.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/quota/quota.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index cb13fb76dbee..5444d3c4d93f 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -60,8 +60,6 @@ static int quota_sync_all(int type)
 {
 =09int ret;
=20
-=09if (type >=3D MAXQUOTAS)
-=09=09return -EINVAL;
 =09ret =3D security_quotactl(Q_SYNC, type, 0, NULL);
 =09if (!ret)
 =09=09iterate_supers(quota_sync_one, &type);
@@ -686,8 +684,6 @@ static int do_quotactl(struct super_block *sb, int type=
, int cmd, qid_t id,
 {
 =09int ret;
=20
-=09if (type >=3D MAXQUOTAS)
-=09=09return -EINVAL;
 =09type =3D array_index_nospec(type, MAXQUOTAS);
 =09/*
 =09 * Quota not supported on this fs? Check this before s_quota_types
@@ -831,6 +827,9 @@ int kernel_quotactl(unsigned int cmd, const char __user=
 *special,
 =09cmds =3D cmd >> SUBCMDSHIFT;
 =09type =3D cmd & SUBCMDMASK;
=20
+=09if (type >=3D MAXQUOTAS)
+=09=09return -EINVAL;
+
 =09/*
 =09 * As a special case Q_SYNC can be called without a specific device.
 =09 * It will iterate all superblocks that have quota enabled and call
--=20
2.21.0



