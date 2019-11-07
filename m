Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDDFC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847CB2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFalviU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfKGURL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:17:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44297 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfKGURK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:17:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id f2so4497005wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XNzt41YFZXyjsZpmoGDLsT4RfyC5Nwv0mUPlwLSX3bc=;
        b=UFalviU5DBTJfeFlbgiXyKOOr8N39C5EfK0S6coDUDS4tX8kAJ82CKlLG4/oQ5o0Oe
         A4uD60QFotjVwh/qG0AQiBXrmKKUC+gzfywVxe2cD9w8p+emBNbjkwhjc61BM8yX/jfG
         KsuqDzqfQxw1iuBgreTOxGEqCrhyWycHR/MPWh6qrv5do8cE4PJF5GovN8kTmraQL7sm
         IlD6Eoun/OExoYx4vk8PzmVZa/pQEdKLfaPXp+Lgpcpoi6pkOy8ZSST+2UT+DcqxA47l
         hRw5Vv1itAUzv//y28UozrXF4yxXGwHiGOVr1ltN4KIrrHVJNAL7xyUY/Vczkdh8FJ5J
         VPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XNzt41YFZXyjsZpmoGDLsT4RfyC5Nwv0mUPlwLSX3bc=;
        b=gQvJCwGfbMC7mR6IvvnOD+SlxbYMu4/+3gFQbokv0WWI/CTMD7vGGqJadfOkzE05qL
         91nli1ZKVx8TYMx1n72JaEzAA35DQl8sNF1BDnvAM6aago9BWaQi/G1Mf+MGOqqHG4P5
         2rZu9UK5jUQ/PVVUlbWw17ml0cvhvpZPIn3Y+oop/sEL9FB45mA7QP1tk3xnP7YPs1YI
         nig5Z8LsI61sQfktbo4YTMChMR3A3az/2m3jQ5rZNwai5n1ndGcrmK8vnSYkPgKo0Gyk
         XkGmkvb78qBwoSe2hYo+3NnatmEJlaGrdk/JOKuzZfxxFAZ0q3aVa+UEFIg8IughdJki
         biBw==
X-Gm-Message-State: APjAAAUWNxKAYSS6vhppSkaCoyg6nLJwtCsUJ7yqRY4A0V3TrbkjsHbd
        8U19zO35kYmUHGznZO65CAnFwA==
X-Google-Smtp-Source: APXvYqxVUNWlPOOt3bFH9N90uImbfbh5nOhmdyu9PeF7oFMBWFpxonLriEOHbnLlemth0Zl314fKDA==
X-Received: by 2002:a5d:6b0e:: with SMTP id v14mr4691904wrw.280.1573157828385;
        Thu, 07 Nov 2019 12:17:08 -0800 (PST)
Received: from localhost.localdomain ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id d11sm3215162wrn.28.2019.11.07.12.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:17:07 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Pedersen <thomas@eero.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 03/10] mac80211: mesh: fix RCU warning
Date:   Thu,  7 Nov 2019 20:16:55 +0000
Message-Id: <20191107201702.27023-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107201702.27023-1-lee.jones@linaro.org>
References: <20191107201702.27023-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Pedersen <thomas@eero.com>

[ Upstream commit 551842446ed695641a00782cd118cbb064a416a1 ]

ifmsh->csa is an RCU-protected pointer. The writer context
in ieee80211_mesh_finish_csa() is already mutually
exclusive with wdev->sdata.mtx, but the RCU checker did
not know this. Use rcu_dereference_protected() to avoid a
warning.

fixes the following warning:

[   12.519089] =============================
[   12.520042] WARNING: suspicious RCU usage
[   12.520652] 5.1.0-rc7-wt+ #16 Tainted: G        W
[   12.521409] -----------------------------
[   12.521972] net/mac80211/mesh.c:1223 suspicious rcu_dereference_check() usage!
[   12.522928] other info that might help us debug this:
[   12.523984] rcu_scheduler_active = 2, debug_locks = 1
[   12.524855] 5 locks held by kworker/u8:2/152:
[   12.525438]  #0: 00000000057be08c ((wq_completion)phy0){+.+.}, at: process_one_work+0x1a2/0x620
[   12.526607]  #1: 0000000059c6b07a ((work_completion)(&sdata->csa_finalize_work)){+.+.}, at: process_one_work+0x1a2/0x620
[   12.528001]  #2: 00000000f184ba7d (&wdev->mtx){+.+.}, at: ieee80211_csa_finalize_work+0x2f/0x90
[   12.529116]  #3: 00000000831a1f54 (&local->mtx){+.+.}, at: ieee80211_csa_finalize_work+0x47/0x90
[   12.530233]  #4: 00000000fd06f988 (&local->chanctx_mtx){+.+.}, at: ieee80211_csa_finalize_work+0x51/0x90

Signed-off-by: Thomas Pedersen <thomas@eero.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Change-Id: I19313f756382b0078683036d50c6645dd8ab2bee
---
 net/mac80211/mesh.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index a70c970a743a..06189c952291 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1062,7 +1062,8 @@ int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata)
 	ifmsh->chsw_ttl = 0;
 
 	/* Remove the CSA and MCSP elements from the beacon */
-	tmp_csa_settings = rcu_dereference(ifmsh->csa);
+	tmp_csa_settings = rcu_dereference_protected(ifmsh->csa,
+					    lockdep_is_held(&sdata->wdev.mtx));
 	RCU_INIT_POINTER(ifmsh->csa, NULL);
 	if (tmp_csa_settings)
 		kfree_rcu(tmp_csa_settings, rcu_head);
@@ -1084,6 +1085,8 @@ int ieee80211_mesh_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	struct mesh_csa_settings *tmp_csa_settings;
 	int ret = 0;
 
+	lockdep_assert_held(&sdata->wdev.mtx);
+
 	tmp_csa_settings = kmalloc(sizeof(*tmp_csa_settings),
 				   GFP_ATOMIC);
 	if (!tmp_csa_settings)
-- 
2.24.0

