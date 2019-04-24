Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FB8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCBA21904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126551;
	bh=gJ/msCalUi9MD8rR5wQQMBXS7TYLiSmtIB3opvTpaUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YBrXyrvX0fI9v8FN9YtZECv13yrO+nFOsxAEmJzakN1Brb+oXogjFGudxyLH61usm
	 kHIogwOOJ3GlDP5cHGqMf/mB922Xtb4q8fhkctc4KFvE8/njkREEdyv47bC590pvam
	 hA9PwopJ17UaxLf6NmxyznsF/0JVrd9V0jNGD5Bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389579AbfDXRWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388922AbfDXRW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:22:27 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CD0A21905;
        Wed, 24 Apr 2019 17:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126546;
        bh=gJ/msCalUi9MD8rR5wQQMBXS7TYLiSmtIB3opvTpaUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xWJL2e8EdXVj2F7N16n8DW0OaV2aXP3QtbPYpf882q7l/JwfclxY0zly9lvPd8GVX
         G1WN/u4+vHNRY9njkpoifEIYO0c7RVh9JkRYWkcy/z/qJhjfEE4/PhXsuMbX/7Wgkk
         kbYGE79di0taoP8NrOLODHluo+k3KbNeK9mQyzvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 100/168] ext4: report real fs size after failed resize
Date:   Wed, 24 Apr 2019 19:09:04 +0200
Message-Id: <20190424170929.572502986@linuxfoundation.org>
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

[ Upstream commit 6c7328400e0488f7d49e19e02290ba343b6811b2 ]

Currently when the file system resize using ext4_resize_fs() fails it
will report into log that "resized filesystem to <requested block
count>".  However this may not be true in the case of failure.  Use the
current block count as returned by ext4_blocks_count() to report the
block count.

Additionally, report a warning that "error occurred during file system
resize"

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/resize.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 22c90eb9a4e0..5223eb25bf59 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -2047,6 +2047,10 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 		free_flex_gd(flex_gd);
 	if (resize_inode != NULL)
 		iput(resize_inode);
-	ext4_msg(sb, KERN_INFO, "resized filesystem to %llu", n_blocks_count);
+	if (err)
+		ext4_warning(sb, "error (%d) occurred during "
+			     "file system resize", err);
+	ext4_msg(sb, KERN_INFO, "resized filesystem to %llu",
+		 ext4_blocks_count(es));
 	return err;
 }
-- 
2.19.1



