Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D737C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2962073F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420265;
	bh=vjRm5z1f7VAIKpx122Lgmut+qlfiEoylkat97rE7Dos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=14s5J8kKfCDWsaFyi+Yz2ZioslbpvSO0n5+Wi0HTnfs5vhyeVF+Au4aQBFDBG9cCQ
	 lZ2bR1IPOM8HnIU/BgDajZ9I+f755cSODLlDTedzspACME/giGg0qoh/SDtxZtTTlU
	 m/rgNuLIdysMz3QE462RNHFm/VyRIGMvtw/PRXVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfKVK5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:57:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbfKVK5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:57:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF4A2071F;
        Fri, 22 Nov 2019 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420256;
        bh=vjRm5z1f7VAIKpx122Lgmut+qlfiEoylkat97rE7Dos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WElz8L5HTFxC5Xb1qwxrkahBqU8sDmhu2SDTSGWAn8bhqWbzFL9lVj2LCuy1k1o23
         DJ1/fBt12LhJdfyNusW7q2Og55lQBjhlzitNW2uhjhgfiJKAlZahI8Yui9Ak1KAY9i
         /oaY3vOUDHoESLQafkKAcBZEwpl84ObDWM35m4Ao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 028/220] f2fs: keep lazytime on remount
Date:   Fri, 22 Nov 2019 11:26:33 +0100
Message-Id: <20191122100914.461904944@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index b05e10c332b7e..15779123d0895 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1556,6 +1556,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 
 	limit_reserve_root(sbi);
+	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 	return 0;
 restore_gc:
 	if (need_restart_gc) {
-- 
2.20.1



