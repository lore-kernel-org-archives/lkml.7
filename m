Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9F7C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB586214AE
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfD0PXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:23:33 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34694 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727508AbfD0PX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:23:27 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3B-0000zK-Je; Sat, 27 Apr 2019 16:15:37 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2i-0004R1-7N; Sat, 27 Apr 2019 16:15:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        syzbot+c1e36d30ee3416289cc0@syzkaller.appspotmail.com,
        "Miklos Szeredi" <mszeredi@redhat.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.16179724@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 043/202] fuse: handle zero sized retrieve correctly
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit 97e1532ef81acb31c30f9e75bf00306c33a77812 upstream.

Dereferencing req->page_descs[0] will Oops if req->max_pages is zero.

Reported-by: syzbot+c1e36d30ee3416289cc0@syzkaller.appspotmail.com
Tested-by: syzbot+c1e36d30ee3416289cc0@syzkaller.appspotmail.com
Fixes: b2430d7567a3 ("fuse: add per-page descriptor <offset, length> to fuse_req")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1652,7 +1652,6 @@ static int fuse_retrieve(struct fuse_con
 	req->in.h.nodeid = outarg->nodeid;
 	req->in.numargs = 2;
 	req->in.argpages = 1;
-	req->page_descs[0].offset = offset;
 	req->end = fuse_retrieve_end;
 
 	index = outarg->offset >> PAGE_CACHE_SHIFT;
@@ -1667,6 +1666,7 @@ static int fuse_retrieve(struct fuse_con
 
 		this_num = min_t(unsigned, num, PAGE_CACHE_SIZE - offset);
 		req->pages[req->num_pages] = page;
+		req->page_descs[req->num_pages].offset = offset;
 		req->page_descs[req->num_pages].length = this_num;
 		req->num_pages++;
 

