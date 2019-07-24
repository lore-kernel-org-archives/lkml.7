Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EFEC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5BF20659
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996783;
	bh=PpDkzkmxeohIc8Eg/mw5PCrRq/RfsPMNsjVx7ZAKai0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ypw3YSzpv1U39jgFTnea3bA0k2EZ529k6aAujeiQlBZYUrFTCEoy7r6iJ0wpkrD8V
	 xPyn5xCasFtcasXn6bRCy/yMF8clB90pYwCg4V7ls725Iu/tFMOcgnbzBpBhdAFrmC
	 mHIIZsXfTK3MKryEGIUchmAQKYs9qvwpwEHrPa0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388762AbfGXTdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388712AbfGXTcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:32:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F48921951;
        Wed, 24 Jul 2019 19:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996775;
        bh=PpDkzkmxeohIc8Eg/mw5PCrRq/RfsPMNsjVx7ZAKai0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6BqHxwl+pkIie2HjsuA8IncHGwmM0HFnEvWzRtIROs+anBeEAa4hFRNjbzlMlu0X
         H4q5ikH93pwIEH24ylv7CgDLPETMU2d+/Zf5sVAwQJs5jEEto15xnX6e3+zQQ5qy+u
         l/e6Y4G7BM3cep5eehkVcy0u3kXlUuyxLX643suE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Felix Kaechele <felix@kaechele.ca>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 171/413] netfilter: ctnetlink: Fix regression in conntrack entry deletion
Date:   Wed, 24 Jul 2019 21:17:42 +0200
Message-Id: <20190724191747.193826392@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
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
index 7db79c1b8084..1b77444d5b52 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1256,7 +1256,6 @@ static int ctnetlink_del_conntrack(struct net *net, struct sock *ctnl,
 	struct nf_conntrack_tuple tuple;
 	struct nf_conn *ct;
 	struct nfgenmsg *nfmsg = nlmsg_data(nlh);
-	u_int8_t u3 = nfmsg->version ? nfmsg->nfgen_family : AF_UNSPEC;
 	struct nf_conntrack_zone zone;
 	int err;
 
@@ -1266,11 +1265,13 @@ static int ctnetlink_del_conntrack(struct net *net, struct sock *ctnl,
 
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



