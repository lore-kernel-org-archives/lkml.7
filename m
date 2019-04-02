Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6508C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE232146E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbfDBNkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:40:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43600 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731509AbfDBNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:11 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe4-0002ol-4i; Tue, 02 Apr 2019 14:40:08 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdy-0004xm-1i; Tue, 02 Apr 2019 14:40:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.766426374@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 91/99] ext4: avoid kernel warning when writing the
 superblock to a dead device
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit e86807862e6880809f191c4cea7f88a489f0ed34 upstream.

The xfstests generic/475 test switches the underlying device with
dm-error while running a stress test.  This results in a large number
of file system errors, and since we can't lock the buffer head when
marking the superblock dirty in the ext4_grp_locked_error() case, it's
possible the superblock to be !buffer_uptodate() without
buffer_write_io_error() being true.

We need to set buffer_uptodate() before we call mark_buffer_dirty() or
this will trigger a WARN_ON.  It's safe to do this since the
superblock must have been properly read into memory or the mount would
have been successful.  So if buffer_uptodate() is not set, we can
safely assume that this happened due to a failed attempt to write the
superblock.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4712,7 +4712,7 @@ static int ext4_commit_super(struct supe
 	BUFFER_TRACE(sbh, "marking dirty");
 	ext4_superblock_csum_set(sb);
 	lock_buffer(sbh);
-	if (buffer_write_io_error(sbh)) {
+	if (buffer_write_io_error(sbh) || !buffer_uptodate(sbh)) {
 		/*
 		 * Oh, dear.  A previous attempt to write the
 		 * superblock failed.  This could happen because the

