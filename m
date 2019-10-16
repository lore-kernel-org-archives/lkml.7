Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C42FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4086C21925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264146;
	bh=OWP9qiIYdbw9wGZUH+h8+ReE0Xal0SwpufBF+1eIWUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FxwE8/R0ztJxKPTkNFdGlQGmJE33kMPoThdCNh+vYOpm8w/+IK7e5w4THwfuxCU60
	 dFQbcT0CrDPDCOSZ6qyWv0LxiQuRKc3oK5X89f5EZ9SooLF6chzeo9VDVla+yemDAR
	 L+T7QfcPSZscWfMi6moVh0eErH6b7bjPCPb2UM18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439392AbfJPWPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437781AbfJPVzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:55:21 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA18721925;
        Wed, 16 Oct 2019 21:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262921;
        bh=OWP9qiIYdbw9wGZUH+h8+ReE0Xal0SwpufBF+1eIWUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CPPTjtSu/b0F7eenbRQmG9N8QrtCReLgJuXAmOenJVyAGKfZrBqT9hBdJE7kQ80bl
         G83S+6kCPZ2QAJEDWuxav9KzLpBix/u7aqYCfxVeZrCH9/la50i5q9bVBaldBzMx+J
         N7tjnn1wNBQaSiIFlvuKps3CkOgiR0EKlpYyTokA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.9 80/92] CIFS: Force revalidate inode when dentry is stale
Date:   Wed, 16 Oct 2019 14:50:53 -0700
Message-Id: <20191016214846.918626643@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Shilovsky <piastryyy@gmail.com>

commit c82e5ac7fe3570a269c0929bf7899f62048e7dbc upstream.

Currently the client indicates that a dentry is stale when inode
numbers or type types between a local inode and a remote file
don't match. If this is the case attributes is not being copied
from remote to local, so, it is already known that the local copy
has stale metadata. That's why the inode needs to be marked for
revalidation in order to tell the VFS to lookup the dentry again
before openning a file. This prevents unexpected stale errors
to be returned to the user space when openning a file.

Cc: <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/inode.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -405,6 +405,7 @@ int cifs_get_inode_info_unix(struct inod
 		/* if uniqueid is different, return error */
 		if (unlikely(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM &&
 		    CIFS_I(*pinode)->uniqueid != fattr.cf_uniqueid)) {
+			CIFS_I(*pinode)->time = 0; /* force reval */
 			rc = -ESTALE;
 			goto cgiiu_exit;
 		}
@@ -412,6 +413,7 @@ int cifs_get_inode_info_unix(struct inod
 		/* if filetype is different, return error */
 		if (unlikely(((*pinode)->i_mode & S_IFMT) !=
 		    (fattr.cf_mode & S_IFMT))) {
+			CIFS_I(*pinode)->time = 0; /* force reval */
 			rc = -ESTALE;
 			goto cgiiu_exit;
 		}
@@ -917,6 +919,7 @@ cifs_get_inode_info(struct inode **inode
 		/* if uniqueid is different, return error */
 		if (unlikely(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM &&
 		    CIFS_I(*inode)->uniqueid != fattr.cf_uniqueid)) {
+			CIFS_I(*inode)->time = 0; /* force reval */
 			rc = -ESTALE;
 			goto cgii_exit;
 		}
@@ -924,6 +927,7 @@ cifs_get_inode_info(struct inode **inode
 		/* if filetype is different, return error */
 		if (unlikely(((*inode)->i_mode & S_IFMT) !=
 		    (fattr.cf_mode & S_IFMT))) {
+			CIFS_I(*inode)->time = 0; /* force reval */
 			rc = -ESTALE;
 			goto cgii_exit;
 		}


