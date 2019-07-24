Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030E2C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F1222AEC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997659;
	bh=5D3yfFn+/3+y/J3ySAk8ok97wNIlyjzXzWvzYMdaAGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xTePMUWUEnNywmrP6xQhOZTYg90JiRl/Hrqp9Cr9sY91CcwIanBkRqON3nSazGxNC
	 dK3TaauJMx4g5Qhab9PrOt0T+85nIQGi/xN0tUib3yIu2m08zl+M9FKU4g8mpi1PTw
	 ufiTB+RIlALTIEsiNM7Jfc0oEjEn28rRNRdtoYAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391276AbfGXTri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403765AbfGXTre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:47:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E283217D4;
        Wed, 24 Jul 2019 19:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997653;
        bh=5D3yfFn+/3+y/J3ySAk8ok97wNIlyjzXzWvzYMdaAGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5CuvpAX7z8QN79BzLOXc8oWrYFbSrG/tN0uwSNjIut/j/uvpZIPODl8zi3CGKlvE
         dAU/Z2fkRMvheHmpkNVqwV5le/ZMynVIkLjQe8UuQKGD+8XxLJ+1RqiazOeddj5LWw
         UURRjtwGgbZo5Cgf8a/Jvn1m63Wmdt/rN8AdzJFg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 098/371] blkcg, writeback: dead memcgs shouldnt contribute to writeback ownership arbitration
Date:   Wed, 24 Jul 2019 21:17:30 +0200
Message-Id: <20190724191732.210366246@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6631142229005e1b1c311a09efe9fb3cfdac8559 ]

wbc_account_io() collects information on cgroup ownership of writeback
pages to determine which cgroup should own the inode.  Pages can stay
associated with dead memcgs but we want to avoid attributing IOs to
dead blkcgs as much as possible as the association is likely to be
stale.  However, currently, pages associated with dead memcgs
contribute to the accounting delaying and/or confusing the
arbitration.

Fix it by ignoring pages associated with dead memcgs.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fs-writeback.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index b16645b417d9..bd9474e82f38 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -714,6 +714,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
 void wbc_account_io(struct writeback_control *wbc, struct page *page,
 		    size_t bytes)
 {
+	struct cgroup_subsys_state *css;
 	int id;
 
 	/*
@@ -725,7 +726,12 @@ void wbc_account_io(struct writeback_control *wbc, struct page *page,
 	if (!wbc->wb)
 		return;
 
-	id = mem_cgroup_css_from_page(page)->id;
+	css = mem_cgroup_css_from_page(page);
+	/* dead cgroups shouldn't contribute to inode ownership arbitration */
+	if (!(css->flags & CSS_ONLINE))
+		return;
+
+	id = css->id;
 
 	if (id == wbc->wb_id) {
 		wbc->wb_bytes += bytes;
-- 
2.20.1



