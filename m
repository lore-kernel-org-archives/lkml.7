Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A29C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C2D214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411402;
	bh=KH8n86j6o8OwUdCbrCGKDfhSVeFGu2wbo1HvtG23JR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VK1jzcMwI1ewk4G2HPdbAF9yrs8OJiGOnmuYjou9AOlchVcQDSopRBlekeRsgX69P
	 eq/Yl7o0Q6cuouLdS4hlo/JFuJY6V8dgpByVn/GSHYumfOLoyKWi030dKxeVkiF6ur
	 Ofd023JBavjTMfK1sPi7xdQ75zpuZ1xmxIZTEjhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfCLRXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729878AbfCLRSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:18:02 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 515502171F;
        Tue, 12 Mar 2019 17:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411081;
        bh=KH8n86j6o8OwUdCbrCGKDfhSVeFGu2wbo1HvtG23JR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVLuh/ODBZQaxaKDqUdEA3P/RrMLIMYXydkrp1HHmlbkrNx3G1laCWZpy+lSlDiwF
         eYPa6dZh/njRLG6aE1wzVy48/1ohmBqTWvLog7L12BiQ6VgVYtQgjrPA7dzPGWgw4T
         ce6obVVU7Nl3/9NK02HL50+O9Rw5nJ8sw2gabrXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martynas Pumputis <martynas@weave.works>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 77/96] netfilter: nf_nat: skip nat clash resolution for same-origin entries
Date:   Tue, 12 Mar 2019 10:10:35 -0700
Message-Id: <20190312171040.405575028@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4e35c1cb9460240e983a01745b5f29fe3a4d8e39 ]

It is possible that two concurrent packets originating from the same
socket of a connection-less protocol (e.g. UDP) can end up having
different IP_CT_DIR_REPLY tuples which results in one of the packets
being dropped.

To illustrate this, consider the following simplified scenario:

1. Packet A and B are sent at the same time from two different threads
   by same UDP socket.  No matching conntrack entry exists yet.
   Both packets cause allocation of a new conntrack entry.
2. get_unique_tuple gets called for A.  No clashing entry found.
   conntrack entry for A is added to main conntrack table.
3. get_unique_tuple is called for B and will find that the reply
   tuple of B is already taken by A.
   It will allocate a new UDP source port for B to resolve the clash.
4. conntrack entry for B cannot be added to main conntrack table
   because its ORIGINAL direction is clashing with A and the REPLY
   directions of A and B are not the same anymore due to UDP source
   port reallocation done in step 3.

This patch modifies nf_conntrack_tuple_taken so it doesn't consider
colliding reply tuples if the IP_CT_DIR_ORIGINAL tuples are equal.

[ Florian: simplify patch to not use .allow_clash setting
  and always ignore identical flows ]

Signed-off-by: Martynas Pumputis <martynas@weave.works>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 19b3f4fbea52..df1d5618b008 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -855,6 +855,22 @@ nf_conntrack_tuple_taken(const struct nf_conntrack_tuple *tuple,
 		}
 
 		if (nf_ct_key_equal(h, tuple, zone, net)) {
+			/* Tuple is taken already, so caller will need to find
+			 * a new source port to use.
+			 *
+			 * Only exception:
+			 * If the *original tuples* are identical, then both
+			 * conntracks refer to the same flow.
+			 * This is a rare situation, it can occur e.g. when
+			 * more than one UDP packet is sent from same socket
+			 * in different threads.
+			 *
+			 * Let nf_ct_resolve_clash() deal with this later.
+			 */
+			if (nf_ct_tuple_equal(&ignored_conntrack->tuplehash[IP_CT_DIR_ORIGINAL].tuple,
+					      &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple))
+				continue;
+
 			NF_CT_STAT_INC_ATOMIC(net, found);
 			rcu_read_unlock();
 			return 1;
-- 
2.19.1



