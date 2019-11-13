Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4975EC17441
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154BB222D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573609855;
	bh=LCgcg2823SU5nvSbZFB0e7JqZXVhEoWiEBO+CGbEi3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WJt7jjAduUh/rW4e3JkD2AZkM35aVes/WmvUYOFPnFVBNtDaJCpCmzmMWp2aOoDsV
	 X8o+Hn+OKxbLwV2F0ghyFmyIfZ+AKXj+Ue+biPBwjWyhE1gblpuxp7/9B0XDGzh6/3
	 2Y+G8Dr3e4WyNka7oChfnkP6JWcpZoeY4AvWfP6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKMBuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:50:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbfKMBuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:50:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDC402245A;
        Wed, 13 Nov 2019 01:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609843;
        bh=LCgcg2823SU5nvSbZFB0e7JqZXVhEoWiEBO+CGbEi3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cMNNKeObyslZ2Ax0UFu+JA7UQ0SymgBnBs+a2IuRXoA5sSnwhKjYoaF6F0c2yYS27
         pnwHDiyOR3CI6UB1/qsK1KPnNJtW62m15sVTgGUv5HJ4zT1LciQfjVKWOgfgszjUxj
         VB8TmUUsvnU0Re2511d/vDLXWe3wn9S2uUVWzBkk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 015/209] f2fs: keep lazytime on remount
Date:   Tue, 12 Nov 2019 20:47:11 -0500
Message-Id: <20191113015025.9685-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 095680f24f2673d860fd1d3d2f54f40f330b4c63 ]

This patch fixes losing lazytime when remounting f2fs.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d9106bbe7df63..d72e937ff57b7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1555,6 +1555,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 
 	limit_reserve_root(sbi);
+	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 	return 0;
 restore_gc:
 	if (need_restart_gc) {
-- 
2.20.1

