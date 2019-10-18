Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3F5CA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F9E222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436340;
	bh=zVWc36t1YQ5i5dLYsdN3Ycb+XDGeIMymeTrjmDPd9qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LOdDSyNYzFoR4DiaBfEIeXj7OHk6sW+sI3ysjdmTBgzHNfTB95Zx+v6TojkckroR8
	 xuWUrVgxos3Smc+Csf71vwvdK30tEcIfDp6kWL42y0aGYUeNFwi5q+p23vax9mYhIj
	 c7nyGpftepDA8jh4A3HgM0ZeEX8RIYQkom6aXXdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfJRWFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729866AbfJRWFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:05:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F832222C6;
        Fri, 18 Oct 2019 22:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436335;
        bh=zVWc36t1YQ5i5dLYsdN3Ycb+XDGeIMymeTrjmDPd9qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KotNSeiVwdL1tKPDukF8dL37DjA+exJpTmBPibNkp2qctkNj97vihqPOTfZ3QPkhe
         ij0u3PK8sxcgSWGBDG/pFjsrwnJsp3fP67JtgwyUsZz+yFKRA/juJPw/7KAUMdXlDh
         /ADhEs00sYwilzbdT8b0EB+LGrgsQlHOmYQq7bpk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 006/100] f2fs: fix to recover inode's i_gc_failures during POR
Date:   Fri, 18 Oct 2019 18:03:51 -0400
Message-Id: <20191018220525.9042-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220525.9042-1-sashal@kernel.org>
References: <20191018220525.9042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 7de36cf3e4087207f42a88992f8cb615a1bd902e ]

inode.i_gc_failures is used to indicate that skip count of migrating
on blocks of inode, we should guarantee it can be recovered in sudden
power-off case.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 0b224f4a4a656..281ba46b5b359 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -226,6 +226,8 @@ static void recover_inode(struct inode *inode, struct page *page)
 
 	F2FS_I(inode)->i_advise = raw->i_advise;
 	F2FS_I(inode)->i_flags = le32_to_cpu(raw->i_flags);
+	F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN] =
+				le16_to_cpu(raw->i_gc_failures);
 
 	recover_inline_flags(inode, raw);
 
-- 
2.20.1

