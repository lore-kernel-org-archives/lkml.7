Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F72AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8B0218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366541;
	bh=bHze5SsU9HdUuDefwMEGfnZn9b4BewsDq9Er7jUDf0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aEUPhmVR2KCeLT1blvhy1zQgjRoF3HcJrk7J0c7m3RGg0BqKt9mI6QKDH0hF5ELde
	 hrk81yhE78EO/2LqyaVUT+DgwH6we9sdc9GOmz5irHsFfqp84/7fS9oNAdgDyuC0VE
	 tQY7HJcmEQO/+LDPj2CNgC/ClU/vxyGEFQu4O6p8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbfB1PI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:08:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:41236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733176AbfB1PIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FDA12184A;
        Thu, 28 Feb 2019 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366530;
        bh=bHze5SsU9HdUuDefwMEGfnZn9b4BewsDq9Er7jUDf0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jYyxihQZ2C9m0Zt2zPP6AYjKOViKhzTrpC5bHc6xwMU2CAFJ1a4sc9zhXScsCqalC
         nQlSatLvqSA9dj6NYom3+7UwXUbykAr2gtNho77wCZcmXsy/7JLVXM4VacnCWb1Cb0
         2f3+OiU2XQ1d3bUM7kRUbafcqCA1rGmVH5JPvuvM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>, Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 23/81] batman-adv: release station info tidstats
Date:   Thu, 28 Feb 2019 10:07:15 -0500
Message-Id: <20190228150813.10256-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
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

