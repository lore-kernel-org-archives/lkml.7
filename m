Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B25C3276F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912F422B48
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mykernel.net header.i=cgxu519@mykernel.net header.b="e8i109+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgADOVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 09:21:25 -0500
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21135 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726005AbgADOVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 09:21:17 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1578147625; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=bgbpHZyY+MRw8YTJOM1WEOc7yXFt1MCmQ61SZGH2rCLHeEBVB4FX376zfIqrFHr+4TW1CmxdlgFkm71q6+heq6ihQRzsneaLjpR1TqfbZI4hxtQgahVRkRpZ/HgFO844kR/9YK4Nl6kpPECRmtWRxr345LyPkP7idrq2qrvV+eE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1578147625; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=6RgICWXwhvwNHztqQtPT2dhQ/f21R4V1Nli9Z29zuMM=; 
        b=B8LMXxqN+WYi2cB+C1WgsNs4MSabWqQN3AnbeGsdg0da3fF8Z2qJkwLk51zoErV3I1R5+bIPR69V7eR1j1vrvhNabBeQobn5ljVEYWfjYM/ETcU7veEbtogT8JhGfCoEU0lCOArv8hKlSxFb8Gx0UDz3PmSWL2H8DlLMob3UJm8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1578147625;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=6RgICWXwhvwNHztqQtPT2dhQ/f21R4V1Nli9Z29zuMM=;
        b=e8i109+QZvsd4wrqLK+Ybcy0JonbcvaCzWUFIG4Iwxz4G4U8UYlj1I/qUOqH64cF
        qGOUrEQYCiykqYIU6t+eIUqA/roamSoT7ILbISdwEw6MSZvg6qeMelcXj5bANQIc7Oo
        zJUYuSqTJ4leSILovkpfDaLNU+0aPpMCV9KLhQSk=
Received: from localhost.localdomain.localdomain (113.116.49.111 [113.116.49.111]) by mx.zoho.com.cn
        with SMTPS id 15781476236011.4213776319637645; Sat, 4 Jan 2020 22:20:23 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200104142004.12883-1-cgxu519@mykernel.net>
Subject: [f2fs-dev][PATCH 1/2] f2fs: fix miscounted block limit in f2fs_statfs_project()
Date:   Sat,  4 Jan 2020 22:20:03 +0800
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

statfs calculates Total/Used/Avail disk space in block unit,
so we should translate soft/hard prjquota limit to block unit
as well.

Below testing result shows the block/inode numbers of
Total/Used/Avail from df command are all correct afer
applying this patch.

[root@localhost quota-tools]\# ./repquota -P /dev/sdb1
*** Report for project quotas on device /dev/sdb1
Block grace time: 7days; Inode grace time: 7days
              Block limits                File limits
Project   used soft    hard  grace  used  soft  hard  grace
-----------------------------------------------------------
\#0   --   4       0       0         1     0     0
\#101 --   0       0       0         2     0     0
\#102 --   0   10240       0         2    10     0
\#103 --   0       0   20480         2     0    20
\#104 --   0   10240   20480         2    10    20
\#105 --   0   20480   10240         2    20    10

[root@localhost sdb1]\# lsattr -p t{1,2,3,4,5}
  101 ----------------N-- t1/a1
  102 ----------------N-- t2/a2
  103 ----------------N-- t3/a3
  104 ----------------N-- t4/a4
  105 ----------------N-- t5/a5

[root@localhost sdb1]\# df -hi t{1,2,3,4,5}
Filesystem     Inodes IUsed IFree IUse% Mounted on
/dev/sdb1        2.4M    21  2.4M    1% /mnt/sdb1
/dev/sdb1          10     2     8   20% /mnt/sdb1
/dev/sdb1          20     2    18   10% /mnt/sdb1
/dev/sdb1          10     2     8   20% /mnt/sdb1
/dev/sdb1          10     2     8   20% /mnt/sdb1

[root@localhost sdb1]\# df -h t{1,2,3,4,5}
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdb1        10G  489M  9.6G   5% /mnt/sdb1
/dev/sdb1        10M     0   10M   0% /mnt/sdb1
/dev/sdb1        20M     0   20M   0% /mnt/sdb1
/dev/sdb1        10M     0   10M   0% /mnt/sdb1
/dev/sdb1        10M     0   10M   0% /mnt/sdb1

Fixes: 909110c060f2 ("f2fs: choose hardlimit when softlimit is larger than =
hardlimit in f2fs_statfs_project()")
Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5111e1ffe58a..78efd0e76174 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1219,6 +1219,8 @@ static int f2fs_statfs_project(struct super_block *sb=
,
 =09if (dquot->dq_dqb.dqb_bhardlimit &&
 =09=09=09(!limit || dquot->dq_dqb.dqb_bhardlimit < limit))
 =09=09limit =3D dquot->dq_dqb.dqb_bhardlimit;
+=09if (limit)
+=09=09limit >>=3D sb->s_blocksize_bits;
=20
 =09if (limit && buf->f_blocks > limit) {
 =09=09curblock =3D dquot->dq_dqb.dqb_curspace >> sb->s_blocksize_bits;
--=20
2.21.1



