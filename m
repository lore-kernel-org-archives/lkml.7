Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1F3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1497320C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367602;
	bh=bHze5SsU9HdUuDefwMEGfnZn9b4BewsDq9Er7jUDf0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HMuiWlMtJ48ePZNuBWQP/Z3+CN4Iq/BWJ9RDX0qrN4bsJlJPp0rMG/gW78QW0rnwy
	 mmWrLFQy2kTIJ0Sr3N/EHTLCKBEmuzVCeMfoTxRnmkv11IErM4p+aFiQaKuyYktoYT
	 ZNmoYXyWGeI7rFb9qglx/sVa9eAYy+Nlfatu2Q/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389054AbfB1P0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:26:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732707AbfB1PLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD2CD218E2;
        Thu, 28 Feb 2019 15:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366699;
        bh=bHze5SsU9HdUuDefwMEGfnZn9b4BewsDq9Er7jUDf0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uBT0GBFVJIau4g7ZKT0MtYMzQ4J4a5o7msvMZ0qxnkYr4sQBgHT/GVoxHpjGqD2CT
         kCDf6VbY2GlQjZnfs0M51DbBtB3KMhBWv8LNsW11/6mBX0JvDenNCKQSGNDsSYBmN5
         WNiCGgps29hZzutqTzai9nOC9VA5xmHDHCzE9G64=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>, Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 18/64] batman-adv: release station info tidstats
Date:   Thu, 28 Feb 2019 10:10:19 -0500
Message-Id: <20190228151105.11277-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 7d652669b61d702c6e62a39579d17f6881670ab6 ]

With the addition of TXQ stats in the per-tid statistics the struct
station_info grew significantly. This resulted in stack size warnings
due to the structure itself being above the limit for the warnings.

To work around this, the TID array was allocated dynamically. Also a
function to free this content was introduced with commit 7ea3e110f2f8
("cfg80211: release station info tidstats where needed") but the necessary
changes were not provided for batman-adv's B.A.T.M.A.N. V implementation.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Fixes: 8689c051a201 ("cfg80211: dynamically allocate per-tid stats for station info")
[sven@narfation.org: add commit message]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/bat_v_elp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index e8090f099eb80..ef0dec20c7d87 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -104,6 +104,9 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 
 		ret = cfg80211_get_station(real_netdev, neigh->addr, &sinfo);
 
+		/* free the TID stats immediately */
+		cfg80211_sinfo_release_content(&sinfo);
+
 		dev_put(real_netdev);
 		if (ret == -ENOENT) {
 			/* Node is not associated anymore! It would be
-- 
2.19.1

