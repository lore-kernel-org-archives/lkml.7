Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C90AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7154920644
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011814;
	bh=M9kA6vywYhmV6AUU9MEyFZaf6DLYgVev0DEg/fwbbYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qwqBwzkjLyvAv6foLbU9SvgqqXXj/fWudttWE0TKYrNNYE36kpfCEYVoJjV/Y4Qo5
	 RAZ2to1O09ww9kbwZDz6YFrbCMZ3HtjNjy1ByUmQwqkToDsqt0t3X3jQZlAnMCcnho
	 jUu4sHuNQu3h9lXe3IbvOgSBWWwWENqHF/CrNoaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfHENU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730356AbfHENUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:20:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DD7220657;
        Mon,  5 Aug 2019 13:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011253;
        bh=M9kA6vywYhmV6AUU9MEyFZaf6DLYgVev0DEg/fwbbYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQ09bzU6hWoBfGmq+nQ4ROOIlNVkjLZuKH2NEIgoKAaMrG/0/+iaKnvHr64LGQdwr
         P0p/Ks9V5z8i/Mf2/FceFvF8j+g/ANH2VSm8ITFSlfG1y1ovrygWX1BRj6zimdCZka
         Ly53MBey+tC9+Zmw1qYWJgE2gErmho0/85kOqBEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 023/131] fs/adfs: super: fix use-after-free bug
Date:   Mon,  5 Aug 2019 15:01:50 +0200
Message-Id: <20190805124952.992413920@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5808b14a1f52554de612fee85ef517199855e310 ]

Fix a use-after-free bug during filesystem initialisation, where we
access the disc record (which is stored in a buffer) after we have
released the buffer.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/adfs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index ffb669f9bba78..ce0fbbe002bf3 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -360,6 +360,7 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	struct buffer_head *bh;
 	struct object_info root_obj;
 	unsigned char *b_data;
+	unsigned int blocksize;
 	struct adfs_sb_info *asb;
 	struct inode *root;
 	int ret = -EINVAL;
@@ -411,8 +412,10 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 		goto error_free_bh;
 	}
 
+	blocksize = 1 << dr->log2secsize;
 	brelse(bh);
-	if (sb_set_blocksize(sb, 1 << dr->log2secsize)) {
+
+	if (sb_set_blocksize(sb, blocksize)) {
 		bh = sb_bread(sb, ADFS_DISCRECORD / sb->s_blocksize);
 		if (!bh) {
 			adfs_error(sb, "couldn't read superblock on "
-- 
2.20.1



