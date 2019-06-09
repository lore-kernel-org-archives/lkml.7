Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0731C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B780B206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099543;
	bh=Ys1U/wNoxtp4S6eaEoyjGFy2cSHnHtqSlbiN071H884=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NPty29wttscxFf/QWtsrliFFWcdozyyVrMMtkXt5gmx0vsPOLQqK8UfYHWbF9u450
	 a8M2HHMa4j0PdOEz0WQWwuLV4NCcnr1pGpXii0tuZjYPQ83Vs3yK9LOST9lDq+6IX7
	 f/G9/V4vt2+uNkCSfG6vEnc33S9Wg1dGgD+1ROF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbfFIQ7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732775AbfFIQ7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:59:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EC162081C;
        Sun,  9 Jun 2019 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099541;
        bh=Ys1U/wNoxtp4S6eaEoyjGFy2cSHnHtqSlbiN071H884=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x39AQBD4VSORnK/ZS+/kTROhbQGbnSsplKJ+I6CIkiU2BXXbK22dGh95KYb0gq3Iu
         pYp/V6zgFvth1bxYpHKYaI4PTVUekHWZ2urAzy2sBAGMlHz5E79AvIzEKO704DK9FD
         mfDXqyGZL5uhZ5AKNP9kGQxo8+zBYPqfSqCfmfd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.4 076/241] ext4: do not delete unlinked inode from orphan list on failed truncate
Date:   Sun,  9 Jun 2019 18:40:18 +0200
Message-Id: <20190609164149.964444188@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit ee0ed02ca93ef1ecf8963ad96638795d55af2c14 upstream.

It is possible that unlinked inode enters ext4_setattr() (e.g. if
somebody calls ftruncate(2) on unlinked but still open file). In such
case we should not delete the inode from the orphan list if truncate
fails. Note that this is mostly a theoretical concern as filesystem is
corrupted if we reach this path anyway but let's be consistent in our
orphan handling.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4944,7 +4944,7 @@ int ext4_setattr(struct dentry *dentry,
 			up_write(&EXT4_I(inode)->i_data_sem);
 			ext4_journal_stop(handle);
 			if (error) {
-				if (orphan)
+				if (orphan && inode->i_nlink)
 					ext4_orphan_del(NULL, inode);
 				goto err_out;
 			}


