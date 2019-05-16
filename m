Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2587C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB07620862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558006824;
	bh=2QMCkLBXE+4qmehVUZGLRiaJ4icugmF13OzLH+kwniM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=osXl9aKtddKew9tJ7tz1OoGAoig0uq74WVGQGak179cnSa3hjiae/6PKAptZcykDb
	 jJemLztcuGJijqSYAYSZOCLfsJ7oGlQFPprF7lVfHjPY5lBeN9AxoU7uvYdQS6bWyo
	 ROR5/o1BTJ16d37OV8/jqZkNaZbKu/xB3ilsVoAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfEPLkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727680AbfEPLkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:40:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3675E2168B;
        Thu, 16 May 2019 11:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558006820;
        bh=2QMCkLBXE+4qmehVUZGLRiaJ4icugmF13OzLH+kwniM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b3X7lVYa+dYtGBzpYLfg7nLREmywSo7zqZrRI8SMLOhmilOlDNkVlL2f29mrZtR7J
         8PtMJhrrSA0GSWCozj0yaqpQxxNwpYt+/bvmD6Ol2vdpy9If3p4SIUOUMV0bmM58Cl
         r1wIM79qUef4WbjqpEW5yRvJpuCXrTNT+PvDtxGA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 30/34] ufs: fix braino in ufs_get_inode_gid() for solaris UFS flavour
Date:   Thu, 16 May 2019 07:39:27 -0400
Message-Id: <20190516113932.8348-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516113932.8348-1-sashal@kernel.org>
References: <20190516113932.8348-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 4e9036042fedaffcd868d7f7aa948756c48c637d ]

To choose whether to pick the GID from the old (16bit) or new (32bit)
field, we should check if the old gid field is set to 0xffff.  Mainline
checks the old *UID* field instead - cut'n'paste from the corresponding
code in ufs_get_inode_uid().

Fixes: 252e211e90ce
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ufs/util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 1fd3011ea6236..7fd4802222b8c 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -229,7 +229,7 @@ ufs_get_inode_gid(struct super_block *sb, struct ufs_inode *inode)
 	case UFS_UID_44BSD:
 		return fs32_to_cpu(sb, inode->ui_u3.ui_44.ui_gid);
 	case UFS_UID_EFT:
-		if (inode->ui_u1.oldids.ui_suid == 0xFFFF)
+		if (inode->ui_u1.oldids.ui_sgid == 0xFFFF)
 			return fs32_to_cpu(sb, inode->ui_u3.ui_sun.ui_gid);
 		/* Fall through */
 	default:
-- 
2.20.1

