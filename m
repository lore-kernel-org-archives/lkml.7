Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65904C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D57520C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563201100;
	bh=yNqL6Fwvy8VR+6wU/izz4NQcOTQLAiWdIbalRu3rH9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W/gVB3Ofu0laintpsesBN2PmhJIAtEmGvpbymTaJaZlw0x9mHoYi85RKzrPrX3jpw
	 9mLFWATTXBHp5RzKZLd1pTIW18VHdKsrKT1WFTDcqrWAON7srR6AQhCmbYMIzyD0fC
	 T6wA1FbqH73lxngjuZKaPEQD8r6c5mehiZRN0TVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403959AbfGOObi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403943AbfGOObf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:31:35 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D89A320868;
        Mon, 15 Jul 2019 14:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563201095;
        bh=yNqL6Fwvy8VR+6wU/izz4NQcOTQLAiWdIbalRu3rH9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CAIoq7W+eYhyg0r+ma9yCyUdUHv1ZQmgSeI3LgANMTCFT0FMaE2SX8XjPI+0U4Pgr
         9Gy6RxrWJLAk63Qzv2xyB3ecU1f2ZgdK0RAXuf9OxovfGYiYeZW4z40r464++P/t6g
         GJt0pNmj1+TxFWJ7Wt9Nb/RMOnWI0p9sggmXgjJY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 050/105] blkcg, writeback: dead memcgs shouldn't contribute to writeback ownership arbitration
Date:   Mon, 15 Jul 2019 10:27:44 -0400
Message-Id: <20190715142839.9896-50-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715142839.9896-1-sashal@kernel.org>
References: <20190715142839.9896-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

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
index 4d561ee08d05..9e8fde348d61 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -721,6 +721,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
 void wbc_account_io(struct writeback_control *wbc, struct page *page,
 		    size_t bytes)
 {
+	struct cgroup_subsys_state *css;
 	int id;
 
 	/*
@@ -732,7 +733,12 @@ void wbc_account_io(struct writeback_control *wbc, struct page *page,
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

