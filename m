Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A583C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D352080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562935158;
	bh=q8PERZs6v5ab/KUl9cYj5n7IxDxsOhsvzGU0Y4jTa6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DS+XCLpiMmBxLuY0Nk7taci/JIL1CZyAF0QiQnhqcdMgzWoOyPbZ5Of2dpWdHJ00M
	 QTKZgsCsy7o7GbVhFxvSmD7AtGUvR0aSuQMutQ642n/Kgqfq5AqKAyY257VwTaYC3X
	 YU26N42Z/OTtnoUr0tqw3HEp1dCVMV2i8m6nYUkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfGLMjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbfGLM1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:27:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2452084B;
        Fri, 12 Jul 2019 12:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934459;
        bh=q8PERZs6v5ab/KUl9cYj5n7IxDxsOhsvzGU0Y4jTa6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a2MD2DK15LFiOZwZUFDowDGgA6If76S5+/wlXFK6+8j22HWUaCkEF8BxjIudTNw4X
         4470da92/Wj/SG/5WGWti2kOjJ6/YY97QERZKXA/8zMEQHqBFlUijwxH/n4O2I7IYf
         EVCe5roZuZ8Q6BKbiUeF9g7CjUgIFrHO7veIv7x4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Naftali Goldstein <naftali.goldstein@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 061/138] mac80211: do not start any work during reconfigure flow
Date:   Fri, 12 Jul 2019 14:18:45 +0200
Message-Id: <20190712121631.018684037@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f8891461a277ec0afc493fd30cd975a38048a038 ]

It is not a good idea to try to perform any work (e.g. send an auth
frame) during reconfigure flow.

Prevent this from happening, and at the end of the reconfigure flow
requeue all the works.

Signed-off-by: Naftali Goldstein <naftali.goldstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/ieee80211_i.h | 7 +++++++
 net/mac80211/util.c        | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 4118704cb0e7..6708c1640207 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2034,6 +2034,13 @@ void __ieee80211_flush_queues(struct ieee80211_local *local,
 
 static inline bool ieee80211_can_run_worker(struct ieee80211_local *local)
 {
+	/*
+	 * It's unsafe to try to do any work during reconfigure flow.
+	 * When the flow ends the work will be requeued.
+	 */
+	if (local->in_reconfig)
+		return false;
+
 	/*
 	 * If quiescing is set, we are racing with __ieee80211_suspend.
 	 * __ieee80211_suspend flushes the workers after setting quiescing,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 447a55ae9df1..3400e2da7297 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2442,6 +2442,10 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		mutex_lock(&local->mtx);
 		ieee80211_start_next_roc(local);
 		mutex_unlock(&local->mtx);
+
+		/* Requeue all works */
+		list_for_each_entry(sdata, &local->interfaces, list)
+			ieee80211_queue_work(&local->hw, &sdata->work);
 	}
 
 	ieee80211_wake_queues_by_reason(hw, IEEE80211_MAX_QUEUE_MAP,
-- 
2.20.1



