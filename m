Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E41C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCFF2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054048;
	bh=SZZE+pgDssWiTsN/aIEafz1u29jCy292uDmCCXDuVjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jghvoWOtqOkTsXWls9fcOCIY+w9bFHYhjWflVFGzgtGLgybNcEK4OxYcqlSSJd4uH
	 as8vhydaKqJ8UBXgqI2QkR2npwwNp2q+QpdDSZrml5xDVzsuo1FTToBc7AzxvmUYwy
	 ogWN92IxZEt6OjnVnrh1KWNQOhNkPLVSrCI9YtFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfFTSH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbfFTSHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:07:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 489E52070B;
        Thu, 20 Jun 2019 18:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054042;
        bh=SZZE+pgDssWiTsN/aIEafz1u29jCy292uDmCCXDuVjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jOwbhcvYf8l3g1Q4WTh5wy3UVG+EdDNUXBusUxq14rgQiJqzMOoMex3a1u2vaohl3
         LeFBUV462ws3Mjd387GeJlxM4SXByC4jalEG6FPrvDgr786zCiAg8Scy43dC+d8Rol
         4SibhQKkmjwzxZn2Jq1ld1CIaUaQvo+pKK+vVNgQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Alexander Lochmann <alexander.lochmann@tu-dortmund.de>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.9 117/117] Abort file_remove_privs() for non-reg. files
Date:   Thu, 20 Jun 2019 19:57:31 +0200
Message-Id: <20190620174358.416172980@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>

commit f69e749a49353d96af1a293f56b5b56de59c668a upstream.

file_remove_privs() might be called for non-regular files, e.g.
blkdev inode. There is no reason to do its job on things
like blkdev inodes, pipes, or cdevs. Hence, abort if
file does not refer to a regular inode.

AV: more to the point, for devices there might be any number of
inodes refering to given device.  Which one to strip the permissions
from, even if that made any sense in the first place?  All of them
will be observed with contents modified, after all.

Found by LockDoc (Alexander Lochmann, Horst Schirmeier and Olaf
Spinczyk)

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/inode.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1804,8 +1804,13 @@ int file_remove_privs(struct file *file)
 	int kill;
 	int error = 0;
 
-	/* Fast path for nothing security related */
-	if (IS_NOSEC(inode))
+	/*
+	 * Fast path for nothing security related.
+	 * As well for non-regular files, e.g. blkdev inodes.
+	 * For example, blkdev_write_iter() might get here
+	 * trying to remove privs which it is not allowed to.
+	 */
+	if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
 		return 0;
 
 	kill = dentry_needs_remove_privs(dentry);


