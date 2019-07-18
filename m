Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69EAC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE0720818
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419318;
	bh=Bi3cbigAC+BcImm58J9QhwLwmuYbdQmXKRbldw5tWnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=txjfIhCuzJtntrNvn4k56XHiFZgrWg7/atT7j8J8xcv6yHjxmwyOKy26+N6nXjGDL
	 Tk1j2o8Tz0tU5zW9ZlTxbOtVdmwJYyMAZ5WcqgBKflOq7GcEfeaYhEiHctLlvFfL4K
	 C02iYlsjvYRThi+2rCr07bGT8lPmQDNeXRYvTOUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390818AbfGRDIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390266AbfGRDIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:08:36 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFDDA2077C;
        Thu, 18 Jul 2019 03:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419316;
        bh=Bi3cbigAC+BcImm58J9QhwLwmuYbdQmXKRbldw5tWnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2iMxlss+5P64XCMUvHlGLvjgBMq6flT7Wt/cvjvJeyq4BEgsxxii9F14xPycIqXy8
         UMz+3GmNvXfKpgiD25Fc/xksmyIz5vPcYbpITGgjxMvl8C0wpyra11078T++2QJuLl
         pL3vRnggt5vu+8ZnnuxQvVZfzB/QuKvOlakuWkgg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 12/80] mac80211: free peer keys before vif down in mesh
Date:   Thu, 18 Jul 2019 12:01:03 +0900
Message-Id: <20190718030059.789261632@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030058.615992480@linuxfoundation.org>
References: <20190718030058.615992480@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index aca054539f4a..c6edae051e9b 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -922,6 +922,7 @@ void ieee80211_stop_mesh(struct ieee80211_sub_if_data *sdata)
 
 	/* flush STAs and mpaths on this iface */
 	sta_info_flush(sdata);
+	ieee80211_free_keys(sdata, true);
 	mesh_path_flush_by_iface(sdata);
 
 	/* stop the beacon */
-- 
2.20.1



