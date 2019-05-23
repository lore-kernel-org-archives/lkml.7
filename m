Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8ACC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1975020879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640157;
	bh=A0Yg2V9achhS0PynrLnME21t4CGr3wm5GbcIE2IwJS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WeHVW0oXOVs+aCMPxQzEDH/5CVPqc1puHFW6SuZPCa8UMiLjOPRtUHpoGk42nrctv
	 oxsxdDGN2vHr557xydN+vu8TW5iTpImIPWqHvCtVLPfYI4kELqUyMnsd2Qb3zltwtE
	 K54g9nCI9zVvb3eCuHkjwwXrjVEUNvUxmIbzuNjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391956AbfEWTf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:35:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391303AbfEWT0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:26:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D9EF21841;
        Thu, 23 May 2019 19:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639575;
        bh=A0Yg2V9achhS0PynrLnME21t4CGr3wm5GbcIE2IwJS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRnRS8+H59A1QK4IjevPGJ24vTqbWylqz7I27ItkncKIqN9aLimt29YSfiDXSpJ2f
         Ofo2zDEs/RB2QmB6CKJyuHgzMEyQcg8gYsL2YiUjsXnsndUfgB2kfTzgZ9kSWFYBVW
         BY/BjW6pLvq3EtboU09/qqiLEfMn0Rd7LZiTxZU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edward Cree <ecree@solarflare.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 016/122] flow_offload: support CVLAN match
Date:   Thu, 23 May 2019 21:05:38 +0200
Message-Id: <20190523181707.027462532@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Edward Cree <ecree@solarflare.com>

[ Upstream commit bae9ed69029c7d499c57485593b2faae475fd704 ]

Plumb it through from the flow_dissector.

Signed-off-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/flow_offload.h |    2 ++
 net/core/flow_offload.c    |    7 +++++++
 2 files changed, 9 insertions(+)

--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -71,6 +71,8 @@ void flow_rule_match_eth_addrs(const str
 			       struct flow_match_eth_addrs *out);
 void flow_rule_match_vlan(const struct flow_rule *rule,
 			  struct flow_match_vlan *out);
+void flow_rule_match_cvlan(const struct flow_rule *rule,
+			   struct flow_match_vlan *out);
 void flow_rule_match_ipv4_addrs(const struct flow_rule *rule,
 				struct flow_match_ipv4_addrs *out);
 void flow_rule_match_ipv6_addrs(const struct flow_rule *rule,
--- a/net/core/flow_offload.c
+++ b/net/core/flow_offload.c
@@ -54,6 +54,13 @@ void flow_rule_match_vlan(const struct f
 }
 EXPORT_SYMBOL(flow_rule_match_vlan);
 
+void flow_rule_match_cvlan(const struct flow_rule *rule,
+			   struct flow_match_vlan *out)
+{
+	FLOW_DISSECTOR_MATCH(rule, FLOW_DISSECTOR_KEY_CVLAN, out);
+}
+EXPORT_SYMBOL(flow_rule_match_cvlan);
+
 void flow_rule_match_ipv4_addrs(const struct flow_rule *rule,
 				struct flow_match_ipv4_addrs *out)
 {


