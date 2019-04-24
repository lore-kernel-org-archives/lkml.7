Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1660C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A142121904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126548;
	bh=xnxHdZyTz43xnAYSMLCJ3rMi6UKFxFCS23zOMIEA9LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MaGX6sFEtoBQBD73sMIDFf+zFKFLKQhAGY4q+Kdz41gqK77k/ew8RHwxH/Cp9UZWd
	 4rHGqYuOBJPXec6mq5w129XlIcLQdc91tmGwClblUvzSQCIsaWGsrvnSxr8bEzhEB2
	 9GP2z90bBLRWhKvDPdps7iNQZ6G8YbJnnjMmLxCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389567AbfDXRW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388780AbfDXRWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:22:24 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AA1120675;
        Wed, 24 Apr 2019 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126543;
        bh=xnxHdZyTz43xnAYSMLCJ3rMi6UKFxFCS23zOMIEA9LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f5CvDFarV/MRDPYgrXnq8HYe8LPfM/bkhLgy0Vg86h3hFZfsas2pD40D757MdiVDt
         NVQO5t+p9afRUlrNpL5xEq0fGQkF/eZAoCJB0Xp35PbgR5CiGB89BRDNpiQp9Yxzti
         buNMdRdUpAkjZq3Es9oknsA9flzk7tmRrKfvNRAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 099/168] ext4: add missing brelse() in add_new_gdb_meta_bg()
Date:   Wed, 24 Apr 2019 19:09:03 +0200
Message-Id: <20190424170929.523267277@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d64264d6218e6892edd832dc3a5a5857c2856c53 ]

Currently in add_new_gdb_meta_bg() there is a missing brelse of gdb_bh
in case ext4_journal_get_write_access() fails.
Additionally kvfree() is missing in the same error path. Fix it by
moving the ext4_journal_get_write_access() before the ext4 sb update as
Ted suggested and release n_group_desc and gdb_bh in case it fails.

Fixes: 61a9c11e5e7a ("ext4: add missing brelse() add_new_gdb_meta_bg()'s error path")
Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/resize.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 4bd12247a9be..22c90eb9a4e0 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -907,11 +907,18 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
 	memcpy(n_group_desc, o_group_desc,
 	       EXT4_SB(sb)->s_gdb_count * sizeof(struct buffer_head *));
 	n_group_desc[gdb_num] = gdb_bh;
+
+	BUFFER_TRACE(gdb_bh, "get_write_access");
+	err = ext4_journal_get_write_access(handle, gdb_bh);
+	if (err) {
+		kvfree(n_group_desc);
+		brelse(gdb_bh);
+		return err;
+	}
+
 	EXT4_SB(sb)->s_group_desc = n_group_desc;
 	EXT4_SB(sb)->s_gdb_count++;
 	kvfree(o_group_desc);
-	BUFFER_TRACE(gdb_bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, gdb_bh);
 	return err;
 }
 
-- 
2.19.1



