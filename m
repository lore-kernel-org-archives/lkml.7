Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A7CC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFE72186A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558552895;
	bh=q45bGC7eS5ClWtkYK6X1HWzi/ijAvwG+ED5Bqf85fyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E5YoQg5gGcjp9Wt+lkCQRXY5VYnTMGRdz4gMxekzOmlG9r/oR2qbqO989lZ5439OW
	 zb1DSwroI8TS1pVWQNDHPeXTvU2736/7SBBkXE2xj+SP4ieyBQqXEeoGR3E6lynAYT
	 yZCfUaN+nfNTk1/peUebLNp5KuVt+uFlKbRNSbS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfEVTVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729924AbfEVTVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:21:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A82D2173C;
        Wed, 22 May 2019 19:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558552889;
        bh=q45bGC7eS5ClWtkYK6X1HWzi/ijAvwG+ED5Bqf85fyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MddxJICHIcH3ebIwRxE8h4ySOdzqcmjQco6MgsZf4J+MJgZZzWqHlwWsyEsIrGwXf
         EGAbcmm8TOMRF37GBvyWBfttl/Aj2SuDz+KZxKo+qTSxGKZFu55psD3GHMFqMXIaN/
         FEaBhI0wAFra+BkrQTJiVUd2n5xSthaMhUezKYv4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
        syzbot+83f2d54ec6b7e417e13f@syzkaller.appspotmail.com,
        syzbot+050927a651272b145a5d@syzkaller.appspotmail.com,
        syzbot+979ffc89b87309b1b94b@syzkaller.appspotmail.com,
        syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 010/375] batman-adv: mcast: fix multicast tt/tvlv worker locking
Date:   Wed, 22 May 2019 15:15:10 -0400
Message-Id: <20190522192115.22666-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192115.22666-1-sashal@kernel.org>
References: <20190522192115.22666-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Lüssing <linus.luessing@c0d3.blue>

[ Upstream commit a3c7cd0cdf1107f891aff847ad481e34df727055 ]

Syzbot has reported some issues with the locking assumptions made for
the multicast tt/tvlv worker: It was able to trigger the WARN_ON() in
batadv_mcast_mla_tt_retract() and batadv_mcast_mla_tt_add().
While hard/not reproduceable for us so far it seems that the
delayed_work_pending() we use might not be quite safe from reordering.

Therefore this patch adds an explicit, new spinlock to protect the
update of the mla_list and flags in bat_priv and then removes the
WARN_ON(delayed_work_pending()).

Reported-by: syzbot+83f2d54ec6b7e417e13f@syzkaller.appspotmail.com
Reported-by: syzbot+050927a651272b145a5d@syzkaller.appspotmail.com
Reported-by: syzbot+979ffc89b87309b1b94b@syzkaller.appspotmail.com
Reported-by: syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com
Fixes: cbebd363b2e9 ("batman-adv: Use own timer for multicast TT and TVLV updates")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/main.c      |  1 +
 net/batman-adv/multicast.c | 11 +++--------
 net/batman-adv/types.h     |  5 +++++
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 75750870cf048..f8725786b5961 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -161,6 +161,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	spin_lock_init(&bat_priv->tt.commit_lock);
 	spin_lock_init(&bat_priv->gw.list_lock);
 #ifdef CONFIG_BATMAN_ADV_MCAST
+	spin_lock_init(&bat_priv->mcast.mla_lock);
 	spin_lock_init(&bat_priv->mcast.want_lists_lock);
 #endif
 	spin_lock_init(&bat_priv->tvlv.container_list_lock);
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index f91b1b6265cfe..1b985ab89c087 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -325,8 +325,6 @@ static void batadv_mcast_mla_list_free(struct hlist_head *mcast_list)
  * translation table except the ones listed in the given mcast_list.
  *
  * If mcast_list is NULL then all are retracted.
- *
- * Do not call outside of the mcast worker! (or cancel mcast worker first)
  */
 static void batadv_mcast_mla_tt_retract(struct batadv_priv *bat_priv,
 					struct hlist_head *mcast_list)
@@ -334,8 +332,6 @@ static void batadv_mcast_mla_tt_retract(struct batadv_priv *bat_priv,
 	struct batadv_hw_addr *mcast_entry;
 	struct hlist_node *tmp;
 
-	WARN_ON(delayed_work_pending(&bat_priv->mcast.work));
-
 	hlist_for_each_entry_safe(mcast_entry, tmp, &bat_priv->mcast.mla_list,
 				  list) {
 		if (mcast_list &&
@@ -359,8 +355,6 @@ static void batadv_mcast_mla_tt_retract(struct batadv_priv *bat_priv,
  *
  * Adds multicast listener announcements from the given mcast_list to the
  * translation table if they have not been added yet.
- *
- * Do not call outside of the mcast worker! (or cancel mcast worker first)
  */
 static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 				    struct hlist_head *mcast_list)
@@ -368,8 +362,6 @@ static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 	struct batadv_hw_addr *mcast_entry;
 	struct hlist_node *tmp;
 
-	WARN_ON(delayed_work_pending(&bat_priv->mcast.work));
-
 	if (!mcast_list)
 		return;
 
@@ -658,7 +650,10 @@ static void batadv_mcast_mla_update(struct work_struct *work)
 	priv_mcast = container_of(delayed_work, struct batadv_priv_mcast, work);
 	bat_priv = container_of(priv_mcast, struct batadv_priv, mcast);
 
+	spin_lock(&bat_priv->mcast.mla_lock);
 	__batadv_mcast_mla_update(bat_priv);
+	spin_unlock(&bat_priv->mcast.mla_lock);
+
 	batadv_mcast_start_timer(bat_priv);
 }
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a21b34ed6548f..ed0f6a519de55 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1223,6 +1223,11 @@ struct batadv_priv_mcast {
 	/** @bridged: whether the soft interface has a bridge on top */
 	unsigned char bridged:1;
 
+	/**
+	 * @mla_lock: a lock protecting mla_list and mla_flags
+	 */
+	spinlock_t mla_lock;
+
 	/**
 	 * @num_want_all_unsnoopables: number of nodes wanting unsnoopable IP
 	 *  traffic
-- 
2.20.1

