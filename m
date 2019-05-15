Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFCEC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A018921744
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918162;
	bh=7XlXueVCWKv6mvI7qbQLRSPmpcXASXGDpgfAu7EFbNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u43JKMebwcMY1+atgMdfb1Kz3W1trH54GxtrrkiFZDdIm+ra01K9qNS+pfPx3+p0O
	 oVvtiNYsrTP6hWLXZK22gd8tFdZNmeDutuT5zs7/sm8dIyIGcCs59Anc8i6ll2d8US
	 Q7UNr/35ka/SUft4P6dTAMoT/3fHqwy2RUPW8gX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfEOLCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbfEOLCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:02:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A916021881;
        Wed, 15 May 2019 11:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918158;
        bh=7XlXueVCWKv6mvI7qbQLRSPmpcXASXGDpgfAu7EFbNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvmeL1wGq0JUn1skUwfoGLbj8rSpnCdNNGjEp9AvR0u119+g1TlZ2vhUbIQvIj25b
         1a84APsIsf9hwUfgLBEyQcrdqnHSd0s7ibxxgf4uNJ2wdCTgwWjEPr0nvCCqJwZGfe
         WSTvL703Tlh6/I7ceCUH2/02vLeP006QivQWV5L0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.4 007/266] ceph: ensure d_name stability in ceph_dentry_hash()
Date:   Wed, 15 May 2019 12:51:54 +0200
Message-Id: <20190515090722.918115451@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

commit 76a495d666e5043ffc315695f8241f5e94a98849 upstream.

Take the d_lock here to ensure that d_name doesn't change.

Cc: stable@vger.kernel.org
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/dir.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1288,6 +1288,7 @@ void ceph_dentry_lru_del(struct dentry *
 unsigned ceph_dentry_hash(struct inode *dir, struct dentry *dn)
 {
 	struct ceph_inode_info *dci = ceph_inode(dir);
+	unsigned hash;
 
 	switch (dci->i_dir_layout.dl_dir_hash) {
 	case 0:	/* for backward compat */
@@ -1295,8 +1296,11 @@ unsigned ceph_dentry_hash(struct inode *
 		return dn->d_name.hash;
 
 	default:
-		return ceph_str_hash(dci->i_dir_layout.dl_dir_hash,
+		spin_lock(&dn->d_lock);
+		hash = ceph_str_hash(dci->i_dir_layout.dl_dir_hash,
 				     dn->d_name.name, dn->d_name.len);
+		spin_unlock(&dn->d_lock);
+		return hash;
 	}
 }
 


