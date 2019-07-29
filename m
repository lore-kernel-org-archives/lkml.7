Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC309C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A862621773
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429423;
	bh=7IlkZw/2t+39Kdv3zI+iZeNRgsWP2mSgdijooRbHjyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QH8Ybx3a8Ld+owlSn4/1ZQxuLhHasXcI9ItV3OZ0iGHH8L59l3bxu1RT8rns/Ijog
	 0gjS9BZQY6Snh9bCI+2yOu8neKEVy0kunnHh4JwwWYcDr+5rYPiA3GKShE8za0oUND
	 bt1MB8bDstB/cXft2waA3rVfk0FQNZ6Qz8Lc/OL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389686AbfG2Tnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389146AbfG2Tng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:43:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E3CC20C01;
        Mon, 29 Jul 2019 19:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429415;
        bh=7IlkZw/2t+39Kdv3zI+iZeNRgsWP2mSgdijooRbHjyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7sarOmRUsCiMgfOgY6szA/aRvokh5q4x/mOZMI4j8bBHYu1RJNa/A1+oJD9y4l5q
         r4hVASvijt3JoXLDXUZTUkAvT4BVHa52fYI/kJ9VcDhL6LOLo2MaquPOIJSoiPT0SO
         C0eWNnbs6OV8zDf+OrS16SRGwSn0qLr493e6BSJI=
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
Subject: [PATCH 4.19 091/113] proc: use down_read_killable mmap_sem for /proc/pid/clear_refs
Date:   Mon, 29 Jul 2019 21:22:58 +0200
Message-Id: <20190729190717.223896566@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
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
index 74965e17ffd5..195fbbaf77d4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1131,7 +1131,10 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
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



