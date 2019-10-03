Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212C3C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD122133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbfJCPgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:36:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730005AbfJCPf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:35:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1FB519D369;
        Thu,  3 Oct 2019 15:35:59 +0000 (UTC)
Received: from cicero.redhat.com (unknown [10.33.36.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D74C960C18;
        Thu,  3 Oct 2019 15:35:55 +0000 (UTC)
From:   Andrew Price <anprice@redhat.com>
To:     cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+c2fdfd2b783754878fb6@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: Fix memory leak when gfs2meta's fs_context is freed
Date:   Thu,  3 Oct 2019 16:35:52 +0100
Message-Id: <20191003153552.2015-1-anprice@redhat.com>
In-Reply-To: <000000000000afc1b40593f68888@google.com>
References: <000000000000afc1b40593f68888@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 03 Oct 2019 15:35:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gfs2 and gfs2meta share an ->init_fs_context function which allocates an
args structure stored in fc->fs_private. gfs2 registers a ->free
function to free this memory when the fs_context is cleaned up, but
there was not one registered for gfs2meta, causing a leak.

Register a ->free function for gfs2meta. The existing gfs2_fc_free
function does what we need.

Reported-by: syzbot+c2fdfd2b783754878fb6@syzkaller.appspotmail.com
Signed-off-by: Andrew Price <anprice@redhat.com>
---
 fs/gfs2/ops_fstype.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 681b44682b0d..dc61af2c4d5e 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1600,6 +1600,7 @@ static int gfs2_meta_get_tree(struct fs_context *fc)
 }
 
 static const struct fs_context_operations gfs2_meta_context_ops = {
+	.free        = gfs2_fc_free,
 	.get_tree    = gfs2_meta_get_tree,
 };
 
-- 
2.21.0

