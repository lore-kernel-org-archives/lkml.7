Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74031C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5AB22CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620540;
	bh=1dniF9NpLvVqob9pU5F/mchFpYLmem9i+BXrwjoJXu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MXbB/3V7SG3zK6Pev+BG0DCy6JUjJvhTUgDWJf860iHEfX2bK1+FkfnoKLWicKKEa
	 3mpzebieXWAbUXXOvv2pLBwIszACEjwjt3m3yrD2mntw3q68+AaFlDD0bjo9bjjmPc
	 QPJDjWm+kw5FN+oQOmKqPuvmMbN7yJEhrsUpstjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389874AbfIDSI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:08:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388327AbfIDSIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:08:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 938C52087E;
        Wed,  4 Sep 2019 18:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620534;
        bh=1dniF9NpLvVqob9pU5F/mchFpYLmem9i+BXrwjoJXu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zEdzxxWmg0Kuy1gsJpXLqjw21CCRi57uhkqLZCQxTWvoQd08T7vo6hLboaJYsPkae
         QDxM0Qfu4kE9MOswHu4wlJEfsWAI2LaQN5O5tSLJB1RvEu++maSlGRVTiQQp5LbMQN
         of9woGZ9Hbff90CDFQAMv9TlND7UTtdyuiXj7Q3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 87/93] NFS: Clean up list moves of struct nfs_page
Date:   Wed,  4 Sep 2019 19:54:29 +0200
Message-Id: <20190904175310.641035897@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 078b5fd92c4913dd367361db6c28568386077c89 ]

In several places we're just moving the struct nfs_page from one list to
another by first removing from the existing list, then adding to the new
one.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/direct.c          |  3 +--
 fs/nfs/pagelist.c        | 12 ++++--------
 include/linux/nfs_page.h | 10 ++++++++++
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 33824a0a57bfe..1377ee20ecf91 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -664,8 +664,7 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 
 	list_for_each_entry_safe(req, tmp, &reqs, wb_list) {
 		if (!nfs_pageio_add_request(&desc, req)) {
-			nfs_list_remove_request(req);
-			nfs_list_add_request(req, &failed);
+			nfs_list_move_request(req, &failed);
 			spin_lock(&cinfo.inode->i_lock);
 			dreq->flags = 0;
 			if (desc.pg_error < 0)
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 0ec6bce3dd692..d40bf560f3ca7 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -769,8 +769,7 @@ int nfs_generic_pgio(struct nfs_pageio_descriptor *desc,
 	pageused = 0;
 	while (!list_empty(head)) {
 		req = nfs_list_entry(head->next);
-		nfs_list_remove_request(req);
-		nfs_list_add_request(req, &hdr->pages);
+		nfs_list_move_request(req, &hdr->pages);
 
 		if (!last_page || last_page != req->wb_page) {
 			pageused++;
@@ -962,8 +961,7 @@ static int nfs_pageio_do_add_request(struct nfs_pageio_descriptor *desc,
 	}
 	if (!nfs_can_coalesce_requests(prev, req, desc))
 		return 0;
-	nfs_list_remove_request(req);
-	nfs_list_add_request(req, &mirror->pg_list);
+	nfs_list_move_request(req, &mirror->pg_list);
 	mirror->pg_count += req->wb_bytes;
 	return 1;
 }
@@ -995,8 +993,7 @@ nfs_pageio_cleanup_request(struct nfs_pageio_descriptor *desc,
 {
 	LIST_HEAD(head);
 
-	nfs_list_remove_request(req);
-	nfs_list_add_request(req, &head);
+	nfs_list_move_request(req, &head);
 	desc->pg_completion_ops->error_cleanup(&head);
 }
 
@@ -1242,9 +1239,8 @@ int nfs_pageio_resend(struct nfs_pageio_descriptor *desc,
 	while (!list_empty(&hdr->pages)) {
 		struct nfs_page *req = nfs_list_entry(hdr->pages.next);
 
-		nfs_list_remove_request(req);
 		if (!nfs_pageio_add_request(desc, req))
-			nfs_list_add_request(req, &failed);
+			nfs_list_move_request(req, &failed);
 	}
 	nfs_pageio_complete(desc);
 	if (!list_empty(&failed)) {
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index e27572d30d977..ad69430fd0eb5 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -164,6 +164,16 @@ nfs_list_add_request(struct nfs_page *req, struct list_head *head)
 	list_add_tail(&req->wb_list, head);
 }
 
+/**
+ * nfs_list_move_request - Move a request to a new list
+ * @req: request
+ * @head: head of list into which to insert the request.
+ */
+static inline void
+nfs_list_move_request(struct nfs_page *req, struct list_head *head)
+{
+	list_move_tail(&req->wb_list, head);
+}
 
 /**
  * nfs_list_remove_request - Remove a request from its wb_list
-- 
2.20.1



