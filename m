Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA626C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776F42072D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421778;
	bh=uzUz+CrFI7pvV8ks0f+j4NUBeLRuSb5YZL/KBMxG/yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pGFAWIPKehI6O7u4bGyPIJd77PEieh6GJXWZ42A0fpC4dBA88wN4UuXJLOXvsrLYY
	 eWDyx2OTsiEtulqt2ZwZ1dbbQ8V0RhXRdl1CRxgW4oMwHopSo0UcYda6NK25fQ7h9X
	 ppIxaWhcgL5pjVae/v571/RCfJMB9x7idMKozLnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfKVKmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:42:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbfKVKmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:42:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40AC720707;
        Fri, 22 Nov 2019 10:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419338;
        bh=uzUz+CrFI7pvV8ks0f+j4NUBeLRuSb5YZL/KBMxG/yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CrXGfD2kmVdTUyC1khpcUiZD4CelhnZrM8APuZTqk6jAOQo5wJ+WaJtG33K+LXxm5
         94bOdjWAayBC48y3POWP6iI9A6W2EsAWsWH4Nv04vzqvQGHVRYQWKxD6W0ub0NstP+
         349ajYaVXM3efiYrHl6W50QR7egd+sjJxMpzKvWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 079/222] ath9k: Fix a locking bug in ath9k_add_interface()
Date:   Fri, 22 Nov 2019 11:26:59 +0100
Message-Id: <20191122100909.124357643@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
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
index f6151a00041d6..abc997427bae5 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -1249,6 +1249,7 @@ static int ath9k_add_interface(struct ieee80211_hw *hw,
 	struct ath_vif *avp = (void *)vif->drv_priv;
 	struct ath_node *an = &avp->mcast_node;
 
+	mutex_lock(&sc->mutex);
 	if (IS_ENABLED(CONFIG_ATH9K_TX99)) {
 		if (sc->cur_chan->nvifs >= 1) {
 			mutex_unlock(&sc->mutex);
@@ -1257,8 +1258,6 @@ static int ath9k_add_interface(struct ieee80211_hw *hw,
 		sc->tx99_vif = vif;
 	}
 
-	mutex_lock(&sc->mutex);
-
 	ath_dbg(common, CONFIG, "Attach a VIF of type: %d\n", vif->type);
 	sc->cur_chan->nvifs++;
 
-- 
2.20.1



