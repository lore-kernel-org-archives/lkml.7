Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD27C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466D72089E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428676;
	bh=VHEcK7OOP1jtW+G99RTlVZzKoB+P1+WnmyH6ylK7zTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=titWEd9NzzxX9SBlWldisEdA2PETQVBYld32MRiJ9INlh2oGYq2+Qn570wRMmK/xS
	 XGjpeX8WAM5k1xC3OtuxUnPtRc4tO6gnRM8lPVHDg+GIrGAaqyWwcZk4MmSvN+JyWz
	 kIN2zDo90i3YlRcwUdkN3dEfOLh6lx4i9zs9YFJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfEISsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbfEISsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:48:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86D96217F9;
        Thu,  9 May 2019 18:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427701;
        bh=VHEcK7OOP1jtW+G99RTlVZzKoB+P1+WnmyH6ylK7zTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0NQtxmiBmNoT/JFt0A1lAvl7aK8xIg+k7E1jDZktiwZ4TNST537Pbn/WNO6prucz
         RSb0tLi2NYrzJBN1YZrqV5vwg8lBdvFDE2ZWb27jKX8ZbQVchkXkCgUIwjrgppxCiq
         FmQRbHATQMLVjjMIwvlrkddXVHXFk4htmZXhZ4e4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        "Tobin C. Harding" <tobin@kernel.org>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 37/66] slab: fix a crash by reading /proc/slab_allocators
Date:   Thu,  9 May 2019 20:42:12 +0200
Message-Id: <20190509181305.905790050@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181301.719249738@linuxfoundation.org>
References: <20190509181301.719249738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index b8e0ec74330f3..018d32496e8d1 100644
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
2.20.1



