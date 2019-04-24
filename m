Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18588C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA8A2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117962;
	bh=GAGYc+RBNY9gOAJBpGm59XaP147pRa+hODvmHtt6geU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hX9WOnnmDan6aD8iJ16s7xSFVWUm5AXj9Qk9QcKMpDhBAic9nNJpptsVCUEAT4glw
	 2fYPWDP7uhvsySze0sCdNklP+lFgM3BTgDmFyUlcTVrWhrKGXaOGz7K11g/Yycozr1
	 XauvxePFVddAk2u3/3AKvPOLy8tdSYfSCAMUW99o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbfDXO7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731324AbfDXOrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:47:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C44221900;
        Wed, 24 Apr 2019 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117242;
        bh=GAGYc+RBNY9gOAJBpGm59XaP147pRa+hODvmHtt6geU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UgODOp2bDzSrMq8G6Cg/mm8lwFnHck6uh8xbrxiOLw8f5E2/4AhxLtQsjAZCb86A+
         WnhrhUuXM2Da8g0/14w478Eqb7JJFPZ1eSU0cxzsEcG3E5QbPXNqEHSrdSN032feOV
         Tt3LDxI3TBiIxKwEPQKPVLe1MgW+x7FNcZQ35a74=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 05/35] batman-adv: Reduce tt_local hash refcnt only for removed entry
Date:   Wed, 24 Apr 2019 10:46:39 -0400
Message-Id: <20190424144709.30215-5-sashal@kernel.org>
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

[ Upstream commit 3d65b9accab4a7ed5038f6df403fbd5e298398c7 ]

The batadv_hash_remove is a function which searches the hashtable for an
entry using a needle, a hashtable bucket selection function and a compare
function. It will lock the bucket list and delete an entry when the compare
function matches it with the needle. It returns the pointer to the
hlist_node which matches or NULL when no entry matches the needle.

The batadv_tt_local_remove is not itself protected in anyway to avoid that
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

Fixes: ef72706a0543 ("batman-adv: protect tt_local_entry from concurrent delete events")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/translation-table.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 9da3455847ff..6c3e446abeed 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1313,9 +1313,10 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 			   unsigned short vid, const char *message,
 			   bool roaming)
 {
+	struct batadv_tt_local_entry *tt_removed_entry;
 	struct batadv_tt_local_entry *tt_local_entry;
 	u16 flags, curr_flags = BATADV_NO_FLAGS;
-	void *tt_entry_exists;
+	struct hlist_node *tt_removed_node;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
@@ -1344,15 +1345,18 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	 */
 	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
 
-	tt_entry_exists = batadv_hash_remove(bat_priv->tt.local_hash,
+	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
 					     batadv_compare_tt,
 					     batadv_choose_tt,
 					     &tt_local_entry->common);
-	if (!tt_entry_exists)
+	if (!tt_removed_node)
 		goto out;
 
-	/* extra call to free the local tt entry */
-	batadv_tt_local_entry_put(tt_local_entry);
+	/* drop reference of remove hash entry */
+	tt_removed_entry = hlist_entry(tt_removed_node,
+				       struct batadv_tt_local_entry,
+				       common.hash_entry);
+	batadv_tt_local_entry_put(tt_removed_entry);
 
 out:
 	if (tt_local_entry)
-- 
2.19.1

