Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1282C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B8821773
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430113;
	bh=vYx/zHP8wWU9g1UIxBmoe+KnVEnCZqWTIOJc41rRGsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ka7evbHyAEuFwU/oce7NrRqm7Z3YpLAY4yM3+pwqA/ysv1t1puk1On+DUhZr+2iOK
	 pFMy9Hc++5YnSM5nVI5wYdSj1JsK78tYeKLb2I5RuH2fM6G09JqeiUYTf+eqRzKXZF
	 +C+tu5ifTciC2tux2K8YvL/+uI6DQqNs+rcg/72M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391039AbfG2TzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403890AbfG2TzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:55:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46E952054F;
        Mon, 29 Jul 2019 19:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564430107;
        bh=vYx/zHP8wWU9g1UIxBmoe+KnVEnCZqWTIOJc41rRGsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnTPb4AjXNFB1atxPkhyren0de8uUY5M7C5OzZK6Eife3lxasvT3F4XHKO7wNmhTH
         kqXJSAHRJziPmm+FWxmDk8CvhQClgWxnEOvuiWlkZPgTqVubPevyza6k1YOnFBdz4K
         57kJQp9pTU0n9JNu4lJo+t+xfCzJfR2G4MY3PTIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Roman Gushchin <guro@fb.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 159/215] proc: use down_read_killable mmap_sem for /proc/pid/clear_refs
Date:   Mon, 29 Jul 2019 21:22:35 +0200
Message-Id: <20190729190807.416089191@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c46038017fbdcac627b670c9d4176f1d0c2f5fa3 ]

Do not remain stuck forever if something goes wrong.  Using a killable
lock permits cleanup of stuck tasks and simplifies investigation.

Replace the only unkillable mmap_sem lock in clear_refs_write().

Link: http://lkml.kernel.org/r/156007493826.3335.5424884725467456239.stgit@buzz
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reviewed-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Koutný <mkoutny@suse.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/task_mmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 1d9c63cd8a3c..abcd9513efff 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1136,7 +1136,10 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 			goto out_mm;
 		}
 
-		down_read(&mm->mmap_sem);
+		if (down_read_killable(&mm->mmap_sem)) {
+			count = -EINTR;
+			goto out_mm;
+		}
 		tlb_gather_mmu(&tlb, mm, 0, -1);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			for (vma = mm->mmap; vma; vma = vma->vm_next) {
-- 
2.20.1



