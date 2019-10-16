Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BD7ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056C621928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263773;
	bh=vewCQrN7yF9jMWkH9maWnRY5m6Dwi6Md9B9QfL55z7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CrMxInJQ4+cJB+tFlrxlqRPRSRMcdNQVE16eBri6kktHXreuKp0w+6bEaf3Yeaj6V
	 srCPZvLEyHQTCHsX6SODxgGqRs2B+Hxd0aprMplrckqXyc7aUXHFkaqyv8PnzR9WwC
	 fptr7iM4cgMcfm1te/KAkkxIbF37Ligt6AdBW5c4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407136AbfJPWJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438012AbfJPV5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:57:30 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D29321D7F;
        Wed, 16 Oct 2019 21:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263050;
        bh=vewCQrN7yF9jMWkH9maWnRY5m6Dwi6Md9B9QfL55z7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KXPfEZVY2FPDGLUuZV3p0ebSgVASMcExv5lIWV9lO0yFcS2P4V85B2M4mOCniIRzM
         HlH3Q8nF93Mni5+keH/kzUTivrxCR6akHi7t8g5sL6/pckrL8sY5XvTzQiNJ+F+nmr
         R02902Gj213ZIqApsP264k6ngA6w/gbGMtL07xps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 55/81] CIFS: Force reval dentry if LOOKUP_REVAL flag is set
Date:   Wed, 16 Oct 2019 14:51:06 -0700
Message-Id: <20191016214842.397599733@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214805.727399379@linuxfoundation.org>
References: <20191016214805.727399379@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Shilovsky <piastryyy@gmail.com>

commit 0b3d0ef9840f7be202393ca9116b857f6f793715 upstream.

Mark inode for force revalidation if LOOKUP_REVAL flag is set.
This tells the client to actually send a QueryInfo request to
the server to obtain the latest metadata in case a directory
or a file were changed remotely. Only do that if the client
doesn't have a lease for the file to avoid unneeded round
trips to the server.

Cc: <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/dir.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -840,10 +840,16 @@ cifs_lookup(struct inode *parent_dir_ino
 static int
 cifs_d_revalidate(struct dentry *direntry, unsigned int flags)
 {
+	struct inode *inode;
+
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
 	if (d_really_is_positive(direntry)) {
+		inode = d_inode(direntry);
+		if ((flags & LOOKUP_REVAL) && !CIFS_CACHE_READ(CIFS_I(inode)))
+			CIFS_I(inode)->time = 0; /* force reval */
+
 		if (cifs_revalidate_dentry(direntry))
 			return 0;
 		else {
@@ -854,7 +860,7 @@ cifs_d_revalidate(struct dentry *direntr
 			 * attributes will have been updated by
 			 * cifs_revalidate_dentry().
 			 */
-			if (IS_AUTOMOUNT(d_inode(direntry)) &&
+			if (IS_AUTOMOUNT(inode) &&
 			   !(direntry->d_flags & DCACHE_NEED_AUTOMOUNT)) {
 				spin_lock(&direntry->d_lock);
 				direntry->d_flags |= DCACHE_NEED_AUTOMOUNT;


