Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D12C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088F6214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142705;
	bh=pfDF5o5Sf/FZB9G8qxf3rgn8Br81z+BJhC63kU1YSUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o8w3JVkMdYl7XO0mS6bxYm82YLK3bPchGk5GFtNzaEwBO+jP3zKsSmYNVVVzf0OFW
	 9v2h5PXy2YsD6hmbISdZTSTBJ3rh77JXrwxTYiHfZQSrLU1GF+LzThMQioDulywxtX
	 lNbfKfpEG16YDqG8f0729yq8q3jXRLZ3yP09+hZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbfKSFvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:51:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731821AbfKSFvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:51:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21317214D9;
        Tue, 19 Nov 2019 05:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142699;
        bh=pfDF5o5Sf/FZB9G8qxf3rgn8Br81z+BJhC63kU1YSUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2MM8K+MEbxwPIK3Hn8EaifFOihgiDbRmkhPHHdxK2XJmyzTjGbuPYrH/rzuF4tp2l
         y6V9OJ48T638xv5gXsRvjUBsLJ+KsMwQd5MhSsrmwa2iEXrj9nh8B570Nr9t26TPWY
         9uevkNAiTv3tyZBT7IC/Uty0o2rv52+EFcrEenQ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 129/239] ath9k: Fix a locking bug in ath9k_add_interface()
Date:   Tue, 19 Nov 2019 06:18:49 +0100
Message-Id: <20191119051330.569269677@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 461cf036057477805a8a391e5fd0f5264a5e56a8 ]

We tried to revert commit d9c52fd17cb4 ("ath9k: fix tx99 with monitor
mode interface") but accidentally missed part of the locking change.

The lock has to be held earlier so that we're holding it when we do
"sc->tx99_vif = vif;" and also there in the current code there is a
stray unlock before we have taken the lock.

Fixes: 6df0580be8bc ("ath9k: add back support for using active monitor interfaces for tx99")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 3589f1f3e744d..72ad84fde5c18 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -1250,6 +1250,7 @@ static int ath9k_add_interface(struct ieee80211_hw *hw,
 	struct ath_vif *avp = (void *)vif->drv_priv;
 	struct ath_node *an = &avp->mcast_node;
 
+	mutex_lock(&sc->mutex);
 	if (IS_ENABLED(CONFIG_ATH9K_TX99)) {
 		if (sc->cur_chan->nvifs >= 1) {
 			mutex_unlock(&sc->mutex);
@@ -1258,8 +1259,6 @@ static int ath9k_add_interface(struct ieee80211_hw *hw,
 		sc->tx99_vif = vif;
 	}
 
-	mutex_lock(&sc->mutex);
-
 	ath_dbg(common, CONFIG, "Attach a VIF of type: %d\n", vif->type);
 	sc->cur_chan->nvifs++;
 
-- 
2.20.1



