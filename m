Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B16C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FD0218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117247;
	bh=6aYBc2w1/p/lKmMwhtqT7+OW1UhQHIlUo0AzJqWVk2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hoNRO8tnAquBzIBE/XR/GK9xi0ppIep3P/qjqzS8C8uCLbjyqMRSbNV71kOsNsdXy
	 uJKj4czxXxVtujXiaarQ4OW3gBmWQ5eDJsvkgceIWJCNT8hp8/HHYGD/28NvKx/Epi
	 b9nBU7WSRkcEc+7nuiVjgcmQs+v/NQPXnsOSwTSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732210AbfDXOr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732190AbfDXOrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:47:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EE4E218FD;
        Wed, 24 Apr 2019 14:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117240;
        bh=6aYBc2w1/p/lKmMwhtqT7+OW1UhQHIlUo0AzJqWVk2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cA8EeI2dUVx6Z05mLExt5jlPt3Z+9U8dFKca/itMkYsvo8CVfs29RW71IIYks4KbJ
         deaUydlQuBaiWsl5drh5MqTvGO1edUfIjaAAEfCNdKVk7f7dyYEe7CAF0HxUkB/CMJ
         Q64XbiRnHMu+msHw6ZBlO8iKCyLkl5MDvJUJAa7M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 04/35] batman-adv: Reduce claim hash refcnt only for removed entry
Date:   Wed, 24 Apr 2019 10:46:38 -0400
Message-Id: <20190424144709.30215-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424144709.30215-1-sashal@kernel.org>
References: <20190424144709.30215-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit 4ba104f468bbfc27362c393815d03aa18fb7a20f ]

The batadv_hash_remove is a function which searches the hashtable for an
entry using a needle, a hashtable bucket selection function and a compare
function. It will lock the bucket list and delete an entry when the compare
function matches it with the needle. It returns the pointer to the
hlist_node which matches or NULL when no entry matches the needle.

The batadv_bla_del_claim is not itself protected in anyway to avoid that
any other function is modifying the hashtable between the search for the
entry and the call to batadv_hash_remove. It can therefore happen that the
entry either doesn't exist anymore or an entry was deleted which is not the
same object as the needle. In such an situation, the reference counter (for
the reference stored in the hashtable) must not be reduced for the needle.
Instead the reference counter of the actually removed entry has to be
reduced.

Otherwise the reference counter will underflow and the object might be
freed before all its references were dropped. The kref helpers reported
this problem as:

  refcount_t: underflow; use-after-free.

Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index c3c848f64fdd..c761c0c233e4 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -803,6 +803,8 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 				 const u8 *mac, const unsigned short vid)
 {
 	struct batadv_bla_claim search_claim, *claim;
+	struct batadv_bla_claim *claim_removed_entry;
+	struct hlist_node *claim_removed_node;
 
 	ether_addr_copy(search_claim.addr, mac);
 	search_claim.vid = vid;
@@ -813,10 +815,18 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 	batadv_dbg(BATADV_DBG_BLA, bat_priv, "%s(): %pM, vid %d\n", __func__,
 		   mac, batadv_print_vid(vid));
 
-	batadv_hash_remove(bat_priv->bla.claim_hash, batadv_compare_claim,
-			   batadv_choose_claim, claim);
-	batadv_claim_put(claim); /* reference from the hash is gone */
+	claim_removed_node = batadv_hash_remove(bat_priv->bla.claim_hash,
+						batadv_compare_claim,
+						batadv_choose_claim, claim);
+	if (!claim_removed_node)
+		goto free_claim;
 
+	/* reference from the hash is gone */
+	claim_removed_entry = hlist_entry(claim_removed_node,
+					  struct batadv_bla_claim, hash_entry);
+	batadv_claim_put(claim_removed_entry);
+
+free_claim:
 	/* don't need the reference from hash_find() anymore */
 	batadv_claim_put(claim);
 }
-- 
2.19.1

