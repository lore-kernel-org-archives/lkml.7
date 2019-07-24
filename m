Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79EFC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A9C22AED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997832;
	bh=VG4bOefSbu9JU1+/k2ddiRZLki9YxON5ve0MJmluFIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nkfdtPx57FbNH28xssmng+ltDVcU0RX3Q9CXvOvF6e8gw6rYZSHSIKX6hJe9yKGnx
	 ooU9vxnImkGbiQSfOhsL9AgGKP/ifOXgeqoCO9R6B/q/3Dtnk2JSVxq4wY47Zi3OAU
	 qIhePde55aFOVtZQayiS/njrhFVLJX5AaL5RyfJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391599AbfGXTub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403826AbfGXTuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:50:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDDDA20659;
        Wed, 24 Jul 2019 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997824;
        bh=VG4bOefSbu9JU1+/k2ddiRZLki9YxON5ve0MJmluFIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DgM7GY3SFhY6+e30J1rHc4QdYgJb9IUd9fceSu8EL9Q6E9Q54scDwTlVDi5b8eXJJ
         +h++KPpTPjXxeiaO4z/l9Hc49LlQYkthgs2ny1Xp4YiGCuxdw6Zhhs1M6+lzu8YN+T
         0yfU7jSgFc0X5pAoYUy9A4E3QGpW84lBAsgaSHpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Felix Kaechele <felix@kaechele.ca>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 155/371] netfilter: ctnetlink: Fix regression in conntrack entry deletion
Date:   Wed, 24 Jul 2019 21:18:27 +0200
Message-Id: <20190724191736.848545063@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e7600865db32b69deb0109b8254244dca592adcf ]

Commit f8e608982022 ("netfilter: ctnetlink: Resolve conntrack
L3-protocol flush regression") introduced a regression in which deletion
of conntrack entries would fail because the L3 protocol information
is replaced by AF_UNSPEC. As a result the search for the entry to be
deleted would turn up empty due to the tuple used to perform the search
is now different from the tuple used to initially set up the entry.

For flushing the conntrack table we do however want to keep the option
for nfgenmsg->version to have a non-zero value to allow for newer
user-space tools to request treatment under the new behavior. With that
it is possible to independently flush tables for a defined L3 protocol.
This was introduced with the enhancements in in commit 59c08c69c278
("netfilter: ctnetlink: Support L3 protocol-filter on flush").

Older user-space tools will retain the behavior of flushing all tables
regardless of defined L3 protocol.

Fixes: f8e608982022 ("netfilter: ctnetlink: Resolve conntrack L3-protocol flush regression")
Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Felix Kaechele <felix@kaechele.ca>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_netlink.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index d2715b4d2e72..061bdab37b1a 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1254,7 +1254,6 @@ static int ctnetlink_del_conntrack(struct net *net, struct sock *ctnl,
 	struct nf_conntrack_tuple tuple;
 	struct nf_conn *ct;
 	struct nfgenmsg *nfmsg = nlmsg_data(nlh);
-	u_int8_t u3 = nfmsg->version ? nfmsg->nfgen_family : AF_UNSPEC;
 	struct nf_conntrack_zone zone;
 	int err;
 
@@ -1264,11 +1263,13 @@ static int ctnetlink_del_conntrack(struct net *net, struct sock *ctnl,
 
 	if (cda[CTA_TUPLE_ORIG])
 		err = ctnetlink_parse_tuple(cda, &tuple, CTA_TUPLE_ORIG,
-					    u3, &zone);
+					    nfmsg->nfgen_family, &zone);
 	else if (cda[CTA_TUPLE_REPLY])
 		err = ctnetlink_parse_tuple(cda, &tuple, CTA_TUPLE_REPLY,
-					    u3, &zone);
+					    nfmsg->nfgen_family, &zone);
 	else {
+		u_int8_t u3 = nfmsg->version ? nfmsg->nfgen_family : AF_UNSPEC;
+
 		return ctnetlink_flush_conntrack(net, cda,
 						 NETLINK_CB(skb).portid,
 						 nlmsg_report(nlh), u3);
-- 
2.20.1



