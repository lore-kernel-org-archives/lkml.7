Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F9DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD07213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfCVFYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:24:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45656 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726553AbfCVFXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:23:16 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-00015t-Iz; Fri, 22 Mar 2019 05:23:13 +0000
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-0001oE-CG; Fri, 22 Mar 2019 05:23:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Brian Foster" <bfoster@redhat.com>,
        "Dave Chinner" <dchinner@redhat.com>,
        "Dave Chinner" <david@fromorbit.com>
Date:   Fri, 22 Mar 2019 05:20:18 +0000
Message-ID: <lsq.1553232018.256555080@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 01/16] xfs: don't BUG() on mixed direct and mapped I/O
In-Reply-To: <lsq.1553232017.771830163@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.64-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Foster <bfoster@redhat.com>

commit 04197b341f23b908193308b8d63d17ff23232598 upstream.

We've had reports of generic/095 causing XFS to BUG() in
__xfs_get_blocks() due to the existence of delalloc blocks on a
direct I/O read. generic/095 issues a mix of various types of I/O,
including direct and memory mapped I/O to a single file. This is
clearly not supported behavior and is known to lead to such
problems. E.g., the lack of exclusion between the direct I/O and
write fault paths means that a write fault can allocate delalloc
blocks in a region of a file that was previously a hole after the
direct read has attempted to flush/inval the file range, but before
it actually reads the block mapping. In turn, the direct read
discovers a delalloc extent and cannot proceed.

While the appropriate solution here is to not mix direct and memory
mapped I/O to the same regions of the same file, the current
BUG_ON() behavior is probably overkill as it can crash the entire
system.  Instead, localize the failure to the I/O in question by
returning an error for a direct I/O that cannot be handled safely
due to delalloc blocks. Be careful to allow the case of a direct
write to post-eof delalloc blocks. This can occur due to speculative
preallocation and is safe as post-eof blocks are not accompanied by
dirty pages in pagecache (conversely, preallocation within eof must
have been zeroed, and thus dirtied, before the inode size could have
been increased beyond said blocks).

Finally, provide an additional warning if a direct I/O write occurs
while the file is memory mapped. This may not catch all problematic
scenarios, but provides a hint that some known-to-be-problematic I/O
methods are in use.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Dave Chinner <david@fromorbit.com>
[bwh: Backported to 3.16:
 - Assign positive error code to error variable
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/xfs/xfs_aops.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -1300,6 +1300,26 @@ __xfs_get_blocks(
 	if (error)
 		goto out_unlock;
 
+	/*
+	 * The only time we can ever safely find delalloc blocks on direct I/O
+	 * is a dio write to post-eof speculative preallocation. All other
+	 * scenarios are indicative of a problem or misuse (such as mixing
+	 * direct and mapped I/O).
+	 *
+	 * The file may be unmapped by the time we get here so we cannot
+	 * reliably fail the I/O based on mapping. Instead, fail the I/O if this
+	 * is a read or a write within eof. Otherwise, carry on but warn as a
+	 * precuation if the file happens to be mapped.
+	 */
+	if (direct && imap.br_startblock == DELAYSTARTBLOCK) {
+		if (!create || offset < i_size_read(VFS_I(ip))) {
+			WARN_ON_ONCE(1);
+			error = EIO;
+			goto out_unlock;
+		}
+		WARN_ON_ONCE(mapping_mapped(VFS_I(ip)->i_mapping));
+	}
+
 	if (create &&
 	    (!nimaps ||
 	     (imap.br_startblock == HOLESTARTBLOCK ||
@@ -1383,7 +1403,6 @@ __xfs_get_blocks(
 		set_buffer_new(bh_result);
 
 	if (imap.br_startblock == DELAYSTARTBLOCK) {
-		BUG_ON(direct);
 		if (create) {
 			set_buffer_uptodate(bh_result);
 			set_buffer_mapped(bh_result);

