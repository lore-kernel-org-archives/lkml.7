Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833A1C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7D821744
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329193;
	bh=+8vMyOsIN6KDliEj6S/eI4ORry4+Lma2T1on9iTX9ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=haOYxh2seLVI2PoDrtfDAAfRw4fGOgxkvP9ung48FFslMmcKuS9qzHvlLyJ7BWSdr
	 hPKR6+dnrRnTZ2dtFdtuyMczpHnSczo+cyl9OKSOQXA+lmeoya0e7vIc9+3ZM+Qwk+
	 teazg+f+XihF8hkEynShGVSyZxpen3eoeSxmOPuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfD0Bjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbfD0Bju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E96D214C6;
        Sat, 27 Apr 2019 01:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329190;
        bh=+8vMyOsIN6KDliEj6S/eI4ORry4+Lma2T1on9iTX9ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zv7k+CakCtN+1V/ICzC7I9GA99ebn1yPe67bW8uF8lexngXAfFimjIHINSNVO76Vz
         HCBFOFHRba0/JqBF1qFjpMLQD+W/pQITtrqoTx9+VEMYrT7c0IX3Is++kaa8TZd56N
         zRXSpA2GGds4c+rzde2WPPMIpBaDpK7knzdd5d5Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 5.0 45/79] slab: fix a crash by reading /proc/slab_allocators
Date:   Fri, 26 Apr 2019 21:38:04 -0400
Message-Id: <20190427013838.6596-45-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
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
index 2f2aa8eaf7d9..188c4b65255d 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4297,7 +4297,8 @@ static void show_symbol(struct seq_file *m, unsigned long address)
 
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

