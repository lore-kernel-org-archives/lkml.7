Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FD4C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1C2206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329778;
	bh=Dfb0m+dKOjZ261kAFokQFS5zgR8yMauVoqIuHnLIdPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iG4lvCxLasGqeYBqNdHicsdhFRWeUglWtaXgZhqbRUOASW677DNjwEpdhgLN7WFWX
	 WQQjB5CB6KBRoYb1LnGcRnv04BXv6nkNqUZYsEpI1szad9blgtZ/qYTIIeXy22i0bQ
	 wG7SC+JpIaf5Li2X2mrgxcyYPaU82WLmPzUE2aUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfD0Bly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:41:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727884AbfD0Blu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:41:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84C352173E;
        Sat, 27 Apr 2019 01:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329309;
        bh=Dfb0m+dKOjZ261kAFokQFS5zgR8yMauVoqIuHnLIdPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ckInvDlJkaiDNO4yr2qRD3YevaF9QkOMk05JxjSb6+dZhaDM6XUPZxuQnDBjSTmY+
         O98ZPRYxLRroxhVSkbQclDVwCszvtxtC399+xvRRcHd3x7SvDW3laAg/yD8I9RKPrG
         b+nLJ66gVpjpxKxrJQ7RNBDYrMOsw7NBPLVDZzGk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.19 34/53] slab: fix a crash by reading /proc/slab_allocators
Date:   Fri, 26 Apr 2019 21:40:31 -0400
Message-Id: <20190427014051.7522-34-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

[ Upstream commit fcf88917dd435c6a4cb2830cb086ee58605a1d85 ]

The commit 510ded33e075 ("slab: implement slab_root_caches list")
changes the name of the list node within "struct kmem_cache" from "list"
to "root_caches_node", but leaks_show() still use the "list" which
causes a crash when reading /proc/slab_allocators.

You need to have CONFIG_SLAB=y and CONFIG_MEMCG=y to see the problem,
because without MEMCG all slab caches are root caches, and the "list"
node happens to be the right one.

Fixes: 510ded33e075 ("slab: implement slab_root_caches list")
Signed-off-by: Qian Cai <cai@lca.pw>
Reviewed-by: Tobin C. Harding <tobin@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slab.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index b8e0ec74330f..018d32496e8d 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4305,7 +4305,8 @@ static void show_symbol(struct seq_file *m, unsigned long address)
 
 static int leaks_show(struct seq_file *m, void *p)
 {
-	struct kmem_cache *cachep = list_entry(p, struct kmem_cache, list);
+	struct kmem_cache *cachep = list_entry(p, struct kmem_cache,
+					       root_caches_node);
 	struct page *page;
 	struct kmem_cache_node *n;
 	const char *name;
-- 
2.19.1

