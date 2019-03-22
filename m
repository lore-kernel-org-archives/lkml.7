Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934C5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EED2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260284;
	bh=dTSZHDnq5fNvQsiQ6b5jX9abW04YFo9sioKHxq30GpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hcsq09UtVnefwKCNSxG1IzwUxX0GyLvUvflDyFDKksMjBDkd9JC0FhEgY8roGfMeW
	 SGRnwtnqwfq1VQ22lh7oorgxvGuImEI1xmI04xGu7mkKWeb4L/h2w8IaaZMbirtNqW
	 +Y3ap7T/j6ypQ3n4aK9JC3SHWGzN8IplHWOFc3VE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfCVNLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:11:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbfCVLdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:33:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F1A521917;
        Fri, 22 Mar 2019 11:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254380;
        bh=dTSZHDnq5fNvQsiQ6b5jX9abW04YFo9sioKHxq30GpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=estZnnJQErs0HoLT/Ft/u5pcJPqVrFwHn4SeUvcO0j26LiLuJYos+CULH2AS+V8iD
         kDnMeuk0zQp4Cc1VmQ5h7p4tRy3vFZXwIl7GNOxL1dXXWLyHZpHW4K0QRFz+tCOVH/
         HMgWOD3huyeKmJicseNX1ftkczofWmPHqxkJsXic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 103/230] autofs: drop dentry reference only when it is never used
Date:   Fri, 22 Mar 2019 12:14:01 +0100
Message-Id: <20190322111243.818296802@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 63ce5f552beb9bdb41546b3a26c4374758b21815 ]

autofs_expire_run() calls dput(dentry) to drop the reference count of
dentry.  However, dentry is read via autofs_dentry_ino(dentry) after
that.  This may result in a use-free-bug.  The patch drops the reference
count of dentry only when it is never used.

Link: http://lkml.kernel.org/r/154725122396.11260.16053424107144453867.stgit@pluto-themaw-net
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/autofs4/expire.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 7a5a598a2d94..0d8b9c4f27f2 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -560,7 +560,6 @@ int autofs4_expire_run(struct super_block *sb,
 	pkt.len = dentry->d_name.len;
 	memcpy(pkt.name, dentry->d_name.name, pkt.len);
 	pkt.name[pkt.len] = '\0';
-	dput(dentry);
 
 	if ( copy_to_user(pkt_p, &pkt, sizeof(struct autofs_packet_expire)) )
 		ret = -EFAULT;
@@ -573,6 +572,8 @@ int autofs4_expire_run(struct super_block *sb,
 	complete_all(&ino->expire_complete);
 	spin_unlock(&sbi->fs_lock);
 
+	dput(dentry);
+
 	return ret;
 }
 
-- 
2.19.1



