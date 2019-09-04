Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABC8C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D2722CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567612840;
	bh=bIpGUdrS+JV8vhdNWybDE/iiWT1MOmLAzGfz+nmxwkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kGGCWuYvPC2JFxEtNgOsm6cwQwvCJFNtEjgHI27O2Em20RsKxTg3aHf87JmKobB3/
	 q5POiCDG/j/i8WMJdDpb4qvTT4u7jlzvaqK2wjoSgRIW2om+XezT4GYlcCoh9c4M1O
	 HuHTFy91B86leY7tbHA9rt6n7w3Eft3JGSpOxrx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbfIDQAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732742AbfIDQAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:00:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1830D2087E;
        Wed,  4 Sep 2019 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612832;
        bh=bIpGUdrS+JV8vhdNWybDE/iiWT1MOmLAzGfz+nmxwkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2wWa0/fdUNtumh4peKLxu0Fboric1GlWCK1CTaIUFWRaWlNIPh2AmUNTGUkBVbtE
         D1SqdM66mnpRFXF5mYpmOlZhgPIvF2cos3KdnMWwaLz8KimlDzD67MzE+38Ufq7Roo
         pH4D4fM0LXCcCxqEN6drZpoE2Qme9uWQMCa3WmcA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 20/52] NFSv4: Fix return value in nfs_finish_open()
Date:   Wed,  4 Sep 2019 11:59:32 -0400
Message-Id: <20190904160004.3671-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904160004.3671-1-sashal@kernel.org>
References: <20190904160004.3671-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 9821421a291b548ef4369c6998745baa36ddecd5 ]

If the file turns out to be of the wrong type after opening, we want
to revalidate the path and retry, so return EOPENSTALE rather than
ESTALE.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 71b2e390becf2..b8d6860879528 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1486,7 +1486,7 @@ static int nfs_finish_open(struct nfs_open_context *ctx,
 	if (S_ISREG(file->f_path.dentry->d_inode->i_mode))
 		nfs_file_set_open_context(file, ctx);
 	else
-		err = -ESTALE;
+		err = -EOPENSTALE;
 out:
 	return err;
 }
-- 
2.20.1

