Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D3EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F1D204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574404127;
	bh=Iv17XI1kZ8i57PKzy5lnBJCIm6Eq4Cz/eJFS8PDWT7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NcD2vs3y+ALn8uPyW4GLyZiSXNYatb+f4yNPsURJaqCB6cP2LyTICcfW/Gx5jHwUf
	 7zKKxAQTyyenSHqpHarVAyxIu5epvJnZjnggLoctE7aIwO8gJO6HuUVaxBYvzmYrUd
	 YYMrHVn5dkGNOlJKo4fgYI/NF8wYN2kr+IkEDcHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfKVG2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:28:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:54520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbfKVFuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:50:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBA2920718;
        Fri, 22 Nov 2019 05:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401807;
        bh=Iv17XI1kZ8i57PKzy5lnBJCIm6Eq4Cz/eJFS8PDWT7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxmPgbxBRBWp5A0/CqqS69CwtMDiYZmKYT3RCL9H7VHEIMam+mHqrzGVDxgxYqGi5
         ffsYt+AAFV37B5VbdIPi2ZpwKvs9lskmD+v6LL1x3P5AtGkuqiCQT2AJXyn0ZiYDvr
         SjHaBAaHXvLxD39EnnfXcFS57XhIHZWwh8FRu0CM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 052/219] nvme: fix kernel paging oops
Date:   Fri, 22 Nov 2019 00:46:24 -0500
Message-Id: <20191122054911.1750-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 092ff0520070fad8407b196f3bb6156ce77a6f98 ]

free the controller discard_page correctly.

Fixes: cb5b7262b011 ("nvme: provide fallback for discard alloc failure")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ced70d37e0f9b..e9060317c1a7b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3569,7 +3569,7 @@ static void nvme_free_ctrl(struct device *dev)
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 	kfree(ctrl->effects);
 	nvme_mpath_uninit(ctrl);
-	kfree(ctrl->discard_page);
+	__free_page(ctrl->discard_page);
 
 	if (subsys) {
 		mutex_lock(&subsys->lock);
-- 
2.20.1

