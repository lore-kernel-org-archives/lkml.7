Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5ACC49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB2321479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403831AbfIJOv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:51:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23719 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393454AbfIJOv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:51:58 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46SSfg4bygz9tyfH;
        Tue, 10 Sep 2019 16:51:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KXm1t-ZnXWpN; Tue, 10 Sep 2019 16:51:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46SSfg0PKyz9tyfF;
        Tue, 10 Sep 2019 16:51:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8CDC68B88B;
        Tue, 10 Sep 2019 16:51:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3u6XCYj-DB3d; Tue, 10 Sep 2019 16:51:56 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 558258B885;
        Tue, 10 Sep 2019 16:51:56 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 30D986B750; Tue, 10 Sep 2019 14:51:56 +0000 (UTC)
Message-Id: <eb3d8f42231aec65b64b079dd17bd6c008a3fe29.1568127106.git.christophe.leroy@c-s.fr>
From:   Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH v2 1/2] NFS: Fix inode fileid checks in attribute revalidation
 code
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 10 Sep 2019 14:51:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to throw out the attrbute if it refers to the mounted on fileid,
and not the real fileid. However we do not want to block cache consistency
updates from NFSv4 writes.

Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
Fixes: 7e10cc25bfa0 ("NFS: Don't refresh attributes with mounted-on-file...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 fs/nfs/inode.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index c764cfe456e5..2a03bfeec10a 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1403,11 +1403,12 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
 		return 0;
 
-	/* No fileid? Just exit */
-	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID))
-		return 0;
+	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID)) {
+		/* Only a mounted-on-fileid? Just exit */
+		if (fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID)
+			return 0;
 	/* Has the inode gone and changed behind our back? */
-	if (nfsi->fileid != fattr->fileid) {
+	} else if (nfsi->fileid != fattr->fileid) {
 		/* Is this perhaps the mounted-on fileid? */
 		if ((fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID) &&
 		    nfsi->fileid == fattr->mounted_on_fileid)
@@ -1807,11 +1808,12 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			nfs_display_fhandle_hash(NFS_FH(inode)),
 			atomic_read(&inode->i_count), fattr->valid);
 
-	/* No fileid? Just exit */
-	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID))
-		return 0;
+	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID)) {
+		/* Only a mounted-on-fileid? Just exit */
+		if (fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID)
+			return 0;
 	/* Has the inode gone and changed behind our back? */
-	if (nfsi->fileid != fattr->fileid) {
+	} else if (nfsi->fileid != fattr->fileid) {
 		/* Is this perhaps the mounted-on fileid? */
 		if ((fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID) &&
 		    nfsi->fileid == fattr->mounted_on_fileid)
-- 
2.13.3

