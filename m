Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5BBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C34A20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140415;
	bh=bEfHUW01l4PuGfoZLFQnzokEjN9dBSRWxfh/NBHQHZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o9GoB940UmkO5C3/2kzey36tk6u2AwAdlKAIpNrZegazvWdjeiJokqab3uEe7rItL
	 F0NJY2tGL6t9VX09lDw80ZvuObuCgIWwCW7YqLManyJ4zi+Hfmi7vvIMnT21tLYVWm
	 X0jI/QqZwE59niEYGe5yVE94dZOBr5SfNTS9SXrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388444AbfDARjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730909AbfDARjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:39:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2148B20830;
        Mon,  1 Apr 2019 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140362;
        bh=bEfHUW01l4PuGfoZLFQnzokEjN9dBSRWxfh/NBHQHZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WrOJB7C7Q71vXLvKnSQ4v0iNawkQo+6A12ATGsboJvk1ozav3hZmS1/BfICxXTYPb
         1gb97MjRPY0cGd4++Y8Vlwsrxt4D3d2ZlCPbkcSaPE3WtDxENtb14UMWHFX38PEeU9
         5pEIujjGHGCg/p7W/HFxlSvIXSOj4JKD6U4yryHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 13/50] android: unconditionally remove callbacks in sync_fence_free()
Date:   Mon,  1 Apr 2019 19:02:56 +0200
Message-Id: <20190401170042.635903004@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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



