Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35E7C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1AF20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355829;
	bh=5zCdNk6o7TvfEzmsRexz2WXo2rRTLCTto/KnK33XGaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IgW271k44NpZcXze7FtTgG3nPi+Rol2IoDA/sCRCZuBQD3v5xSYUDtFXmqzbGwglH
	 dqirlmqHT5/THDFRlD/NeSLguTLMivGf9rlQzAjmjseX5nqEeyRL7cGrOe0vbgtkyH
	 D0k+v1VfNJCd09oosgltUVHUH3eYMqtU6LtczK04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391304AbfETMhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391338AbfETMgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:36:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BB68204FD;
        Mon, 20 May 2019 12:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355813;
        bh=5zCdNk6o7TvfEzmsRexz2WXo2rRTLCTto/KnK33XGaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vTxIcz9bL0Z3MIM3139zFxb0F3R9Nspo/Bjaci7FDAKtsagOYrEukTJHw1ZVcOkIS
         sTt6ByYeoT2ozu6nIjTtdc14l+D/3dJwUTKTXYVOrKur0mHm48nxs2KqfewGQqZq1I
         jZOY/REnpyk5ok4sQTBVqv9PMxSqqsKR8QVFePfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Arthur Marsh <arthur.marsh@internode.on.net>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.1 128/128] ext4: fix block validity checks for journal inodes using indirect blocks
Date:   Mon, 20 May 2019 14:15:15 +0200
Message-Id: <20190520115257.193032813@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115249.449077487@linuxfoundation.org>
References: <20190520115249.449077487@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

commit 170417c8c7bb2cbbdd949bf5c443c0c8f24a203b upstream.

Commit 345c0dbf3a30 ("ext4: protect journal inode's blocks using
block_validity") failed to add an exception for the journal inode in
ext4_check_blockref(), which is the function used by ext4_get_branch()
for indirect blocks.  This caused attempts to read from the ext3-style
journals to fail with:

[  848.968550] EXT4-fs error (device sdb7): ext4_get_branch:171: inode #8: block 30343695: comm jbd2/sdb7-8: invalid block

Fix this by adding the missing exception check.

Fixes: 345c0dbf3a30 ("ext4: protect journal inode's blocks using block_validity")
Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/block_validity.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -276,6 +276,11 @@ int ext4_check_blockref(const char *func
 	__le32 *bref = p;
 	unsigned int blk;
 
+	if (ext4_has_feature_journal(inode->i_sb) &&
+	    (inode->i_ino ==
+	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
+		return 0;
+
 	while (bref < p+max) {
 		blk = le32_to_cpu(*bref++);
 		if (blk &&


