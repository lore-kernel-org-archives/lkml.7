Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C734BC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3AC20578
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557920336;
	bh=cCpzihbvXaaWTGpByLsxynU8DRIq2Yq+Ki/HH3TdJGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xggHseh0f6wgfMq46DBcw3y0cLl6bGfv8VIZY70pAz344xecMCX+dJ1iEeeb+mjvH
	 eZOOKkGntgrO84GVEMS+SdPw/5wKAy14lTwU4v+L3kw2cte61tJyiWXDXuxTvnPI1U
	 6kqm1qLUz0UlD79qF8WiSiwidDOjE3h4WPlLQZUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbfEOLiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732777AbfEOLao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:30:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFFC920843;
        Wed, 15 May 2019 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919844;
        bh=cCpzihbvXaaWTGpByLsxynU8DRIq2Yq+Ki/HH3TdJGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=scnzcXYecBbUggojG1lCmaCA9QgI5it1rSfcirOymveqoRcYyoOsZVYGXB/TB19u/
         3dLHYIideyKAAbngZ5APWA0jBHnCCmB22lqMBQ5tfi7hv/+xj6P12bsvozRBxW16Tb
         rKqfBDGLNpaOYLvt+gs/rB0lZfcHI1PX5y4/K66Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Andrei Vagin <avagin@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 078/137] netfilter: fix nf_l4proto_log_invalid to log invalid packets
Date:   Wed, 15 May 2019 12:55:59 +0200
Message-Id: <20190515090659.109923422@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d48668052b2603b6262459625c86108c493588dd ]

It doesn't log a packet if sysctl_log_invalid isn't equal to protonum
OR sysctl_log_invalid isn't equal to IPPROTO_RAW. This sentence is
always true. I believe we need to replace OR to AND.

Cc: Florian Westphal <fw@strlen.de>
Fixes: c4f3db1595827 ("netfilter: conntrack: add and use nf_l4proto_log_invalid")
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_proto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_proto.c b/net/netfilter/nf_conntrack_proto.c
index 859f5d07a9159..78361e462e802 100644
--- a/net/netfilter/nf_conntrack_proto.c
+++ b/net/netfilter/nf_conntrack_proto.c
@@ -86,7 +86,7 @@ void nf_l4proto_log_invalid(const struct sk_buff *skb,
 	struct va_format vaf;
 	va_list args;
 
-	if (net->ct.sysctl_log_invalid != protonum ||
+	if (net->ct.sysctl_log_invalid != protonum &&
 	    net->ct.sysctl_log_invalid != IPPROTO_RAW)
 		return;
 
-- 
2.20.1



