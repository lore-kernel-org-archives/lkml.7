Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DA8C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841F5215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887038;
	bh=QTntiOm27ELfX+4pHEMJoOCTT0p1VFvY5sE0aEjOdi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iDCPmM0l0ayBJ9I+voBnhyQY3mH7cLf3eYEbsbVKAwWT/ykGDII3Utzp2Vm+pMGnE
	 FxoQZD3U/pxLer19s3FyZKIP+wWLBHXxiGsxAwusiEn14dC8BxxjmffekVWPGoh5xd
	 NmzYEECSWauKWXGSNH+/FqWGvi7GkDpxaNiThRQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfK0UhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:37:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728525AbfK0UhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:37:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51A13215A4;
        Wed, 27 Nov 2019 20:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887033;
        bh=QTntiOm27ELfX+4pHEMJoOCTT0p1VFvY5sE0aEjOdi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vajfgj77yc99XpLWHDrRDDDBRfI+JSRBwHR2200C3iAA3vSByBqXrD2hMSrxCDkHw
         Qteop9dhbRW+Jdo+L+bfvn2yr4tifif3xl+Akcy18+rI0XKmDCwY4m1Wt/yMMHlNV7
         aQrzvjLpUYrVc8mwbyRYG3Cl6Ci6fBe4ca4a1eCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "=?UTF-8?q?Ernesto=20A . =20Fern=C3=A1ndez?=" 
        <ernesto.mnd.fernandez@gmail.com>,
        Vyacheslav Dubeyko <slava@dubeyko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 070/132] hfsplus: fix return value of hfsplus_get_block()
Date:   Wed, 27 Nov 2019 21:31:01 +0100
Message-Id: <20191127203004.993033167@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>

[ Upstream commit 839c3a6a5e1fbc8542d581911b35b2cb5cd29304 ]

Direct writes to empty inodes fail with EIO.  The generic direct-io code
is in part to blame (a patch has been submitted as "direct-io: allow
direct writes to empty inodes"), but hfsplus is worse affected than the
other filesystems because the fallback to buffered I/O doesn't happen.

The problem is the return value of hfsplus_get_block() when called with
!create.  Change it to be more consistent with the other modules.

Link: http://lkml.kernel.org/r/2cd1301404ec7cf1e39c8f11a01a4302f1460ad6.1539195310.git.ernesto.mnd.fernandez@gmail.com
Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Reviewed-by: Vyacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/extents.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index ce0b8f8374081..d93c051559cb8 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -236,7 +236,9 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 	ablock = iblock >> sbi->fs_shift;
 
 	if (iblock >= hip->fs_blocks) {
-		if (iblock > hip->fs_blocks || !create)
+		if (!create)
+			return 0;
+		if (iblock > hip->fs_blocks)
 			return -EIO;
 		if (ablock >= hip->alloc_blocks) {
 			res = hfsplus_file_extend(inode, false);
-- 
2.20.1



