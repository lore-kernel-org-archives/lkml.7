Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCBDC48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D71205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596108;
	bh=V38AR51WVZUlPALVqnX0BjGkS5IFDKpbFnNYu8LKKAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F1Etyn1IVJOtRHyr/ZoUTkjRXcbzxq2L6LIsPUdx3vXxuSMjQMsQ6KkkxSwa/eahs
	 P3Ujm3tBEPz2DW34A4yE+4UEu+w4EJ931+FZnXUlxMC8pvHstipIadN6qMYCDQlN9/
	 m7APlB2ZwQc4BqWQvMegN1Jq6hAbVCWi3dFTCROY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfF0Alr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729545AbfF0All (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:41:41 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85FB1205ED;
        Thu, 27 Jun 2019 00:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561596100;
        bh=V38AR51WVZUlPALVqnX0BjGkS5IFDKpbFnNYu8LKKAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDpQCL79IdbYGLNDQWJ/qSrl5Db8V8AJ7cDgkuKPpbMu+w/Odu0dJKrIbdWvpscvb
         DANzoeDw84t9tiuKMsX6QAFI8MJXpsOFvE3zANJn1XZgx+WsMtUQfZUDdi1eqVLX3g
         AW8MNA2PD5wsAdDp/FYVlo0EI7JuwfPz8fiApBq4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 05/21] mac80211: free peer keys before vif down in mesh
Date:   Wed, 26 Jun 2019 20:41:05 -0400
Message-Id: <20190627004122.21671-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627004122.21671-1-sashal@kernel.org>
References: <20190627004122.21671-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>

[ Upstream commit 0112fa557c3bb3a002bc85760dc3761d737264d3 ]

freeing peer keys after vif down is resulting in peer key uninstall
to fail due to interface lookup failure. so fix that.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mesh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 7f902e69530f..5c347d3a92c9 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -885,6 +885,7 @@ void ieee80211_stop_mesh(struct ieee80211_sub_if_data *sdata)
 
 	/* flush STAs and mpaths on this iface */
 	sta_info_flush(sdata);
+	ieee80211_free_keys(sdata, true);
 	mesh_path_flush_by_iface(sdata);
 
 	/* stop the beacon */
-- 
2.20.1

