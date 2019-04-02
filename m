Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A606C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D709B2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbfDBNoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:44:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43552 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731498AbfDBNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:10 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe3-0002nu-Nw; Tue, 02 Apr 2019 14:40:07 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdy-0004y3-4z; Tue, 02 Apr 2019 14:40:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.10131522@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 94/99] ext4: fix special inode number checks in
 __ext4_iget()
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

commit 191ce17876c9367819c4b0a25b503c0f6d9054d8 upstream.

The check for special (reserved) inode number checks in __ext4_iget()
was broken by commit 8a363970d1dc: ("ext4: avoid declaring fs
inconsistent due to invalid file handles").  This was caused by a
botched reversal of the sense of the flag now known as
EXT4_IGET_SPECIAL (when it was previously named EXT4_IGET_NORMAL).
Fix the logic appropriately.

Fixes: 8a363970d1dc ("ext4: avoid declaring fs inconsistent...")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4190,7 +4190,7 @@ struct inode *__ext4_iget(struct super_b
 	uid_t i_uid;
 	gid_t i_gid;
 
-	if (((flags & EXT4_IGET_NORMAL) &&
+	if ((!(flags & EXT4_IGET_SPECIAL) &&
 	     (ino < EXT4_FIRST_INO(sb) && ino != EXT4_ROOT_INO)) ||
 	    (ino < EXT4_ROOT_INO) ||
 	    (ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))) {

