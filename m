Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2CCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380B2205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412956;
	bh=FuExrZfuUkvwQoJC1hUNT13gDORnJ2YSmCiJ7be5exI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lKQ8mFr2DFJL0zBrFvLh7v1vWnIqgJfmgtC415TLED01XWtxGUf2VRzsgLoONTY8L
	 cj5KMCw/ZEmDWXRle2vtny8WcTXo3oa/WvfMzM+88SDjFElekAnPMnw2KhOL++MS7B
	 zJoJ+m034KGsmZUo6A5HxClPKFxOeKsMsWCpB1gE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfCLRtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbfCLROv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:51 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A35D92186A;
        Tue, 12 Mar 2019 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410890;
        bh=FuExrZfuUkvwQoJC1hUNT13gDORnJ2YSmCiJ7be5exI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OwNQVTntrtexzhXv+ZJamzfH228Rlm21W4d/7WlQaM63AYenrkdcR2UBVvyDzNSNV
         4KrdYmQmi1v1QfdJs6LrI18RXH6h/xpssUmBflnkPqHw2X38AprORPiaYf3mmizLvD
         k3rQatSssnxoWpIq0kS0nyjVdnQwmAOLdubQ4+Qs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 079/149] batman-adv: release station info tidstats
Date:   Tue, 12 Mar 2019 10:08:17 -0700
Message-Id: <20190312170356.290341827@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index e8090f099eb8..ef0dec20c7d8 100644
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



