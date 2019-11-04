Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB64CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0332621655
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904113;
	bh=SSzynxw9O6haz63D2CYnyk6dDHo2upxF+m8+6hpCyCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RnoqPNlnPFZrkIv3YAkO0TlpB83yFjVEiSI7X/V0ow8xFqEYSkN/cvx04OaESgRKY
	 5mhPcWL8Tclx0LlmLU7OioDUESnIonGgYy+2SJT7+FIx8iqIXDbdoJFAXVBafcByIz
	 20GcQl+63mP5zzBGEdjAgum2XlgtVt/VJrUV/m2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfKDVsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:48:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbfKDVs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:48:29 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25DF421655;
        Mon,  4 Nov 2019 21:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904108;
        bh=SSzynxw9O6haz63D2CYnyk6dDHo2upxF+m8+6hpCyCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgtzpTSDCTw23b57au8KchOvCCOoOhe5suoavZaxlIm9Cc1u+eZpWNCOA8FjdPxRn
         rmzGL0xI6pcKYL/zjYYs+IzPOJRdGMfPJkaryoCnzlz1t7eRznHm7InLeQHwBxTUQu
         MFJLKh+6A8bQDL1gBMqJZxTG3PS4yEJZ58G5mwSY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.4 25/46] fuse: flush dirty data/metadata before non-truncate setattr
Date:   Mon,  4 Nov 2019 22:44:56 +0100
Message-Id: <20191104211857.462527664@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104211830.912265604@linuxfoundation.org>
References: <20191104211830.912265604@linuxfoundation.org>
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
@@ -1628,6 +1628,19 @@ int fuse_do_setattr(struct inode *inode,
 	if (attr->ia_valid & ATTR_SIZE)
 		is_truncate = true;
 
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


