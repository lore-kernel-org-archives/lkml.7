Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76111ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494BA2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263778;
	bh=Pxs2aB/agyCIYNPG8qWddQ44GaKflEmdA4OTUXMUcMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ghDrjZG+xXbmXT828ryJR+l2crCxTFIEf/bk55XWd0sGpaAJtA6pTnbKYKkNziFt5
	 aslw5VVEQEDQKolHMriekheK/bnnedaOPK5qUukxLOlSxXhp2O6U36AkBLY9ky14ak
	 5bEDrOQG4ke3E1nBGW6AZ6YPkmHvt/rwzF8Cas04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407159AbfJPWJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391757AbfJPV53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:57:29 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 564DD21928;
        Wed, 16 Oct 2019 21:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263049;
        bh=Pxs2aB/agyCIYNPG8qWddQ44GaKflEmdA4OTUXMUcMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZlt4OS43J9zHehdRuccRGOrBUv6MhyfF6wRJVokUG2R0pLMRLp5WLhy8PgHr04YP
         dQTK2bHBihxC2pvTz5BleiC9RrF2uSzfDoseqDWbVaYPnbGraXxOIOC2BkbBkcEVjc
         K7WKrdJHksNYOG3asnRu5KWZwSFhfpI9XTiLMNbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 54/81] CIFS: Force revalidate inode when dentry is stale
Date:   Wed, 16 Oct 2019 14:51:05 -0700
Message-Id: <20191016214841.933221804@linuxfoundation.org>
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
@@ -410,6 +410,7 @@ int cifs_get_inode_info_unix(struct inod
 		/* if uniqueid is different, return error */
 		if (unlikely(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM &&
 		    CIFS_I(*pinode)->uniqueid != fattr.cf_uniqueid)) {
+			CIFS_I(*pinode)->time = 0; /* force reval */
 			rc = -ESTALE;
 			goto cgiiu_exit;
 		}
@@ -417,6 +418,7 @@ int cifs_get_inode_info_unix(struct inod
 		/* if filetype is different, return error */
 		if (unlikely(((*pinode)->i_mode & S_IFMT) !=
 		    (fattr.cf_mode & S_IFMT))) {
+			CIFS_I(*pinode)->time = 0; /* force reval */
 			rc = -ESTALE;
 			goto cgiiu_exit;
 		}
@@ -926,6 +928,7 @@ cifs_get_inode_info(struct inode **inode
 		/* if uniqueid is different, return error */
 		if (unlikely(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM &&
 		    CIFS_I(*inode)->uniqueid != fattr.cf_uniqueid)) {
+			CIFS_I(*inode)->time = 0; /* force reval */
 			rc = -ESTALE;
 			goto cgii_exit;
 		}
@@ -933,6 +936,7 @@ cifs_get_inode_info(struct inode **inode
 		/* if filetype is different, return error */
 		if (unlikely(((*inode)->i_mode & S_IFMT) !=
 		    (fattr.cf_mode & S_IFMT))) {
+			CIFS_I(*inode)->time = 0; /* force reval */
 			rc = -ESTALE;
 			goto cgii_exit;
 		}


