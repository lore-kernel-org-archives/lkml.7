Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AD1C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE03521823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfLFBfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:35:03 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:53825 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbfLFBfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:35:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Tk4jgLJ_1575596090;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tk4jgLJ_1575596090)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Dec 2019 09:34:57 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mtk.manpages@gmail.com, cl@linux.com, jhubbard@nvidia.com,
        mhocko@suse.com, cai@lca.pw, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] move_pages.2: not return ENOENT if the page are already on the target nodes
Date:   Fri,  6 Dec 2019 09:34:50 +0800
Message-Id: <1575596090-115377-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e78bbfa82624 ("mm: stop returning -ENOENT
from sys_move_pages() if nothing got migrated"), move_pages doesn't
return -ENOENT anymore if the pages are already on the target nodes, but
this change is never reflected in manpage.

Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Qian Cai <cai@lca.pw>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 man2/move_pages.2 | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/man2/move_pages.2 b/man2/move_pages.2
index 2d96468..2a2f3cd 100644
--- a/man2/move_pages.2
+++ b/man2/move_pages.2
@@ -192,9 +192,8 @@ was specified or an attempt was made to migrate pages of a kernel thread.
 One of the target nodes is not online.
 .TP
 .B ENOENT
-No pages were found that require moving.
-All pages are either already
-on the target node, not present, had an invalid address or could not be
+No pages were found.
+All pages are either not present, had an invalid address or could not be
 moved because they were mapped by multiple processes.
 .TP
 .B EPERM
-- 
1.8.3.1

