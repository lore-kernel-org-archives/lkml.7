Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B498C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D7520675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810829;
	bh=5IKcHb/BiqpQ9jsv0SapryPbCO4oCW5m2Nfmbwo9D9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EqX3vY6m6biywNFWJ8BKNuhGc9qdKWhQTBI1dCBpp+yKrVTdo/uxpuhpCe6FnnNmq
	 OfvJa4j99bTPJpHueD130ERgJL9PrYutVo6wDg2SxNYlBMCh/yrXAWxCO2bOSwX9g/
	 n1I4e1SKkJrp4sHXbltV5Jd6Un/cNuYNhmgWKpto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfEBP1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbfEBP1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:27:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F7422081C;
        Thu,  2 May 2019 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810825;
        bh=5IKcHb/BiqpQ9jsv0SapryPbCO4oCW5m2Nfmbwo9D9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=znShkYjH2jAwJtjo0NQkCYYmiR2e82UTrfjN1tJ/xKVvrlq+/TMFvDLS5Rgwttxag
         JVSzHw3/LyMqsDlSsEntq6av76S+na7yIPVThpiiC1CE1pjKt0ax1AJ35iiaFN+B7E
         JcAeHzebr1scGCrP5aV9JJfS8lALuiO6iePSwQWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 42/72] net/sched: dont dereference a->goto_chain to read the chain index
Date:   Thu,  2 May 2019 17:21:04 +0200
Message-Id: <20190502143336.829714760@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



