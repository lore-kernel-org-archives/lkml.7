Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83A0C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B28622AEC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996270;
	bh=U0o0C1aPAvOjwdQ7vLkMsrXoC/6GvrrOfuqwkwg7ouQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nUywB1/7h7BUjeNF7UCSmEz840UlBi2aTzOCi2xiOiBdphxJjaLMvJD6mX7lgf6yx
	 x1ZAC9TzDU7jWs6kZj9zTYhKr7yDOIYsKb6KMl2hM+yMNYq8AArKqBzLngi0gTKFTG
	 tcfKgePnfaBm/893TCuF7KQj6x8Dv6dDuNqGuks0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfGXTY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbfGXTYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:24:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3625229F3;
        Wed, 24 Jul 2019 19:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996264;
        bh=U0o0C1aPAvOjwdQ7vLkMsrXoC/6GvrrOfuqwkwg7ouQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVNxH4ZkG+pTtRM2MBolC+VQ+IR4Fm2mK5YqKvYae57afcvU0mskh1BEjSCukh+f8
         FuXCYKQA45oWNy2msaFhqbwYO83HPt9jMQNm9AQvMnsUIXBkQRyJuEqikJMlsmktLz
         cDV7y6idriL5xjaNV7NQ4e/kDsItPzW7kOrd/eeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Surabhi Vishnoi <svishnoi@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 009/413] ath10k: Fix the wrong value of enums for wmi tlv stats id
Date:   Wed, 24 Jul 2019 21:15:00 +0200
Message-Id: <20190724191735.952245370@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9280f4fc06f44d0b4dc9e831f72d97b3d7cd35d3 ]

The enum value for WMI_TLV_STAT_PDEV, WMI_TLV_STAT_VDEV
and WMI_TLV_STAT_PEER is wrong, due to which the vdev stats
are not received from firmware in wmi_update_stats event.

Fix the enum values for above stats to receive all stats
from firmware in WMI_TLV_UPDATE_STATS_EVENTID.

Tested HW: WCN3990
Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1

Fixes: f40a307eb92c ("ath10k: Fill rx duration for each peer in fw_stats for WCN3990)
Signed-off-by: Surabhi Vishnoi <svishnoi@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/wmi.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index e1c40bb69932..12f57f9adbba 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -4535,9 +4535,10 @@ enum wmi_10_4_stats_id {
 };
 
 enum wmi_tlv_stats_id {
-	WMI_TLV_STAT_PDEV	= BIT(0),
-	WMI_TLV_STAT_VDEV	= BIT(1),
-	WMI_TLV_STAT_PEER	= BIT(2),
+	WMI_TLV_STAT_PEER	= BIT(0),
+	WMI_TLV_STAT_AP		= BIT(1),
+	WMI_TLV_STAT_PDEV	= BIT(2),
+	WMI_TLV_STAT_VDEV	= BIT(3),
 	WMI_TLV_STAT_PEER_EXTD  = BIT(10),
 };
 
-- 
2.20.1



