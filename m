Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A198C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A6220643
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963330;
	bh=oGYkHQNu3BqXyCxRhZmTUV35WhDj7e17QJcfODQ0Egg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ygegEKBoD4+S1lkZht8xG1Q/z0dIUB9yb+qx0p8Xn7DNdVxSrSYr5WlrRtQ4zENnL
	 TflpuNm7XV9lBefmsjwRFiWUf+WPLc7pbO3VzVX22mgpulZt8HNni81/x2QlOtk0/x
	 4xywN5PLDJiUNAEKECRzXqekx1eVccCSbxcs4Xd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfDVTqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:46:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbfDVTqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:46:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1F30218FF;
        Mon, 22 Apr 2019 19:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962398;
        bh=oGYkHQNu3BqXyCxRhZmTUV35WhDj7e17QJcfODQ0Egg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Il6T5jAe7RgBz750r9ieR8/S9+n5BJjMtYJrg0j4BfoQebm3+Z+FMIvvumwF/F+R6
         Liw7fCk9J5I8kPZPZjxu2cv+ca5RClyb/O+Ur4Y/4DpEfqQpMNMC1tk3kXm8ZsejYB
         icqKpxU1oVtaSe/eiUCqYnOA3PAVVO/qau4ZQaSU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Davide Caratti <dcaratti@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 36/68] net/sched: don't dereference a->goto_chain to read the chain index
Date:   Mon, 22 Apr 2019 15:44:44 -0400
Message-Id: <20190422194516.11634-36-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit fe384e2fa36ca084a456fd30558cccc75b4b3fbd ]

callers of tcf_gact_goto_chain_index() can potentially read an old value
of the chain index, or even dereference a NULL 'goto_chain' pointer,
because 'goto_chain' and 'tcfa_action' are read in the traffic path
without caring of concurrent write in the control path. The most recent
value of chain index can be read also from a->tcfa_action (it's encoded
there together with TC_ACT_GOTO_CHAIN bits), so we don't really need to
dereference 'goto_chain': just read the chain id from the control action.

Fixes: e457d86ada27 ("net: sched: add couple of goto_chain helpers")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 include/net/tc_act/tc_gact.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/tc_act/tc_gact.h b/include/net/tc_act/tc_gact.h
index ef8dd0db70ce..56935bf027a7 100644
--- a/include/net/tc_act/tc_gact.h
+++ b/include/net/tc_act/tc_gact.h
@@ -56,7 +56,7 @@ static inline bool is_tcf_gact_goto_chain(const struct tc_action *a)
 
 static inline u32 tcf_gact_goto_chain_index(const struct tc_action *a)
 {
-	return a->goto_chain->index;
+	return READ_ONCE(a->tcfa_action) & TC_ACT_EXT_VAL_MASK;
 }
 
 #endif /* __NET_TC_GACT_H */
-- 
2.19.1

