Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DBEC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB151204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963115;
	bh=KMbzly5KBf1sshuB4l+j6AzaoGBqCdHQQ/KP09IqgzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=znnCJ07A4VOj/gGuqqm+OwmKwh13OKPWpFYRq9Pcoudsvd9iVAHbkYPniAO5+jVxe
	 Aj4WQJ/1thW0turESkk7MIgjRpOKzZzLlPlo6I6J4AJr0r1+FXG60JOUHTordKGqyf
	 PezBSpG2b94KjZmsjGsMaBh+wSrTVmfWQER/hBy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbfDVT6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbfDVTsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:48:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D0AE218FD;
        Mon, 22 Apr 2019 19:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962500;
        bh=KMbzly5KBf1sshuB4l+j6AzaoGBqCdHQQ/KP09IqgzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qFwAL9V12q58Ruog5YX7D+SAnfHVU8umavsq0yIJREu2LZfMETer7Ah3w/UaXlHVE
         gUs1KTFy61R952tOXBlm5ogGF8wUGr+DufYTLcEutyp5U7AMiUr5HJcWDKcFBYhyrv
         vhZW7FjnVL4up0TgHXyr58sdABZ7NuD7ntABuQ/g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Davide Caratti <dcaratti@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 23/43] net/sched: don't dereference a->goto_chain to read the chain index
Date:   Mon, 22 Apr 2019 15:47:07 -0400
Message-Id: <20190422194727.12495-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
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
index e82d93346b63..bb74ea83d57d 100644
--- a/include/net/tc_act/tc_gact.h
+++ b/include/net/tc_act/tc_gact.h
@@ -51,7 +51,7 @@ static inline bool is_tcf_gact_goto_chain(const struct tc_action *a)
 
 static inline u32 tcf_gact_goto_chain_index(const struct tc_action *a)
 {
-	return a->goto_chain->index;
+	return READ_ONCE(a->tcfa_action) & TC_ACT_EXT_VAL_MASK;
 }
 
 #endif /* __NET_TC_GACT_H */
-- 
2.19.1

