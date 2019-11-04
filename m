Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F2BCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9977D20650
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905408;
	bh=hMZ+6uzgHEr/dMaKBuhF6e8kLt6gB4N3Cpnqs0zwZ5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UTO1F+uQ+HUpwImGDW4FPEZEV9gbfvAKKEd66LfAVDIi9aWxX6P4JujMtfNGoE9tk
	 9h8ssMBYLEn4fJfa2Yncmixp9AAY/6BxXmQAO62ttHKw5Zht7g2OPzqW4m36c4ZRxO
	 hUCTyw/fIrDy3z0205ePwVSop2tosykFRsc/MGWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389707AbfKDWKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:10:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:43150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389262AbfKDWJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:09:59 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 219DE2084D;
        Mon,  4 Nov 2019 22:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905398;
        bh=hMZ+6uzgHEr/dMaKBuhF6e8kLt6gB4N3Cpnqs0zwZ5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cWZqDtQK8uiiMCQ6Hp28KhIYb8VlYqjF0YjJGUvxc2w9v+rtoiJorS7RODzakZ+fh
         Gm/VC22xXWWQyEouqrzjX0idHmorSdQ6PY40cTYbketp/EzYxaZSV/i8R1RYtcjakI
         iG3iUWPsrDuQQsdby5O116tIx9MlIZ1bL7MLiBD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.3 095/163] fuse: flush dirty data/metadata before non-truncate setattr
Date:   Mon,  4 Nov 2019 22:44:45 +0100
Message-Id: <20191104212147.014034079@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

commit b24e7598db62386a95a3c8b9c75630c5d56fe077 upstream.

If writeback cache is enabled, then writes might get reordered with
chmod/chown/utimes.  The problem with this is that performing the write in
the fuse daemon might itself change some of these attributes.  In such case
the following sequence of operations will result in file ending up with the
wrong mode, for example:

  int fd = open ("suid", O_WRONLY|O_CREAT|O_EXCL);
  write (fd, "1", 1);
  fchown (fd, 0, 0);
  fchmod (fd, 04755);
  close (fd);

This patch fixes this by flushing pending writes before performing
chown/chmod/utimes.

Reported-by: Giuseppe Scrivano <gscrivan@redhat.com>
Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>
Fixes: 4d99ff8f12eb ("fuse: Turn writeback cache on")
Cc: <stable@vger.kernel.org> # v3.15+
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dir.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1476,6 +1476,19 @@ int fuse_do_setattr(struct dentry *dentr
 		is_truncate = true;
 	}
 
+	/* Flush dirty data/metadata before non-truncate SETATTR */
+	if (is_wb && S_ISREG(inode->i_mode) &&
+	    attr->ia_valid &
+			(ATTR_MODE | ATTR_UID | ATTR_GID | ATTR_MTIME_SET |
+			 ATTR_TIMES_SET)) {
+		err = write_inode_now(inode, true);
+		if (err)
+			return err;
+
+		fuse_set_nowrite(inode);
+		fuse_release_nowrite(inode);
+	}
+
 	if (is_truncate) {
 		fuse_set_nowrite(inode);
 		set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);


