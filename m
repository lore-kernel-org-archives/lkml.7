Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CF8C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9D82067B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947358;
	bh=EYrfnDqSgMzgf5DIBdN1vN7QHCkw64YspbkfRh4RT3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0pAryVc/nuh7niflBpADpZWK7gDNESpgaNBhsIDTUsXVt95kruY29OYgcZpfkEWhr
	 C7c4RC6mAtVU6B2Bw7SUV702VSoaYvSq/gBmIaEyEqY+ybOeaGjO+FD9bSjZitD8GZ
	 HcMOZ9cmU6WNhyutzD2icq1G4pvX91iju02rJ/ho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbfIHMud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732061AbfIHMuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:50:20 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0A0521920;
        Sun,  8 Sep 2019 12:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947019;
        bh=EYrfnDqSgMzgf5DIBdN1vN7QHCkw64YspbkfRh4RT3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8ekluRB4DaxDW9t27pTs4Pw7OUF2zesSHKWE5++J+8DtFl8pAfMLrWyEc6e5IdqK
         pk/R+KCsaOg2QEuVVUxHC5uyuD4ojQifLWy9J2zP+qCx4IinHj/xGEXYE2JwYGo/pp
         SkDTO8XAOtmo9IhIWFEikTAyRJ0DM2cmsgm/ctgE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 30/94] netfilter: nf_flow_table: conntrack picks up expired flows
Date:   Sun,  8 Sep 2019 13:41:26 +0100
Message-Id: <20190908121151.303047242@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3e68db2f6422d711550a32cbc87abd97bb6efab3 ]

Update conntrack entry to pick up expired flows, otherwise the conntrack
entry gets stuck with the internal offload timeout (one day). The TCP
state also needs to be adjusted to ESTABLISHED state and tracking is set
to liberal mode in order to give conntrack a chance to pick up the
expired flow.

Fixes: ac2a66665e23 ("netfilter: add generic flow table infrastructure")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_flow_table_core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 948b4ebbe3fbd..4254e42605135 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -112,7 +112,7 @@ static void flow_offload_fixup_tcp(struct ip_ct_tcp *tcp)
 #define NF_FLOWTABLE_TCP_PICKUP_TIMEOUT	(120 * HZ)
 #define NF_FLOWTABLE_UDP_PICKUP_TIMEOUT	(30 * HZ)
 
-static void flow_offload_fixup_ct_state(struct nf_conn *ct)
+static void flow_offload_fixup_ct(struct nf_conn *ct)
 {
 	const struct nf_conntrack_l4proto *l4proto;
 	unsigned int timeout;
@@ -209,6 +209,11 @@ int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow)
 }
 EXPORT_SYMBOL_GPL(flow_offload_add);
 
+static inline bool nf_flow_has_expired(const struct flow_offload *flow)
+{
+	return (__s32)(flow->timeout - (u32)jiffies) <= 0;
+}
+
 static void flow_offload_del(struct nf_flowtable *flow_table,
 			     struct flow_offload *flow)
 {
@@ -224,6 +229,9 @@ static void flow_offload_del(struct nf_flowtable *flow_table,
 	e = container_of(flow, struct flow_offload_entry, flow);
 	clear_bit(IPS_OFFLOAD_BIT, &e->ct->status);
 
+	if (nf_flow_has_expired(flow))
+		flow_offload_fixup_ct(e->ct);
+
 	flow_offload_free(flow);
 }
 
@@ -234,7 +242,7 @@ void flow_offload_teardown(struct flow_offload *flow)
 	flow->flags |= FLOW_OFFLOAD_TEARDOWN;
 
 	e = container_of(flow, struct flow_offload_entry, flow);
-	flow_offload_fixup_ct_state(e->ct);
+	flow_offload_fixup_ct(e->ct);
 }
 EXPORT_SYMBOL_GPL(flow_offload_teardown);
 
@@ -299,11 +307,6 @@ nf_flow_table_iterate(struct nf_flowtable *flow_table,
 	return err;
 }
 
-static inline bool nf_flow_has_expired(const struct flow_offload *flow)
-{
-	return (__s32)(flow->timeout - (u32)jiffies) <= 0;
-}
-
 static void nf_flow_offload_gc_step(struct flow_offload *flow, void *data)
 {
 	struct nf_flowtable *flow_table = data;
-- 
2.20.1



