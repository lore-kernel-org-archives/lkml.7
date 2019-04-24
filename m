Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4D0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D16121902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116775;
	bh=9NJYmwpf9VhoBxtvQ8aUDg/Ij7vKRb4oFNMCNHa9J44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2BXfiCV6angnUa0ksnC5SDONjPR3YpEbnOX6zikQ9Jd22//JxDNSo3GRkrgAFbnVq
	 1CdODqpJhOhpmonsi4wM1VQthGlXBPNrrleseoJ4XqEcuA72GbbeMZAvOoz7g1Lv/p
	 2hKd/yhqHvekw3zuW/YQ5ZGstikJvd/+1XhIZcP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbfDXOje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730633AbfDXOjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:39:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 653AD21901;
        Wed, 24 Apr 2019 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116770;
        bh=9NJYmwpf9VhoBxtvQ8aUDg/Ij7vKRb4oFNMCNHa9J44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HI+uhsOPqDOtJI04fFguBmV9trKo7JBi/W/RRI+RZaUrMF3voDeFBPn3D2e03omj7
         tSrfUyTmvrMHSqg/n8zMmExo6c8mpFVqkpjiRPJCMu7GNqDpFGmL/+v4CNJbYwmbWV
         IpcgaWQwD60YuWEz86bBKkf5mavoL2xUyb1lzYro=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/52] batman-adv: Reduce tt_global hash refcnt only for removed entry
Date:   Wed, 24 Apr 2019 10:38:26 -0400
Message-Id: <20190424143911.28890-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit f131a56880d10932931e74773fb8702894a94a75 ]

The batadv_hash_remove is a function which searches the hashtable for an
entry using a needle, a hashtable bucket selection function and a compare
function. It will lock the bucket list and delete an entry when the compare
function matches it with the needle. It returns the pointer to the
hlist_node which matches or NULL when no entry matches the needle.

The batadv_tt_global_free is not itself protected in anyway to avoid that
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

Fixes: 7683fdc1e886 ("batman-adv: protect the local and the global trans-tables with rcu")
Reported-by: Martin Weinelt <martin@linuxlounge.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/translation-table.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 696e6ddc534b..359ec1a6e822 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -616,14 +616,26 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 				  struct batadv_tt_global_entry *tt_global,
 				  const char *message)
 {
+	struct batadv_tt_global_entry *tt_removed_entry;
+	struct hlist_node *tt_removed_node;
+
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Deleting global tt entry %pM (vid: %d): %s\n",
 		   tt_global->common.addr,
 		   batadv_print_vid(tt_global->common.vid), message);
 
-	batadv_hash_remove(bat_priv->tt.global_hash, batadv_compare_tt,
-			   batadv_choose_tt, &tt_global->common);
-	batadv_tt_global_entry_put(tt_global);
+	tt_removed_node = batadv_hash_remove(bat_priv->tt.global_hash,
+					     batadv_compare_tt,
+					     batadv_choose_tt,
+					     &tt_global->common);
+	if (!tt_removed_node)
+		return;
+
+	/* drop reference of remove hash entry */
+	tt_removed_entry = hlist_entry(tt_removed_node,
+				       struct batadv_tt_global_entry,
+				       common.hash_entry);
+	batadv_tt_global_entry_put(tt_removed_entry);
 }
 
 /**
-- 
2.19.1

