Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C317C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA68B22479
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696911;
	bh=AGKVJITybppG06fs8nTR/rKh/OuQGQsCKDpZoorvQhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hMUSXMYZrsPl6wuiWBHQHGai2tNj1tQg2ZT7EyGubeSSvLBQvit2rAIBct8zDOMno
	 29MUaRcNv46VV+e1PrKx283uoWrexU1r8kTHzUfIbuwaIHq3u6fJROP6Ca/KGMVANh
	 9g/MBWM9kcmlQJ8Hgal6U9nPCOsAQ6cqpGWM8AXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbfJJIlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388404AbfJJIlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:41:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 152432190F;
        Thu, 10 Oct 2019 08:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696906;
        bh=AGKVJITybppG06fs8nTR/rKh/OuQGQsCKDpZoorvQhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DkbegiTOAXQfBYNqnWNnhU1b44fH/n51lr/IcLQB923sg7iqmMVXoetzvP9oUPJq1
         SAth44jeE3Lg8KvFKQF1hyEI3OlibPLYCyl8cBPswhfPvudzSgwTl7dpzL2tl/Z8Ng
         KeK9cJrr0WACDsZXN/xY1ERjhQHnZHFeZYuA6c4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 097/148] fuse: fix request limit
Date:   Thu, 10 Oct 2019 10:35:58 +0200
Message-Id: <20191010083617.145392705@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit f22f812d5ce75a18b56073a7a63862e6ea764070 ]

The size of struct fuse_req was reduced from 392B to 144B on a non-debug
config, thus the sanitize_global_limit() helper was setting a larger
default limit.  This doesn't really reflect reduction in the memory used by
requests, since the fields removed from fuse_req were added to fuse_args
derived structs; e.g. sizeof(struct fuse_writepages_args) is 248B, thus
resulting in slightly more memory being used for writepage requests
overalll (due to using 256B slabs).

Make the calculatation ignore the size of fuse_req and use the old 392B
value.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 987877860c019..f3104db3de83a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -823,9 +823,12 @@ static const struct super_operations fuse_super_operations = {
 
 static void sanitize_global_limit(unsigned *limit)
 {
+	/*
+	 * The default maximum number of async requests is calculated to consume
+	 * 1/2^13 of the total memory, assuming 392 bytes per request.
+	 */
 	if (*limit == 0)
-		*limit = ((totalram_pages() << PAGE_SHIFT) >> 13) /
-			 sizeof(struct fuse_req);
+		*limit = ((totalram_pages() << PAGE_SHIFT) >> 13) / 392;
 
 	if (*limit >= 1 << 16)
 		*limit = (1 << 16) - 1;
-- 
2.20.1



