Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8193C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36B921900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258478;
	bh=QdMUm2fDIxH1B06noPTDOBjENb2eXfQxRXNyq4V7Ua4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qXKIzKB9vPhAE1PVhemMhaI0gSIBNpYdto1xdyYgQFmKW8Cqo4McZwkC86VNySija
	 dfQnfZTf0iES2xv4tQeTP/xcjOEY0MYSFAb3aThuVckEl3Kkx4BYLz+xcegPOW0Rg6
	 7OuLHdVhj0OATDUOtMARrcOfeoiT+5jqUxUl+IV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388845AbfCVMFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388524AbfCVMFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:05:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A21BA21929;
        Fri, 22 Mar 2019 12:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256338;
        bh=QdMUm2fDIxH1B06noPTDOBjENb2eXfQxRXNyq4V7Ua4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ANnpZFhAV2EAgeV8NzeSWINCmpX8a9MFJU4jNIt5AgMxLze8Cn7u5fiMQBlPfTxgR
         lONy3JT4D+DR7GAA2MwEe8p0SzENcvh+PAnvvclm8+Dn0rHreI0FuQfXro2FJG+6En
         sPXMc0Oday4cO5bQ5GAbSQGKlS75NbaQuoyF5aCQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.19 180/280] ext4: fix check of inode in swap_inode_boot_loader
Date:   Fri, 22 Mar 2019 12:15:33 +0100
Message-Id: <20190322111326.526067230@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: yangerkun <yangerkun@huawei.com>

commit 67a11611e1a5211f6569044fbf8150875764d1d0 upstream.

Before really do swap between inode and boot inode, something need to
check to avoid invalid or not permitted operation, like does this inode
has inline data. But the condition check should be protected by inode
lock to avoid change while swapping. Also some other condition will not
change between swapping, but there has no problem to do this under inode
lock.

Signed-off-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ioctl.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -116,15 +116,6 @@ static long swap_inode_boot_loader(struc
 	struct inode *inode_bl;
 	struct ext4_inode_info *ei_bl;
 
-	if (inode->i_nlink != 1 || !S_ISREG(inode->i_mode) ||
-	    IS_SWAPFILE(inode) || IS_ENCRYPTED(inode) ||
-	    ext4_has_inline_data(inode))
-		return -EINVAL;
-
-	if (IS_RDONLY(inode) || IS_APPEND(inode) || IS_IMMUTABLE(inode) ||
-	    !inode_owner_or_capable(inode) || !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	inode_bl = ext4_iget(sb, EXT4_BOOT_LOADER_INO, EXT4_IGET_SPECIAL);
 	if (IS_ERR(inode_bl))
 		return PTR_ERR(inode_bl);
@@ -137,6 +128,19 @@ static long swap_inode_boot_loader(struc
 	 * that only 1 swap_inode_boot_loader is running. */
 	lock_two_nondirectories(inode, inode_bl);
 
+	if (inode->i_nlink != 1 || !S_ISREG(inode->i_mode) ||
+	    IS_SWAPFILE(inode) || IS_ENCRYPTED(inode) ||
+	    ext4_has_inline_data(inode)) {
+		err = -EINVAL;
+		goto journal_err_out;
+	}
+
+	if (IS_RDONLY(inode) || IS_APPEND(inode) || IS_IMMUTABLE(inode) ||
+	    !inode_owner_or_capable(inode) || !capable(CAP_SYS_ADMIN)) {
+		err = -EPERM;
+		goto journal_err_out;
+	}
+
 	/* Wait for all existing dio workers */
 	inode_dio_wait(inode);
 	inode_dio_wait(inode_bl);


