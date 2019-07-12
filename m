Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DF4C742BC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B940020645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562935223;
	bh=vzNDa/PUAz8ZpCP/DkO6lBxzT4lU2xNhVFgJK0Wd++E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=02hnTqL7EF11fGm2Z1CuwOmq+y2PKn/n6LD51JqoVol1W7CagDwbqbiJ8KbLOW/+T
	 3DulsGuXyy6KUa95hf1VBUnZ56mx0rtQ0+6hvwy25neHF/2UyBgcd5bL0/kc6j5qdM
	 phWCwPXgiVo+2m1MqSZvZYIzjwWA96sfN/4OHowg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfGLMZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfGLMZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:25:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18B8B2084B;
        Fri, 12 Jul 2019 12:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934332;
        bh=vzNDa/PUAz8ZpCP/DkO6lBxzT4lU2xNhVFgJK0Wd++E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i8aRJWcY1iuVH5OtcFteQ7eneenPTNVk++Zqu4PIO1ok2fiLhuaUXIXvlTfR/GY4i
         FI68+xztWr/SJdaIzq8GZO/XmneAaMceT8TQ+qc+T1Zh/TePjaG9XQmTxG5NkvScic
         ByDJwexQIiS4I0yBVUJhnjBRwhg8Y4/zS+OH1vpU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 020/138] mac80211: free peer keys before vif down in mesh
Date:   Fri, 12 Jul 2019 14:18:04 +0200
Message-Id: <20190712121629.488546030@linuxfoundation.org>
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
index d5aba5029cb0..fe44f0d98de0 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -929,6 +929,7 @@ void ieee80211_stop_mesh(struct ieee80211_sub_if_data *sdata)
 
 	/* flush STAs and mpaths on this iface */
 	sta_info_flush(sdata);
+	ieee80211_free_keys(sdata, true);
 	mesh_path_flush_by_iface(sdata);
 
 	/* stop the beacon */
-- 
2.20.1



