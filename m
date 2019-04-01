Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49078C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0818920830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140769;
	bh=oMKOc8WfuSK+Prb2ThS+Q9O5fIQSDkYPPvL/3b5Yja8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rThXekVDBf3lEk/zEmAj/Tq/VOO3GhsNQ1UJKhqpWr4/6YFmgm8LcHj+zA0KG9oWL
	 +jtEOpDCMEqdprPVgQ6yr177Me/dwl4RvTvpy0jIUxGs4MtjqfVqKqsvNRCjsI8v6O
	 5FRE6QySaK7H8J0JBuRyVWXVu6tu0/51YDnA9pqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387824AbfDARqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387471AbfDARdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:33:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 931D2208E4;
        Mon,  1 Apr 2019 17:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140023;
        bh=oMKOc8WfuSK+Prb2ThS+Q9O5fIQSDkYPPvL/3b5Yja8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2dh6QfY07WARIROaDdWUgidZ6n/HHF3PZ7xpuZn8xa52W9MWQNXvo3c11GHMt5Yq
         lba4vv/wn6t92TaApwfjZRNZ/YQo2hsuZxR7E6BfInTRHXZp+AzWJMgmJHDXtJ3QtG
         stpsFCAufFjmwur8XY+vFI0FQplB4Qw+Cmrtawy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 046/131] android: unconditionally remove callbacks in sync_fence_free()
Date:   Mon,  1 Apr 2019 19:01:56 +0200
Message-Id: <20190401170056.159747084@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 699f685569434510d944e419f4048c4e3ba8d631 ]

Using fence->status to determine whether or not there are callbacks
remaining on the sync_fence is racy since fence->status may have been
decremented to 0 on another CPU before fence_check_cb_func() has
completed.  By unconditionally calling fence_remove_callback() for each
fence in the sync_fence, we guarantee that each callback has either
completed (since fence_remove_callback() grabs the fence lock) or been
removed.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/android/sync.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/android/sync.c b/drivers/staging/android/sync.c
index f83e00c78051..50a9945da27e 100644
--- a/drivers/staging/android/sync.c
+++ b/drivers/staging/android/sync.c
@@ -519,12 +519,10 @@ static const struct fence_ops android_fence_ops = {
 static void sync_fence_free(struct kref *kref)
 {
 	struct sync_fence *fence = container_of(kref, struct sync_fence, kref);
-	int i, status = atomic_read(&fence->status);
+	int i;
 
 	for (i = 0; i < fence->num_fences; ++i) {
-		if (status)
-			fence_remove_callback(fence->cbs[i].sync_pt,
-					      &fence->cbs[i].cb);
+		fence_remove_callback(fence->cbs[i].sync_pt, &fence->cbs[i].cb);
 		fence_put(fence->cbs[i].sync_pt);
 	}
 
-- 
2.19.1



