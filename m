Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6EAC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B47620652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hWd+aIEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfD3Gkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 02:40:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:36955 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfD3Gks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 02:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556606441;
        bh=bKS025PSTsBnOa8/vzDCWX1uOiZEOQaRN/JroWKQru8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=hWd+aIEWgQoYazFzjz8DogAj9Ct4jI6TADaMwu4esujror9n7c6eeCIOHkCgA1fe2
         Vu6D2ZfDoZ6P3P3qljHCB71FHjygFr2M53ReErtpJm52cdU5ByNKT8E9Phzp091OBz
         3Lg2uAaP0b7BdRlLGVbj+e6I1kzoObyOf/JEQqs4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1Mel3t-1gke33271x-00an99; Tue, 30 Apr 2019 08:40:41 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] quota: check time limit when back out space/inode change
Date:   Tue, 30 Apr 2019 14:40:10 +0800
Message-Id: <20190430064010.22406-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WSxrfsVyDlW4Mk4nR6xoBnrEsApg862G2AG8EoC/1SjlMOiVZDN
 FSPUGkC298ltweQTFptgHvQC7dykdU3AYxYJAQ+JvhQdntAU3wQU8gT2wDNC7C4pLy1IkjN
 /R9TIqsR3cWr7fluH6yI4OGI54AJI0UN2Ouk+yUY43wmITkMEuTZqUNNL1jbQglWEGT8KfT
 WRbGnk/6MbNindxsOcMrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O32kz2t8GeY=:mtEBCeLB6OK8u+aZz9Cdcg
 LwMrhJLlhU2puIltqRQ4/wywWlx3HUSwAhGls5/a1W+rJmIzwN1fxDk9ie5xCqFyjqUmP7ZTG
 STaiX4zgWhg6ua3VA8HHfIVWZinTgUamxqVgwH+nEVGuPjdpoweyrQO8j6KbbDIV9hw3Q93H4
 iE5n1A9+Du15iF036sDvQNLke3HIoOCqN14vLQInAnFCyp+wJlXxFEvsa4COP4PoUjdjWFCUW
 kiEDOzlBbnI5kmr+PIvZyCcdqmirH793//Adv/T6Or3vafL1D4/ZcJFMAtbtUcQs29PdFuhqi
 sla/DRciC44xNWPozothqT0JkA8RB9kIW30OeLJUoWkuxQRV4bKge/Tji6X3Bax/HmxgDrFQR
 VyA7IoH+Fv1LwGnkGEGpM6SGqgj3iJ37eLsGCT4xXoBbKv8nqHtsCFMElOF/DyoczdG9QMIzB
 EmnG8tdCIIpH756pPyfI0ncSflnAEGe+Ai+tIITysebbD3/lHBfOl2GkokfqMm0DkMgDMXcyY
 SKTr30yo/LaPHOjyyNLdZO9uu0j5bxw+0oWYzETgTZ7O2vVJPxX/asCshDT/oCzJ3+AHETj+3
 U2Ehe8rOqADgiEz+s58znNTORQNSMDnmFks2u0DdTIvx87Vfh4TfY4QiUNNz4hu8D3iQlbswb
 kXn/hlPmw76ZnKlk/3PxEIbLd2XS9WtjuFsLaEskeRfu1Rf9T5vBLvLTz9FByqXHubGDDGIIq
 nC6arDug9UUj9Yd1MZcprX1MO4yANw0CXMtrbrYJjDDlgqMb/wUVF8scmSPTEYxUdE2z2eVMS
 d2RXpZQblIHzcsr6OG94oGi/d9SLBxh032eCi9lj9JiHrozQxjO2jTc9Ff8eHkkqanuUcZktg
 ZZ11ZMh3ClWE7owdfsF735qJiDLX6fptds3pk/vJ4mpzoCgggCX0zXeha+4uAK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we fail from allocating inode/space, we back out
the change we already did. In a special case which has
exceeded soft limit by the change, we should also check
time limit and reset it properly.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
=2D--
 fs/quota/dquot.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 9d7dfc47c854..58f15a083dd1 100644
=2D-- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1681,13 +1681,11 @@ int __dquot_alloc_space(struct inode *inode, qsize=
_t number, int flags)
 				if (!dquots[cnt])
 					continue;
 				spin_lock(&dquots[cnt]->dq_dqb_lock);
-				if (reserve) {
-					dquots[cnt]->dq_dqb.dqb_rsvspace -=3D
-									number;
-				} else {
-					dquots[cnt]->dq_dqb.dqb_curspace -=3D
-									number;
-				}
+				if (reserve)
+					dquot_free_reserved_space(dquots[cnt],
+								  number);
+				else
+					dquot_decr_space(dquots[cnt], number);
 				spin_unlock(&dquots[cnt]->dq_dqb_lock);
 			}
 			spin_unlock(&inode->i_lock);
@@ -1738,7 +1736,7 @@ int dquot_alloc_inode(struct inode *inode)
 					continue;
 				/* Back out changes we already did */
 				spin_lock(&dquots[cnt]->dq_dqb_lock);
-				dquots[cnt]->dq_dqb.dqb_curinodes--;
+				dquot_decr_inodes(dquots[cnt], 1);
 				spin_unlock(&dquots[cnt]->dq_dqb_lock);
 			}
 			goto warn_put_all;
=2D-
2.20.1

