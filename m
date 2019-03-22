Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739B7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D872192B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255966;
	bh=+NTyLmjZDvyMnV/Z3zinDapPkfgIuHlz1/LzwXwCfEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U6RRh3hWSXzp4j6rZJlNroqg9IAe/peqGvZRbDQQWoO1+R/Xvw2Wyk10lxIyAdHt8
	 HDWApFNrxEyILx4OXMm5issD/I4CEtP9iBwcKbUYP79s5z6EgmkqaO2az2VRGI6XFs
	 foax/bC3RTKoUFvIOXl+gBE7GHefm/PGCTOxBVYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbfCVL7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733301AbfCVL7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:59:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72D1C20830;
        Fri, 22 Mar 2019 11:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255962;
        bh=+NTyLmjZDvyMnV/Z3zinDapPkfgIuHlz1/LzwXwCfEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QNAcjd0v8XGI6kbvwOPFlEFLfL74KGrFXiz7MldBBiWFqaaw/MyvQJqY6Kxo3CzgQ
         KC2S4D7PTfeJBrqW81Ye/tSRpUqz/jfDgkPu6cllVsxdwfJakvt76NPr7r4bsnYzB7
         jhTjptVnI9LEmvDqVOoGrxEXDctee8wDnByr0Ouk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 049/280] mac80211: Fix Tx aggregation session tear down with ITXQs
Date:   Fri, 22 Mar 2019 12:13:22 +0100
Message-Id: <20190322111309.069961852@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

[ Upstream commit 6157ca0d6bfe437691b1e98a62e2efe12b6714da ]

When mac80211 requests the low level driver to stop an ongoing
Tx aggregation, the low level driver is expected to call
ieee80211_stop_tx_ba_cb_irqsafe() to indicate that it is ready
to stop the session. The callback in turn schedules a worker
to complete the session tear down, which in turn also handles
the relevant state for the intermediate Tx queue.

However, as this flow in asynchronous, the intermediate queue
should be stopped and not continue servicing frames, as in
such a case frames that are dequeued would be marked as part
of an aggregation, although the aggregation is already been
stopped.

Fix this by stopping the intermediate Tx queue, before
calling the low level driver to stop the Tx aggregation.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/agg-tx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 69e831bc317b..54821fb1a960 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -8,7 +8,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -366,6 +366,8 @@ int ___ieee80211_stop_tx_ba_session(struct sta_info *sta, u16 tid,
 
 	set_bit(HT_AGG_STATE_STOPPING, &tid_tx->state);
 
+	ieee80211_agg_stop_txq(sta, tid);
+
 	spin_unlock_bh(&sta->lock);
 
 	ht_dbg(sta->sdata, "Tx BA session stop requested for %pM tid %u\n",
-- 
2.19.1



